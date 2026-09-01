Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D72436BC0;
	Tue,  1 Sep 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276539; cv=fail; b=szj0v0yvbJ7lSXOtcIjb0W+kOhpbPwQ4TpBQxbMeDNwkHKqr5NXi5nZQUfFYJl23z51FNB+jtTMsKT5IUhPQDDeHEjgHgX73V8imFLztqDNNNoz3lyhTwdRxbHmez5Tw7vrqY5K9rZdGDV/an63hOtyB6FB5Y98/y9n31EhB58I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276539; c=relaxed/simple;
	bh=Uw4E0YAvq974Qax0GhlZ/yu7xdvCd+YfFx/AmsJOskw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q3R7mi98xTNuXakvlMkjeyFpQAZYuvnGb8YJxu3EBZ12Hsm1lbmG5hILVEqn/0Dml/l870kGtAOK0+xSTRulYvL/Nh3gf/DcrsyNE0aBjz+jBGirgRbWAAHoCNdrkP71Haf9FmJT0vAQrkSByt0UDT2QdB1zvF9ljE7ZrTMozoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cljhnke5; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cljhnke5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2tSjDqZBjSRYz03UxBhCAywGurjHMjegbd7qfemRcq+HWR5/628tLVSxpPB7nPZG68vIWp5anjt3X8e3KeT5kO7DqbYqWcUEPu4FOfpDlYVw31HuyapduhEixM89VYb7pPd/6DFf/s4THN2p1zMkXPVbSLfWbsVmH09mLrzBbS4sQWubg8vPTBuksuqz4KimLWEq4dyCQvAXwjoe6a0HdZlKupq+bfLZwrqrKyv8vLqSxYrEC7kKThQTyOZ5D5FFDHmS2OXVhqmSG5lE8dtnv4VHRdv/vTaKl8P+G8MrSEXLedUkseajGJ96wQJ9Mtok42U+5v211VVWlo8cjuCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/3i0DFGbnPXagoyFRLWx50FkKglH+KPiNM1lpes7+o=;
 b=hUgTX6MMzYpzmGrDSAj1Z8xN1z0WLaxXmNsUUef23GhBEHcffVrxclbheyYGEIA889Uvg+38TWQED93KKXXo9jr6Uj5UqPW9D/Mk7X+6jU9IL1Le+woYMD8hcfE2aBudUPCwfDuvEvsQP4i4rIqtb1bz7BxnpWyUTBf4Ky3myGf5xysp7jd0X3y2Fn+xTutXrs1iusjgLazhA8cDsEUnhb0ORFrBKuWkKnGKNyfFsdFLf3KheIoIp4J/RW7ojERhqvAI1o5y+eFTfb3F0l+pqkam280PmkKas62n41jzwEL+dYOhAf8G8DkdM+HAjssgCJdjcKG6t6evzGIk5QfWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/3i0DFGbnPXagoyFRLWx50FkKglH+KPiNM1lpes7+o=;
 b=cljhnke5Cqp021WsbFk6TUBJy8IQo1DCi5+rMn5IU3DyFmcBzVdoMSYWecf3Wg7DU+WCAMD+W1vjJ5cjVTbZFQHYBOaIx+IeyTBa+EYXDJb1tM6zjK2sFK1v5vPnUxx89ci0IYCLMAKtWEikEGf7iTRZ5+MzLYjgU9ARt20CP/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV2PR12MB541025.namprd12.prod.outlook.com (2603:10b6:408:3a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:28:55 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:28:55 +0000
Message-ID: <fc724887-fbad-4433-85b2-27dca6da28dd@amd.com>
Date: Tue, 1 Sep 2026 10:28:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor boost ratio handling
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, x86@kernel.org,
 Vishal Badole <Vishal.Badole@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
 <20260831194428.2287055-2-mario.limonciello@amd.com>
 <f18fafe4-f873-4080-8ddf-72fb6abec557@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f18fafe4-f873-4080-8ddf-72fb6abec557@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:806:a7::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV2PR12MB541025:EE_
X-MS-Office365-Filtering-Correlation-Id: 85152ebf-07ef-42d9-6b94-08df083dbc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JeBpQN9du64SbSLU8rtovnnpIXn3QHZVsFV6R0ZiLByHoGUfePBABQF4YXHj02SfZp8nD/13cxck6syLj9ohMb3pLfQnH53Y9hdIW4g/Uwm5axxxuyMnbJDTS+d17oiPJDUJgQ7bYOuerhjqxna08q5bRon1QboAyekfafBoUmWrebmqaZNG1VeBsxEz4tDvrBIQbS9VE6QfQ4j0vrhYuuNRAyiYMnS5OaUTTov1uOwPZNKmowyUXYyeorAIOl24Kby8K1msPenfBH34M3hs/EGpY2De5foL4jOFr9OBAioexpRQykq9E9tCh8oA7wkctM+6x7l7c3AigEhtB0kTBWQHa1FFkqe0OUPKueS2gfPvSnMnHmSwq1S7GdA1rylm/luuucsmjo7m4i0AFBjQgkJ601omY20Uka/Np91DPa0243VWBeXy25v0CyqFYeghXw8mq68tZfFovHaGwzSjhvmUiErx+tlwUf7RDdCRV2K9oyun8G1sB74gIpCAuEfZ92hyyGA+dQxr2KamOE4O7vHjNXf3V0mwgf/KxWKZ9/ol8Q7kF8+faXj6mrj07ZSKB7ZD/wFnN/FvkThKIriRBuUGyfa66V/Tn5DgY9Z2acOy0C+RctJ8205ZRoLWDZbIL2cWMD9gUBh9XamU0xKdhqv9Wr54wP/AcqYK2ReoR84=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RJdS9mQmdKczFSWUZOQXZ6U3p4N3pvNlBxWStCVURaTkNjT0RRakVUVzRX?=
 =?utf-8?B?YnVGRktqSjU5ZXcwYjM4RGR6cnFmSzE3YTZ3YzlnT1ZVV3ByQlErRE9WNXBa?=
 =?utf-8?B?MmlydnRNK3lWUzZxSDZycTJrUXR0dktQSUV4RG5zNityQ3lsUnF3Q3hzMTMy?=
 =?utf-8?B?VktGMkcvR1d0WDU4N3NCcE91bHNnSnVPQjBmejVhZHhpZnNvQ1lxanRQNThS?=
 =?utf-8?B?REZHU1lNakhOWmtJZlJqZWtRRzI4RFRpYXAzK2x2QndCUVh4ZWcrenB6Undi?=
 =?utf-8?B?WnFnejBqdzV0bDMvNHN3anhYOG02d0R0bXJUTk5iSzhTNW1hUHJyOVNlYXVE?=
 =?utf-8?B?UE52aFR2MHpVK1VQakJ1YUpzUmxxSEFDSUVCdFVMTEZud2QzS0xsRmlGUGdx?=
 =?utf-8?B?RkN6VzJXd0JZZm9IWVU4R1gzY2lTemNIOEx1ek1UOXhZUzZtMmg1bkJXUEJE?=
 =?utf-8?B?YkN4aTlEaks5WlIra1I4NjVwbGY1anhzcVZudzlBbFJIcW5QVHVVOG0zRjlV?=
 =?utf-8?B?b2dyaUNqZ3FSSmZkMEZGSmVZSUxaQUl0VjBBS1FsUUpIaExXK2JmVHpUeXhz?=
 =?utf-8?B?R1A1eElnVVVuME9JS28zMW5BSzBMS2xONER0Wm1uNDMzWWZ0TU1vZWNtUTVM?=
 =?utf-8?B?Q3BuaDJhNjc4ajNnSFF6RGdSNWFKMVlzWjA2UWN6UkZINFpPMTREQ0s4d0Zv?=
 =?utf-8?B?MCtQV3QzZ1BzKzRzSTdVTTZ2Y0E5aXJ6NU1MUTl5OGZKS2xiK01nLzFTSHha?=
 =?utf-8?B?SUI2Nmdpa0p4OEFkdGxXQXYyZlFRUHAvZzZEOGtsZlhGcjNQRjV0VUV2Q3pW?=
 =?utf-8?B?NVhVTmtOdlBZc1lwMXpMNS9IeGVBejFaWWZBdnpSZll0cW9ucGQxUXhmUEdt?=
 =?utf-8?B?TkNIbHpOWHZlOXhDazZOcS9meTlmd3NnOHdlZlc3WGY0SkREaFZJRDQrSU4w?=
 =?utf-8?B?eXZ3c2VleGhHMTdMbWFxbUFSU2JWb28zUEV0MkxkWWJoaW9kMnAyY2YwaTRW?=
 =?utf-8?B?aEtVUWVrU0hQQWdVL0tiMFlDNS9EYmRra1pwczl5N3c0RmhUYnE0YTV0SC9D?=
 =?utf-8?B?bDF5bm16ZFJrSmtpMnpXb3VoNVMwWWxMUDFDaUVmOGY1cXBzL29Gd3FDdjA3?=
 =?utf-8?B?dW45NUtaR3hwUE1TYSt3MXFFVnk3eHpKSnJkaXVmN25sQnB0VFJtSUREMlpy?=
 =?utf-8?B?cjdlakMzbU1vS1Y4VEpjcVRWMFI3OG0rcklwNklmUUI1eDlTTkxTR3htMklh?=
 =?utf-8?B?RkhqaVN2bnM5Y2JGVmZCKzVXanREREl2WnpKTHVMbUVSNW9NOE1SbjlwUEEr?=
 =?utf-8?B?eWcrd3FFV0RrUFNVbHJCcHdsdmE5TmQ4NjR3RlBKWnJCbG5BRms5ME1wK3lt?=
 =?utf-8?B?Vk5WU2c5VkpBdVZUYWVuZXBlL3YybmxzVCtDSGhIVHM1S2RxREVKQ0toWVRP?=
 =?utf-8?B?RFV6SS9EczBMK3lFWmhOQnZvbW5nZFdDUUQ1MERISzJodGYwamxSMHNNWUJu?=
 =?utf-8?B?WGN6N0cwNXZXWkVHZW5EMHhxUUZOc0RlNUVPcFpGemtvU3lOOTFFN2VEWlZ5?=
 =?utf-8?B?c2VpZldZTmhaY0pVaEpmTE5KR1g2TWM1cURvRzQraU13NyszOW5aUzVhazRC?=
 =?utf-8?B?WGIxd1pLNUtxR0EyRStoV1ZTMXBYVnhVUUxleWc2OWVEYWRaK3p3OTNtMXh1?=
 =?utf-8?B?UnY0TUx2b2x6Qkl3VlkyZ0NyUEQwN0EwSXlyRWRCRmpxcEMwWTdnRTlrcVoz?=
 =?utf-8?B?Y2xCeUxKWitaK0FnQVlPNWtqY2ZEcHZaZ0xBcjNUaHZHTGN4VmtiU2RicFB6?=
 =?utf-8?B?cXcyVGtmSkZKWWxRV1pjZVVmaGpSVWVRZmlUQ0dxK05ZekZ4YUxJRHpzYm9v?=
 =?utf-8?B?STBtZEphS1k0dXlZMTRkTm5EU24wNHdmYVhHODNaOEpFZUU0NnMzaUI1enRi?=
 =?utf-8?B?QlRySHZMeXdXK3RiRWMzbUxneTAxelhpVkRuU3NnaVdjZmlkdVV4U1hCNWJ6?=
 =?utf-8?B?QXhMOFdPMHUxSGROQ0FLVUR2LzgzRHFXenYwNTI3cVdFcHpKTXlzTFlIZXcz?=
 =?utf-8?B?V0hmZ3Jia2VzUkZEeWQyeG5aWUs1NFd4ZmJiOGRtcERQZnNMSEFKaFg2ejgz?=
 =?utf-8?B?UmVCckNnb2dKQXArY2c2QXZ5c0RtWjd1Tzh2MEhUZys4VUxYRjBVbGNjRW9v?=
 =?utf-8?B?TkV5SDF0NGZNNHVNbUJGcnVCREpadWwrdkxaOVFKUVExTDRIT2JGY1BFQTN6?=
 =?utf-8?B?ZW5lZHE4R3R2c0JqekRwaENPdmthWXNOYS9uS0pETnRQTUcwN0hSUFI1RHg1?=
 =?utf-8?B?c3VkM2dhdlFPVVZNWjRRS1doV01vS1UxSWpvZUo5R3JvSUpIMUVEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85152ebf-07ef-42d9-6b94-08df083dbc1f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:28:55.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIMd21lI/lGwuRdyKMzu+MRJvVtdhyr7oslmlDex17pVw6I7J1ijAAAbngjUVKZZMFSUOKltXR7aTtOgXJHh0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB541025



On 9/1/26 04:31, K Prateek Nayak wrote:
> On 9/1/2026 1:14 AM, Mario Limonciello wrote:
>> +int amd_get_max_frequency(unsigned int cpu)
>> +{
>> +	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
>> +	const struct x86_cpu_id *id = x86_match_cpu(amd_zen6_client_ids);
>> +	const struct amd_max_freq *max_freq;
>> +
>> +	if (!id)
>> +		return -ENODEV;
>> +
>> +	max_freq = (const struct amd_max_freq *)id->driver_data;
>> +
>> +	switch (type) {
>> +	case TOPO_CPU_TYPE_PERFORMANCE:
>> +		return max_freq->performance;
>> +	case TOPO_CPU_TYPE_EFFICIENCY:
>> +		return max_freq->efficiency;
>> +	case TOPO_CPU_TYPE_LOW_POWER:
>> +		return max_freq->low_power;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
> 
> nit. Since we don't really propagate the error codes returned
> by amd_get_max_frequency(), maybe we can return 0 instead of
> -ENODEV, -EINVAL and the callers can simply do:
> 
>      max_freq = amd_get_max_frequency(cpu);
>      if (!max_freq)
>           max_freq = /* Fallback */;
> 
> similar to get_max_boost_ratio() pattern. No strong feelings
> either way.
> 

OK.  Will adjust for next version.

>> +}
>> +EXPORT_SYMBOL_GPL(amd_get_max_frequency);

