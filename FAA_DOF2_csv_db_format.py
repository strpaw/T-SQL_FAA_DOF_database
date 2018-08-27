""" Function to convert DOF (Digital Obstacle File) to csv file according to
    Digital Obstacle File Jun 19, 2018 specification.
    For more information please refer to:
    https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dof/media/DOF_README_06-19-2018.pdf
    https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dof/
    Output fromat is appropriate to import via MS SQL import functionallity, flat file (CSV file) into
    table tblObstruction from FAA_DOF_sample_db
"""
import csv

def FAA_DOF2csv_tblObstruction_format(in_DOF_file, out_csv_file):
    obs_csv_field_names = ['ObsNumber',
                           'VerifStat',
                           'CtryStateID',
                           'CityName',
                           'LatDMS',
                           'LonDMS',
                           'ObsType',
                           'AglHgt',
                           'AmslHgt',
                           'HAcc',
                           'VAcc',
                           'MarkType',
                           'LightType']

    with open(in_DOF_file, 'r') as DOF_file:
        with open(out_csv_file, 'w', newline='') as out_csv:
            writer = csv.DictWriter(out_csv, fieldnames=obs_csv_field_names, delimiter=',')
            writer.writeheader()
            line_nr = 0
            for line in DOF_file:
                try:
                    line_nr += 1
                    if line_nr < 5:
                        continue
                    else:
                        # If tehere is missing height above ground level write number -999
                        agl_hgt = line[83:88].rstrip('0')
                        if agl_hgt == '':
                            agl_hgt = '-999'
                        # If there is missing data for horizontal accuracy - add additional code
                        hacc = line[97]
                        if hacc == ' ' or hacc == '':
                            hacc = 'N'
                        # If there is missing data for vertical accuracy - add additional code
                        vacc = line[99]
                        if vacc == ' ' or hacc == '': 
                            vacc = 'N'
                            
                        writer.writerow({'ObsNumber': line[0:9],
                                         'VerifStat': line[10],
                                         'CtryStateID': line[0:2],
                                         'CityName': "A",
                                         'LatDMS': line[35:47],
                                         'LonDMS': line[48:61],
                                         'ObsType': line[62:80].rstrip(),
                                         'AglHgt': agl_hgt,
                                         'AmslHgt': str(int(line[89:94])),
                                         'HAcc': hacc,
                                         'VAcc': vacc,
                                         'MarkType': line[101],
                                         'LightType': line[95]})
                except:
                    continue
    return
