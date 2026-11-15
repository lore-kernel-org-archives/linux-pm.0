Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794752186;
	b=q6inptfTWD0PlD2eFJfmFjeG7kFri7HjaZrFrDJsXgxjWZR7Hgc84LqaRXhfSTC29/a3
	 TmvftmBmhCyAe9rDcICOso1fqYfEKkS09g2NMGz13Ms0Gq1zcYGgtEgedD++KmiIX/Kdv
	 ZYTEh61Pd0YIKvYSLTXwE7NsV9UHul6PdLxH7Lg8kNRJWdR4IEiJR6QeGKx/DtjD9KiZU
	 WJBQw3vEIj2NaNG5KQjKlX6fz1ydLsChZlmIApyrctYQxTaYIw45yxKm+85JK5KAqXj24
	 eqfpnvrt6p/c0zCXxvwxp+g/hazeeZtaPQQS0dcQRWBFP7+m+ikgOkyWwgo8akJ4paA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752186;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
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
	bh=IdNOFIujtAPnfWFBMP6V+WUZ1WSu9AXOBnSonF3VLaU=;
	b=jbYt3g49+NAfy6J+Tx3951wRrZLgRIv6A8VcG9mA4lySIEdPmXCNZqHjLdWORQ7L5yY1
	 2jJAQY4X1qeJhuhMbstFQ9O3szpoMxs0ou2zAsdAc0SM445lL9Xraorsk9s0n7i5jEcE2
	 F8Dn9ODyJIMAvcIh2SI6xf+NdSR2CzJf7MjFC4k/NX0AZHdsN/JVCypSd2kzRxMzmDBux
	 qYITdeSut4+/3SIzjcj0hTaM3gajbo6qipUWukNU6MZ5pqdxUSbbPqZmHS83lLvhzi7ri
	 wU0BTpewAaejSKSrv74H2CexX/wyg9lJp88Z/wxaNVsLgIO0BuvuA1o4R8sUfnJjm7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fsP8n8Np;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA6606A31F;
	Sun, 15 Nov 2026 14:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0DA6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fsP8n8Np
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9TDMc9TWp0LDlrIEqWbjhJd2jVDz1utWq+zEapZrTpi3EL24FUTTnvtE3CCBU1CGTn+CzryVMUsl4We4EPj1Y6ArsyLPFWb0YpZNfj+BZLKwNmhD03rBAgOytwb9zZAMvu4sH0+qktQvylmBCJkMdOW2uR1KaemWl6Xs5EDA5W0F/kgjsDMz3Mcz5pHf0AMHgUBai8FhDnf0qm3qxc4VWkoMa1YKVLkfrRUmnpmGSVFL/Zz9+07p1SOn05aL2tacmwr6x0N+kwCsGwrG85x2xaayneTwHLoag8saYrPoqXJyRqLXTifSpBGMNLU5D0l7yfjwZWPIS/sB4YEZlMnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdNOFIujtAPnfWFBMP6V+WUZ1WSu9AXOBnSonF3VLaU=;
 b=v2KD5pC5YgD5RadRuIzwi3gST8au5dC3rRbM61Zm2+fVmrSnMxHVVzfbkdBJreqXlK7pj8CjjPYOze0BYkZPdRF4/hpsTJOdDUBi2aPKidztYhCxgQCnM8s29XPqn+Lk9+IOHaGNdV/PlE7pBVaQBRg7jU4XoYnyZI67616Dw/rOyyKlHSvTCd0AflDumND5rSMl+Jwd5TrqkOGa2XWBBcI3Vh6ZHLyC4hz0bDIQZdFp8EHr/5nCotQS2TfTQtcpzAYixH3bJ20FI6oowzegGba6oQL5CWw7aK4Ot2W1L6TsB5reyZYnXj+Tun/V9HwYPw2tw/+R20XcT28c6GOSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdNOFIujtAPnfWFBMP6V+WUZ1WSu9AXOBnSonF3VLaU=;
 b=fsP8n8NpJq8RLRzC6bLFMp6A3kzuiBi4BkZO/QI8sfpq++cH3v+9xcGW2/zb7FxsH+UUUnNWL3dEawxdxJx3xJYpDTEpYVTr8mhe0PZG/N/YaIv/HQjGOK2kJfkiYtQm/0FziGgwSXxO3I8JOtfDsKakK8Y10/jYthkPQshoV7I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 14:16:22 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 14:16:22 +0000
Message-ID: <404553c5-60b3-464a-8d76-7850120f3d58@amd.com>
Date: Sun, 15 Nov 2026 08:16:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/amd: hfi: Stand down when amd-pstate CAS
 is active
Content-Language: en-US
To: Vishal Badole <Vishal.Badole@amd.com>, ray.huang@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org, perry.yuan@amd.com,
 kprateek.nayak@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krishnamoorthi M <krishnamoorthi.m@amd.com>
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
 <20261114150310.1377654-3-Vishal.Badole@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261114150310.1377654-3-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:21::14) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ae279d-e086-42e6-622c-08df43230682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|921020|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AaMCMn5TBVhCiNRnns4NJGUwr/Nag2AOK8dPeI8SMzpEwUKRqRvZ7Wc6hLv0zmijtki60xoldss0Us1Orj3dBtbyiG7EDjz1betQZBCeJhMle/5HzQy0Jic9v2PoX/Fob/qCXcvrVsmbgrj9U1ngUNodgyyoYIEgJhZxfHPJUY8SmtNkW8rpaRXfzcNqE08iIZD5AjEBcCURm6enP/M0fTRsZHp5DrbOMRN+AsP7ns5RLcAsyeKHRa3Kh9yv9guR71wTySiO4XvhnERe9c9pK/B2YzgxmpfZtY+lHzSMItmPF2soQ8qHKrlX2990KdAQtr6Ow8tYpB+EndO3m9SLf8rSVq8uXYfjnKE1CpTpTOr2dlUOspezeJp1FC2DNbxv1EO4LSCMVo/WtTZhh4+d1t6Oqrnh06uEwC6htJ0aapwCn4BioEx66hUHG0eP2JQPbkvJxvyZwohIM8d+CanxvDQD6hjrqK4hmci2hfD/c61SK3IoFOKoqWt3HadM0Tt+TZzFML7pO44aeXeRcV1u29q6Hhl1vYrMa7crFVjSlmeby8nW8x4IWokfbvAhyZ35YiW0oAk2LSozaQ2OU3Mww0Zsg8Vwm0Zdm0vRzzVxfnmTkTzKPO2hkfRDoDDSNNvos1IzJPRjMgdZvH0UzCU7McdBR23VT0x9Et6HolWytSKrtwQ7vy/gM4u1FDYn36nD9Xyw8clXgfQDQcqnOVkYsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXM4OFEyQStZZmN2NVJlYktnSW1vM2hJdGMxdFZHblh6VnJBM0pmRy8vREZw?=
 =?utf-8?B?bDk3dkpDajlrVFYyYmpiSTNRdWtxcFFhOHhUbEprUDg1K1Z4dFQvYnlxVUFQ?=
 =?utf-8?B?Z2FKWEdkZWRmenlrUkZCdmJhclkvMm1jT3N2KzhsdEwvRm42a25qSmVKV3ZH?=
 =?utf-8?B?K3hQTCtCRHRNOGJmb29WM3JDd0VEVFdLM2pFRzNHdFBoRCtGMUJZVTVka2Zx?=
 =?utf-8?B?VnBuTjdFMm5nZnZCUXlvczE4bFU1eWRsOE0rR2FPVHhnLzF0c2NOcWN1eFo3?=
 =?utf-8?B?dk9kNjJhMTYrZWJHdTZ4TVh5NlZKZm9MaEN5c1o0ckdXKzBmdjdESzJvbG5C?=
 =?utf-8?B?R25xeTNZd00wMmg4aGdtRjVxb0JWQzBkeVIwNmFiT3d2eHA1Y2kvL29nWk1n?=
 =?utf-8?B?d3lPeVQ3NWh3SGJoK1JUaVVoQlh2ZkUyblVoYjh3RDFRRXUrWmIrUDNERHJJ?=
 =?utf-8?B?VGg3YWgvdUZNMGM3eXc0MDZNem1DMkViM0pzcUV6RFlaZFZLL1dyWlNuNkZ3?=
 =?utf-8?B?MlFPV0Vxa1FIMDNVWHFnVlh4eldrNTVWYW9iSHFVa0NIZ0w3WmxVbGd5SGN6?=
 =?utf-8?B?czlyM2cyclZNSW1FV1FQKy95VTZLRW94UkpmL01GTHJxS2FaSngxQ05ObFBT?=
 =?utf-8?B?d0ZpNFZpeUVkUXdOUi8wV04rVXNhN2JjNkJ3RkVOVFFtbk1lczNLTXRQbWE2?=
 =?utf-8?B?Wkx0QkVodGcvdXVzSjgyaUEwMzJwWG82aDhKRW9Kb3FyK3F6NklpQTZsZXFZ?=
 =?utf-8?B?WUplbTBxT242bXBoSVBhdE52OUlUZThMMUVKS1VRMmZIVjFvaDdsNE9TRmVi?=
 =?utf-8?B?RFhyZWNZWndEbXVMRER2RUxNbU01NkwvVEZpRnVoMFhla2ZzY3dPcGtKRlQx?=
 =?utf-8?B?clVjanFvYnAra0tKUEdhaWs4YkxqeFJwQ0t6Sm8yY1ZYSEoySlZyQk4zei93?=
 =?utf-8?B?eXpHRVN1SWl2S1l3czlRTitqSnFFd2NIR25aWFlPUHd5TDFLOWFPYVRCVWVY?=
 =?utf-8?B?cGpTZUhhb0dVWkRRMzB2TUcwajFtL1pMWTN1NkRWdWk3dk9zYmIrVXRkT3dk?=
 =?utf-8?B?VFc1Rkh6N3A4TWdHVDBBWlZsdWNjRW84Y2Y5UU5vMnlQMHFhdHhGcGEvZ2Zj?=
 =?utf-8?B?U0lFczgxbHV5SGNrR0FSaUFiUnhSeTVFOGdvMDUyZTl1TllNM01ydXE3WEtL?=
 =?utf-8?B?Vk05SlBlblFsalV1ZVN0YTV3VEtLSGx2V3VuZ2Z3MmhlVmNhRXZ2ZmdJUlFV?=
 =?utf-8?B?dnkxYm42RlVUa3AweEkxTitRYThJUnhUOU5VNSttcGIyd0dkdWljOUhzUGwv?=
 =?utf-8?B?b2tqYnJYNzBFdGFlaVZSTWRSMnNxZlFPYnBHRjgybzVZU0VXdFdqR0VCUk1S?=
 =?utf-8?B?UlFYakRCdWpEUnNNU0tMZlNXbkJTSFkyT1lnaEgycnhsbi9DVzlxYWJlVU83?=
 =?utf-8?B?aVNZVXVlNnFJT0ovWjlmL3RqQ3QwTmhNbE8wWEhjYi9wN3ovaTJ6QWRzbGZT?=
 =?utf-8?B?SDE1dlJlRFlPQWFQUlYyVEhMczVSWnRkTCt5ZWIrTVpGaG5XKzkrcWFRNEE2?=
 =?utf-8?B?QzRnazVyRXd3dFJHOWd4VWdrZUlCMkltMjZxYjRiUllIMWVsdVh5TXYxWW9G?=
 =?utf-8?B?SWVSVCtxMmZvNnJtV2grM2RPL0Irb09nNklJUDZFdzljODlKU1pDWk14MnAx?=
 =?utf-8?B?UXBYTUJTU3BpaW1DbmRQWEhNL1ZJUUQveXBBRWxxdVRuTWpCOFJoVUdVQ0pW?=
 =?utf-8?B?RVg1R0RpUitSNWcyTzRSTUx4MGhhUWJlMEhGQUJTZUQzSk1LemRBNzdCclJE?=
 =?utf-8?B?Z3E5UFZLYmd1d1Nod0ZEUmFSaTlYajJ0b1hFdzFmNWp3YzZQRTZRNFBlSWNW?=
 =?utf-8?B?RlB2THNYQmZzMWg5YlB1WjEvRkw5Zm0rbWZaUWZoMldzbzl4QS83UUxYMk0r?=
 =?utf-8?B?V0tnN0Uzb05INSt1c0tpWElDRFB6US9NQzlNYTNhaHlVbkRHTXo0S29DYytB?=
 =?utf-8?B?ZHd6K2Jvcy9RUW5tTVJQc0VFdWVKZ09kaVZubU5BU05TM3FkUDJnQlBrZUFY?=
 =?utf-8?B?WUY4Ui9ka1hxMFVBSHBUdnpINUl1a0E1OTdBMzFFMjcxc2IyTkRnZ0psMmVL?=
 =?utf-8?B?Q2w4RGNBVGdKNXRObVNxOVdUZ2RDdEtManpoRloxc3pLK0srSWloWk8xSlJv?=
 =?utf-8?B?SXRYMmhLbmhiZU0wV09ITmpQUndVZ01oaEtIN0kvTUIrOVFHK0JHTXdhRmd2?=
 =?utf-8?B?UVR0ZVJtVEZHWnJDRWIxOC9Rb0docFUwc05JYStIN01STXpWb0t3VDl5cm1F?=
 =?utf-8?B?eFR0a1U1WXU2SExMOVh2alJ0WFZNTWYyNFFRSmJYdU1oTG8xQTFrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ae279d-e086-42e6-622c-08df43230682
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 14:16:22.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qpyc8cQqoOwqdGFikztOJ16Kxl5PEVo1EZmK6TN5fh7D0/0IkXNAMbjYgMrjf+3apqKolkK/tJ/5TbqzeLB6Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810



On 11/14/26 09:03, Vishal Badole wrote:
> From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> 
> When amd-pstate CAS is active, it takes ownership of per-CPU capacity
> values that the scheduler uses to distinguish performance and efficiency
> cores. amd-hfi manages the same scheduler state through its ranking
> mechanism. Running both simultaneously would cause them to overwrite
> each other's settings, leading to unpredictable task placement on hybrid
> platforms.
> 
> Avoid loading amd-hfi if CAS is enabled.
> 
> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>

When a patch is authored by another person and you send it on their 
behalf you need to add your own S-o-b as well.

Think of it like a chain of custody.

> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 86a7f4332c35..b6878614e2bc 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -29,6 +29,8 @@
>   
>   #include <asm/cpu_device_id.h>
>   
> +#include <linux/amd-pstate.h>
> +
>   #include <acpi/pcc.h>
>   #include <acpi/cppc_acpi.h>
>   
> @@ -536,6 +538,12 @@ static int __init amd_hfi_init(void)
>   	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
>   		return -ENODEV;
>   
> +	/* amd-pstate CAS owns heterogeneous core scheduling when enabled. */
> +	if (amd_pstate_cas_active()) {
> +		pr_debug("amd-pstate CAS is active, not loading amd-hfi\n");
> +		return -ENODEV;
> +	}
> +
>   	ret = platform_driver_register(&amd_hfi_driver);
>   	if (ret)
>   		pr_err("failed to register HFI driver\n");

