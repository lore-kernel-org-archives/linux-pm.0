Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013082.outbound.protection.outlook.com [52.103.74.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501D31E830;
	Thu,  3 Sep 2026 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400975; cv=fail; b=Vmgfhd5Vw0aGhWsp1WCiLhgThY/M8x4W8BvNXKdudOLmP6qvTb19TKnBZZFRXCZidBfNWwEtAcz+b/84uEyDgJaaFGvWKlEpOGQo336v4+1muIfCCU96hK5eWcGKBfPhT8opxHZF6ZPl54f2VT3WtCs/lBW/OLLe523j41KWk80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400975; c=relaxed/simple;
	bh=f6wEYQWvqOriKRt4yak6qJmZd+fn7Uo4cIu3j1y0Vj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dfmAW1oR/fhC1VnAQYcvARA7gqRqxJ9jRKjNJk6zu8Rc7WZgnY4GQ007Az4txtQVcYwm8kVJmoi8iaY8gVyXaU5aiDymU5GlEqS30T4vidUEvcTtVJnIHwMiekDhRyYWSg/BWHxXXSN4blzF+zZmhlQNcydAYzp9vjCtEKPS+k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vRcQ/afw; arc=fail smtp.client-ip=52.103.74.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vRcQ/afw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNMd8tNN0G+x3CvNkabzkwu8kVWtxRu+bLdPCo/Du5CO4yKi8w6R8z9I1FqFdNwSadH9CNUKuTgVDfFtQehGv3pp0qG8dWufA4PoG+RxrlCxFk/fZwAIQ1KvW30ISBCQlulRuHfYrCcFdcacmnT9xjSWo0bwZjC+o+ra4WoltrxZ5sw++sJlQMBWMQ3vsBGFrET1pydVsd8+ZjcrIg9474P6B6UHAtZ8a2MP+seeNDgt3xp+hLne84U4nQNtiZUn5GRF4kANiwxwT0GZX3gMddQoUYrPlCaXHaSVnluHpN7ZkSWJB8rewpWe0VQuSa58gIVois9OfahQD1jK5mRsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfAhxawOaYZa9lkvyXHvBhddNUbvvSGBeH5yB3yvaAw=;
 b=f7caE2DkC091NAFjfqmjRunRB2MiPHGbiqb/5e9e9bUGmEeDt0s++qRyu48PxXLQOUtQNh3/N2J3TGZBk3+a3Dfr0gL+qxic6OkJIfdBYuyXi+rG+2+NlG++7wnyQ7PJgYGbZmsv1gCKP04WnAJD0ieF/C8xNfkhgouEGqeOexM93eZqJyXDzvVIEDsmr0XjCOo58zQzhwdn6HbHhOnBfUsV+qHsQxvxHgcSNxbnudBdNpuVb9MDEOJ/CBSzY9kukYZmlvyxh0Oe15Q65PLgzNbdbBFMBwKpFb9U47FcZaij+IrTHeup7zH9QKSe9RUxevUPV8UiRNWUoZFvfAIS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfAhxawOaYZa9lkvyXHvBhddNUbvvSGBeH5yB3yvaAw=;
 b=vRcQ/afwV301oOkZmQLz4wzQKPy+LC/bjTufAOUx3jz6XEiqVvRXyEHtNHBXyMbnncXfXyKhtCGrupYPu/Wke9D3e1oWjrhh4wGCW46w3cAflgdb6ytseTEJIluwbRS/1P0dQwF96jehgCY3h0h/qyAfATOqucHAbsDZp210BfOTNIRl55+Xu12mu85qxqsm3oSgf3/SpNx+zV0cADENoQ83Od7PI5YQNCSfPfgmxNTW63wyLVRz/7WLQ9HvCC2hJXLzkwca+xqae2bppaWc+6BFgdRA8AUZYrshK1rbcd0bVao3eEr6Edt8/1vaa7BVEAuQU4Fg1gRsLX1Qv/lpTA==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by KL1PR04MB7367.apcprd04.prod.outlook.com (2603:1096:820:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:02:43 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 02:02:43 +0000
Message-ID:
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
Date: Thu, 3 Sep 2026 10:04:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Hongyan Xia <hongyan.xia@transsion.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
 "huangsj@hygon.cn" <huangsj@hygon.cn>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
Content-Language: en-US
From: jong wu <jianyong.wu@outlook.com>
In-Reply-To: <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
X-Microsoft-Original-Message-ID:
 <2ffa42d8-7a45-49d1-9faf-75cf2466aea3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB4931:EE_|KL1PR04MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: af89c4e5-e777-405b-2c5b-08df095f7089
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19101099003|51005399006|15080799012|6090799003|5072599009|8060799015|19110799012|23021999003|25010399006|40105399003|2607281247196008|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTZ0ZVU4Tlc0M1Jmc3QwMk9uaFl5eWtxdk1DRFBrNUZSb0FlNW1HWGJWNlN0?=
 =?utf-8?B?NGx3Ykk1bzJuQ0xCdDFwVXRzcFlCTENxWkdEV255aGtVVzBzRXpnMFZLK0Zv?=
 =?utf-8?B?REJ5M0ZDY0NYMHVDaWM0ZHowSG5DSlhwbzh3Q01QMnowcFNOTDM1cFBkWUJm?=
 =?utf-8?B?ekJERlIyMlZJZnZ2b2hNaUpDeG1CWFVDSXcyaTlOT1RaZmdNakRiSjI5SlNP?=
 =?utf-8?B?djBxUFdHckQrSVR2eU5PUFVsdWF1MG1ybnJmcUdza0Y3bkx0Z0EyNzRBVWFE?=
 =?utf-8?B?VjNsby93VENzQTExYXlZcDlHZlR2NzlQYXFTR0h1TnVxalc1U3l1dXFRdCt2?=
 =?utf-8?B?WGtWTy81c0NRZG5wclVlQkFhNEpHbThWaUl6cnZZVVRzaU9rZ0VCb2NJYmtG?=
 =?utf-8?B?ZmtHbnl0ZUVSbG5GdW5VS01yNEhZTzZWeUFRYzlLTGQzbkViRXJvRjdRdFJ6?=
 =?utf-8?B?Y2JoYnpwUmFFNFFpbG15SHpLMUU5dysvdEVkc3hPUGk2ZmFRU3NTRS9ZaUlJ?=
 =?utf-8?B?Y2U5c1EvQXllTGxDRlptZ25QVEQwUG5zQ2JvR3VvSlI5bXdUc0xMMUlJc3V6?=
 =?utf-8?B?bUh0K3ZUZVFlc0xQSWxWbFIzVjJhWEtRc1pxeXg2a0lkVjFXbkIzZDA2Vlgv?=
 =?utf-8?B?QURka2UxL01iaUV3ckhoVUE0czR2ZWNaaGxpaExTUXY0Wldwc1Q1WjM5eG9z?=
 =?utf-8?B?dnZ0R1JGUUxrWVFqUENKcmk2azlva0lPQ2hCRGRnajRqcFY0N2NFM0JjWUNC?=
 =?utf-8?B?L1hzaERDSTdvSEUxdzBPWHR2RkRSKy9hblZtWTIxRUtPdnpaaW5Jam43M1JN?=
 =?utf-8?B?MUV1MHcxYkU2SUt2WlNvVzd5Q3lDam1Ja3RxRmFJOVNScU42Y0NZalBPbXJN?=
 =?utf-8?B?ZmkrMVB6bVJBc0ZPKy96bTBlcDVhME1LS1lwZFlOc3BIbGVFWFJKR0dBdm9Q?=
 =?utf-8?B?NkRXMU53akprREhFUCtzUzVmbFk3Z3FRZjFDVXIxOTBoZXNSKzVLc0JOZks5?=
 =?utf-8?B?YnZ2SFBBWUdHRDFrcEdvVE5OQkxkcmZEeHVQbit5WVp1STJWanNnYzZ5Wk4r?=
 =?utf-8?B?NUdJcmFlUDJ6U1RmU3hmOXpXNXhpMDNwRFNWd2NHNGg0SWJ6ZHBHbWQveUZl?=
 =?utf-8?B?QjFjdDYvVUxUekpnSm1VUGJ1dnJsZ2xmTDFiWCtOaHN4dnQvUHA0RXJWaFlZ?=
 =?utf-8?B?NDJTRHdMd3pEd1lBcEh1QUtpTU51OStXU09ybXA0MllpcGRiUjJ4NmtXYzB5?=
 =?utf-8?B?UkJnTm1oRGdWL1d2MFVxKzJxN0x6Y3QvLzIzNko2enlhMFEvZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1pHcG5DREI2NWp6aTZ3bW53dmVEanhvNlNJa0t6WjUrc1FyQmFKZmQxYW44?=
 =?utf-8?B?RU9vNXdPaWtra2NGQkVDYXVZTmhjb0x1Y1pPcjkrSnZQSDJqbThlRHBaN1dQ?=
 =?utf-8?B?UEJrdGwxMERUZm5uKzQxMzREaHB4M29yUFR3SFNMR012R0dxNFlsQlhUMHBS?=
 =?utf-8?B?Y2tRNGh3S2tSSlNlc21ocUJRMjR0S2ZZQ0ZWSkdZMjlLYWlKTS9WK2F6bFBG?=
 =?utf-8?B?S1NCMXV2OFZmeWVhWkFGdGg1c2lucG5lWUlPZi9wQ3ZXZXBKYXd1WXR4U0Fv?=
 =?utf-8?B?aE1kdkdIV1JIdFdSbGZTYUYya3hJcGJvK3FwMGlXYlhUQUoyQUtnSFk0RjNJ?=
 =?utf-8?B?QlBROUloUW96cWVwWlRPREVOc2FuYmQydnJjSDJEWUtQT1c3REQxLzBtOVpJ?=
 =?utf-8?B?UHBoZ0xzWllnQzBuaWVDdVd3bUQxTDB5bi96VUQ1dFlzcjdQSmo0eitHUTVv?=
 =?utf-8?B?TkRDSjVLUW5UVUZWcHdUZ0V0ZVRYQUZQcWtiZG5NTG0xVHJGQ2lVbWQ0cFBN?=
 =?utf-8?B?NzZ0VFRvZlliRy8yNVJtMTg0VWc0MDdCZGphaUR2QXF5cVRKL3VlZW1Zc3cz?=
 =?utf-8?B?WWk0MmQrSis0MFV4SkxEdXNNR202ZjB3TjB2S0Q0VjNiVzBFZjduYUxUdmMx?=
 =?utf-8?B?N3Vick5meE01bUhwZE1qSVRnSkQvWFdaS2s1WTRnWTVVazJIdk1ZUGVxNThs?=
 =?utf-8?B?TVY2VnJ6UVpOVVJHRmwyQTJWQVBIV0gwZHVxZUxrODhpVDI5eG1tQUZ6Y0JK?=
 =?utf-8?B?VUZMVVRqUHh6QURudGxSVktuU1Z3UUk3bFhNT2N5ZlJJSHVjV2kwd3c0OTJX?=
 =?utf-8?B?RjhQNEt3d0l5Nkp2cE9oL0N3REl3VDMwTk53TEt0TTNLbVYzWHBhemQvRHZC?=
 =?utf-8?B?ZHVjeE5zOEgyRktMTFVvbSt2YVRZUHpBNkxrRmt6TXlCTDQ2VWoxTUNodE92?=
 =?utf-8?B?THVldXJOU2phK1JwNHNEdFRNWVZnTjhMcHJGT3JYVElFQm9lYkhQVGx6WWpO?=
 =?utf-8?B?T29OSFZZRlNlRmlDdjdXczRSWnR6MXBVNGZ5ZmhuajZHSU5rV3N4ZkFuSVBl?=
 =?utf-8?B?bzgrSHgrclpZeHRvSU9YYXJ0alpTemNSV0tKMVZINHk5Y2hiT0QrbWVETHk1?=
 =?utf-8?B?d3JjV1o1RmNNZTNhRUtCNWNTTlBZZHJNUmFCc0Uwam9FckNGaHI5ay8wWWdK?=
 =?utf-8?B?cmw3d0sveFR0YVhqeFFRbWFjcU5kWWwvbmpWWDN4N0VLdVdSblplYjZDKzFT?=
 =?utf-8?B?Q24xeHNWOGJJek91b3c2WmNsOUtRRDlKanVRSkNjbzhrYTFNL000MTcxYm5X?=
 =?utf-8?B?TlpDRkxGUFJ5bURlL3RBbUJHNFY1dXY4T0VBdXpiOHVpOUUzM3JuVzY5OE5I?=
 =?utf-8?B?N1RkMFBxQmw2VTRQY3dJTFVFc05FRFNZbU1yZlg4cjBmSlRXU09mbVFjUllJ?=
 =?utf-8?B?MDdQK2V6M0ZKYXNEckhTdVVURkhwYWFpR2NrRm10NklWWWRQZ1RYaTIxanB2?=
 =?utf-8?B?Y28vZGV5aWswQ2Z5clVtTGEzdXkzWkFlUStCenJGQ2dGMFZjY2I0OEtQT3pQ?=
 =?utf-8?B?M01sRURMRGJpeFhuT3JEbVlna3N3QTM0SWlxZDJaVU5HUjZBSkZ3YTlBWVBm?=
 =?utf-8?B?RGJFYkhpNFRjOUV0bGViSE9kdGxmajY5RHRRNXhBRDcvWHEyTHR3b2tmclFv?=
 =?utf-8?B?UGpka1dJNVp6b2ZpNlV4S0d2STN4OVdTV0tZaEU5L2VGbXhuRkpBNUliQnBD?=
 =?utf-8?B?RmFnZG9zRVdEcHFoQWhxMUQ2SC9Qd21qNDc4ektEdDFQamhodHB6NlVWSzZL?=
 =?utf-8?B?ZEtzNEtveUdTVVFGTlIrVVlNb3VkNDBRbVpPRDZNZE9UL0Q1THJRYUZtZkhv?=
 =?utf-8?Q?HQlTlNxEU17/e?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af89c4e5-e777-405b-2c5b-08df095f7089
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 02:02:43.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7367



在 2026/9/2 17:37, Hongyan Xia 写道:
> On 9/2/2026 4:49 PM, jong wu wrote:
>> 在 2026/8/25 21:05, Vincent Guittot 写道:
>>> On Mon, 24 Aug 2026 at 15:06, Jianyong Wu <jianyong.wu@outlook.com>
>>> wrote:
>>>>
>>>> Hi Vincent, Hongyan,
>>>>
>>>> Thanks for your comments.
>>>>
>>>> My original commit message did not clearly describe the concrete issue
>>>> being fixed, and its explanation based on frequency invariance was not
>>>> correct. After looking into this further, I found that the issue I
>>>> observed has a different cause: the cpuinfo.max_freq fallback added by
>>>> d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to
>>>> cpuinfo.max_freq").
>>>>
>>>> The commit message says:
>>>>
>>>>     However, in the absence of arch_scale_freq_ref(), it is reasonable
>>>>     to assume that cpuinfo.max_freq is the maximum sustainable frequency
>>>>     for the given cpufreq policy.
>>>>
>>>> That assumption does not always hold.
>>>>
>>>> On an x86 server using acpi-cpufreq, cpuinfo.max_freq includes the
>>>> autonomous boost frequency, while policy->max is resolved to the
>>>> highest selectable _PSS state. With boost enabled and policy->max
>>>> unchanged at that state, the measured CPU frequency can still exceed
>>>> policy->max. Thus, policy->max does not represent an effective hardware
>>>> maximum-frequency cap in this case.
>>>>
>>>> Nevertheless, the cpuinfo.max_freq fallback makes
>>>> cpufreq_update_pressure() calculate positive pressure for every policy,
>>>> although no effective maximum-frequency restriction has been applied.
>>>>
>>>> The underlying issue is that cpuinfo.max_freq is the maximum possible
>>>> operating frequency and may include an autonomous boost frequency,
>>>> whereas policy->max may represent the highest selectable _PSS state.
>>>> Consequently, policy->max < cpuinfo.max_freq does not necessarily mean
>>>> that the available CPU capacity has been capped.
>>>
>>> IIUC, cpuinfo.max_freq == boost freq and policy->max reflects the
>>> correct highest frequency reachable by the CPU when boost is disabled
>>> so the cpufreq_pressure is correct. But your policy->max is not
>>> updated when boot is enable and doesn't reflect the highest freq
>>> reachable by the CPU.
>>>
>>
>> Exactly. I think the root cause is that policy->max has different
>> semantics across cpufreq drivers. On Intel and most AMD machines it is
>> the maximum attainable frequency, i.e. the boost frequency when boost
>> is enabled. For acpi-cpufreq, however, policy->max is resolved from the
>> ACPI _PSS table, which does not contain the boost frequency.
> 
> Proper solutions aside, I vaguely remember investigating scheduler
> issues on a Ryzen 7840U. That has acpi-cpufreq with only 3 OPPs. Boost
> frequencies are not included in those 3 and are much higher than the
> ACPI OPPs. I certainly managed to disable pstate and switched to
> acpi-cpufreq on it. I wonder if you can reproduce such issues on such a
> machine. Maybe this is a broader issue than we realize.

That may well be the case, but so far I have only observed it on my own
machine, so I would rather not claim more than that yet.

My current understanding is that the trigger would be the driver rather
than the vendor: if a system runs acpi-cpufreq and its boost frequency
is not present in the _PSS table, the same reasoning should apply. The
7840U you describe -- 3 OPPs, boost well above the highest one -- looks
like it could fit that shape, but that remains a guess until it is
actually measured.

I do not have a 7840U at hand. I will try to reproduce it on an Intel
or AMD box by forcing acpi-cpufreq (intel_pstate=disable /
amd_pstate=disable), then comparing the measured frequency against
policy->max with boost enabled and checking whether a non-zero cpufreq
pressure shows up while the system is unconstrained. I will report back
with the numbers once I have them.

Thanks
Jianyong

Thanks
Jianyong>
>> [...]

