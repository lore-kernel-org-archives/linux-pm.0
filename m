Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA22DFA2F;
	Thu,  7 May 2026 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188065; cv=fail; b=sqEvMKoEWjqhoo1V/qz9EdqifQ2bbJYJAuYdM+rJeZ0AWK1Wfg9qz/kkYu+9ebuibTGOpWo3QRuybfOuEECqSBVHui7DKnz8epFFCYz0wYGTs0xHM+HYLUreXU8V5QHezG9/n2DLnYuoYRbBdhvXiBnJ/vtKkgS7QCIMque3Ikc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188065; c=relaxed/simple;
	bh=X3OqBHs6tuD1fRWDhqflvc4YhFjWS0YN8wO7EBahnnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/XXrI/qzHBv9w291pftEE8bu3j/9SlsYidwoAaYtbXOoh/sLyTa8FKfSwGZyPQVV5KbJAMPEiXGQ32ZbZPP7uJEfdiFL/2Tqadxd7PbOZ0V/WOpmC2hIBl1gaNzfmq2KcICF0DhvmooQmq19VOJP9TLtbF2Fb6vJWyaoyT03dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kulDujol; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kulDujol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbzityp8vx1c+ptDm5n/RqhkCnD/seI/bMtOQzE8M1q3I3SfiIHbH+LXF2jCCczPmMnmZwmGQ+pl1+tl7wW+EVMkEevsD47/iDrNILLATz/syVh8qi2yJOOe5wIiniTvttnfs7aqbKqNL+GAwBcqU30Rqm4uhdVOh4TLiqNYI4dg8VuxTWbUZkBzLAm3EJZ+etYcUGogvIjMGiwiBuJtivHDJusaAsLjhBC1XPJmAh6pCqEk65AtvxY/hbYSGN19B6LdHdpWnZpIfxm33hq6r9sLgo+QonvmrucWGzuKt6/z12E5+j3ruwxBUBex4YQPMbE5Vmva82kk1bVz4su0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2BYjLoee3eBFH54OKIZ6XvfuzTl+0E1ZtMD9EbXtyg=;
 b=f3s4K+WonZtDZMLIXIGChik8PQsNgBKFwme61MwmqLiJaIxmuC6bpKHxOsD3e/QQz7VobsG2Sdvt0IYNsso7FgtEIe6+PFG6799+xRqhjP0hmaU3mvcwlI2QZ5tI13vDwbGIA6y5jZn159AcoWU1dqQxV5ITW8wRBblBEfaqowOTLOl7Uyxlenv72Li/lMkBrJ5NHnTviQ1UWtYpmHvK2E1V735As31frE7cfX7Zr3EFhdxEAOOMVLAAuqKeH2FGvde1bc95vGpscf/2aH1A1OdHd/ziasRD/3IQ7rIZgPK+pvV4CyGJba6wVgRrmFtcMhCI9nR+g+UMd0BmGOE50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2BYjLoee3eBFH54OKIZ6XvfuzTl+0E1ZtMD9EbXtyg=;
 b=kulDujoluu9rTCyH7ewT1Df/rr1QLfsaCDCTRgawDsqW68A8vCl0UJNW53Bw7fzzT5J/Us32COoQuY8wmbfulBpQ8Z6cKEJaHSP00wENJAMIXt3tjzzyPqCiRA5b7JO8RzOi+Z7Cdl7LlIYYbN8HSaku360VjB2wG3PF7vWeyILQXIMrsbenXKBh52/OqzxpRvQp78uHXa8wYp1E0tiE+xB7YaVa6jAV5XfNAo2nCAA7HfAEcbFVJwQW31Mbqq/hTnIUbiDnGn1pRGCH6w238bNjC5VDWKmwTUd1m/fiW8BgXcsTl0dSGudOCoTGnmuc2P/WcaKrVm7PZCXuSy2HpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 21:03:27 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 21:03:27 +0000
Message-ID: <9c32f75a-294f-4cea-810e-c011c4dd91ab@nvidia.com>
Date: Fri, 8 May 2026 02:33:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 sumitg@nvidia.com
References: <20260430142430.755437-1-sumitg@nvidia.com>
 <20260430142430.755437-3-sumitg@nvidia.com>
 <8516aeea-f20b-4afa-a737-1dff636f5c2d@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <8516aeea-f20b-4afa-a737-1dff636f5c2d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0224.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 406737ef-c04b-4bc9-3ce4-08deac7c1592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|921020|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KZHCIupNrjyyz3p/PIM+pq18XWQj6vgKa+nOwKflzc/GVlO2EsvG+Um7zT3Lh7Ukb4eLcpidJKxjjWFzGSPCY6gewmJmOw+PKMSq5EMztaPhN0XAan6i3SQ9Vk8+Bcwx5TB13hOM6VTBPjntpqo71bpFmrXkTDikcT7uLSphscFVFIYn+LQ0f2pAgXGpSli2hzMLMcFGJ119Xt7YPmWKJ5bVc5uhc3eYOM1N2NI9V9SUi92QvrEW1eaH+G9EQBzKfKnT5EWKqQEDYT3LEJ5At+FVB64WFA4HIhgwQnoNhIGjuijgyzonN+xrgDr8bBZ+SiZ4/DtNm9sd+cAyWXSGbx3+8tOkKCKtkdvRW+v1teC7jVk1tXyfe7kCMIohHqLeyv5ysZ2j4zOEMsCIavGO3MQlw3bcpK+KOaixCF9RDutGTwUGhgbjBJKlXqn8bxFC0nd5vjlkxYE0nbYtwboHfMygrnDoRaq17d4jK3aDIVftLqZUt13/Vsq9Yf9NBoPiQIwywncyAHYi5ixkG6d+THkl0E55Ck/KZJoKwbVYku+YtPor3j8xi+PTme6m6fOxwzfhujM1VpBktMC7DnVe0PrftEuUi+0WrmJPXdcKb6vG59Kgr3ZwEY05qSIlcIrj3xDJGDK7/Hndorm5lwz6iFjDz7FbKjoWe9/yRZmBuOW4tPZa3wk6WXS2XGriv76zQJ/y8gLGk/VD67HwLOAxtgi+jxco7TonPNEH4/yQXq1t2TQPw3+rAtRndf9SFJvC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(921020)(3023799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXUzZitONnBQcCtFcnVtU0dJSUZCN2dNWlpDWlhXZldUc0Q4M2wrZEs5Ry9Y?=
 =?utf-8?B?NUVTdTZXQmZlZ2RibXBCbTVTQXNpWmlqUGc3bDR5NUxxT2J2b0JjdS9CYlVZ?=
 =?utf-8?B?dmlGMEJPckFNeldNSWZXbGdsSFNLOWhWNnpyT0t1Wml2VzhWdFJIY3NIOVY1?=
 =?utf-8?B?SUNrMlVhWmQzckpJTjBCS0ZOTi9ZRVQrVThvem5kNElXdWVnMklEWUVZRDJk?=
 =?utf-8?B?ODMvd3Vwc2djS01tWFExVkdMbFhMeEJFVmNXK0tuWkljZ2hOT0U5aDY2NkJj?=
 =?utf-8?B?WlZOV2ZzR05ZZVI0V3lML2JQRVBkcHNaWXA2dkk0WDAvVUMrcG9JTG5BNGVK?=
 =?utf-8?B?STBlVnd6b3NNaHV1eUR4dzQ3Q3JUQXF0eXpkQ2FzSkVjNkVHRkFsSHpjQ1V5?=
 =?utf-8?B?cjZrMHpXK3AxNklMbmlXUXlDL2c2OGZ1Z01pOWV3RXBkRk9EWlZFUGFGWUNl?=
 =?utf-8?B?VXF0Vkprb29XTmZ3aDNYaW9QUVVvOEtEZFVpM3BWVkJuVkJzZ0NUN1JYSExa?=
 =?utf-8?B?MXVzSEpEeC9rNzgvT2ZiOEh2eU96aExXcFNMdW1VM3BKTnFZM3h5S1dwZXhl?=
 =?utf-8?B?UXByZ0w0a21rSUthNm5TT25FS0JBbnNDQVRzblNNTDdadDFPdHZmNUZsUVRG?=
 =?utf-8?B?bFIrTHgxVEF2cm5JRm5UMGhvdmxJckt3T3BGSzNQdEkwVVpzMFhsVjhJdHhx?=
 =?utf-8?B?emgxWGpxU2ZmaGp2YkRlemR6TTk0Q0VZWWlwenN1MWR3S2lvWk1CaEMwT3lW?=
 =?utf-8?B?eTNFN3VENHlUKzFCdllnTlVUcXpqdkpIOXFCVkJwd1FpTU9nZ0s0YjlZNkJD?=
 =?utf-8?B?L0lObTk1NEdQY2FNL0p3YW1SQ2pVcEdWMXdvYnIrN0tmN3hCc0VROHpGL2lX?=
 =?utf-8?B?NW9FNTU3QVpDWG1Cdy94YnZVVDBkRktHcEtKN09vRjgzSlJ6TFpFeGhFUlUz?=
 =?utf-8?B?ZTEyZmlkOVJtdEczQlJkbzg3M0MwOUJMRWt1OEQwcFVqby8vL2RFb0RHVzE2?=
 =?utf-8?B?a2N0c3lxaFhoVDY3N2loU2YxZFBlNGVvaEUrek1qQVhvNUFGWW04Y1E0UGRy?=
 =?utf-8?B?SjJQOExTUG1DazFRV29ETndJem9VWXFoVmdBUTlsdEFWUlJzSnNrZnVRc0gw?=
 =?utf-8?B?czBUT2pCNUFFRUVwVHQ0RE1TMmdlUzVrVUN3NzRmVG43aFYyclhPUGVlRnpZ?=
 =?utf-8?B?dlVETU9qeHJVcjRTVFRpUDNXWlBqMzFpWDcvZW9qYWc0bFZxbVdnNVBoLzhR?=
 =?utf-8?B?SEZhTVpyQ3JjaUpZdnJCaE9xRWw1bjBzUWNqbVB4UGZBMU9kTmZPRXRVcUpM?=
 =?utf-8?B?ZmJkOGo2VTVHTWF6TWtlMUJYcGdGZlcxV1pBNG14dXhpQ1lWeG1zSEFEaUpi?=
 =?utf-8?B?UjNONkxFb1ZTTjZjUUVVUVdlNDJVUncyS1l1VFFyMlB4S2Z3a0dhcDIzdGxj?=
 =?utf-8?B?T1l4MmVQVnlzOElISFVTS01zRkIwWkdOaU03alZxZUNZdzI1MTJNOVRQQWl3?=
 =?utf-8?B?ekowejZXd0dKaFV4YkVmOUtkR0pOWldjaURKcjRSb0N5OXhTQnprLzV6a0pP?=
 =?utf-8?B?WkdwTUhpNXFuTFczNTBwUGlGODZPZ0svTkRGdnM3MEQ4c3B3MGM0czU2cFpl?=
 =?utf-8?B?TVNndFhnRXBnWlNLVmFaNjVRUUJvYXI1aGJ6eHZ6cXNCektlMHB5Zmd5RkZL?=
 =?utf-8?B?OFNNR21QaE8vRy82czBNdFJhZitOazZqOHkrQnFOdDNHdXpVc01SUWxtVFhh?=
 =?utf-8?B?NjB3cnZTbXR1WlBKQklYYkErbWlYNm8rY2V4azVqSVBWam5qTllsd1F2SkVn?=
 =?utf-8?B?TlB6bkkybkptOENDeXJCNFZIMWFjemZsNmFZc1pHOWk0MGxPOUtrRHR3TGJs?=
 =?utf-8?B?akIxWUxEckUyWUo2RjJpRnNPYVpwNTVqRTNqRWFUZmpmaUlscm45S3NuYStP?=
 =?utf-8?B?K1E2aGNvYUJFakdvd1dZS09qZE85emRweGMxZ21OUlFRdXZINFltRVNIMFBl?=
 =?utf-8?B?YnIzY0xza2JtNi9Vc0tmNk1sdW55RWlEcWtiMnphSzFrYTdTdnA3aHd3Z1dI?=
 =?utf-8?B?VHRIRGhhZ2t1SzRTS3YzNEJGaURiQjkxeVlqUEVtM0tuOEs0OTlkT0kzL3c1?=
 =?utf-8?B?R1haUC9xNitOaFZoMXcvL1dGd05zN1VxZXNuZ2RmQjFlVUluWm1LL0hJRzFw?=
 =?utf-8?B?YmttUlo1b0NYMC9OV1JXR1Job3hkY09MTGg3L3lSNlFwRU0vRjFjcUVNTDRD?=
 =?utf-8?B?Y0crdVR6UlBIYkJqWHNNbEZGUzkrd0N5TXNpZHFHQndaRUliTlNjdlIvY1V5?=
 =?utf-8?Q?OeLmmHwVG/klBtrltv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406737ef-c04b-4bc9-3ce4-08deac7c1592
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:03:27.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWNrBsNjSquiKW4TWYPl02RXrohPtrTOns/tiEjjxYSzJtMg14uk0SZ5TvG8xCHNIXT+s3KMSv1aurJmFc+jRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746


On 30/04/26 21:55, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> On 4/30/26 16:24, Sumit Gupta wrote:
>> Add acpi_cppc/ospm_nominal_perf sysfs attribute (read-write) and
>> cppc_set_ospm_nominal_perf() API for the OSPM Nominal Performance
>> register (ACPI 6.6, Section 8.4.6.1.2.6).
>>
>> The register conveys the desired nominal performance level at which
>> the platform may run. OSPM can request a lower level than platform
>> nominal. Valid range is [Lowest Performance, Nominal Performance].
>> The value tells the platform what OSPM considers nominal. The
>> platform classifies performance above this as boosted and below as
>> throttled. It uses that for its power/thermal decisions.
>>
>> Although the register is write-only per spec, cache the OSPM-written
>> value in cpc_desc so userspace can observe it via sysfs, and to
>> skip redundant writes.
>>
>> Initialize to platform nominal at policy init. Override via sysfs
>> if needed.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 69 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 10 +++++
>>   include/acpi/cppc_acpi.h       |  6 +++
>>   3 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a1c91ce20cc8..fbc620adafad 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -155,6 +155,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, 
>> cpc_desc_ptr);
>>   static struct kobj_attribute _name =                \
>>   __ATTR(_name, 0444, show_##_name, NULL)
>>
>> +#define define_one_cppc_rw(_name)            \
>> +static struct kobj_attribute _name =         \
>> +__ATTR(_name, 0644, show_##_name, store_##_name)
>> +
>>   #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
>>
>>   #define show_cppc_data(access_fn, struct_name, member_name)         \
>> @@ -211,6 +215,38 @@ static ssize_t show_feedback_ctrs(struct kobject 
>> *kobj,
>>   }
>>   define_one_cppc_ro(feedback_ctrs);
>>
>> +static ssize_t show_ospm_nominal_perf(struct kobject *kobj,
>> +                                   struct kobj_attribute *attr, char 
>> *buf)
>> +{
>> +     struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
>> +     u64 val = READ_ONCE(cpc_ptr->ospm_nominal_perf);
>> +
>> +     if (!val)
>> +             return -ENODATA;
>> +
>> +     return sysfs_emit(buf, "%llu\n", val);
>> +}
>> +
>> +static ssize_t store_ospm_nominal_perf(struct kobject *kobj,
>> +                                    struct kobj_attribute *attr,
>> +                                    const char *buf, size_t count)
>> +{
>> +     struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
>> +     u64 val;
>> +     int ret;
>> +
>> +     ret = kstrtou64(buf, 0, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = cppc_set_ospm_nominal_perf(cpc_ptr->cpu_id, val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +define_one_cppc_rw(ospm_nominal_perf);
>> +
>>   static struct attribute *cppc_attrs[] = {
>>       &feedback_ctrs.attr,
>>       &reference_perf.attr,
>> @@ -222,6 +258,7 @@ static struct attribute *cppc_attrs[] = {
>>       &nominal_perf.attr,
>>       &nominal_freq.attr,
>>       &lowest_freq.attr,
>> +     &ospm_nominal_perf.attr,
>>       NULL
>>   };
>>   ATTRIBUTE_GROUPS(cppc);
>> @@ -1683,6 +1720,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>
>> +/**
>> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance 
>> register.
>> + * @cpu: CPU on which to write register.
>> + * @ospm_nominal_perf: Value to write to the OSPM Nominal 
>> Performance register.
>> + *
>> + * OSPM Nominal Performance allows OSPM to inform the platform of 
>> the nominal
>> + * performance level it intends to maintain.
>> + *
>> + * Return: 0 for success, -EINVAL on invalid input, -EOPNOTSUPP if not
>> + * supported, -EIO otherwise.
>> + */
>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +     int ret;
>> +
>> +     if (!ospm_nominal_perf || ospm_nominal_perf > U32_MAX)
>> +             return -EINVAL;
> I think the spec also requests to have a value in the range
>
> [lowest:nominal]. As these registers are read-only it should
>
> be ok to read the values here ?

Will add the [lowest_perf, nominal_perf] range check in v3,
fetching the bounds via cppc_get_perf_caps().


>
>> +
>> +     if (cpc_desc &&
>> +         READ_ONCE(cpc_desc->ospm_nominal_perf) == ospm_nominal_perf)
>> +             return 0;
>> +
>> +     ret = cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
>> +     if (ret)
>> +             return ret;
>> +
>
> Shouldn't we have some protection against concurrent accesses ?
>> + WRITE_ONCE(cpc_desc->ospm_nominal_perf, ospm_nominal_perf);
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>> +
>>   /**
>>    * cppc_get_auto_act_window() - Read autonomous activity window 
>> register.
>>    * @cpu: CPU from which to read register.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 7e7f9dfb7a24..d06cba963550 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>               goto out;
>>       }
>>
>> +     /*
>> +      * Initialize OSPM Nominal Performance to inform firmware of
>> +      * OSPM's nominal level. Performance above this value = boost;
>> +      * below = throttle. Uses platform nominal by default.
>> +      */
>> +     ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_debug("Failed to set ospm_nominal_perf for CPU%d: 
>> %d\n",
>> +                      cpu, ret);
>> +
>
> IIUC, if (ospm_nominal_perf == nominal_perf), the firmware should
> not behave differently. Is this really useful ?
>

Right, it's a no-op from the firmware's side. The init was only so that
sysfs would show a value (platform nominal) before any userspace write.
Will drop it in v3 and return 0 from sysfs until userspace writes a value.


> ------------
>
> Also this seems like there will need some synchronization
> mechanism to keep-up with the boost state.
>
> If the ospm_nominal_perf is lowered and boost is disabled,
> a freq. update should happen. IMO it looks like this could
> be handled with (another) freq_qos_request.
>
> This new freq_qos_request, if we name it ospm_nominal_freq_req,
> should only be taken into account if boost is disabled.
> Otherwise, if boost is enabled, ospm_nominal_freq_req
> should be ignored.
>

Agreed, will add the new freq_qos_request in a follow-up patch.

> ------------
>
> Also, the function seems to set the ospm_nominal_freq for
> a single CPU when the policy might be common for multiple
> CPUs right ?

In v3, after dropping the change from cppc_cpufreq_cpu_init,
the problem won't come in this specific instance.


>
> The issues this field raises seems similar to the auto_sel
> ones. I.e. :
>
> - concurrency accesses + need for a scratch value
>
> - what should happen when unloading the driver
>
> - the value can be set for single CPUs but we might
> want to have the same value for the whole policy
>
> Maybe a common solution should be found.
> (I m not suggesting anything right now unfortunately).
>

One way to address this is to move the sysfs from per-CPU acpi_cppc to
a per-policy node under cpufreq (ospm_nominal_perf_freq, kHz).
In the sysfs callback, we can convert kHz to perf and write the register
on every CPU in policy->cpus.
Concurrency is already covered by policy->rwsem at the cpufreq layer.
This is similar to how we were handling min/max_perf in earlier version.
Does this approach make sense?

Thank you,
Sumit Gupta

....


