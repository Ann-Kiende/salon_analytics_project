-- RawSalonRecords

-- Cleaning RawSalonRecords data
UPDATE RawSalonRecords
    SET ServiceName = 'Nail Repair'
        WHERE ServiceName = 'Repair'

UPDATE RawSalonRecords
    SET ClientName = 'Ann Kiende'
        WHERE ClientName = 'Ann'

UPDATE RawSalonRecords
    SET ClientName = 'Walk-In Client',
        PhoneNumber = 'Unknown'
        WHERE ClientName = '--'
        AND PhoneNumber = '--'