drop table if exists episodes;
drop table if exists sources;
drop table if exists locales;
drop table if exists subjects;
drop table if exists services;

create table services
(
	id varchar not null
		constraint services_pk
			primary key,
	localized_name varchar not null,
	authorized boolean not null,
	subject_url_format varchar default null,
	episode_url_format varchar default null,
	video_url_format varchar default null
);

create table subjects
(
	id int not null
		constraint subjects_pk
			primary key,
	name_jp varchar default null,
	name_cn varchar default null,
	name_en varchar default null,
	mal_id int default null,
	website varchar default null,
	on_air_date timestamptz default null,
	bgm_image_url varchar default null
);

create table locales
(
	id varchar(5) not null
		constraint locales_pk
			primary key,
	label varchar not null
);

create table sources
(
	subject_id int not null
		constraint sources_subjects_id_fk
			references subjects,
	service_id varchar not null
		constraint sources_services_id_fk
			references services,
	paid int not null,
	subject_url_id varchar default null,
	subtitle_locales varchar default null,
	remark varchar default null,
	constraint sources_pk
		primary key (subject_id, service_id)
);

create table episodes
(
	subject_id int not null
		constraint episodes_subjects_id_fk
			references subjects,
	episode_id int not null,
	service_id varchar not null
		constraint episodes_services_id_fk
			references services,
	episode_url_id varchar default null,
	video_url_id varchar default null,
	remark varchar default null,
	constraint episodes_pk
		primary key (episode_id, service_id, episode_url_id)
);
