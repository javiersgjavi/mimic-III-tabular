import os
import streamlit as st
import subprocess
import time
import pickle

class LogStack:
    def __init__(self, n_lines=10):
        self.lines = []
        self.n_lines = n_lines
    
    def add(self, line):
        self.lines.append(line)
        if len(self.lines) > self.n_lines:
            self.lines.pop(0)

    def __str__(self):
        return '\n'.join(self.lines)
    

def generate_custom_physionet_sh(user, password):
    with open('./build_mimic_data/download_template.sh', 'rb') as f:
        content = f.read().decode('utf-8')

    content0, content1 = content.split('--user  <User_of_physionet> ')
    content1 = content1.split('--password <physionet_password> ')[1]

    new_code = f'{content0} --user {user} --password {password} {content1}'.encode('utf-8')

    with open('./build_mimic_data/download_physionet_data.sh', 'wb') as f:
        f.write(new_code)


st.write('''# Generation of Tabular MIMIC-III Data''')

st.write('''## 1- Download and build the MIMIC-III Database''')
st.write('''### 1.1- Generate the script to download the data from physionet''')

# User of physionet
password_physionet = None
with st.form('Physionet credentials'):

    default_user = os.getenv('PHYSIONET_USER')
    st.write('User of physionet')
    user = st.text_input('Username', value=default_user)
    st.write('Password of physionet')
    password_physionet = st.text_input('Password', value=password_physionet, type='password')
    submitted = st.form_submit_button('Submit')
    if submitted:
        st.write('Data recorded until the end of the session')


if st.button('Generate download .sh file'):

    if password_physionet is None:
        st.warning('Please enter the password of physionet')

    else:
        try:
            generate_custom_physionet_sh(user, password_physionet)
            st.info('Generated file ./build_mimic_data/download_physionet_data.sh')
            
        except Exception as e:
            st.write(f'Error: {e}')

st.write('''### 1.2- Execute script to build MIMIC-III Database ''')

code_str = '''
cd build_mimic_data  # Move to correct directory
sudo chmod +x *.sh # Make necessary files executable
sudo ./download_physionet_data.sh # Download the data and build the mimic DB
'''
st.code(code_str, language='bash', line_numbers=True)

st.warning('''You will watch the log of the postgres database being loaded. You must wait until you see a table with the tables of the DB where all rows return "PASSED", and below must display the message "Done!" before going to the next steps.

           Execute Ctrl+C to stop the process when it ends and go to the next step.''')


st.write('''## 2- Generate CSV files from the mimic DB''')
st.info('At this step you will use the terminal and you need to be in the build_mimic_data directory')

code_str = '''
./preprocess_data.sh
chmod +x src/query/main.sh
make query
'''
st.code(code_str, language='bash', line_numbers=True)

st.warning('This process will be even longer than the previous one.')

st.write('''## 3- Obtain the final irregular data''')
st.warning('Execute this just after the execution of the previous step, that will left you inside a docker container.')

code_str = '''
make generate_data # Generate the pkl of irregular data
exit # Leave the container
./create_data_folder.sh # Create the folder with data
'''
st.code(code_str, language='bash', line_numbers=True)

st.write('''## 4- Obtain the final tabular data''')

with st.form('Wich imputation methods do you want to use?'):

    imputation_methods = {
        'nan_imputation': st.checkbox('nan_imputation', value=True),
        'carry_forward': st.checkbox('carry_forward', value=True),
        'forward_filling': st.checkbox('forward_filling', value=True),
        'zero_imputation': st.checkbox('zero_imputation', value=True),
        'gaussian_process': st.checkbox('gaussian_process', value=True),
        'linear_interpolation': st.checkbox('linear_interpolation', value=True),
        'indicator_imputation': st.checkbox('indicator_imputation', value=True),
    }

    sudo_password = st.text_input('Sudo password', type='password')

    submitted = st.form_submit_button('Submit')
    if submitted:
        for key in imputation_methods:
            imputation_methods[key] = 1 if imputation_methods[key] else 0
        
        with open('sel_imputation.pkl', 'wb') as f:
            pickle.dump(imputation_methods, f)
        
        _ = subprocess.call('docker compose up -d', shell=True)
        cmd = 'container_id=$(docker ps -aqf "name=generate_mimic_data") && echo $container_id && docker exec $container_id python main.py 2> nohup.out'
        #cmd = 'echo $(docker ps -aqf "name=generate_mimic_data")'
        generation_data = subprocess.Popen(cmd, shell=True)


        logger = LogStack(n_lines=30)
        last_log_size = 0
        file = 'nohup.out'
        log_area = st.empty()
        while generation_data.poll() is None:
            if os.path.exists(file):
                with open(file, 'r') as f:
                    f.seek(last_log_size)
                    new_logs = f.readlines()
                    if new_logs:
                        for log in new_logs:
                            logger.add(log.strip())
                        log_area.markdown(f'```\n{logger}\n```')
                        last_log_size = f.tell()



        



