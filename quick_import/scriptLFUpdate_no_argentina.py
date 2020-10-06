import openpyxl
import os
import sys
import typing
from collections import defaultdict
import csv
import datetime
import shutil

script_dir = os.path.dirname(os.path.abspath(__file__))

economic_inputs_dir = os.path.join(script_dir, "../Economic Inputs")
assert os.path.isdir(economic_inputs_dir), economic_inputs_dir
upload_csvs_dir = os.path.join(script_dir, "../Upload CSVs")
assert os.path.isdir(upload_csvs_dir), upload_csvs_dir
asset_team_dir = os.path.join(script_dir, '../Asset Team Economics')
assert os.path.isdir(asset_team_dir), asset_team_dir

# copy files from Asset Team Economics to Ecomomic Inputs
asset_xlsxs = ('Canada', 'Eastern Us', 'Gulf Coast', 'Mid-Continent', 'Midcon', 'Permian', 'Rockies')

for asset_xlsx in asset_xlsxs:
    print("Copy " + asset_xlsx + " to " + os.path.join(economic_inputs_dir, "{}.xlsx".format(asset_xlsx)))
    shutil.copy(os.path.join(asset_team_dir, "{}.xlsx".format(asset_xlsx)), economic_inputs_dir)

#create a backup directory
c_date = datetime.datetime.now()
back_up_date = str(c_date.year) + '-' + str(c_date.month) + '-' + str(c_date.day)
back_up_dir = os.path.join(upload_csvs_dir, '00_Explorer/' + back_up_date)

if not os.path.exists(back_up_dir):
    os.makedirs(back_up_dir)
print("created back up directory: " + back_up_dir)

basins = (
'Canada', 'Eastern US', 'GOM Offshore', 'Gulf Coast', 'Permian', 'Rockies', 'Western US', 'Mid-Continent', 'Argentina')

sheets = ('loebyplay', 'loebyplayop', 'mappingbyplay', 'mappingbyplayop', 'mappingbyregion',
          # 'mappingbystatecounty',
          'nglbyplay', 'nglbyregion', 'procfeebyplayop', 'tportbyplay', 'tportbyplayop'
          )

sheet_columns = {
    'loebyplay': (
        'playName', 'regionName', 'minResult', 'maxResult'
    ),
    'loebyplayop': (
        'playName', 'ticker', 'grossVarLOE', 'liquidPercent', 'includeInReg'
    ),
    'mappingbyplay': (
        'playName', 'rrOilPercent', 'rrGasPercent', 'rrNglPercent', 'oilDifferential', 'gasDifferential',
        'nglDifferential', 'oilDifferentialPercent', 'gasDifferentialPercent', 'nglDifferentialPercent', 'fixedLoe'
    ),
    'mappingbyplayop': (
        'playName', 'ticker', 'rrOilPercent', 'rrGasPercent', 'rrNglPercent', 'oilDifferential',
        'gasDifferential', 'nglDifferential', 'oilDifferentialPercent', 'gasDifferentialPercent',
        'nglDifferentialPercent',
        'fixedLoe'
    ),
    'mappingbyregion': (
        'regionName', 'rrOilPercent', 'rrGasPercent', 'rrNglPercent', 'oilDifferential',
        'gasDifferential',
        'nglDifferential', 'oilDifferentialPercent', 'gasDifferentialPercent', 'nglDifferentialPercent', 'fixedLoe'
    ),
    # 'mappingbystatecounty',
    'nglbyplay': (
        'playName', 'composition', 'nglYield', 'gasShrink', 'procFee', 'rangeStart', 'rangeEnd', 'isStartIncl',
        'isEndIncl'
    ),
    'nglbyregion': (
        'regionName', 'composition', 'nglYield', 'gasShrink', 'procFee', 'rangeStart', 'rangeEnd', 'isStartIncl',
        'isEndIncl'
    ),
    'procfeebyplayop': (
        'playName', 'ticker', 'composition', 'procFee'
    ),
    'tportbyplay': (
        'playName', 'regionName', 'minResult', 'maxResult'
    ),
    'tportbyplayop': (
        'playName', 'ticker', 'grossTransportation', 'liquidPercent', 'includeInReg'
    )
}


def get_row_data(row: tuple, sheet_name: str, column_indices=None) -> typing.Optional[dict]:
    if column_indices is None:
        column_indices = {i: c for i, c in enumerate(sheet_columns[sheet_name])}

    data = dict()
    for i, cell in enumerate(row):
        if cell.value is None or cell.value == '#VALUE!' or cell.value == '#REF!':
            return None
        data[column_indices[i]] = str(cell.value).strip()

    return data


if __name__ == '__main__':

    #process and generates csv files
    sheet_data_all = defaultdict(list)

    for basin in basins:
        print("The Basin to be processed: " + basin)
        basin_path = os.path.join(economic_inputs_dir, "{}.xlsx".format(basin))
        print("The file directory: " + basin_path)
        assert os.path.isfile(basin_path), basin_path
        # if not os.path.isfile(basin_path):
        #    continue
        print("Reading {}".format(basin_path))

        wb = openpyxl.load_workbook(basin_path, read_only=True, data_only=True)

        for sheet_name in sheets:

            sheet = wb[sheet_name]  # wb['loebyplay']
            sheet_data = list()

            # TODO: verify header columns are in the right order?

            for row in sheet.iter_rows(min_row=2):
                row_data = get_row_data(row, sheet_name)
                if row_data is not None:
                    # sheet_data.append(row_data)
                    sheet_data_all[sheet_name].append(row_data)
                # if sheet_name == 'tportbyplayop' and row_data is not None and row_data.get('playName') == '#VALUE!':
                #     print(basin)
                # print(row_data)

    for sheet_name in sheet_data_all:
        output_csv = os.path.join(back_up_dir, "{}.csv".format(sheet_name))
        print("Writing {}".format(output_csv))
        with open(output_csv, 'w', newline='') as fp:
            writer = csv.DictWriter(fp, fieldnames=sheet_columns[sheet_name])
            writer.writeheader()
            writer.writerows(sheet_data_all[sheet_name])

    sys.exit(0)
