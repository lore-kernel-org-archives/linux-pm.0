Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCE456E1F;
	Tue,  1 Sep 2026 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293474; cv=fail; b=iD7n2lxwbSGJMRNHDH5fFSdfgLML4Sr3JkyAr3eljGkJZjJ/3eZndP6LLxV6e2RmkCG0wfzyU4aXpA79QDCOmU+TramMMdsTIrqB7m+yIRlkZkG1sEMINywVFcco2Y2H43JC38OBbEp1GICx4gfQ0E4uZFhIpJoeHCpyAY7VOek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293474; c=relaxed/simple;
	bh=NRy4yqPtCfTqlICTjXMtqvFC+A7kfo4tNYl01z0e6/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IbeoNz16S9dLDI9lqN2U246eIzreNBYyz5qOknVtGx7+zAKA9S6rZXumMsemIdjHLnqI1coI1TTHWDfzMfO74C+KaCpNfMF+zBdg51hviHglxknTTxyD4SC/LP1E4j2Cx6wAVM6eDZkcLepnJmEG9nhnjN5sXl/nDL2DAgh1+y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vYGqd2eY; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vYGqd2eY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZqPPE1v33ED4Rawu9+NpZQYnh43Z6MOAwYsG//JUc7EpnvuHcr4RwGrc/neNmxvHc/q7i2I7xmouH5KWN1beeQbNPJWW7o8s5FCeaTOBIfNnPDoOGGDTn5u1QMUBoN3A2xt6n28AdTNB+DvpW3X/dFW5ddB6zyQmGAMluAlnAxKTa2jY+NcRdvm43wAhyrR14VN3JArieNIj5CybbDoFh5arylx/2T0RF+nhFj8D6PRkE7U3CzND9zrv/BdeYBPL4xq5srgvy91yS06Ni0q1Hgzz8hyWKCysD8mapA/J6xD/T4nfttgM9qkuq6FHyMuvJn/XMiTMer37rK842BSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz9Mt00JG44oQ/TQUBeTbkWNHadAft2KkdtSt3zb4Ns=;
 b=RXYFcZmXyOMjs5cO4/BMRpKI7mqeH3eXTmhV1RKAQba+5Y53QIFVidgbjNDGheH1OtsHF90rGTnidSQWfRCkWb0F2Z7QGdpFXTlKO04J+07WgLk4KZMr5Ef3ruZJuDW+DKXhY6EQU1QWzw6ZCUi5NcvGwan/VwrRWiJ0etAUyS559tjWtiS+YTUaWoIl9DMYlC1sEX6A2dxWOA/8d7J4Jvpgxksc7TydEXrBFxabErspGDoEcwImaJ+9WrPSjHfmCflS7xNsT8PsjNVgG8wXdhXyurX9Tl9n4JniCzn2Ffkp604mtElibODpY9nm7+ChkJFYoJ7DZqdrgAqdglnfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz9Mt00JG44oQ/TQUBeTbkWNHadAft2KkdtSt3zb4Ns=;
 b=vYGqd2eYU1FSKt1gz9PydBeOkXSGXvLeewQH9VJRu9O5lCPEXPA1sDDBEjnPZa7UzkR5zABJL9sBGntMfX43QN3E4pYM5ANug3oFVOQbRb28f8NTUjIznsmzitV+QlFiprSX3wiuil+H6kYpaiLUn4AAQxVerCsCjoiaTRgMufI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:54 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:10:51 +0000
Message-ID: <951cad11-3660-4f15-b92d-47e8f91f415b@amd.com>
Date: Tue, 1 Sep 2026 15:10:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/15] ACPI: CPPC: Fix register access and lifetime bugs
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com,
 K Prateek Nayak <kprateek.nayak@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Huang Rui <ray.huang@amd.com>
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <f1054d96-85f7-44a3-b8d4-f9887551edfd@arm.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f1054d96-85f7-44a3-b8d4-f9887551edfd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: a319ce89-d7c0-467e-a1a6-08df08651ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|6133799003|10067099003|11063799006|5023799004|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	auy7iLV7mfVdo7mgy2eORG2E+NkF0I9+u2nlSOWmWOBGMD+e+1VaHe+Cq25prjCJ5uO3GJRCjwcB4YViVgrxnRF/IU/UcVGhqAKajdnz2HPu9JH99krOCM90nma9ixtPeN7mi8J6+9WJAkdGK7A771fgy0twjNxGVBkfYtwrFlZli2FNIEM2Zsj7CsWSkr8ND+WLkBWfD86eelid5n28PxBY8zhf7KQElT+Qoer/qwZzOA1XQ4epUwYiQ6llaPBQk0v5eE7C+iEkIpU72r2BX7wnUl9K1uaBiyoE54anxFd1TkEZxmGaMTvEU7i3qvzZTPPyxhx32LXr7ZCzkV8Ch0LNPP0Ok1xOKt9GtsCAoXfXSp8SOaa48tPuJJbuWNTMTid+U+1Y4EtUhVsU9EGgF6S+k5WOs0QjjuKhwUbD8VMRk4qlq62aJs3f/kw0FTEKn3gZXI5W91H/xRLgvwGWwA7dW2GcmD2n9ETzgt5MJMPLzLMgmV+m1UFCxq4Jjlx/htEQx4CzOoYysC/B3jd8nBbhOoaXeEMu5bElb9yj24H4s7kum1MNZ4OGOOCraAkZd/mB9upepWCIzh78LZlLmVQ1lFni0CEvA/O4kW4xUMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(6133799003)(10067099003)(11063799006)(5023799004)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWdxS3pkL2J2cTQ5RGtZZCtCTnVKUnZXbEo4MXNZWlN6WTJmeTZ4U0RJWDF0?=
 =?utf-8?B?VEljZWVRQjFJUzlJR2U5SFNtTVhIM052ZE5kSG1TMmR6SUtjMWE1dmdCUVdy?=
 =?utf-8?B?Q09QbkdNQWw2ZHBIUE00a3pXbnZVZWFwZDRkKzkwUFZQZjFYeHY1am9QUGt0?=
 =?utf-8?B?MHRMZURYMlg4eDdjMlFVQXJBNHNKTEhodExhS0ZaVVJ1MFR5d1UzMTRpMjdW?=
 =?utf-8?B?NUU2MFBwcDlXOXN2RExnZFJaTjNHQk04Tjloa2J4VUdLdThVTGVOcjBLUG42?=
 =?utf-8?B?YzlTejdCa3VwSTRTbzNSN0pOdk1TREszOVZ0eDMvYi9SNVpIWlJzWS9NNG00?=
 =?utf-8?B?TDMyazZML1M3Vkc1OFZ1a2crOU5lSk9mNUI4amVBRDJtOWhCUXlMckRMZ1lm?=
 =?utf-8?B?UnZxekh0V0ZueGsveDVLM2ZET0s5cUU1cTNtTjhieHlWSFF5R21MMDRIaXh6?=
 =?utf-8?B?SXFRWGNoK0c0N3I1SDFOQXgxdzg3VmRkY0lhMmVFOU1xUDBsWUkrMVljWmZh?=
 =?utf-8?B?TU5lcllJS1BGZ0hTcWloeWEwZGlBM3EveDdrck1ZOGcwT1JkazA4ZzYvTG5u?=
 =?utf-8?B?TkQyOXBpaE1wVEcxejkrNGdmTVYyREJuQlMrVmwyc05JY2hCZktuNjU1Z21Z?=
 =?utf-8?B?YWlHVGVJcyt6N3J3YnN3NE5IeVBTSVRacTdkMUJLWkpOMHVRTk8zSXBlejEx?=
 =?utf-8?B?Y1dnYXdLOUpRY2NRZ0FGNFU1bE8zYVluN1JEeHU2TmtvemNZeWllUlJiR09m?=
 =?utf-8?B?b0NjQzhlZkYvNk5NdkdURlBaem03T21rVS90SXd4bWw3Tm00VDk5QWNiRlht?=
 =?utf-8?B?NlZNVEZQZG1xS3FMaGNwVEg5THpBODV2TllENDhvdnlLMkNJT2F6aXlHM1JQ?=
 =?utf-8?B?VW9pMlVGSHUrZGxnZThtZEt6Z3FORDgrS1RNN1ZJZnZUcjBPNzBNQkk2RVJI?=
 =?utf-8?B?QmNuMm1rWndwbzhzODZzSUppaDBmTmd5a1B5OXFWbURPK2xGWG1TZ2dSSEpW?=
 =?utf-8?B?S08xTzZZcUpPNUthNjZCRllXSTVkVk9JQW42SDJyWHFkajFCOVh1NWx5Q2o1?=
 =?utf-8?B?Y00rdFhBSEMxSC9rU2NIVlQzQXBaYVVXYmRvR2ltRVFBNmtNTmJKRWVuVERO?=
 =?utf-8?B?U2JLTDNXZmhEbWZwR0VRS29MWEJFc0pwNHc3YXowenVXTzBkZ09NK3dObGZW?=
 =?utf-8?B?VWRzWmxYMld0Z3lydG5aMVdNNmc1SW1sK0ZOTThrUnQwd3JJdkhabDRkQUZ4?=
 =?utf-8?B?NzhDU0ZEUFV5VmMwcGlqbDRCQUFLZWFOVmJSbW91SVRYT3JVdzMvTWI1T2Fm?=
 =?utf-8?B?aTUyK0JieFFZVjRBc25NdVFTaWN0UzZhWFNHNUlteGlvVTAvMTlYR214WTJs?=
 =?utf-8?B?clVDSDZqd3RlTktvUFAvRmw3djJ6WjBaLzBMUFlqTXNNZmw0Q3dqNE1CdTh4?=
 =?utf-8?B?bTI0WmhnbTdmL0tTWWUzQkp3aE95SGJHQW9MeUFZYW53VGYxNVN3b0UrMDM4?=
 =?utf-8?B?bEgxTnNoQVdXRDFuWE9iaVljRjArdjVoOGsvK2JtMFNPMEZZMlA0SmlyVjhE?=
 =?utf-8?B?R05mMUhoNERUbE5oelBGUTk0SnVlVTAvMzVJTFcraXArNytSNEwrOERIWkk4?=
 =?utf-8?B?cUQ3QTFSdElmbE5Gc0ozZGZtdjgwMDZaYi9WWGdzcGtRYzZsbFpvaWMyUFVQ?=
 =?utf-8?B?SmkwdFZpQlJWQjhoS3dLM1pjL0pzUmsxMVlDYnE5V3RUQUxKcUZTUjBYeEox?=
 =?utf-8?B?Y3kzMEpuN1EzU1lWMC9yQVpOL0tCNzFzZzBLQ21Fam91V0RHZkhMRkZObXFu?=
 =?utf-8?B?RzA0TXNxSzdqTkhCSHdqKy9Ya2hZMnVPVkF0VWdrVFNaZWFPZnpDV1R2UHNR?=
 =?utf-8?B?cHo1R0g1Yy91SWllR2JxZERYVHN1NnRvblZLWXdMa2FWbGNHYkYwbHlRV2ZN?=
 =?utf-8?B?dGdXb3kzK1V1UVZwbGM0TWd0akdTNkRGQWZEWjVKT2R2bHY0YU9RbTVzTmx6?=
 =?utf-8?B?Zk16OC9tcXMrVnlNTTBMc3RMdTFkaW12TW9QY2xDZHJiZ1NmZUFyR09jL1VL?=
 =?utf-8?B?NCtMRGhhSFo3bGJtTDZoRVU1VytLb2pGbzFFQmdyWlh2Z3Rza01DVHBuY1hz?=
 =?utf-8?B?NEZTamhRTjJ4ZHlJYnc4ZStOa0xyYnBJNUhxRXlCbitaMWZPWlZQT0hEeFN0?=
 =?utf-8?B?b3ZUUHRBcnMzVXpVaC9wRXdkWFlXSnJ6c2szU1hFUXozaEc0RDNrWUhHckRx?=
 =?utf-8?B?a0VUQVlHK3Z2THdRbHBVbGJNdVNpYmFQell3Tk1lSGpBR282ZHA4V2dKUEJX?=
 =?utf-8?B?VURxdTh0b3lXTC84aGYrd1RjMndERUZ0TUd4R293N0FjRm4yRkNydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a319ce89-d7c0-467e-a1a6-08df08651ee3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:51.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQYdYEGomjnBpFXH0xFF4+JNIMxzk4YC8I6Wzp6zUbmTN2c+tTE9EC1rLF0Zr1hRpSgL4yjZu8UGU34J1vZsUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328



On 9/1/26 01:24, Christian Loehle wrote:
> On 8/30/26 12:56, Christian Loehle wrote:
>> This series fixes correctness and robustness issues found while reviewing
>> the CPPC control path. They affect malformed _CPC handling, error
>> propagation, PCC ownership and cleanup, CPC object lifetime, register field
>> access, cross-processor aliases, and Performance Limited clearing.
>>
>> Series structure
>> ================
>>
>> Patches 1-8 are deliberately small, independently useful fixes. They
>> validate the _CPC encoding consumed by cppc-acpi, propagate control-write
>> errors, serialize PCC payload updates, correct 64-bit field masks, and fix
>> descriptor and PCC lifetime handling.
>>
>> Patches 9-15 are the register-layout hardening portion. Geometry validation
>> is more substantial because safe RMW and alias handling depend on the
>> physical access unit, not merely on a logical _CPC entry or _PSD domain.
>> These patches normalize and validate each supported address space before
>> building probe-only physical interval registries. Keeping this work in the
>> same posting gives the complete safety boundary and a single base for
>> review, while each transport and bug retains its own Fixes provenance.
>> Feel free to treat the two parts as independent series, I didn't split it
>> because they're all technically fixes and to get Sashiko review for the
>> whole lot.
>>
>> No interval lookup is added to the scheduler hot path. Full-width
>> SystemMemory writes remain lockless. RMW locking remains necessary only for
>> a partial field, where we must preserve the other bits in its access
>> unit. The existing per-descriptor raw lock continues to cover disjoint
>> partial fields within one _CPC package; probe rejects cross-descriptor
>> layouts that it cannot protect.
>>
>> Parsing and control semantics
>> =============================
>>
>> The parser now validates the package header before indexing it, bounds the
>> BYTE and DWORD Integer forms before conversion, and validates the Generic
>> Register descriptor consumed by cppc-acpi. NumEntries may not exceed the
>> AML package count, but additional trailing package elements are ignored
>> because doing so is safe and preserves compatibility with padded firmware.
>> The parser likewise tolerates trailing ResourceTemplate data instead of
>> imposing a new EndTag compatibility requirement.
>>
>> Capability values read from registers must also fit the u32 fields exposed
>> to CPPC callers. Reject wider values instead of truncating them, which could
>> otherwise turn Highest Performance into a zero divisor.
>>
>> Writable controls must be Buffer-encoded registers. Minimum and Maximum
>> Performance are checked as the pair required by ACPI 6.6 Sections
>> 8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from the
>> Integer-zero convention for absent optional fields, so Lowest Performance
>> may retain the valid abstract value zero.
>>
>> Performance Limited is one deliberate compatibility exception. ACPI lists
>> it as required, but permits a platform with no limiting indication to
>> always return zero, and deployed firmware represents that case with a NULL
>> descriptor. CPPC control does not depend on this status register, so we
>> continue to accept that encoding. A present _CPC package which otherwise
>> fails parsing or initialization now emits an error instead of silently
>> preventing cpufreq registration.
>>
>> Compound performance and EPP updates propagate errors and perform every
>> fallible non-PCC write before modifying the PCC payload. Updates across
>> address spaces cannot be atomic, but a known non-PCC failure can no longer
>> commit only the PCC portion or leave an unsent value for a later command.
>> All requested PCC fields are validated before the first payload store, so
>> a malformed later field cannot leave an earlier value for a subsequent
>> doorbell to commit. Writable Minimum and Maximum Performance controls are
>> programmed even when their requested value is zero, because zero can be a
>> valid abstract performance level rather than an omitted update.
>>
>> SystemMemory locking and support boundary
>> =========================================
>>
>> A partial SystemMemory field requires RMW to preserve the rest of its
>> access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage") used
>> a per-_CPC lock and noted that a global lock would be needed if physical
>> registers were shared between packages.
>>
>> ACPI does not make _PSD a physical-register ownership boundary. Rather than
>> put a global raw lock or lookup into the scheduler path, this series makes
>> the cheaper per-descriptor model's assumptions enforceable at probe.
>>
>> Supported SystemMemory layouts are:
>>
>>    - naturally aligned 8-, 16-, 32-, and 64-bit access units;
>>    - lockless full-width controls;
>>    - read-only aliases;
>>    - exact writable aliases, including partial aliases of the same logical
>>      field, when the complete access is one aligned native transaction;
>>    - disjoint partial writers within one descriptor, serialized by its
>>      rmw_lock, when neither must preserve another write-only field; and
>>    - a partial writer sharing an access unit with a disjoint read-only
>>      field, except Performance Limited.
>>
>> Probe rejects overlapping logical fields involving a writer, another field
>> inside a full-width writable access unit, non-identical cross-descriptor
>> partial writers, writers sharing Performance Limited's access unit, writers
>> which would preserve a write-only neighbour, unaligned accesses, and exact
>> writable 64-bit aliases on 32-bit kernels. These layouts were not safely
>> supported by the old per-descriptor lock or generic writeq(); rejecting them
>> turns possible corruption into a visible probe failure rather than removing
>> working support.
>>
>> PCC access and locking
>> ======================
>>
>> The PCC protocol requires OSPM to acquire the subspace before changing its
>> command or payload. Single-register and EPP updates now hold pcc_lock
>> across ownership acquisition, payload staging, and command submission.
>> Concurrent Phase-I callers intentionally store the same true value to the
>> pending-command flag under the shared side of pcc_lock, so that store uses
>> WRITE_ONCE(); transitions back to false remain exclusively locked.
>>
>> ACPI 6.6's implementation example places a mandatory 32-bit Delivered
>> Performance Counter at unaligned PCC offset 0x116. Performance controls may
>> also use byte-multiple widths such as 24 bits. PCC therefore uses
>> byte-oriented I/O with explicit little-endian encoding for zero-offset,
>> byte-multiple fields from 8 through 64 bits. A short per-subspace payload
>> lock protects concurrent aliased copies made under the shared side of
>> pcc_lock; it does not replace the protocol ownership lock.
>>
>> Bit-level PCC fields require RMW and remain unsupported. An unsupported
>> optional field is marked absent, but a present inaccessible CPPC Enable
>> fails probe because OSPM must write it before using CPPC. Thus the
>> ACPI-legal one-bit CPPC Enable used by the specification example is a
>> documented kernel limitation. The old accessor could not program it
>> correctly either, so an explicit error is safer than silently proceeding
>> without enabling CPPC.
>>
>> Every retained PCC field is bounds checked against the shared-memory
>> region. A subspace-keyed interval registry permits read-only overlap and
>> exact same-control aliases while rejecting every other writable overlap
>> across processors. A lifecycle mutex serializes allocation, reference
>> updates, first channel setup, and teardown of each shared PCC object.
>>
>> SystemIO support boundary
>> =========================
>>
>> SystemIO supports Bit Offset zero, naturally aligned, full 8-, 16-, or
>> 32-bit accesses ending at or below port 0xffff, including legacy Access
>> Size zero when Bit Width supplies the size. Partial fields never worked
>> because the driver neither shifted them nor preserved adjacent bits, so
>> they now fail visibly instead of being misprogrammed.
>>
>> On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected or
>> disabled according to the affected control's semantics. Runtime accessors
>> also return -EOPNOTSUPP rather than treating an I/O port as a
>> physical-memory address. A global port interval registry rejects
>> cross-processor writable overlap.
>>
>> Write-only and Performance Limited controls
>> ===========================================
>>
>> Between _CPC revisions 3 and 4, Desired Performance changed from
>> Read/Write to Write, and revision 4 added write-only OSPM Nominal
>> Performance. ACPI 6.6 Section 4.6.3 says reads from write-only positions
>> are undefined. Explicit reads of both controls are rejected. Partial
>> SystemMemory fields remain writable because RMW replaces every bit of the
>> field and therefore does not propagate its undefined readback, provided no
>> other writer shares the access unit and would preserve that field.
>>
>> Performance Limited is sticky, write-zero-to-clear, and requires
>> interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old separate
>> read and write could clear a new event reported between transactions. The
>> clear path now writes zero only to requested status bits and one to the
>> other defined bits. Partial SystemMemory forms remain readable but cannot
>> be cleared because a spinlock cannot interlock an enclosing RMW with
>> platform updates. Probe also rejects another writable field sharing its
>> access unit. QWord forms cannot be used on 32-bit kernels, where the MMIO
>> accessor may be split into two 32-bit operations; naturally aligned,
>> full-width QWords remain supported on 64-bit kernels. Since CPPC control
>> does not depend on Performance Limited status, an unreadable description
>> marks status access unsupported instead of rejecting the processor's
>> otherwise usable _CPC. Its physical range remains visible to overlap
>> validation so another writer cannot evade the status-register conflict.
>>
>> Lifetime and cleanup
>> ====================
>>
>> CPC descriptors are released through their kobject callback, keeping their
>> storage and mappings alive for outstanding sysfs references. Every PCC
>> allocation, reference, and acquired channel is unwound on probe failure,
>> and the per-CPU PCC index is initialized before every early return. PCC
>> allocation uses a separate temporary result, so its success cannot turn a
>> later parse failure into a successful probe return. Shared PCC allocation,
>> reference updates, channel initialization, and teardown are serialized. A
>> repeated processor start reuses an already published descriptor instead of
>> resetting its PCC index and leaking or detaching the existing state.
>>
>> Changes since v5
>> ================
>>
>>    - Kept Lowest Performance zero valid while starting the arm64 artificial
>>      energy model at its first positive capacity step, and made every
>>      present _CPC initialization failure emit the common CPU/errno
>>      diagnostic.
>>    - Checked completion of a preceding PCC command before writing the direct
>>      half of a mixed-address-space performance request.
>>    - Coalesced exact SystemMemory aliases behind one interval-tree node and
>>      promoted a live alias on teardown, avoiding quadratic probe work on
>>      large systems. Also skipped registry allocations for descriptors with
>>      no entries in the corresponding address space.
>>    - Stopped treating unused Performance Reduction Tolerance and Time Window
>>      entries as writers, and retained disjoint fields when a narrower
>>      full-width write cannot touch the overlapping read-only access unit.
>>    - Preserved inaccessible write-only controls in physical overlap
>>      validation, and tested whether the other writer's access unit actually
>>      covers the write-only field before rejecting an asymmetric layout.
>>    - Restricted writable PCC controls to their DWORD width, coherently
>>      disabled an inaccessible Minimum/Maximum pair, and ordered PCC payload
>>      bytes against completion and doorbell accesses.
>>    - Classified a SystemMemory field as writable during overlap validation
>>      only when both its _CPC semantics and validated access permit writes.
>>      This keeps partial Performance Limited status fields shareable after
>>      their unsafe clear path has been disabled, while still rejecting an
>>      actual writer sharing the status access unit.
>>    - Preserved an inaccessible 64-bit Performance Limited physical range on
>>      32-bit kernels while marking reads and writes unsupported, so a
>>      neighbouring writer remains detectable without mapping a split access.
>>
>> Changes since v4
>> ================
>>
>>    - Validated all requested PCC control widths before the first payload
>>      store, preventing a later malformed field from leaving an earlier
>>      staged value for a subsequent doorbell to commit.
>>    - Marked the intentional concurrent same-value pending-command store with
>>      WRITE_ONCE().
>>    - Serialized shared PCC allocation, reference updates, channel setup, and
>>      teardown, and published channel readiness only after initializing its
>>      lock and wait queue.
>>    - Rejected another writable field sharing a SystemMemory access unit with
>>      a write-only field, because its RMW would preserve and replay undefined
>>      readback.
>>    - Rejected capability values which do not fit the u32 interface instead
>>      of allowing truncation and a possible zero divisor.
>>    - Programmed writable Minimum and Maximum Performance controls when the
>>      requested value is zero, which is valid when Lowest Performance is zero.
>>    - Reused an existing CPC descriptor on a repeated processor start instead
>>      of resetting its PCC index before a retry could fail.
>>
>> Changes since v3
>> ================
>>
>>    - Allowed partial SystemMemory Desired and OSPM Nominal controls when RMW
>>      discards their undefined readback, supporting NVIDIA's separate 9-bit
>>      controls in _CPC revision 4.
>>    - Reported an unavailable Desired Performance control as unsupported from
>>      the common getter instead of returning a synthetic zero.
>>    - Required natural alignment for SystemIO access units, preventing faults
>>      on architectures which implement port I/O through Device-memory MMIO.
>>    - Kept partial Performance Limited fields readable but not clearable,
>>      rejected another writer sharing their access unit, reported fully
>>      inaccessible forms as unsupported instead of returning a synthetic
>>      zero, and consolidated each nonfatal fallback into a single warning.
>>
>> Changes since v2
>> ================
>>
>>    - Relaxed the exact NumEntries/package-count match to tolerate safe
>>      trailing package elements while still rejecting any count that could
>>      cause an out-of-bounds walk.
>>    - Made patch 10 independently preserve immutable-autonomous setups whose
>>      inaccessible Desired Performance register requires RMW, rather than
>>      relying on patch 11 to restore that exception.
>>
>> Sashiko v2 review not addressed
>> ===============================
>>
>>    - Kept Guaranteed Performance Buffer-only. The suggestion was to accept a
>>      nonzero Integer, but ACPI 6.6 Table 8.23 permits only a Buffer for this
>>      entry.
>>
>> Sashiko v4/v5 review requiring no code change
>> =============================================
>>
>>    - Kept nonzero Integers restricted to entries whose object type includes
>>      Integer in ACPI 6.6 Table 8.23. Guaranteed Performance and Energy
>>      Performance Preference are Buffer-only registers.
>>    - Kept Desired Performance optional only when OSPM advertises CPPC2 and
>>      Autonomous Selection Enable is encoded as Integer 1. ACPI 6.6 Section
>>      8.4.6.1.2.3 explicitly requires that immutable encoding; a writable
>>      Buffer does not qualify.
>>
>> Deferred follow-up work
>> =======================
>>
>> Sashiko also identified a broader pre-existing lifetime question which this
>> series does not attempt to solve. In-kernel accessors read the per-CPU
>> cpc_desc_ptr without acquiring a reference, while processor teardown can
>> unpublish and eventually release the descriptor and its PCC data. The
>> kobject change here fixes the concrete sysfs lifetime bug, but a NULL
>> pcc_data check would not protect a caller which already holds a stale
>> pointer. Closing this properly requires defining the kernel accessor
>> lifetime contract and then using CPU-hotplug serialization / safe
>> referencing across all callers, therefore will be handled by a follow-up.
>>
>> ACPI-legal bit-level PCC and SystemIO fields also remain unsupported. In
>> particular, the ACPI example's one-bit PCC CPPC Enable register cannot be
>> implemented by the old whole-value accessors. Supporting these
>> descriptions requires transport-specific field extraction and an RMW
>> operation which obeys PCC ownership or safely preserves adjacent SystemIO
>> bits, just accepting the descriptors would silently program the wrong
>> value. Therefore continue to disable optional inaccessible fields where
>> safe and reject a present inaccessible CPPC Enable control.
>> Full support, if even needed, belongs in a separate follow-up.
>>
>> The review additionally suggested validating the complete AML
>> ResourceTemplate, including its EndTag. We currently validate the Register
>> descriptor we consume and tolerate trailing firmware data. I don't really
>> see the point of ever doing this, but definitely not in this series,
>> where I'm trying to guarantee that no reasonably working platform is
>> regressing.
>>
>> Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
>> reviewing:
>>
>>    https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
>>
>> Patches 3, 5, 6, 9, 10, and 15 address findings from the follow-up review:
>>
>>    https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>>
>> Patches 1 and 10 address findings from the v2 review:
>>
>>    https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loehle%40arm.com
>>
>> Christian Loehle (15):
>>    ACPI: CPPC: Validate the _CPC package header
>>    ACPI: CPPC: Validate _CPC entry and control semantics
>>    ACPI: CPPC: Propagate performance-control write errors
>>    ACPI: CPPC: Use 64-bit masks for register fields
>>    ACPI: CPPC: Serialize PCC single-register payload updates
>>    ACPI: CPPC: Serialize PCC EPP payload updates
>>    ACPI: CPPC: Release CPC descriptors through kobject
>>    ACPI: CPPC: Release PCC data after probe failures
>>    ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
>>    ACPI: CPPC: Reject direct reads of write-only controls
>>    ACPI: CPPC: Validate and access PCC register layouts
>>    ACPI: CPPC: Validate SystemIO register layouts
>>    ACPI: CPPC: Validate PCC overlaps across processors
>>    ACPI: CPPC: Validate SystemIO overlaps across processors
>>    ACPI: CPPC: Clear Performance Limited without a stale read
>>
>>   drivers/acpi/cppc_acpi.c     | 1807 ++++++++++++++++++++++++++++++++++++------
>>   drivers/cpufreq/amd-pstate.c |   12 +-
>>   include/acpi/cppc_acpi.h     |   11 +-
>>   3 files changed, 1569 insertions(+), 261 deletions(-)
>>
>> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
>> --
>> 2.34.1
> 
> +CC AMD maintainers

I've tested this series on top of 7.3-rc1 on a handful of Zen5 and Zen6 
client hardware.

It works correctly on Zen5 with this series as is.
With my CPPC patches on top of it for Zen6 it works correctly.

Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

