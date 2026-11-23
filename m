Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430728;
	b=mLvrw10Is9WJTVvXL/7SQpzHcOAuZqVvrL4tfQubvXtk3EQ8hDm0P9pgzavNCWyNnZXC
	 ZV2TAFQwxCK4CYKppTVx0U2Rp/jZA0i38T2eX/kDRNt2dMKvwFPpV3ufCU497f4dXJg6U
	 /V6Gus/4i/5LwokiqYPPg07/vixl+KU0fN+ooD8bOatEfPmPnDSSaYrca8dP4wsUQMzG1
	 aay/JpP/KI8KsiTzDBgD+bKe32dDoYdhhoOfUqYoWP+/hqV8iCLXvQL/4EVZ96Jz+Idtg
	 ZN79rUyKgLpO/D9ox/3ma7TiNXcYU9XaSK4ulPvEt5NFeNfDQ1scgHUIDOyXzXjQT1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430728;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1zzUVvttSHESavHFUCsRteQXsjlmTPHJS+g3HT2pUEE=;
	b=Wkk6u0+NZgceOEH5aZQ857otoPtzIFhumAvpQrTHNXaXMxsGVGThGXOqzwz7CgQuBTrI
	 JsuwqRO1kPM6aVrtMJ8xwc8jO5VxIBTP6Q1JV5daLVQjuW9hiYmWp1z9zcpNHDG9Zq0w7
	 QwNKZtqWdVNpUCmlYG+US5fc4QOAgh50nfBKNLO0PlQatkLCUHcwHaTWXOkqo6CPTVwl+
	 sogOX7OOC4byQkCr6r1LcBZHorNLseNPInQRl3n7F/c3ZGsskHsLHYZdPGbZMIm4Z2R9x
	 norrobsZHlYOEYUwu7mnGIy6G61kmDczulykBkwVmHGZ6UBfZ7XbUoHrVcN1kfGpTyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SKlaU3c9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.17
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E548606A333;
	Mon, 23 Nov 2026 10:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E548606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SKlaU3c9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7ctfhuPgyE2wTDjGJoVAvZZA0T9WblFZaguSZ6Otw9zyRAhtUwVrB3bVyivjvETCbxEgHXf4KAIroUkJ6tRDQrsf9sXTFB2Mg1O7uNX9mCHebKxOyVX5G5q7w6OblB5g6IzQgt7C2Fyw1bocuDBA5UN+IBqT4R4gpbzS+0hGsrHa3QJEB+0z26P8ezc/olQ9DhKCqgItvgZjRzqayLyMTOa+q+ZfwcDuD8YosnEYCi3qO3aCpMjyjFVTZAvgNWNrT2kfBAYEPNewE4Dp9YrTf8Za0RDNFQpeNetKKmH4lsjU7FpM4D7YpXXw4v2Wmv68vNHFzrrvN4umdnf6+tTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zzUVvttSHESavHFUCsRteQXsjlmTPHJS+g3HT2pUEE=;
 b=lZwNCk/UP/GcfpclFzMObn2pW/xZkbi1Bu3rceeMUj3hszIhKH8reIoejM52Fwat7X4Z0bC4rdsVUDjVRH5GV/N/qTsbAL6WSlX+n7XPhFcgHCYHZrJNoetzUSshDjvZAboyStoooKknFsWVW6qvuILOAqPuZt+OCn1FdQkR9O8T4JPrptbVrY9ACV8sTluC9eO/oNd+Sn4pz3cUJsN52GMs5XmlrIi67fiVJQqD4PG8DemTJA1Sk8m23iwV9lPSS6ciHO0LPyHaUKpK3W332YGHj38V9GLhMgpQ7j02vUqPQrZ0h667dgDc4LsziDkxQLfTkFPO7UuL6aRVKyRKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zzUVvttSHESavHFUCsRteQXsjlmTPHJS+g3HT2pUEE=;
 b=SKlaU3c9kJbl/Jb0LA8N2LU7grJKSbbkpdOTS88u6zMTpU/OStNg9ANjMIa3pERuDOAx9yC+oBUlez+BUZIstjn9RqnHIFX0H0A8y/OLVFWsM+9vhQwEozalJ27IcTGmb/2ouCUDo39ArEEt7bnPJw1hDfHb5ZgZEfLJCcIBaOk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by PH7PR12MB7163.namprd12.prod.outlook.com
 (2603:10b6:510:202::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 10:45:20 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:45:18 +0000
Message-ID: <2b15c0ee-39de-4050-a830-b709c7c19213@amd.com>
Date: Mon, 23 Nov 2026 16:15:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: Set asymmetric CPU capacity on
 hybrid platforms
To: Mario Limonciello <mario.limonciello@amd.com>, ray.huang@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org, perry.yuan@amd.com,
 kprateek.nayak@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
 <20261114150310.1377654-2-Vishal.Badole@amd.com>
 <ea92861f-cdf6-4828-9292-b49ad6c21590@amd.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <ea92861f-cdf6-4828-9292-b49ad6c21590@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0226.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::11) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 171f9b87-70dc-4c91-63c6-08df494edd50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|921020|4143699003|11063799006|56012099006|261026121527099003|261102123227099003|261102130727099003|261026140227099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261009221227099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	+0fyiytTpBKBl6hP6OpbnyjjmEUp8azBkBpG7oOO+y00bGoy76Poj6WkCuXXXoeKgNWwrk933V4v04/C5SdIgNZO2eSKyhzMG69c8jGBmNp0zYQ23N6rtBSE6qb8qvK5QuQKM+GlmS7gn5AmOSaUREuVi9o2xGdENc7zocJ5W7oz9RGYXzH4OCA1q9DcDicmyN4el12nZDRf1GUesTc57cSoQUwOX/Y0Qefgd+kuq4ooSjCu82bGYCZyx0DFlyLvOeCufQ3RSl0ZIPh47Y9NVigePKUKEdyzqrA54FDbGaIeYeIwTbLkbSzXNYaAnHFZKByX97Afy+hYXa35ZzRsidXoqJL5iSRp8X+q7fxSDPTpDvL1L6OLVSWLmQV/F72DHMiVFazvC9ZmQVOx0I3JOck+qGFshTnOaLMtBtzxKrCX26VgPAbg0+xnPoSXQGRSVsxA/sA3/9J9qU85jrKYA44zwC9KDBHC5athp1TzlECBMKSC9g1Z+dJNa627ajWwcY9KLMpulCBlKa/AN+IxbfxVegeFdSAi5o21RgPt95MltV9OMSu3ntCyH6XiK8cUo6+9hHO/GUSwrX3sZa8/M1Q3coBLpyYo4LmC3Z5aIjj+Nojzm+jey6lA/IFNtlqoT+03OZug5xJz/IwOt/22q10mPnTKOB86BB5V5PQmGNP0rCOBpm60xtJtMx0XpqGD5pa75k3RtrIfiMF8f5Lvbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(921020)(4143699003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261102130727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261009221227099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGRTVkZSak5OTm84L0ozL04xbjkraVpOa2tIbEVMOVVPcjRsU2YwQmlkVzRC?=
 =?utf-8?B?MEhEdDFIaVF5cUNmYi9QdVM0WUZzb2dUMTdEUFBuNHVRYVZsemJ6M0RiUXNC?=
 =?utf-8?B?SXFKS0Z0cWgwK0hBRG5GV3RhZGVnamd0VVpTUGJpbjh4Rk05dGpKUEczMUZI?=
 =?utf-8?B?d1dGTWFSdVBDV0xoT3NwbFFmY2pSNWF3MlJSY25xemdoSEozRm1VdVFtU3hz?=
 =?utf-8?B?ZDZTaUYzbXlpeGViUkNvbHJ3L2ZRVFBUN3FmdnpUdVdha0g4NnJKdWxxdmND?=
 =?utf-8?B?eUFoR3FRSUxRM1lldFQ4SlBIZ2xuV05zbWl2M2ZZckptakdLN0o1RkZadFdV?=
 =?utf-8?B?RnNHMmJLSTZuTDZIUTN4UmZzS0JtSTI0VExpNU9ZUW54citQVTdub2ZndXVL?=
 =?utf-8?B?am12bWNJTnZCOFhEbWVlamZDczNva05RM1FPV3lQY3pDSkQ1UlhZT0VnOWEr?=
 =?utf-8?B?Tnk1bFVkZEovbVcrVm02eEUwODk1OENDemN1L2R4YTVEbGFrSXQwTHV0VGh2?=
 =?utf-8?B?VnpnOE9EWEgvei9rTHova0J5T3FIeG1Wd2pzVlhFcG5pRU1McDJtR1lKSFVH?=
 =?utf-8?B?bGdlZk0vNVBvRmxoVERsRHlvQVJWaHE3dXBnekNScnozMlVaeU9NN3ArbXht?=
 =?utf-8?B?a1NBSTBsNzhRZm1ldTJxVkF3N25qK1NHWDJTQnpqSUxzcHhJdVFHdlJoekov?=
 =?utf-8?B?dUx1RmVuRWZycXlIMkdyN283N3pvUVFycVhRckhDVDExSVJnSWZPcU1mSkhk?=
 =?utf-8?B?TW1CUEtwcVEycCtXL2EvNC9ocGpxUjNDVFlpNnBUMndpKzVxbWhCRnZOM0JZ?=
 =?utf-8?B?VGpXc2Y4THVNeEtqdHJrZHcxbVFXMDdFNEpRRG5oT0FJWk5IbnFNM0RKT2lC?=
 =?utf-8?B?WEZNRkZ4cGhRNnhyUkZIaGt3VWtnYkNDM1ZVWWtab2FaNE5pNU11MUh4Z3I4?=
 =?utf-8?B?SXZ4cnVzNy9Hb0lSMUNScW91d0p0ZXQxUDhwQ081ZnRORnhvUzFxb2drVlMx?=
 =?utf-8?B?eVhXZlZXRVh6ZVJiOERiTHJwNW9FY2o0SVlGNGNJYU1PMEVKZkFHN1I0dHIr?=
 =?utf-8?B?c3BLUy9YYWNsMis5NXV0WFRxdDhJVFljaEJDdTVWUjVQU1dXL0FxL2FORUdL?=
 =?utf-8?B?Wm5kS2lCL2pUdnI3N3Z1Y1RpYmZEN0FMS3F2L3pNTFc3ZTV4ZytaUEVMZkVj?=
 =?utf-8?B?M0hyU2RpRXc4cTY1ZHYwamJCaEVZMnZVa1RIOWc2d2x0UzAvQTUyMnpxeFIr?=
 =?utf-8?B?ODFnQWNib00wS3BUYllKR3BsNFkvcTVoek5tSEcxQnd6YzNQR2lpRTB1VTF5?=
 =?utf-8?B?Vnk0ZllPem4yVmdoamc5OVFVUVBKL1NzTTYyR3RhSVFSRC9aRkN1RDh0YU40?=
 =?utf-8?B?RHFwYWxneUJlU201NTEzeGlPRXVodDJCRjVrYlhPejFpbytFSmpGSzdNVVBJ?=
 =?utf-8?B?UGt2WGdGbmdnVWs2Y25LQWU1Vktta0dNS3RTVmQ2SFY2ZXJ6eXZ3MlJ6Qy9M?=
 =?utf-8?B?RmNLMjlZU05iYmU2Qld2UUx3bEF1a3BOZVd3NnplajJhcVdNZm1GQnVVVXVp?=
 =?utf-8?B?bUFVV0VUd3RmeXVGeDdVUUZhZUx6cXd1VFM0VVdlaHM4eW94Sm5ObEtIcnFU?=
 =?utf-8?B?UGt3enRyL0IyWEVPa1pqRElGbmgyeWYrVkVrOGk2NnFMWE9uRVFpMjk0dzFi?=
 =?utf-8?B?emgyT0dmVllYbjhVYXo1N2RkVHBzL0VURXNKanBUS2xpaC9HMldpc24xeFMx?=
 =?utf-8?B?aklsMlI3UFc3RW12QzZscm9lM1dyZE13QjRWK0V6bmhrb1BHOFh3bHoveUQy?=
 =?utf-8?B?SkZQeUNjY3FxOHBIR2EwYUliYkdZMitEenNmNkFNamJUQ3R0WWZrc2hZeTBw?=
 =?utf-8?B?U0lIaUN4d3BWbHdMV2llaFdWUUNwQ0Rjd0E2blpSRzU2WnJjSUQ1ZmRMcVNx?=
 =?utf-8?B?c3R0YmxXaHJYWHVGcE9tOE9lbE9kRkQ3TlM0VG03U3lxVzlKdlFBSi9PSUhh?=
 =?utf-8?B?UXdEOUR4bXhSZGU2aWhIQVpCTXlsck1VR0N2dHhGdGtLdFpNV1BZSmFQMmxM?=
 =?utf-8?B?bmRVWkp0NkpmcTFpakFDNjQ4Tk1yTHpRUG43bzdsVUJhTGFraDJONVd1czR5?=
 =?utf-8?B?NndQdjhHNFYwSzlkaW1xYytOajZEMU85UTdHMWtYeDdOMStwUzV6eHNMakdo?=
 =?utf-8?B?N2JJcVVjaUwzYkREVllMVTY4TGptVHdJc1N6R1YwQm16MXd2UTY4VGtDdjlt?=
 =?utf-8?B?TDRwblFiVmhndFNhWlA2dTRoTk9wZnhZaDQzWFpEMGwxVGI4cFFKU3ZXK21y?=
 =?utf-8?Q?8i+SGRJJgX0+aEbdj0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f9b87-70dc-4c91-63c6-08df494edd50
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:45:18.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ncl4uuF42HFj8x7Tx7biESDMFOCapYMO2eUL7l7NOapO6iKzHaNP14dzVWaOhhIbuQix2ph2XFPpO/A6U7dUqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163

Hello Mari,
Thanks for reiviewing this patch.

On 11/15/2026 9:24 PM, Mario Limonciello wrote:
> 
> 
> On 11/14/26 09:03, Vishal Badole wrote:
>> AMD heterogeneous processors combine multiple core types (e.g.
>> performance and efficiency cores) whose maximum sustained performance
>> and frequency differ. On such platforms the Linux scheduler relies on
>> per-CPU capacity values to place and balance tasks across cores.
>>
>> Today amd-pstate does not export any per-CPU capacity information. As a
>> result the scheduler sees every CPU as having identical capacity and
>> treats performance and efficiency cores as interchangeable. Tasks are
>> therefore placed and balanced without regard to core strength, which
>> hurts both throughput and energy efficiency on hybrid systems.
>>
>> This happens because the scheduler defaults to a uniform
>> SCHED_CAPACITY_SCALE when no arch- or driver-supplied capacity exists,
>> and amd-pstate never feeds the asymmetry it knows (via CPPC highest
>> frequency or the effective highest performance register) into the arch
>> hybrid capacity scaling interface.
>>
>> Enable capacity aware scheduling on AMD heterogeneous-core processors.
>> Use CPU 0 as the capacity reference, assuming it is a highest-performance
>> CPU on the supported platforms. Cache its maximum frequency in kHz and
>> effective highest performance once before driver registration, treating
>> these reference capabilities as fixed for the lifetime of the system.
>> During per-CPU initialization, compute each CPU's capacity relative to 
>> the
>> cached reference and publish it:
>>
>>   - When maximum-frequency data is available for both CPUs, scale by
>>      frequency via arch_set_cpu_capacity().
>>   - Otherwise, fall back to performance-register based scaling using the
>>     effective highest_perf values.
>>
>> Record frequency availability before applying the per-CPU fallback. Keep
>> frequency and performance references separate instead of interpreting a
>> boost-ratio numerator in performance units as MHz. The fallback base
>> frequency still depends on each CPU's nominal frequency and performance,
>> so calculate that conversion per CPU. Disable CAS if reference setup 
>> fails
>> without preventing normal CPUFreq registration.
>>
>> Capacity aware scheduling is enabled by default on supported hardware and
>> can be turned off with the "amd_cas=disable" boot parameter. Its 
>> effective
>> state is exposed through the "cas" sysfs attribute, and also exported via
>> amd_pstate_cas_active() so amd-hfi can stand down when capacity aware
>> scheduling owns the heterogeneous cores.
>>
>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/cpufreq/amd-pstate.c | 102 ++++++++++++++++++++++++++++++++++-
>>   include/linux/amd-pstate.h   |  14 +++++
>>   3 files changed, 115 insertions(+), 2 deletions(-)
>>   create mode 100644 include/linux/amd-pstate.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 222b7fc2c3aa..26217272be95 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1324,6 +1324,7 @@ L:    linux-pm@vger.kernel.org
>>   S:    Supported
>>   F:    Documentation/admin-guide/pm/amd-pstate.rst
>>   F:    drivers/cpufreq/amd-pstate*
>> +F:    include/linux/amd-pstate.h
>>   F:    tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>>   AMD PTDMA DRIVER
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 4bedfbfc18b6..59eb2c4c7867 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/smp.h>
>>   #include <linux/sched.h>
>>   #include <linux/cpufreq.h>
>> +#include <linux/sched/smt.h>
>>   #include <linux/compiler.h>
>>   #include <linux/dmi.h>
>>   #include <linux/slab.h>
>> @@ -39,6 +40,8 @@
>>   #include <linux/power_supply.h>
>>   #include <linux/static_call.h>
>>   #include <linux/topology.h>
>> +#include <linux/cpuset.h>
>> +#include <linux/amd-pstate.h>
>>   #include <acpi/processor.h>
>>   #include <acpi/cppc_acpi.h>
>> @@ -86,6 +89,10 @@ static struct cpufreq_driver amd_pstate_driver;
>>   static struct cpufreq_driver amd_pstate_epp_driver;
>>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>>   static bool amd_pstate_prefcore = true;
>> +static bool amd_pstate_cas = true;
> 
> As this strictly requires SMP support, what do you think about this 
> instead to pick the default.
> 
> static bool amd_pstate_cas = IS_ENABLED(CONFIG_SMP);
> 
Ack!
>> +static bool amd_pstate_cas_initialized;
>> +static u32 amd_pstate_ref_freq_khz;
>> +static u32 amd_pstate_ref_highest_perf;
>>   static struct quirk_entry *quirks;
>>   /*
>> @@ -957,8 +964,8 @@ static void amd_pstate_init_prefcore(struct 
>> amd_cpudata *cpudata)
>>           return;
>>       /* should use amd-hfi instead */
>> -    if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
>> -        IS_ENABLED(CONFIG_AMD_HFI)) {
>> +    if ((cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
>> +         IS_ENABLED(CONFIG_AMD_HFI)) || amd_pstate_cas) {
>>           amd_pstate_prefcore = false;
>>           return;
>>       }
>> @@ -969,6 +976,64 @@ static void amd_pstate_init_prefcore(struct 
>> amd_cpudata *cpudata)
>>       sched_set_itmt_core_prio((int)READ_ONCE(cpudata- 
>> >prefcore_ranking), cpudata->cpu);
>>   }
>> +bool amd_pstate_cas_active(void)
>> +{
>> +    return READ_ONCE(amd_pstate_cas_initialized);
>> +}
>> +EXPORT_SYMBOL_GPL(amd_pstate_cas_active);
>> +
>> +static bool __init amd_pstate_init_cas(void)
>> +{
>> +    int highest_perf, max_freq;
>> +
>> +    highest_perf = amd_get_effective_highest_perf(0);
>> +    if (highest_perf <= 0) {
>> +        pr_warn("Invalid reference highest performance (%d)\n", 
>> highest_perf);
>> +        return false;
>> +    }
>> +
>> +    max_freq = amd_get_max_frequency(0);
>> +    if (max_freq < 0 || (u32)max_freq > U32_MAX / 1000) {
>> +        pr_warn("Invalid reference maximum frequency (%d)\n", max_freq);
>> +        return false;
>> +    }
>> +
>> +    amd_pstate_ref_highest_perf = highest_perf;
>> +    amd_pstate_ref_freq_khz = max_freq * 1000U;
>> +
>> +    return arch_enable_hybrid_capacity_scale();
>> +}
>> +
>> +static void amd_pstate_set_cpu_capacity(struct amd_cpudata *cpudata,
>> +                    bool highest_freq_available)
>> +{
>> +    unsigned long capacity, max_capacity, capacity_freq, base_freq;
>> +
>> +    if (!IS_ENABLED(CONFIG_SMP))
>> +        return;
> 
>  From what I can tell; I don't think this is realistically something 
> that can get called since you already check to enable CAS based on this 
> same check (IS_ENABLED(CONFIG_SMP)).
> 
> So please drop this check here.  More later about IS_ENABLED(CONFIG_SMP).
> 
Sure, I will update it in the next patch revision.
>> +
>> +    if (highest_freq_available && amd_pstate_ref_freq_khz) {
>> +        capacity = cpudata->max_freq;
>> +        max_capacity = amd_pstate_ref_freq_khz;
>> +        capacity_freq = capacity;
>> +        base_freq = max_capacity;
>> +    } else {
>> +        union perf_cached perf = READ_ONCE(cpudata->perf);
>> +
>> +        capacity = perf.highest_perf;
>> +        max_capacity = amd_pstate_ref_highest_perf;
>> +        capacity_freq = perf_to_freq(perf, cpudata->nominal_freq, 
>> perf.highest_perf);
>> +        base_freq = perf_to_freq(perf, cpudata->nominal_freq, 
>> max_capacity);
>> +    }
>> +
>> +    guard(mutex)(&sched_domains_mutex);
>> +    arch_set_cpu_capacity(cpudata->cpu, capacity, max_capacity,
>> +                  capacity_freq, base_freq);
>> +    topology_set_cpu_scale(cpudata->cpu, 
>> arch_scale_cpu_capacity(cpudata->cpu));
>> +    x86_topology_update = true;
>> +    WRITE_ONCE(amd_pstate_cas_initialized, true);
>> +}
>> +
>>   static void amd_pstate_update_limits(struct cpufreq_policy *policy)
>>   {
>>       struct amd_cpudata *cpudata;
>> @@ -1043,6 +1108,7 @@ static int amd_pstate_init_freq(struct 
>> amd_cpudata *cpudata)
>>       u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
>>       struct cppc_perf_caps cppc_perf;
>>       union perf_cached perf;
>> +    bool highest_freq_available;
>>       int ret;
>>       ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>> @@ -1069,6 +1135,7 @@ static int amd_pstate_init_freq(struct 
>> amd_cpudata *cpudata)
>>       /* try to look up from BIOS/quirk first, fall back to 
>> (nominal_freq * highest_perf)/nominal_perf */
>>       max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
>> +    highest_freq_available = !!max_freq;
>>       if (!max_freq)
>>           max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
>>       WRITE_ONCE(cpudata->max_freq, max_freq);
>> @@ -1100,6 +1167,9 @@ static int amd_pstate_init_freq(struct 
>> amd_cpudata *cpudata)
>>                bios_min_freq, cpudata->cpu);
>>       }
>> +    if (amd_pstate_cas)
>> +        amd_pstate_set_cpu_capacity(cpudata, highest_freq_available);
>> +
>>       return 0;
>>   }
>> @@ -1923,12 +1993,20 @@ static ssize_t prefcore_show(struct device *dev,
>>       return sysfs_emit(buf, "%s\n", 
>> str_enabled_disabled(amd_pstate_prefcore));
>>   }
>> +static ssize_t cas_show(struct device *dev,
>> +            struct device_attribute *attr, char *buf)
>> +{
>> +    return sysfs_emit(buf, "%s\n", 
>> str_enabled_disabled(amd_pstate_cas_active()));
>> +}
>> +
>>   static DEVICE_ATTR_RW(status);
>>   static DEVICE_ATTR_RO(prefcore);
>> +static DEVICE_ATTR_RO(cas);
>>   static struct attribute *pstate_global_attributes[] = {
>>       &dev_attr_status.attr,
>>       &dev_attr_prefcore.attr,
>> +    &dev_attr_cas.attr,
>>       NULL
>>   };
>> @@ -2438,12 +2516,23 @@ static int __init amd_pstate_init(void)
>>               return ret;
>>       }
>> +    amd_pstate_cas = amd_pstate_cas && IS_ENABLED(CONFIG_SMP) &&
>> +            cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES);
>> +
>> +    /* Enable CAS for processors with heterogeneous cores. */
>> +    if (amd_pstate_cas)
>> +        amd_pstate_cas = amd_pstate_init_cas();
>> +
> 
> This seem to be a pointless variable initialization, especially as it's 
> a global variable and this runs on non-hetero systems too.  Maybe 
> something like this:
> 
> 0) See my previous comment about where to use IS_ENABLED(CONFIG_SMP).
> 
> 1) Change amd_pstate_init_cas return type to void.
> 
>  > +static void __init amd_pstate_init_cas(void)
> 
> 2) Add checks into the function like this:
> 
> static void __init amd_pstate_init_cas(void) {
>      if (!amd_pstate_cas)
>          return;
>      if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
>          return;
>      .
>      .
>      .
>      amd_pstate_cas = arch_enable_hybrid_capacity_scale();
> 
> }
> 
> 3) Change the call in this function to just:
> amd_pstate_init_cas();
> 
Sure, I will include these changes in patch revision.

> That should help avoid some extra variable writes.
> 
>>       ret = amd_pstate_register_driver(cppc_state);
>>       if (ret) {
>>           pr_err("failed to register with return %d\n", ret);
>>           return ret;
>>       }
>> +    /* Per-CPU capacities are set during registration; rebuild 
>> domains once. */
>> +    if (amd_pstate_cas)
>> +        rebuild_sched_domains();
>> +
>>       dev_root = bus_get_dev_root(&cpu_subsys);
>>       if (dev_root) {
>>           ret = sysfs_create_group(&dev_root->kobj, 
>> &amd_pstate_global_attr_group);
>> @@ -2484,8 +2573,17 @@ static int __init amd_prefcore_param(char *str)
>>       return 0;
>>   }
>> +static int __init amd_cas_param(char *str)
>> +{
>> +    if (!strcmp(str, "disable"))
>> +        amd_pstate_cas = false;
>> +
>> +    return 0;
>> +}
>> +
>>   early_param("amd_pstate", amd_pstate_param);
>>   early_param("amd_prefcore", amd_prefcore_param);
>> +early_param("amd_cas", amd_cas_param);
>>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
>> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
>> new file mode 100644
>> index 000000000000..eb750abd20f7
>> --- /dev/null
>> +++ b/include/linux/amd-pstate.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Public interface for the AMD P-state driver.
>> + */
>> +#ifndef __LINUX_AMD_PSTATE_H__
>> +#define __LINUX_AMD_PSTATE_H__
>> +
>> +#if IS_ENABLED(CONFIG_X86_AMD_PSTATE)
>> +bool amd_pstate_cas_active(void);
>> +#else
>> +static inline bool amd_pstate_cas_active(void) { return false; }
>> +#endif
>> +
>> +#endif /* __LINUX_AMD_PSTATE_H__ */
> 

