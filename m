Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C83385D7A;
	Tue, 25 Aug 2026 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691220; cv=fail; b=TssBbg7MU7Vu+2ziNK0opbISi7fbqb1QGxj9oTEDdC4R1IRQBAFYGYXIvlcKORvB2hrHV8r+MSgAnTVEre92LQ41ZygukRLsQWR/eAmqZJl++iVYz8H0/1n9bSYa66f3nrumR7GLFh12knQdbxZljdUXiOaU8luv4HE8ri2Cu9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691220; c=relaxed/simple;
	bh=W6imzJx6Lq75XxHazjCQfG3VHpdq5+uaUVQAwhB+ilA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uvTVxkzdkRLbwDlIEDUbWmVonWZ94xH2fVNRVsOSzA/RcyuT6RzyF0+Wv+c0hsedSZEHP380BvTTj9GjZsZv9CAeucHO77VtxHgdmYo/CH1pJ960cM/DUe8Nf3hiRxHxcYOFaw6ylgDiYKk0YSAhtkIOYnNgQhFASICWifyGbak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gl0wiUTZ; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gl0wiUTZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9vVXMR+VzIvhD62Hu51Ok4VWoK5RJpa9C/uPf7AlkAvii/7eN8paaNPI6od3AeIoXA6g7hFkati8A4CASm64S3k9/D7FPYn5P8asw64Ek8Fw+AXG4egVKbul1UhzA652IzVhMET2aICoHowzWhytyiPFvMM7MkjK4UXtPY8bYZuvnVVJN6gNGb+EvD8NW0eq6gyApYTF4gU2fjp15/enQeywWdFQbWZJQ942IrHSXsNtQNU+2wSEd9GwEP+PmEkyUWhGL9j7CNsG5qcG2avRcQ8xWOTbUqxIjuS7pXC+wWmAfA/b8KQqKz5RTrjbYl70b4HdwgP9Ek1bDpbsNmuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkOnL/cUi2c0m5CBKrhmAhJkmurKJMVrjGhCfa/+Mg0=;
 b=lI5GOxNJeMXZ7sEPSuiJ68ng4AloAqM5VJVGUHF9gfUDDJWSL5LqxJvi6GBR+vGDqTLM6tfFDnWzccDTqH0E6OXO0CdHegWoqTo7M9V7dKRDTytbfACDo6G9YKo8gMWpr9suv90Aylw6cg0bG0suquXOi5gUbE1/Kq6rr+afLLXMjU7gF7yKYpscOPgeZVKLYGAnVoiwxPh44zVUd9A1ou/0+ct++v9Q0JYfd1WgmlFdPYawQOQSHulzVWYdEjgyZbt7RMlJwaoCERUIlBY2q2rk8Z2tquR7mijqgQ+6k/ByLYVRQHlxZUsatpkZ6JNPeivP/dfMnBJ5BTykIHivTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkOnL/cUi2c0m5CBKrhmAhJkmurKJMVrjGhCfa/+Mg0=;
 b=gl0wiUTZsXXojX8a1KJDrXtbNjGAMTps0yVO5/cTZjexVtSzM3WraRN1mc8Bv1eJH7+2j1Su8iLbnyArnJGGQXp5gxmUzK+BuTqBBzoq0537WUdVSqNuWqP3x1s1rVyYM/QddLFzPZ3u60+84WGXgsow0Ycg1I7O6Ox2bB9d3sDwWx2ygrdLGFnUqeHd8VQm0Wjn246e/lIlAscRohj6g0jSGNBQIJpM2FokizPvKoTVt6rU3Y1dNwttD8xE/+MG3gUqdImLPSGf18f2DaPqtgDBErm3dbAFGO9JWLlrEWuCo8mddisEJPpK5v6W6UvbbQC5qrvP7jOvKEZ6ppqCDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 20:53:30 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 20:53:26 +0000
Message-ID: <d6a147d7-e416-4f2c-ad25-700d4fa0abf3@nvidia.com>
Date: Wed, 26 Aug 2026 02:23:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] ACPI: CPPC: Fix register access and lifetime
 bugs
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, K Prateek Nayak <kprateek.nayak@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 jarredwhite@linux.microsoft.com, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>,
 Shubhang Kaushik OS <shubhang@os.amperecomputing.com>,
 vanshikonda@os.amperecomputing.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260809062549.1415955-1-christian.loehle@arm.com>
 <15234e9c-b9a5-434d-836f-e2e2ebc036c9@arm.com>
 <3a23d54c-5ce6-4225-82d3-453e7133fdf1@nvidia.com>
 <ef37d738-4b25-4609-8bf0-6c2322ecbd02@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ef37d738-4b25-4609-8bf0-6c2322ecbd02@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: faceb884-85a7-4f6b-abb9-08df02eae8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|5023799004|11063799006|10067099003|4143699003|6133799003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	P4eypoWtDZdeJnmUfCOltFFPg1AFrQCnEqqsNbblDBuUilsrZRRAr2e8Uk16+FqyWL3uiIKfH8KJ2dvZRY/Azjq6KP4u1lkOPK/Y6+UsDHKX1hP7TqEgzK1s6tjRLhWsaGk9R5rpInHf/d3/TYBRiHQod6+DZB9F6Zaa2Ejv1JIBtLsJmHrpyMTVFYwxzjFR0x95wirIp5NtRpEfOICB4y2gIGkmfgT3wW3ygJlMU5sq8AzbgiO/DlD4QBtTxM1YYQ3t0Znvwu3Wb0cJxDwgwkbyRKV3lgVtcaAFkFN6VuNrpK9E3gVFgCope8tnKQ+X7MlkyQqculyiciziZaZmn6ZRdV7xneimFIig55JbZrVnopUDnFips7Oe9JSfsP65CFasEU97uipNs6MgSUmeHLt9j2iTNVAEInMmsHsvO/lf5U1x9pi2UQOX8A6LRJwVeaYVH05ov2mH1BAqorMw+QjPW76HRCquToaO6lv3D/Y3HqN7HqX3QcjnqniZcyAFKDE8heVTOOJvXe8TgT75K7cDvYLxDGRn/1Z5/7PLvBTuLFe6/jKeKAW67fpNXPB+z0YdGruRBGEeL2ib4XZhPO9dg9jP54ENd6LvGsvHPy1gohFrnQ1OmuOs0xukL2Bn04hrgIqi8lv3x+qkov6Zd0SCs+XMPmziK6Z/FKX3MAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(5023799004)(11063799006)(10067099003)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5XcUEzZEcrVnhMb3VsdEpCYTFWUUs1V1A0clV6bW1JYlVqK0YxVGdNV0V5?=
 =?utf-8?B?UmYwbUh6UllZOWl1UjN6c25mMDRBTkRnNGYybVcyV2hRaVljUUFRcTVSVGE4?=
 =?utf-8?B?TFlhcmlxQ1JtV292bUQ1eEVZd3NYRGEzRVBSRWFxWVBKU3BvZnhjdWMrZWVS?=
 =?utf-8?B?NjFHa1grcExyTmtFR3pXNG4waUFEOURxT2JZY2EwK0s1bWtJRENpVHlySGdk?=
 =?utf-8?B?K2ZwMmpLem16WFVFZHBQMWMvUFdkN1BjRlhjRkM1d2lnUG1DOFcvR0hxRjg3?=
 =?utf-8?B?U0l1R090OUx6RHdvTjBEUkVqSUdRajNhQ2szM0lLOXRnMEdYcEo3YVdXRHFr?=
 =?utf-8?B?enpjczc1MWxBRThzL3k5YjhOUU9jNzRDN01sc3NCOTBOZlI0YTQ5VGIvZnA1?=
 =?utf-8?B?anB1NlF0ekljNDh3aytzaUpRMVkycDgyZHZiWnhGZkFDYjBGZy9YUkRVNVJP?=
 =?utf-8?B?WmVsTE9kbm1LL05hWkp6WDZuMUUvWUYrUVBMZ0tMME9Qa2JyRHI3NFljaGoz?=
 =?utf-8?B?QTVvTElIZXlkV0I3SGxIZVIrQ00vZURsdXNLdzZXQkxST2NLSnkzRStOdkg4?=
 =?utf-8?B?SWNoWW9OSXRkdG52RzFSMG1nOVRPV3EyUis0NXhsdUF1ajNmcWZJb2pyUGto?=
 =?utf-8?B?Zk5nL09nQ1NseUs2T3ZjWmJ6d1FzUmhLdkRWLzdsbm9BZCszbDNVMGlZYWN6?=
 =?utf-8?B?OUs1VG5NbUtEbkRMakY4eGNER2J3Wlh6Vy8rK2VXVmpSNldEbXJiQVVnMGVH?=
 =?utf-8?B?eUdMenhuUVQrMkNCVHprcHZjRXh1ODB6Q1ZUYUFIcU9WZGhyRXBjQW1sQjNJ?=
 =?utf-8?B?eU9HLzJOMlBvQk5vWCtJSHFHZkZZbm9DOE5zeWk4cm8xTUIzVS83bWVNYVZM?=
 =?utf-8?B?UnFqUkVTdFBEZDV1TkFJbFQ4amNHbEpSN2ZWL0QxY01Nell0VDUwL3c4NUFh?=
 =?utf-8?B?M2NEVFVoZlVMK2VWQkZGVU9nbWJlcHhGbTlsN3MzUkI4ajBCa1M1cTh6a3Zy?=
 =?utf-8?B?elRtd3JYL1hxTXh1N1dOd29SWlA5b25DZnliV2VreUJYRFB0OTd2a1dOUURH?=
 =?utf-8?B?OEdDZUZqcitXTUtYc3RJRDMvVHArcXoySGUvVDhWc2ROanN3b1dBM0oyZjE1?=
 =?utf-8?B?M0hKdnBXMGluT0xEd25Xdlg1d0FXa0gzTldKTzIxaGRMVkJwajBoNXM5dTgy?=
 =?utf-8?B?dWdXV2t3cEVyR0N6dEN4Zy9ySFdUUVFGTjlBNnZFd3V1NzljclNDYWxXZURY?=
 =?utf-8?B?aTI0ZWx6bzNXOEprK1BmZUxaZUFZcStPZ3pOT0V4WTd5V0tsSnhQKytlcUpz?=
 =?utf-8?B?ZVN4OWNkeW9rWDFaT3QxQ0t2eTF1N2hqSzBHczB1clZmZEp4OVhlTG9LSFZk?=
 =?utf-8?B?SWl1TTMvWVI3TitwakRFeWZyOXIxM2NKZWZnNUwvT0lqZ2FaMzU2dEl4VVRs?=
 =?utf-8?B?VVE3Tm16bnc3TGFndVBBSmNEV3JQSnhkR1lYbDZaVnQ5b3FRKytBeWsyeXpv?=
 =?utf-8?B?aXAraXI1bHVrK2JHOC85cmhTbzJ1RTc5eFBZaGxZVldCMngvOG1leUZQVlNE?=
 =?utf-8?B?SHd4WklYRktmY016a2R0ZTEzcEhLUm16d3E1VmViMUF0aDgyTm45aFV5L2w1?=
 =?utf-8?B?TC9vLzVqblNTQXJ5Z2JIZzZ0blI4VTc5SmlCWXF2Ty9ac3lRNGZpSFR3TWRN?=
 =?utf-8?B?WjVNaTVidUZ2aldZbDdvbDBxRWtQZkRJcVZWWnFBbElTemFGem9ZbkdkZjly?=
 =?utf-8?B?VlBReTd2czNHUCt3Y2tCTHlnYkoxMkhoUmNBalJZZ2pxejFyNVVwSldKem04?=
 =?utf-8?B?VUIzdkwwOTI1TUdlYVlYcVFGS1FPNk44L1kxQlpGTDNiMjBKV2UwV040Z1Ix?=
 =?utf-8?B?a29ZVFhMZzRVd2RVNnBhNisyMmJiSnE0ektwczhsaXRVQnVxeVdmbmRkeEk1?=
 =?utf-8?B?WVhBYW5HMGdYRXlEKzJjbFJBMVZQc0swWmFPR2NqNTdaOW1nWXNDeWNERWRn?=
 =?utf-8?B?aUI3VlpIbWMvekM0UmlGUzdJeVNkdjZhTkFuUmhtdDBYMTBLRE0wK1hDSksw?=
 =?utf-8?B?Qy9lRXpzcjV0TjVCSXgvNnhkWVZoQ0IybU5yeWRqSHppODg4dW5ISE1tZ3J1?=
 =?utf-8?B?RVBQU2xoUGxWVlF6VmpGSlNrTGZZRFN2eVBTcjRnVGszd1AvVHZaZ3RTUlJI?=
 =?utf-8?B?VUYxSkNtQ2hmK0hJTVN6MU94WnI1d3d2Z0pJcUhzQXEzZmJ3bTlOUE9Qd2dm?=
 =?utf-8?B?Y2VOQ3dFUDV0cGw1bldMaUhGM3pQK3cwaGpsaDVhdzVGZk14TVFuWG93SHBC?=
 =?utf-8?Q?39fKzTcuYNDkM5yoMH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faceb884-85a7-4f6b-abb9-08df02eae8b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 20:53:26.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CDce/WNLM2m8OLFgd4uI4IRsNRU+Whus30RgCtfBYBbrKWofvpgd/mhWWGd0fBI7QrK5AIOlTOaIsvyXQ1Kaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422


On 25/08/26 13:55, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/25/26 07:58, Sumit Gupta wrote:
>> Hi Christian,
>>
>> Sorry for late reply.
>>
>>
>> On 20/08/26 15:37, Christian Loehle wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 8/9/26 07:25, Christian Loehle wrote:
>>>> First of all, sorry this got so out of hand, initially this was just
>>>> trying to fix some relatively simple issues found by sashiko in an
>>>> earlier (unrelated) series.
>>>> But with me touching more and more code and going through rounds of AI
>>>> review that kept finding more and more pre-existing issues I've arrived
>>>> at this.
>>>>
>>>> This series fixes correctness and robustness issues found while reviewing
>>>> the CPPC control path. They affect malformed _CPC handling, error
>>>> propagation, PCC ownership and cleanup, CPC object lifetime, register field
>>>> access, cross-processor aliases, and Performance Limited clearing.
>>>>
>>>> Series structure
>>>> ================
>>>>
>>>> Patches 1-8 are deliberately small, independently useful fixes. They
>>>> validate the _CPC encoding consumed by cppc-acpi, propagate control-write
>>>> errors, serialize PCC payload updates, correct 64-bit field masks, and fix
>>>> descriptor and PCC lifetime handling.
>>>>
>>>> Patches 9-15 are the register-layout hardening portion. Geometry validation
>>>> is more substantial because safe RMW and alias handling depend on the
>>>> physical access unit, not merely on a logical _CPC entry or _PSD domain.
>>>> These patches normalize and validate each supported address space before
>>>> building probe-only physical interval registries. Keeping this work in the
>>>> same posting gives the complete safety boundary and a single base for
>>>> review, while each transport and bug retains its own Fixes provenance.
>>>> Feel free to treat the two parts as independent series, I didn't split it
>>>> because they're all technically fixes and to get Sashiko review for the
>>>> whole lot.
>>>>
>>>> No interval lookup is added to the scheduler hot path. Full-width
>>>> SystemMemory writes remain lockless. RMW locking remains necessary only for
>>>> a partial field, where we must preserve the other bits in its access
>>>> unit. The existing per-descriptor raw lock continues to cover disjoint
>>>> partial fields within one _CPC package; probe rejects cross-descriptor
>>>> layouts that it cannot protect.
>>>>
>>>> Parsing and control semantics
>>>> =============================
>>>>
>>>> The parser now validates the package header before indexing it, bounds the
>>>> BYTE and DWORD Integer forms before conversion, and validates the Generic
>>>> Register descriptor consumed by cppc-acpi. NumEntries may not exceed the AML
>>>> package count, but additional trailing package elements are ignored because
>>>> doing so is safe and preserves compatibility with padded firmware. The parser
>>>> likewise tolerates trailing ResourceTemplate data instead of imposing a new
>>>> EndTag compatibility requirement.
>>>>
>>>> Writable controls must be Buffer-encoded registers. Minimum and Maximum
>>>> Performance are checked as the pair required by ACPI 6.6 Sections
>>>> 8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from the
>>>> Integer-zero convention for absent optional fields, so Lowest Performance
>>>> may retain the valid abstract value zero.
>>>>
>>>> Performance Limited is one deliberate compatibility exception. ACPI lists
>>>> it as required, but permits a platform with no limiting indication to
>>>> always return zero, and deployed firmware represents that case with a NULL
>>>> descriptor. CPPC control does not depend on this status register, so we
>>>> continue to accept that encoding. A present _CPC package which otherwise
>>>> fails parsing or initialization now emits an error instead of silently
>>>> preventing cpufreq registration.
>>>>
>>>> Compound performance and EPP updates propagate errors and perform every
>>>> fallible non-PCC write before modifying the PCC payload. Updates across
>>>> address spaces cannot be atomic, but a known non-PCC failure can no longer
>>>> commit only the PCC portion or leave an unsent value for a later command.
>>>>
>>>> SystemMemory locking and support boundary
>>>> =========================================
>>>>
>>>> A partial SystemMemory field requires RMW to preserve the rest of its
>>>> access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage") used
>>>> a per-_CPC lock and noted that a global lock would be needed if physical
>>>> registers were shared between packages.
>>>>
>>>> ACPI does not make _PSD a physical-register ownership boundary. Rather than
>>>> put a global raw lock or lookup into the scheduler path, this series makes
>>>> the cheaper per-descriptor model's assumptions enforceable at probe.
>>>>
>>>> Supported SystemMemory layouts are:
>>>>
>>>>     - naturally aligned 8-, 16-, 32-, and 64-bit access units;
>>>>     - lockless full-width controls;
>>>>     - read-only aliases;
>>>>     - exact full-width writable aliases, including 64-bit aliases on 64-bit
>>>>       kernels;
>>>>     - disjoint partial writers within one descriptor, serialized by its
>>>>       rmw_lock; and
>>>>     - a partial writer sharing an access unit with a disjoint read-only
>>>>       field.
>>>>
>>>> Probe rejects overlapping logical fields involving a writer, another field
>>>> inside a full-width writable access unit, cross-descriptor partial writers,
>>>> unaligned accesses, and exact writable 64-bit aliases on 32-bit kernels.
>>>> These layouts were not safely supported by the old per-descriptor lock or
>>>> generic writeq(); rejecting them turns possible corruption into a visible
>>>> probe failure rather than removing working support.
>>>>
>>>> PCC access and locking
>>>> ======================
>>>>
>>>> The PCC protocol requires OSPM to acquire the subspace before changing its
>>>> command or payload. Single-register and EPP updates now hold pcc_lock
>>>> across ownership acquisition, payload staging, and command submission.
>>>>
>>>> ACPI 6.6's implementation example places a mandatory 32-bit Delivered
>>>> Performance Counter at unaligned PCC offset 0x116. Performance controls may
>>>> also use byte-multiple widths such as 24 bits. PCC therefore uses
>>>> byte-oriented I/O with explicit little-endian encoding for zero-offset,
>>>> byte-multiple fields from 8 through 64 bits. A short per-subspace payload
>>>> lock protects concurrent aliased copies made under the shared side of
>>>> pcc_lock; it does not replace the protocol ownership lock.
>>>>
>>>> Bit-level PCC fields require RMW and remain unsupported. An unsupported
>>>> optional field is marked absent, but a present inaccessible CPPC Enable
>>>> fails probe because OSPM must write it before using CPPC. Thus the
>>>> ACPI-legal one-bit CPPC Enable used by the specification example is a
>>>> documented kernel limitation. The old accessor could not program it
>>>> correctly either, so an explicit error is safer than silently proceeding
>>>> without enabling CPPC.
>>>>
>>>> Every retained PCC field is bounds checked against the shared-memory
>>>> region. A subspace-keyed interval registry permits read-only overlap and
>>>> exact same-control aliases while rejecting every other writable overlap
>>>> across processors.
>>>>
>>>> SystemIO support boundary
>>>> =========================
>>>>
>>>> SystemIO supports Bit Offset zero, full 8-, 16-, or 32-bit accesses ending
>>>> at or below port 0xffff, including legacy Access Size zero when Bit Width
>>>> supplies the size. Partial fields never worked because the driver neither
>>>> shifted them nor preserved adjacent bits, so they now fail visibly instead
>>>> of being misprogrammed.
>>>>
>>>> On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected or
>>>> disabled according to the affected control's semantics. Runtime accessors
>>>> also return -EOPNOTSUPP rather than treating an I/O port as a
>>>> physical-memory address. A global port interval registry rejects
>>>> cross-processor writable overlap.
>>>>
>>>> Write-only and Performance Limited controls
>>>> ===========================================
>>>>
>>>> Between _CPC revisions 3 and 4, Desired Performance changed from
>>>> Read/Write to Write, and revision 4 added write-only OSPM Nominal
>>>> Performance. ACPI 6.6 Section 4.6.3 says reads from write-only positions
>>>> are undefined. Explicit reads of both controls are rejected, as are
>>>> SystemMemory layouts which would implicitly read them for RMW. Full-width
>>>> writes remain supported.
>>>>
>>>> Performance Limited is sticky, write-zero-to-clear, and requires
>>>> interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old separate
>>>> read and write could clear a new event reported between transactions. The
>>>> clear path now writes zero only to requested status bits and one to the
>>>> other defined bits. Partial SystemMemory forms cannot be used because a
>>>> spinlock cannot interlock an enclosing RMW with platform updates. QWord
>>>> forms cannot be used on 32-bit kernels, where the MMIO accessor may be
>>>> split into two 32-bit operations; naturally aligned, full-width QWords
>>>> remain supported on 64-bit kernels. Since CPPC control does not depend on
>>>> Performance Limited status, an unusable description disables that status
>>>> register instead of rejecting the processor's otherwise usable _CPC.
>>>>
>>>> Lifetime and cleanup
>>>> ====================
>>>>
>>>> CPC descriptors are released through their kobject callback, keeping their
>>>> storage and mappings alive for outstanding sysfs references. Every PCC
>>>> allocation, reference, and acquired channel is unwound on probe failure,
>>>> and the per-CPU PCC index is initialized before every early return. PCC
>>>> allocation uses a separate temporary result, so its success cannot turn a
>>>> later parse failure into a successful probe return.
>>>>
>>>> Changes since v2
>>>> ================
>>>>
>>>>     - Relaxed the exact NumEntries/package-count match to tolerate safe trailing
>>>>       package elements while still rejecting any count that could cause an
>>>>       out-of-bounds walk.
>>>>     - Made patch 10 independently preserve immutable-autonomous setups whose
>>>>       inaccessible Desired Performance register requires RMW, rather than
>>>>       relying on patch 11 to restore that exception.
>>>>
>>>> Sashiko v2 review not addressed
>>>> ===============================
>>>>
>>>>     - Kept Guaranteed Performance Buffer-only. The suggestion was to accept a
>>>>       nonzero Integer, but ACPI 6.6 Table 8.23 permits only a Buffer for this
>>>>       entry.
>>>>
>>>> Deferred follow-up work
>>>> =======================
>>>>
>>>> Sashiko also identified a broader pre-existing lifetime question which this
>>>> series does not attempt to solve. In-kernel accessors read the per-CPU
>>>> cpc_desc_ptr without acquiring a reference, while processor teardown can
>>>> unpublish and eventually release the descriptor and its PCC data. The kobject
>>>> change here fixes the concrete sysfs lifetime bug, but a NULL pcc_data check
>>>> would not protect a caller which already holds a stale pointer. Closing this
>>>> properly requires defining the kernel accessor lifetime contract and then
>>>> using CPU-hotplug serialization / safe referencing across all callers,
>>>> therefore will be handled by a follow-up.
>>>>
>>>> ACPI-legal bit-level PCC and SystemIO fields also remain unsupported. In
>>>> particular, the ACPI example's one-bit PCC CPPC Enable register cannot be
>>>> implemented by the old whole-value accessors. Supporting these descriptions
>>>> requires transport-specific field extraction and an RMW operation which obeys
>>>> PCC ownership or safely preserves adjacent SystemIO bits, just accepting the
>>>> descriptors would silently program the wrong value. Therefore continue to
>>>> disable optional inaccessible fields where safe and reject a present
>>>> inaccessible CPPC Enable control.
>>>> Full support, if even needed, belongs in a separate follow-up.
>>>>
>>>> The review additionally suggested validating the complete AML
>>>> ResourceTemplate, including its EndTag. We currently validate the Register
>>>> descriptor we consume and tolerate trailing firmware data. I don't really
>>>> see the point of ever doing this, but definitely not in this series,
>>>> where I'm trying to guarantee that no reasonably working platform is
>>>> regressing.
>>>>
>>>> Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
>>>> reviewing:
>>>>
>>>>     https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
>>>>
>>>> Patches 3, 5, 6, 9, 10, and 15 address findings from the follow-up review:
>>>>
>>>>     https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>>>>
>>>> Patches 1 and 10 address findings from the v2 review:
>>>>
>>>>     https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loehle%40arm.com
>>>>
>>>> The series is based on Rafael's bleeding-edge
>>>> 77acf59d7cf1 ("Merge branch 'acpi-cppc' into bleeding-edge")
>>>> the base-commit specified below is linux-next for Sashiko review.
>>>> It applies cleanly on either.
>>>>
>>>> Christian Loehle (15):
>>>>     ACPI: CPPC: Validate the _CPC package header
>>>>     ACPI: CPPC: Validate _CPC entry and control semantics
>>>>     ACPI: CPPC: Propagate performance-control write errors
>>>>     ACPI: CPPC: Use 64-bit masks for register fields
>>>>     ACPI: CPPC: Serialize PCC single-register payload updates
>>>>     ACPI: CPPC: Serialize PCC EPP payload updates
>>>>     ACPI: CPPC: Release CPC descriptors through kobject
>>>>     ACPI: CPPC: Release PCC data after probe failures
>>>>     ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
>>>>     ACPI: CPPC: Reject reads and RMW of write-only controls
>>>>     ACPI: CPPC: Validate and access PCC register layouts
>>>>     ACPI: CPPC: Validate SystemIO register layouts
>>>>     ACPI: CPPC: Validate PCC overlaps across processors
>>>>     ACPI: CPPC: Validate SystemIO overlaps across processors
>>>>     ACPI: CPPC: Clear Performance Limited without a stale read
>>>>
>>>>    drivers/acpi/cppc_acpi.c | 1298 ++++++++++++++++++++++++++++++++------
>>>>    include/acpi/cppc_acpi.h |    7 +-
>>>>    2 files changed, 1116 insertions(+), 189 deletions(-)
>>>>
>>>> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
>>> Gentle ping on this in particular to the CCs not involved in the merge window.
>>> Even just a Tested-by: that the new CPC validation didn't break your platform would
>>> be appreciated!
>> Tested the series on linux-next-20260824.
> Thanks for testing, can you dump the CPC descriptors for both revisions?
>
>> With firmware reporting _CPC revision 3, every CPU logs:
>>    ACPI CPPC: CPU0: Performance Limited register cannot use an interlocked SystemMemory access
>>    ACPI CPPC: CPU0: ignoring inaccessible Performance Limited register
> Assuming the detection here this is expected.
>
>> cppc_cpufreq still probes and frequency scaling works, though
>> perf_limited interface reads 0 rather than reporting the
>> register as unsupported.
> Ack, I'll fix the getter.
>
>> With revision 4, every CPU logs:
>>    ACPI CPPC: CPU0: _CPC v4 Desired Performance register requires unsupported read-modify-write
>>    ACPI CPPC: CPU0: Performance Limited register cannot use an interlocked SystemMemory access
>>    ACPI CPPC: CPU0: _CPC v4 OSPM Nominal Performance register requires unsupported read-modify-write
>>    ACPI CPPC: CPU0: cannot access _CPC register 5
>>    ACPI CPPC: CPU0: failed to initialize _CPC: -22
>>
>> Here _CPC initialization fails on every CPU, so cppc_cpufreq does not
>> register.
> It would be nice to have your CPC descriptors here, but in case the detection isn't wrong we
> have:
> Desired (5), Performance Limited (13), and OSPM Nominal (21) inaccessible

The detection is right. All three are SystemMemory with Bit Offset 0 and
Access Size 3, so each is a partial field inside a 32-bit unit:

   Desired              9 bits
   Performance Limited  2 bits
   OSPM Nominal         9 bits

Revision 3 describes identically and OSPM Nominal is absent there.


> I'm assuming this platform supports both 0 and 1 for AUTO_SEL_ENABLE.

Yes. Autonomous Selection is a writable 1-bit register, not a fixed
Integer 1. It reads zero, so nothing is forcing autonomous mode.


> We can disable Performance Limited then and OSPM Nominal but Desired we do need
> (unless the kernel forces AUTO_SEL_ENABLE=1?)
> We clearly cannot do a RMW on a write-only register (CPCv4), the only solution which
> may be possible is that we write all registers that lie in Desired access all the time,
> but that really depends on what registers those are. In case these registers are
> from other policies this would equate into a global lock, which clearly isn't what
> we would want.

Every SystemMemory register in the package occupies its own DWord, 8 bytes
apart. No other _CPC described field shares these access units, on this
processor or any other, so no cross-descriptor serialization is needed.
Fields described outside _CPC are not visible here.


> Any suggestion how this platform is supposed to work here?

Where the access unit is not shared, could the read be kept,
or the full unit written instead?
Both write only controls are 9 bits at Bit Offset 0, so the driver
takes bits 8:0 from the new value and only bits 31:9 from the read.
Those upper bits lie outside the register, so nothing undefined is
used or written back.

Thanks,
Sumit

