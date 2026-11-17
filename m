Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794910712;
	b=QMIh9NUPrqrc1zg+BY9CqHhEb1r3uDe/kU9Viy7eV+xhM3G4v2xbnG1vznaZ7CLRrhq0
	 RMcg+CQKoGnIsXl/OK4DwWESReZ08Wd8zsWZvDJ+Xcv7IZSNeTJcWZcvXn2wKnZ3fMGIx
	 QhlvXgisi1zDCiPELM6tkeLSIXxfygT3/6FssRbYewo/LJyjn0DniMg3Rc1UZ9JBcVUmA
	 LV2XkGohcR7+LIbRqgbrySDrzVIaNpe5PnoD7dHNLfGmAlRH9nIuV+XZvjoSHeeA2BX4r
	 ndvGmoMtZ6x7r1X8kCN7jna2qkJ8AE4xS96hunCmKzAR6Ly1UsQDCUNwdizlS/W1chA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910712;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=rN/NFIzg8B3oG9iqQQQt9k0jG+WbIKQOQnfK3DL+zoQ=;
	b=yZuHvVP5J3srPNeS7uUfNDXzQvmL5a5hhRmwWWtejn6dISkIkHgsv9nfDAhWzCQAc3eJ
	 xwLVEpjpL+WLd6Vqxrvm/3kTU7e+ONeTSY5eyrqwBrb9JBFyDWy+9nCGSw1rjoo54Zvuz
	 mBt+c25NNJI4t4e0nhPoLfMnt7y/w4fBeCFvxtLyXbXzviFKLzAxZfQgL7gjlmnYXVWgV
	 hMlL9fZi5YUsicXKmTqlHhBHZMZyUdK8fD4M0hNqOIFVQzG9s6HsdGCD38omDfHuBvnPV
	 Msrzpvqnkb/VKUuFYFP3pHHDvzpuGIYD5NAs+/A6QO6nYOnniIpvUOvNhrlVRkSlQ6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mmPYL400;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.26
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB7606A323;
	Tue, 17 Nov 2026 10:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7BB7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mmPYL400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW6cIpUDW7dQRwZHA7Nw3GYBe7AQRgpJ5RRtLaLPKPQ4Jw66H4dPvvPRjNGRVdiTItNmsxHPIM8D1nCunVjb81eHDtkj0vs4oR9hiP3mMWFDa1uIdM0KnfUqF+IIj/HxmCCqH6b6H7m9LODDdW0WlCuom8aifLLUqAbNM59jQ67lB/r2KvXj2g4SVAvRZWOHbdelTZ4JSnXnF/U7g/f/5uxKeah2jSQ8xuCqPO5Zba0MDaxcWQB9/17ELErUpd44+lYKBa0t5SR2VWGiRoUSkufEeIeelQYrG0CMNSvB7pShBSpYan4FOOFJXbFbabyUTUE4L/sCndyqsBIYt4a21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN/NFIzg8B3oG9iqQQQt9k0jG+WbIKQOQnfK3DL+zoQ=;
 b=qo2TWhhhLHxvRY03A3Z0qEWqjC0zA8rxAyBtp9EKDKhlzEotfZo/KOd47yG71nD8Jisdym9yNnD8ChGySUcbYRDbhPwGkpEjVSr3clxD07/ifEHrKoAOvndDeaZc8xwHHBiKTc7fzZM5WJT2OhorsfgMBIK5LnuOMf3iLHBtzM3jDT8UkwZ55Olf98fYGfocjdp5RdLLQhvdS8MXhz53/IZvdH8TFZcueKC0oaXxfJOHSM5E9X766GbnbhWgE+WmBHAw27C9J1FvbJeszObJAfEgLuF5k3A/rXMM3WuIumIJbSNJYtXeqy8xCAzPpJJjdlrkqBbNIpJGlrx2vq+JYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN/NFIzg8B3oG9iqQQQt9k0jG+WbIKQOQnfK3DL+zoQ=;
 b=mmPYL400iCP1oYiP2C4Uz6qvzLMpxZ6W3Ud0Z/HkqB7C/bvfFEEl14avwkxqSYYh+PNM9MZ/gHvqISLX+uBrcYMDseNXdm2P5tu2Vzc/00Ipv8XtpeisaGvu5V0nH2rrbLYFeghlxgnggt9/YehrCcslXVr2Y6cdUcBavRsCPLOUu1BRqh4yyqCnqj/QDNlx2S99KSQhwI/9wQwwYXC+m6jYjhy0k2RZEtxGUaEgHX2F7RsUSWkbMZK2w4+n1QvkG825Z6I3jRCkC1oaZq9pqv+lswSx7BaaAZwMmHe4OfWsl2rMZaoyML08aN8GFEiRbe97Jogz5egWg5/fBr40/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:18:27 +0000
Received: from SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7]) by SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:18:27 +0000
Message-ID: <ad63fdd0-86d9-4b8b-89ac-7fc3bba6d8dd@nvidia.com>
Date: Tue, 17 Nov 2026 15:48:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] cpufreq: tegra194: Add support for Tegra264
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com
References: <20261104181521.3003578-1-sumitg@nvidia.com>
 <20261104181521.3003578-9-sumitg@nvidia.com>
 <4f680a92-c69c-459b-acc1-c877e88cc265@oss.qualcomm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4f680a92-c69c-459b-acc1-c877e88cc265@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::28) To SA1PR12MB5637.namprd12.prod.outlook.com
 (2603:10b6:806:228::13)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 7694c69b-0d9c-482f-cf3b-08df44941ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|921020|10067099003|4143699003|11063799006|261102130727099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OJC0/LBsdlaIQeXIn7uqwRlWz0wyNKJlkSBx2vY25vHXEjNSyanw6SWgobIKijf1uUDKq/DR1P+WhYEG3wREqSV+VQA0nS8enUujTKCBURc8lw1Q/3muKXPX0DrcJWcfBTm+6HpxbYmSeozcWPlbeWKzfHMUO3LTb4I6eG5blFIf+9Drk9BBnPFfY0jFwdF2ULxXpW2uD4Dq9Ej31kLwBIpBMVZNmGxsRQJDiCj0nU9BKLpg/le2w9DzPkcC3QMrOw/7Wb+MAA0CcdSMZltwj9agRrSVZMnp7aUvijexWYRNl0qQJkRfmuWj8Z0ukrOXVBs+kN3iwmZ1C1jsUg+dCmj/7TT1ahXDCOxlcSIeWm+u1khEjDn5B5SaQzd1MFYVayspiG+jVfVFZAzhzFP/wyajTB3cIoKV8NAr5vd2pJ1hKu4nM5FqkW8OHiKIV/oeTLXLGnrIOy5nc+LKilG/G/gHr1v1KSvokOLIDLVj/sl+4DRxBeLtyA7a2ajrts8ItwwP44Y1MaeycCsjOmmTeiPtPBJOkfhbby0b3FhzG/Pyre/7Cjxt5Hch2OIQAmUaZYNZVfQgXJVyh/giK0FsGlWZylk+MXXSI/Ah01NQLu17kuCliJ8BGvxrJo/6uDD7IFgLZlnk29xoroeAaSgwPUhfDNd9nfT1RO/06W7zA1+w+mzjr6TN+T39Llvv8vpPxLCFOyZ5ghgkf9bXhj7czQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(921020)(10067099003)(4143699003)(11063799006)(261102130727099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkx2bVEzemw5akdjSXZsSHJSb2Iwbzd6ckJoRVdwWkpLTmUwY2o4Yi81cTJr?=
 =?utf-8?B?dnc4eFQzRWR0TjhCM09MUWpVb1Z4cEgwTmlXSVJKQU5PSUdkWlVHSzE0UGl3?=
 =?utf-8?B?aFlZRnZaRDFuZEdPeWxvTlowVnU3RTV2bkk5US9qdkxYY2h4L2ZlSnJXQlkz?=
 =?utf-8?B?MC9vTXlBZytNUjR4UU0zQXJtbSt0QkcweEJGazZ1TG9yRGJOVGhHUk52Y2F3?=
 =?utf-8?B?cHJUanlDcUhRVmZlVTdZVTFZNVpRdmxqZlJRWDZxYkJVUUF1MFBBWG5YKzB3?=
 =?utf-8?B?OXJpeWRaVUZFM3RrNjFRaHZvMXVPdkpLMWtab3JzSi8rSDVuejdZSm9BNlJ1?=
 =?utf-8?B?aEUvcHVRMjdzY01tUUpDSTBYbm9xMS9CWDZTcTdSVHFXYnIrbXVrSXgxY1hM?=
 =?utf-8?B?YndXT1FGaHBRM1IwaCtNS1NTV05vYVRnQmZhRWZ2OGRYR3VweXArNFZLQ0lj?=
 =?utf-8?B?TVFuaCtJWWJ5NS9EWmxZNU1nM09nZm9ENGRwekNjd3JSUlNQeWZTWjdpdm8y?=
 =?utf-8?B?SS8vdHl5YW92MVRJRjZXUW5kaHluRE5hK3FOZWc3OWE3Z1pERnZTTG5QZjFC?=
 =?utf-8?B?NWlSMWRuQ1dQK08xS3pLcnplbjVTK0M5L3hiYUtmaHNJQkZBU2g2NVpUcFN0?=
 =?utf-8?B?ME9FeXh5S3R0Z3V6UzRreGhWSEYwY21IOTJhL3ZvcHBaVnFiZEJtU1NxaWxZ?=
 =?utf-8?B?WGoyMlIyaUVnb2N6SExRYkFKQTdGdDFVUkxQQytMazliMFFXdFAyby9sTHcw?=
 =?utf-8?B?eWk0aFp2ck9WMnBaY0JKaDRYUy9PVFNlVk9JVGJPeGpqKzF0MGRPRUprcWVK?=
 =?utf-8?B?b1ZPeEVoRFdPTjVoNWFqSGtqVURIQVJoSURERXJuTkU4ZXFrWnNoenVRQVBq?=
 =?utf-8?B?WlUxMVhSclRVM0x6S0NmTzQ3Rm9rWGQ2VVVYbXM4RVMvR3FuRkFaUmlCaDMr?=
 =?utf-8?B?MFM5SlNmZlRNK0E5UmpMZEpxcnUrT2Q0ZmVxcTVqUDFNbXFuQ2NsOHRVM0d2?=
 =?utf-8?B?VTlTLzZIb1JrN3JkWmhXeUlYbUxSV2tXZ2dDdzlDODZTbHVwWG1yekRrVkJa?=
 =?utf-8?B?RmF5R21Uc0lMeFNoUU42a3FPZmRDL2IyV3R4akVtUU1iSTZxVHFvV2MrZS9J?=
 =?utf-8?B?UnB4amhoaVhQdDRDbllXMWlQU1NHWFpWNnF3RlNqRnFpbXNtMWQ5bmc0d0F3?=
 =?utf-8?B?MUJuVEN3Q09jVnZzV0g5NFN5bSttaUxFN2JzbTM0eWYrOUFtMWt2UUVSSlhU?=
 =?utf-8?B?TUhsQ0FhS21xZkZzQ2pobHMvZWJpV3lLRC9EZFBEVDBXc2IwT2lJaG0zRCtH?=
 =?utf-8?B?VUo0NEZKU2Y3amZCdVpIbHlBRDNCSUx2R1JTdGFraGE1ZHhxYkxpZ0lTMmhM?=
 =?utf-8?B?QkFnSmZSdDR5VEhvNkdqYjN5d0ZFSFhtb29qeFNwWERXY1RzUTIvZzdPaklG?=
 =?utf-8?B?MDBxdkpJV1YzcFJPUHRacTVFdERnRWlYaTVuNmVabUFTTStnV2ZhbXlwbmRJ?=
 =?utf-8?B?dmVhZkpNbHh5ZE55cEVlQURnTkJPNklpVUJaRHB1VU5oRzZMK3E2TnZwSnIv?=
 =?utf-8?B?bFlFY0pGemZNQm52LzZhY3J1R1NmblU3MW5RbnoxcktpR3A5RTl0VlpudWk1?=
 =?utf-8?B?VkdDSGpydmlma1dZd1FpYVdnZWd5WHJ3OXQ0SU9PZjJRd1pmSnRaMWRNTko2?=
 =?utf-8?B?RDJrMHlPeFFLdDFnOWZQMk94dys0SExNSTFZczIzd2ZtbFp1SG9YQWdhYTRu?=
 =?utf-8?B?R0NEY3I2S0s4Z1BnRHVGSkUyamFsTWM4UlY2alkrVnRSeHBZbk90VnJJbGhy?=
 =?utf-8?B?V3YwaDN0bTUzcFAybWxBWkk2RTM4RkY3TzIrMHRRQ2NnQW9wZUZRNDJkcUJx?=
 =?utf-8?B?ZWs5b0dsdU9UL1JOVm1FOStVQ0pqbkpNOHlTdkZkNTloWk51c1FUQzBaVTM5?=
 =?utf-8?B?WmxNQ0xhOGJlcm5PM3ZubW83WEw2RDJvK3lOblRRQVRia3dxclZpTWEyTjF4?=
 =?utf-8?B?SUFzcGJnUTJWcmdLaitiTTBIWDlUZFZTclhVNkgxaytlRjlIYWxEajRnZDJ6?=
 =?utf-8?B?NVVXNWhQZElwZVZiZDV1YTR4VWNkVjRaSC84Vm9jMVVGRFhrSGZlZmlmbG9C?=
 =?utf-8?B?SEs0OEp2VFZmYlF4Q0kxdDNOU3NTQ2ZzMjBjV05MT2gyN2ZidjlqSWxHdXE1?=
 =?utf-8?B?cG43dy9DNUtzbUtZT0w1ckFMd3p6S2N2ZFp0d0hJSGdDd2NyaHVybjhWOTha?=
 =?utf-8?B?Q2tmRUhHS1JuYTNQNWhEeGh5VUhIQTNSdFZjMDViVHlrMElvbVgvQzc0cUNs?=
 =?utf-8?Q?06XAsR1giFGWwxF/+4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7694c69b-0d9c-482f-cf3b-08df44941ed2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:18:27.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yct1Dwvw1HPn9vK7WD+ZYqwlkbeZx7f65UHJIicOkKvoOuMUFWtM95tIFpb4v8prVD8IH5GRwzjbGVeJ5K52ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909



On 13/11/26 11:57, Zhongqiu Han wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/5/2026 2:15 AM, Sumit Gupta wrote:
>> Add cpufreq support for Tegra264. It requests and reads the CPU
>> frequency differently from earlier SoCs.
>>
>> To request a frequency, the driver writes NDIV to a core_freq_req
>> register in the CCPLEX register space. Two clusters share a
>> cluster-clock unit and its register, so they always run at the same
>> frequency. The driver exposes each pair as one performance domain and
>> one cpufreq policy. Each CPU's "performance-domains" property gives the
>> domain index, which selects the register. If the CCPLEX node declares
>> "#performance-domain-cells", probe fails if any CPU lacks the property.
>>
>> To read the frequency, the driver samples the per-CPU 64-bit AMU
>> counters through system registers. The AMU constant counter is the
>> reference. It ticks at the system counter rate, so the driver takes the
>> reference rate from CNTFRQ instead of the fixed 408 MHz clock.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/Kconfig.arm        |   4 +-
>>   drivers/cpufreq/tegra194-cpufreq.c | 147 ++++++++++++++++++++++++++++-
>>   2 files changed, 144 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index a441668f9e0c..a5482b12be57 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -248,9 +248,9 @@ config ARM_TEGRA186_CPUFREQ
>>
>>   config ARM_TEGRA194_CPUFREQ
>>       tristate "Tegra194 CPUFreq support"
>> -     depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
>> +     depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || 
>> ARCH_TEGRA_264_SOC
>>       depends on TEGRA_BPMP
>> -     default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
>> +     default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || 
>> ARCH_TEGRA_264_SOC
>>       help
>>         This adds CPU frequency driver support for Tegra194 SOCs.
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/ 
>> tegra194-cpufreq.c
>> index 1328aa0a1bd1..0767a6fd6bdc 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -14,7 +14,9 @@
>>   #include <linux/slab.h>
>>   #include <linux/units.h>
>>
>> +#include <asm/arch_timer.h>
>>   #include <asm/cputype.h>
>> +#include <asm/sysreg.h>
>>
>>   #include <soc/tegra/bpmp.h>
>>   #include <soc/tegra/bpmp-abi.h>
>> @@ -36,6 +38,18 @@
>>                       (data->regs + (MMCRAB_CLUSTER_BASE(cl) + data- 
>> >soc->actmon_cntr_base))
>>   #define CORE_ACTMON_CNTR_REG(data, cl, cpu) 
>> (CLUSTER_ACTMON_BASE(data, cl) + CORE_OFFSET(cpu))
>>
>> +/*
>> + * Tegra264 requests a frequency by writing the NDIV to a core_freq_req
>> + * register in the CCPLEX register space.
>> + *
>> + * Two clusters that share a cluster-clock unit form a performance 
>> domain.
>> + * Each domain has one core_freq_req register. The registers are grouped
>> + * in blocks, two domains per block.
>> + */
>> +#define T264_CORE_FREQ_REQ_BLOCK_SIZE                0x400000
>> +#define T264_CORE_FREQ_REQ_BLOCK_DOMAIN0_OFFSET      0x40000
>> +#define T264_CORE_FREQ_REQ_BLOCK_DOMAIN1_OFFSET      0x50000
>> +
>>   /* cpufreq transisition latency */
>>   #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in 
>> nanoseconds */
>>
>> @@ -70,6 +84,8 @@ struct tegra_cpufreq_ops {
>>   struct tegra_cpufreq_soc {
>>       struct tegra_cpufreq_ops *ops;
>>       u64 cnt_mask;
>> +     /* AMU's constant counter ticks at the system counter rate. */
>> +     bool ref_clk_from_cntfrq;
>>       int maxcpus_per_cluster;
>>       unsigned int num_clusters;
>>       bool needs_mmio;
>> @@ -79,8 +95,10 @@ struct tegra_cpufreq_soc {
>>
>>   struct tegra194_cpufreq_data {
>>       void __iomem *regs;
>> +     resource_size_t regs_size;
>>       struct cpufreq_frequency_table **bpmp_luts;
>>       const struct tegra_cpufreq_soc *soc;
>> +     u32 ref_clk_mhz;
>>       bool icc_dram_bw_scaling;
>>       struct tegra_cpu_data *cpu_data;
>>       enum cpuhp_state cpuhp_state;
>> @@ -240,6 +258,78 @@ static const struct tegra_cpufreq_soc 
>> tegra238_cpufreq_soc = {
>>       .refclk_delta_min = 16000,
>>   };
>>
>> +static void __iomem *tegra264_core_freq_req_reg(struct 
>> tegra194_cpufreq_data *data,
>> +                                             u32 clkid)
>> +{
>> +     u64 offset = (u64)(clkid / 2) * T264_CORE_FREQ_REQ_BLOCK_SIZE;
>> +
>> +     offset += (clkid % 2) ? T264_CORE_FREQ_REQ_BLOCK_DOMAIN1_OFFSET :
>> +                             T264_CORE_FREQ_REQ_BLOCK_DOMAIN0_OFFSET;
>> +
>> +     /*
>> +      * clkid comes from the device tree. Reject an index whose 32-bit
>> +      * register does not fit in the mapped region.
>> +      */
>> +     if (offset + sizeof(u32) > data->regs_size)
>> +             return NULL;
>> +
>> +     return data->regs + offset;
>> +}
>> +
>> +static int tegra264_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, 
>> u64 *ndiv)
>> +{
>> +     struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>> +     u32 clkid = data->cpu_data[cpu].clkid;
>> +     void __iomem *reg;
>> +
>> +     reg = tegra264_core_freq_req_reg(data, clkid);
>> +     if (!reg)
>> +             return -EINVAL;
>> +
>> +     *ndiv = readl(reg) & NDIV_MASK;
>> +
>> +     return 0;
>> +}
>> +
>> +static void tegra264_set_cpu_ndiv(struct cpufreq_policy *policy, u64 
>> ndiv)
>> +{
>> +     struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>> +     u32 clkid = data->cpu_data[policy->cpu].clkid;
>> +     void __iomem *reg;
>> +
>> +     reg = tegra264_core_freq_req_reg(data, clkid);
>> +     if (reg)
>> +             writel(ndiv, reg);
>> +}
>> +
>> +/*
>> + * The AMU counters are per-CPU system registers, so this must run on 
>> the CPU
>> + * it samples. tegra194_calculate_speed() queues it there with 
>> queue_work_on().
>> + */
>> +static void tegra264_sample_counters(struct tegra194_cpufreq_data *data,
>> +                                  struct tegra_cpu_ctr *c)
>> +{
>> +     c->coreclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
>> +     c->refclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
> 
> 
> AMU is optional, so arm64 core reads these counters only with
> CONFIG_ARM64_AMU_EXTN and a per-CPU check (arch/arm64/kernel/
> topology.c). Is AMU always enabled on Tegra264, or should this be gated
> the same way?
> 
> 
> -- 
> Thx and BRs,
> Zhongqiu Han
> 

AMU is always enabled on Tegra264.
cpu_has_amu_feat() is not exported, so it can't be used.
In v2, I will change the driver to check for CONFIG_ARM64_AMU_EXTN
and the AMU field of ID_AA64PFR0_EL1. All Tegra264 CPUs are identical,
so a system wide check should be enough.

static bool tegra_cpufreq_amu_present(void)
{
	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);

	return IS_ENABLED(CONFIG_ARM64_AMU_EXTN) &&
	       cpuid_feature_extract_unsigned_field(pfr0, 
ID_AA64PFR0_EL1_AMU_SHIFT);
}

Thanks,
Sumit

