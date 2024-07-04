import pickle

from classes.DataGeneration import DataGeneration



def main():

    with open('sel_imputation.pkl', 'rb') as f:
        imputation_methods = pickle.load(f)

    print('[INFO] STARTING DATA GENERATION')
    data_generation = DataGeneration(imputation_methods)
    data_generation.generate()

    print('[INFO] EXECUTION FINISHED')


if __name__=='__main__':
    main()