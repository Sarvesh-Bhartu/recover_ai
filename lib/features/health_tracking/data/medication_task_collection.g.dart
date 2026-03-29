// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_task_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationTaskCollection on Isar {
  IsarCollection<MedicationTask> get medicationTasks => this.collection();
}

const MedicationTaskSchema = CollectionSchema(
  name: r'MedicationTask',
  id: 1646092438396845836,
  properties: {
    r'dosage': PropertySchema(
      id: 0,
      name: r'dosage',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 1,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'isTaken': PropertySchema(
      id: 2,
      name: r'isTaken',
      type: IsarType.bool,
    ),
    r'medicationName': PropertySchema(
      id: 3,
      name: r'medicationName',
      type: IsarType.string,
    ),
    r'scheduledTime': PropertySchema(
      id: 4,
      name: r'scheduledTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _medicationTaskEstimateSize,
  serialize: _medicationTaskSerialize,
  deserialize: _medicationTaskDeserialize,
  deserializeProp: _medicationTaskDeserializeProp,
  idName: r'id',
  indexes: {
    r'medicationName': IndexSchema(
      id: -3870955775737281770,
      name: r'medicationName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'medicationName',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'scheduledTime': IndexSchema(
      id: 4528483578431344364,
      name: r'scheduledTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'scheduledTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isSynced': IndexSchema(
      id: -39763503327887510,
      name: r'isSynced',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSynced',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _medicationTaskGetId,
  getLinks: _medicationTaskGetLinks,
  attach: _medicationTaskAttach,
  version: '3.1.0+1',
);

int _medicationTaskEstimateSize(
  MedicationTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dosage.length * 3;
  bytesCount += 3 + object.medicationName.length * 3;
  return bytesCount;
}

void _medicationTaskSerialize(
  MedicationTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dosage);
  writer.writeBool(offsets[1], object.isSynced);
  writer.writeBool(offsets[2], object.isTaken);
  writer.writeString(offsets[3], object.medicationName);
  writer.writeDateTime(offsets[4], object.scheduledTime);
}

MedicationTask _medicationTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationTask();
  object.dosage = reader.readString(offsets[0]);
  object.id = id;
  object.isSynced = reader.readBool(offsets[1]);
  object.isTaken = reader.readBool(offsets[2]);
  object.medicationName = reader.readString(offsets[3]);
  object.scheduledTime = reader.readDateTime(offsets[4]);
  return object;
}

P _medicationTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _medicationTaskGetId(MedicationTask object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationTaskGetLinks(MedicationTask object) {
  return [];
}

void _medicationTaskAttach(
    IsarCollection<dynamic> col, Id id, MedicationTask object) {
  object.id = id;
}

extension MedicationTaskQueryWhereSort
    on QueryBuilder<MedicationTask, MedicationTask, QWhere> {
  QueryBuilder<MedicationTask, MedicationTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhere>
      anyMedicationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'medicationName'),
      );
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhere> anyScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'scheduledTime'),
      );
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhere> anyIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSynced'),
      );
    });
  }
}

extension MedicationTaskQueryWhere
    on QueryBuilder<MedicationTask, MedicationTask, QWhereClause> {
  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameEqualTo(String medicationName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'medicationName',
        value: [medicationName],
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameNotEqualTo(String medicationName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicationName',
              lower: [],
              upper: [medicationName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicationName',
              lower: [medicationName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicationName',
              lower: [medicationName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicationName',
              lower: [],
              upper: [medicationName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameGreaterThan(
    String medicationName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'medicationName',
        lower: [medicationName],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameLessThan(
    String medicationName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'medicationName',
        lower: [],
        upper: [medicationName],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameBetween(
    String lowerMedicationName,
    String upperMedicationName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'medicationName',
        lower: [lowerMedicationName],
        includeLower: includeLower,
        upper: [upperMedicationName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameStartsWith(String MedicationNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'medicationName',
        lower: [MedicationNamePrefix],
        upper: ['$MedicationNamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'medicationName',
        value: [''],
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      medicationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'medicationName',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'medicationName',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'medicationName',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'medicationName',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      scheduledTimeEqualTo(DateTime scheduledTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'scheduledTime',
        value: [scheduledTime],
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      scheduledTimeNotEqualTo(DateTime scheduledTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledTime',
              lower: [],
              upper: [scheduledTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledTime',
              lower: [scheduledTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledTime',
              lower: [scheduledTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledTime',
              lower: [],
              upper: [scheduledTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      scheduledTimeGreaterThan(
    DateTime scheduledTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'scheduledTime',
        lower: [scheduledTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      scheduledTimeLessThan(
    DateTime scheduledTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'scheduledTime',
        lower: [],
        upper: [scheduledTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      scheduledTimeBetween(
    DateTime lowerScheduledTime,
    DateTime upperScheduledTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'scheduledTime',
        lower: [lowerScheduledTime],
        includeLower: includeLower,
        upper: [upperScheduledTime],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      isSyncedEqualTo(bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSynced',
        value: [isSynced],
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterWhereClause>
      isSyncedNotEqualTo(bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MedicationTaskQueryFilter
    on QueryBuilder<MedicationTask, MedicationTask, QFilterCondition> {
  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dosage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dosage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dosage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dosage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosage',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      dosageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dosage',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      isTakenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'medicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'medicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'medicationName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'medicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'medicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'medicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'medicationName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicationName',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      medicationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'medicationName',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      scheduledTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      scheduledTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      scheduledTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterFilterCondition>
      scheduledTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MedicationTaskQueryObject
    on QueryBuilder<MedicationTask, MedicationTask, QFilterCondition> {}

extension MedicationTaskQueryLinks
    on QueryBuilder<MedicationTask, MedicationTask, QFilterCondition> {}

extension MedicationTaskQuerySortBy
    on QueryBuilder<MedicationTask, MedicationTask, QSortBy> {
  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> sortByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      sortByDosageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> sortByIsTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      sortByIsTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      sortByMedicationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationName', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      sortByMedicationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationName', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      sortByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      sortByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }
}

extension MedicationTaskQuerySortThenBy
    on QueryBuilder<MedicationTask, MedicationTask, QSortThenBy> {
  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> thenByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      thenByDosageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy> thenByIsTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      thenByIsTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      thenByMedicationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationName', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      thenByMedicationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationName', Sort.desc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      thenByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QAfterSortBy>
      thenByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }
}

extension MedicationTaskQueryWhereDistinct
    on QueryBuilder<MedicationTask, MedicationTask, QDistinct> {
  QueryBuilder<MedicationTask, MedicationTask, QDistinct> distinctByDosage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QDistinct> distinctByIsTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTaken');
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QDistinct>
      distinctByMedicationName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicationName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationTask, MedicationTask, QDistinct>
      distinctByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledTime');
    });
  }
}

extension MedicationTaskQueryProperty
    on QueryBuilder<MedicationTask, MedicationTask, QQueryProperty> {
  QueryBuilder<MedicationTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationTask, String, QQueryOperations> dosageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosage');
    });
  }

  QueryBuilder<MedicationTask, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<MedicationTask, bool, QQueryOperations> isTakenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTaken');
    });
  }

  QueryBuilder<MedicationTask, String, QQueryOperations>
      medicationNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicationName');
    });
  }

  QueryBuilder<MedicationTask, DateTime, QQueryOperations>
      scheduledTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledTime');
    });
  }
}
