Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013084.outbound.protection.outlook.com [52.103.74.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CDB346A08;
	Sat, 12 Sep 2026 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789196992; cv=fail; b=l7EZu8mJ29vTndKGLArLgOpOLuOJHcGld16lgVB6DogA3z/IoKi1Ir6sSfKfcsaZFk2Wkw+OWwz4m+u5q77wl/0FDOomTdnDI96IkIeedAX/7e0LFnCKaBxYokKDurNrvIg1dTKRW+tbGJM/w70/UVVeiK5ORAUJvrmc6GDlRfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789196992; c=relaxed/simple;
	bh=WUAVT4TkfcjotOwos4vIKaRfgSvIaXzISFceJywsoNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=edQKs1STX/F6XokpMjCvqV2qQfmJKKeEUhEWnbZ3eBwsQiXZGSgSOIPnYdR18xfoFIYtNLadJOrYRCd+FruWrIhNEZHHTR24zl9dQbVuTiIeiwHz/kopmHTmNKBO1Vd1/2hWr9yTv0ZwwUMvtD6M8hVivUoCJxgD15tC3XoAA44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h2TEMpTt; arc=fail smtp.client-ip=52.103.74.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h2TEMpTt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUDHXLCqYIvTHqjuCSgk1neW+rYVveseGK/8yEt83u9WSixDgRc4S6jJETaAJTU95zMWzHRHhzCgH312uMvUleD5wxdY2Hxk0zpaEC2JT+kysLZLlR4hUIrfLxvKy5wsU6clB/+4HemPaYraCZviXR0gJM+xCEAeiBEXB6k2Y0WwHcUq9Z337Mk+Hb62imfNwxrm5Uzh0bfy0PYBijC2JIOEmFY8g2e9v7N7Bdf8ZjRglsVbMK7cy/aCjY3zm4RXaWM11b39m0gfmtJU7JjJovEE6yOG8jKCWz7BIiWQwVM5C8hRz8MTEviVxQX/YrwtPuGCFnRxvsJI/LbPnJCFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7g/xeAYnHxBKdT0rhbRhgjiWwtJp4wH/pZzT2AH1DI=;
 b=TNvQpsenupbEYoJ+X7VrSQkIH0+gTCuCvWgO0YUlnvBQLMhBLkc9escH4AthId5CLv6SehgaVw5+ndOeLvboPFJ3cdv41QHVDPjBfZh1KOvTSo4GwEnHHMqgW9QSTBK3l44OhHVbS32E1pW/4rpadUoeguV982XZOlI+W1yarCVazpkmQo5+kEL9gUDFgk8VWsb9FlTRkxGGtz28Fq9GYBNNjX3jVtGgR1XqFoPz3VKxZw7kCcV4m5xyBIWX8sAn2/KWzWZ0T00aXsfFtYX7d75JsBoQZkfFfbnwoqSfAKJYIQ3xN3aFhafBLfhLwn9rIKT4yk3WqVpt3+c3xZRVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7g/xeAYnHxBKdT0rhbRhgjiWwtJp4wH/pZzT2AH1DI=;
 b=h2TEMpTtFerfQa33S2KcCnp+bDwJ5LYvCh3yync0YOo8rRApUv/Oe7g/Csc/ZRpuh1WJJsfSHfjEQjyWsnKqbZsG2LK2jjxj0Ge1rpD91sS5VpaNSl35kEdzLC/Vaz/qR/NMe/vD9A4fXs3Ts4StMzbzfSg+rSwvNvaeBZEGo8U6M0OFdVWM9REGsqRvtXwQUAN+lb+Sv/0ZgWEuIqqw84RZvm54YJVAocbpuS6lz+9/RoGIK9Kvzu6WFxWPHiE2Ib19HkBy87b7WMH9Gha7WU3vd61qcfzJWb/w8JsNn7GudCYgmevizlat1TXfL3mvFvE8O8xgW43RRdZmf8OWVg==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by TYZPR04MB7667.apcprd04.prod.outlook.com (2603:1096:405:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 07:09:45 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 07:09:45 +0000
Message-ID:
 <SI2PR04MB4931A8BA0EF213B0238BD9E4E3BD2@SI2PR04MB4931.apcprd04.prod.outlook.com>
Date: Sat, 12 Sep 2026 15:11:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
 "huangsj@hygon.cn" <huangsj@hygon.cn>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
 <d709498b-9572-44bd-a93e-bbed23fd7372@amd.com>
 <4e39e935-2339-442b-8b14-a688b605c35e@amd.com>
 <a9dc111b-21cb-4bcb-ac91-f6be04bc2e06@transsion.com>
 <a2466e7d-2dd7-4de9-963f-6eb8c58d4a49@amd.com>
Content-Language: en-US
From: Jianyong Wu <jianyong.wu@outlook.com>
In-Reply-To: <a2466e7d-2dd7-4de9-963f-6eb8c58d4a49@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0027.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::18) To SI2PR04MB4931.apcprd04.prod.outlook.com
 (2603:1096:4:149::12)
X-Microsoft-Original-Message-ID:
 <e0326172-6452-4756-bc23-d0bc2bfd5445@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB4931:EE_|TYZPR04MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 092891f2-5e26-44de-7b6b-08df109cd036
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|25010399006|24021099003|51005399006|6090799003|5072599009|19110799012|8060799015|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnR0TDFSeklRK0FIdkVSSk9HbkNkalFPMnJBd3NPTHdIVDhLL3BES1NFZ3lQ?=
 =?utf-8?B?TFNlQlEwRWt4OGoxeTB5cW01ekpYWUVqN1Q2RzdaQ3liU2VqclhJSFpOU3hG?=
 =?utf-8?B?bjZ5NHZtdDhaNVRRMGJnVnprcXFNZHJLOFJUV1VJMzdpVHVmMXNkQ0R1Vyt5?=
 =?utf-8?B?alpXOUs0bXpoNllZR1JQb0RScmluTjB2VkdZVGFTUGxvcHVwZ29iU0tucnNP?=
 =?utf-8?B?REhNOUJZWmR4V0FVbmpSU2hldklqK1pQNnJNQXNTRVhnZ1h3RFlSQ21tR0ht?=
 =?utf-8?B?S0k3T1drd3lmdG5uQXdwK2FobXhmU21kM1Q3Ny9JN1BXaXhiYUo0UjR0dGFk?=
 =?utf-8?B?MFZHbWExTmYwZTMxdjVRK2hoUXhDamd0djd0S1NES0d3SklteGpkMVZSazdp?=
 =?utf-8?B?RkdhcUU2UkVKSjF3Nm1oZGFPZmx4TjQvRWVGRmRpaEp1cU4rdkhHQXJtWmFw?=
 =?utf-8?B?ZnhYbVNkUGt5R2p2QXYxZFVQejZtckNPSjh5bmwwZkNrazBNYzVZUGV4QkNo?=
 =?utf-8?B?M0YzOU9IaCtCZmsrUVNhUW1mRVhqZkhFWGxFRW1rY0NQUFFjajltejFWL2Y3?=
 =?utf-8?B?M2JKNGFIQTVGbFFiZ1pKK0hCVWd6NU5UTkM4OEVPYUxUUE1jQnBFald5SjZw?=
 =?utf-8?B?emJiaSsrTDVmQTQ0RWFQVDFLZFFtNTM1RVRiZ1NwUndsK0ZtRE5PVXBuWEkr?=
 =?utf-8?B?S3ZVcnFnU1ZNTWZnSDdmV3lsdjIrcnk0Y1B6L3dVcVBZTm9kOW5uTzZuZkpN?=
 =?utf-8?B?K0IyYXFoL2h2TGYra1g1RHN6WWVrK2FJdXI4dndIUG45aVE5dG8vZys0Mlhz?=
 =?utf-8?B?QTA3ajNsK3R1YnJIeGlYYTUxWnAyNFdpNk9CcmNZcnJIRmduV3lmVGFyR3JN?=
 =?utf-8?B?aXVTYmx3RU8vR2UwUzJLdXdrMVBZeVpIRWtiNEhUUld5TUNxM2MyTHJRaUVM?=
 =?utf-8?B?ZS9ncWlVdkV1ajFFS1ZacThncHozajR4UXY3bkVqcmd6c2JCRXF5bTNlbXVZ?=
 =?utf-8?B?Uzd2eWNMb3RsMkxBN3R5UER5bEt5dVE4VDJlWmpTYWMyRFZpbnd1ZFRMcjVs?=
 =?utf-8?B?MWdRUmhDWmpGN29WNGUxemdtczFiWkFkeUY2SXRxbFlXZUxEUEZZTXRDbzVU?=
 =?utf-8?B?bERJU1pvUzFOUXpmbHNzZjRCbFd0Mlh2MVltb3JNOTd0NG1LL291TG5TdHZ4?=
 =?utf-8?B?OFR4SzVTRllDMjdkNy93T3BjbFN4QkNDdk8wK2JWcERiL1R4MUNZTmpTL1NN?=
 =?utf-8?B?YnMwaHBmdVk2SU1MOHlGN1l2ejlwQWZPcVcxMUdlbWJiVE1ndz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTRDN2xRRDh2UUl0TzVwaVdXTDN6bDNrbmRtNldJaHFKbHh2SmRUYmdIM3l3?=
 =?utf-8?B?TFlhOU9IOUdTZXhkRC9wbXZESGlVbkdPRnh5a3dFazZUZ051Qml5MmpsWlFZ?=
 =?utf-8?B?YUhtYjJsNHJQbFk3ekNEQXFmZ0xqRy9wK2I2S3dnOFZOcGxHL3R1NEhkMi9r?=
 =?utf-8?B?M1NYZXNuUUhLV3pJVnNjNnNiVVc0Z1BvVG9TNGNyUVpVT1JmNkwweEdNQVFV?=
 =?utf-8?B?YmYvYmhBMWFlNklqdXlhbDNYMUg4R2QzZkpvay9BdFBIZnYwVFVwOFVtYmFv?=
 =?utf-8?B?Y1pnSTlvbzBjM3pZYWc5OFRvZFJzTi95Y1BIYStPV0FYWEMydDRaNktrVUxp?=
 =?utf-8?B?ODJFS3ZDUmdnVEZzdEQyNnQwLzJ1dWlDeThNYlhnQnRYVFNCdXBML2sxaTFO?=
 =?utf-8?B?YXhSWkZUM1NobjB5WGZyL1pkNHlldExnem1PaUdsaUpqZTlQRHkwbGxpNnpD?=
 =?utf-8?B?Q2g3eDUrcmp1bjFFNk9KNy9yanppQTVOOGJPN3NKejFDazIyektsbExwQkRy?=
 =?utf-8?B?VHNVMlpFd0pMb1RqMlpzb09USXFrMXo0S3ZscWE1QUsxeG5raUZUQTlJSGsv?=
 =?utf-8?B?aFhUOWxScXZzMzFHNWpiMmhCaHE5eGJXMnZpZVpmWlJLSmM3Vk9kRGlYck5D?=
 =?utf-8?B?TTRnWE9tbmFHZXdhZjRsTitGajY2K1UvUmNmd2lYdHNlcTVSekpBMGxaNHUz?=
 =?utf-8?B?WllWamg1M09XV25zeUgvblFnZURTWlVqV1NZVEVNcEljZC9GQkFaRjN3Umg3?=
 =?utf-8?B?aHJTQTlhbWI0RlBVNkV3TjBXMUZsUWJnQnJQSCtHMnhMWkpLdXRlcU5EZEt0?=
 =?utf-8?B?NHJKYU4wVWlKb2pBK2V2RHU2bHI4blQ0OTFWZHlsdVZKS3ZNenNiWTliSzMv?=
 =?utf-8?B?N1BUYmlyZlRUTGhuaCtzUDAyODJkZnZPSHM4bzVvdkp4UnJ6dDF3Z29qaWNF?=
 =?utf-8?B?a0lnNlNybnFsbWxsVUl4TXliSzNKd2V5aDd3R0VRdkE3QTdTd0JlYjc4TTNt?=
 =?utf-8?B?aVJiYno4czQ4aUp4VStHd1lOYWJ2R3VFWGRTQUdiWkJnWHIwTitkT25QKzcz?=
 =?utf-8?B?VXQ0U3JRWmJ3L0NmMnFZZVppTjRZamc2WXVzS1lBOVZPbXltTFYyc3hrQVE0?=
 =?utf-8?B?d1BCdnd1L0NvRGI0MFBHN0FpcEVtVzl2WkN3NDRPNTBwd3ZXZFJkcm5xR2tO?=
 =?utf-8?B?U3dZNG0zZ3lXRkQ3bGlyNUpqRitjNHNVUVYwNUdCTE1BNHAveU1VbVY2anpT?=
 =?utf-8?B?c2VubXVOMGtKaFpIb2VGbmhraFZ6dEFFSVRxN0JDVDVwT1hib0tDcHcxREpE?=
 =?utf-8?B?aWVnZ0s0d2s5NW9sOEF3VVk2OG83QmprdE1UMEttUkhhVVcxaUtLQTVyVVBO?=
 =?utf-8?B?NVErQjQ3Z1kwUnpTcUx2aVhOSGVwcVFmeE5VVXorbFBaSlVJYWQ5aGxJUUNP?=
 =?utf-8?B?cmRYRnJ5T3VHbndXSXZWWk52bTErYXZlWXdFN1NJMUlGdEZTb3lqdHRqRUpt?=
 =?utf-8?B?ZW8yWGZlOUFYTlRPT2VWSUZrSEFuRUQvVDhsTHVpL01icHFVVGcrTUJURkFT?=
 =?utf-8?B?b0djaG5YS1loZXRWUjZScnY0TnBreG1mRjdXWk9nMEVudFpXVjFicTJMeEhN?=
 =?utf-8?B?eFNjbU9Lc2FnaUdiMVBxa1lxRDJVaDhiWWE1MFdwL2hXdGtkbEQ1Z01abnlT?=
 =?utf-8?B?OXJURjdkYTZvQW1QTDFNMmE4RnhqMEt0TXVUbDJ4cjN3aE1PMk9GQktpcEpv?=
 =?utf-8?B?dkNaTXV2cUVYYnd1UVNRcUhacFQ1dG1LdGR4WkFZdmFOemcraTVML09CcXhO?=
 =?utf-8?B?ZTdhWk1iY2Q4dXJxNE1XT1B3OTlBekRYM1FMaFMxL3UwKzBrL0xDbmJTRk1k?=
 =?utf-8?Q?4L50tk5i5nv46?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092891f2-5e26-44de-7b6b-08df109cd036
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 07:09:45.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7667



在 2026/9/9 18:04, K Prateek Nayak 写道:
> Hello Hongyan,
> 
> On 9/9/2026 9:39 AM, Hongyan Xia wrote:
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index b898b6544069..97f4a3ba5107 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>>>    
>>>    	cpu = cpumask_first(policy->related_cpus);
>>>    	max_freq = arch_scale_freq_ref(cpu);
>>> -	if (!max_freq)
>>> -		max_freq = policy->cpuinfo.max_freq;
>>> +	if (!max_freq) {
>>> +		max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
>>> +					  policy->cpuinfo.min_freq, policy->cpuinfo.max_freq,
>>> +					  CPUFREQ_RELATION_H);
>>> +	}
>>>    
>>>    	capped_freq = policy->max;
>>>    
>>
>> LGTM.
> 
> Thanks a ton for taking a look at the suggestion.
> 
>>
>> NIT: I do wonder if we need a full __resolve_freq() each time. We could
>> cache the highest achievable OPP on max_freq updates, but that's future
>> optimization.
> 
> Sure! We can cache it in the policy object during
> cpufreq_policy_online().
> 
> Jianyong Wu would like to take a stab at it? If not, I can send it out
> early next week.

Thanks for asking, I would happy to take a stab at this.

Based on Vincent's follow-up, I think we may need a different approach
to keep the reference frequency fixed across boost state changes.>

