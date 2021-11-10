CREATE DATABASE knowledge;
USE knowledge;

CREATE TABLE dpp_policy_theme
(
    uuid  VARCHAR(255) COMMENT '政策类型uuid',
    theme VARCHAR(255) NOT NULL UNIQUE COMMENT '政策主题名',
    PRIMARY KEY (uuid)
)
    COMMENT '政策类型表';

CREATE TABLE dpp_policy
(
    uuid          VARCHAR(255) COMMENT '政策id',
    theme_id      VARCHAR(255) NOT NULL COMMENT '政策对应的政策主题id',
    title         VARCHAR(255) NULL COMMENT '政策标题',
    policy_index  VARCHAR(255) NULL COMMENT '政策索引号',
    public_unit   VARCHAR(255) NULL COMMENT '发文机关',
    issued_number VARCHAR(255) NULL COMMENT '发文字号',
    public_time   DATE         NULL COMMENT '发布日期',
    complete_time DATE         NULL COMMENT '成文日期',
    content       TEXT         NULL COMMENT '政策内容',
    url           VARCHAR(255) NULL COMMENT '资料url',
    source        VARCHAR(255) NULL COMMENT '政策来源',
    CHECK ( url LIKE 'https%' OR url LIKE 'http%'),
    PRIMARY KEY (uuid),
    FOREIGN KEY (theme_id) REFERENCES dpp_policy_theme (uuid)
)
    COMMENT '政策表';

create index theme_id
    on dpp_policy (theme_id);

CREATE TABLE dpp_theme_word
(
    uuid      VARCHAR(255) COMMENT '主题词id',
    policy_id VARCHAR(255) NOT NULL COMMENT '关联的政策id',
    word      VARCHAR(255) NOT NULL COMMENT '主题词',
    PRIMARY KEY (uuid),
    FOREIGN KEY (policy_id) REFERENCES dpp_policy (uuid)
)
    COMMENT '政策关联主题词表';

create index policy_id
    on dpp_theme_word (policy_id);


CREATE TABLE dpp_theme_word_relate
(
    uuid            VARCHAR(255) COMMENT '主题词关系id',
    subject_word_id VARCHAR(255) NOT NULL COMMENT '关联的主体主题词id',
    relationship    VARCHAR(255) NOT NULL COMMENT '关系名',
    object_word_id  VARCHAR(255) NOT NULL COMMENT '关联的客体主题词id',
    PRIMARY KEY (uuid),
    FOREIGN KEY (subject_word_id) REFERENCES dpp_theme_word (uuid),
    FOREIGN KEY (object_word_id) REFERENCES dpp_theme_word (uuid)
)
    COMMENT '主题词关系表';

create index object_word_id
    on dpp_theme_word_relate (object_word_id);

create index subject_word_id
    on dpp_theme_word_relate (subject_word_id);

CREATE TABLE dpp_theme_word_property
(
    uuid            VARCHAR(255) COMMENT '主题词属性id',
    subject_word_id VARCHAR(255) NOT NULL COMMENT '关联的主体主题词id',
    property        VARCHAR(255) NOT NULL COMMENT '属性',
    property_name   VARCHAR(255) NOT NULL COMMENT '属性值',
    PRIMARY KEY (uuid),
    FOREIGN KEY (subject_word_id) REFERENCES dpp_theme_word (uuid)
)
    COMMENT '主题词属性表';

create index subject_word_id
    on dpp_theme_word_property (subject_word_id);

CREATE TABLE dpp_related_organization
(
    uuid      VARCHAR(255) COMMENT '单位id',
    policy_id VARCHAR(255) NOT NULL COMMENT '关联的政策id',
    name      VARCHAR(255) NOT NULL COMMENT '机构名',
    PRIMARY KEY (uuid),
    FOREIGN KEY (policy_id) REFERENCES dpp_policy (uuid)
)
    COMMENT '政策关联单位表';

create index policy_id
    on dpp_related_organization (policy_id);


CREATE TABLE dpp_related_information
(
    uuid      VARCHAR(255) COMMENT '资料id',
    policy_id VARCHAR(255) NOT NULL COMMENT '关联的政策id',
    type      VARCHAR(255) NOT NULL COMMENT '资料类型',
    url       VARCHAR(255) NOT NULL COMMENT '资料url',
    CHECK ( url LIKE 'https%' OR url LIKE 'http%'),
    PRIMARY KEY (uuid),
    FOREIGN KEY (policy_id) REFERENCES dpp_policy (uuid)
)
    COMMENT '政策关联的相关资源URL表';

create index policy_id
    on dpp_related_information (policy_id);

