Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013084.outbound.protection.outlook.com [52.103.43.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4423A9618;
	Mon,  7 Sep 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792971; cv=fail; b=B/Z8MpzOIXhCo8MaKjt5HXDCdcGt5aPSL/s+CKs5VnznIiAOi4VEW+nsJElJB/fH9HCnkbV1TnSSZQWBr9uRVIdZ6dYMVnizjeGVgso8Llbh/N3ycmniPtRkFbUUigfhfd4/hYcPsOGoGj0zZWiCQWjr1QIrKlFUxxa3EsU+n04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792971; c=relaxed/simple;
	bh=xE6kRvUrQ4pcojsHq3oRul1UPqEeOx4TfMnBsXDJ/Ro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j70Y3t7q+sd7B09Pg2mpW86M/aE03wWhr5heUC1TLCmU3OxilqaDXAOFS0kNKhiVEdE7EoJVJjG3lv3BwLmiw8kh18iXiB+0VDNvS2i45CYJ21APjRjxN5mPp38cXkggT64zAYrpXY/dr8n6te2y8o9pcsWbMUJtIRlS8MJO9Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CVTojlvr; arc=fail smtp.client-ip=52.103.43.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CVTojlvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8+WTKCfR89ziIGRgwxfYMulw8DeOGSmSdcDEO/yWqyFaRn3u48y3McgSodDIUwy21yiVA5DZ3iJBz15RwHdgPJs/NKbD6BUbpWgN6vk6l4JgQJBe2AUjsb8saM6bfYre7CNGeqpKr7J/EB80kQI+nlD3q2TX6/02TH0KnobPwu7NRHqGGysk0L+/EVNnxyz2lnVLs72u+nLesdWtEsEGUU4HOxFeTmMO7dkPTsjRyQ//HlTlL5/ocPYRKokgVJPdUe2DZ23CzPwv/5SIWxnxLhmdpmmepwTB0BlcXqFxxxZkrD5BxGzLMSXdcHWvsBy/10J6FC48+tNK3Jjr4KrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijd34SMo/cJLSLn3Y76RmVRSjDXiun3a/z2Gy0vuOrI=;
 b=FszxEwPTnBzx+/a18+jD9H6Uk5stPdEqBZZ4ggiueNm+kWKVjABRjd5qFULm9mIl2hai6GvaER9uCbbs1BXsRQrABw41dA4MNnP4Mafu+7d2LiZ7BCyEuVcA5KWyIluSRg/7siaVz+eUXBByDGgNeyWnXzOjp5IwJAT6b8e6aSTBL/QzeRLijb0ALfM+qOelKHyLu4nF/1r5l/Q6OJ61A5IKJ9tyjLZYt2wCl3hz/+D9s9J4lhNGnyZ6qEhLKiw7gVQMH4vLDQjtVaqye5PzaDfgYZ15OfpcDva8qWVfYOnve/l320vp/Ag3jzdbBxrTLzZgpZWnNMBHJBjOHcMu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijd34SMo/cJLSLn3Y76RmVRSjDXiun3a/z2Gy0vuOrI=;
 b=CVTojlvrNng7HIyOa4HURwuWRJfnSorUGlFH4mcYp416Oy4VYrJBZ7lMaEePyOZabVTvlWFITSHJM9JunK7sjA5+TM7mPQaa6JeWe1OMMJXKNW2pgHBPB9o8tSMjFNY3v9NlziSBmZqUgOWpE/x27xBiQ3jqQsilOxZdMPF3zy0FRjY7exHBHJjWGC9J0kZaLLozlUiLoPbS+wTqRcbxZYTlYkQFmTDXtUHGR+u/HDhpWPjs4qFX8Go4cxMGcQr64NSK5WkeE5Zbh2GeKAKOQ/zv6jpmOkiiR/fJASYTSWmT8+DPqfBAqdn7HevhvdiwyAEK+BlAXeqnxEpVRZUYTg==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by OSNPR04MB9230.apcprd04.prod.outlook.com (2603:1096:604:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:56:03 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:56:03 +0000
Message-ID:
 <SI2PR04MB49318F9F4DB71CC11F8E0AD4E3B22@SI2PR04MB4931.apcprd04.prod.outlook.com>
Date: Mon, 7 Sep 2026 22:57:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
 "huangsj@hygon.cn" <huangsj@hygon.cn>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, wujianyong@hygon.cn
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
Content-Language: en-US
From: jong wu <jianyong.wu@outlook.com>
In-Reply-To: <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0015.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::9) To SI2PR04MB4931.apcprd04.prod.outlook.com
 (2603:1096:4:149::12)
X-Microsoft-Original-Message-ID:
 <ab7be017-158b-4d57-a43d-2f2b985f9a04@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB4931:EE_|OSNPR04MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e866b3f-8590-478c-19a3-08df0cf02225
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|15080799012|23021999003|24021099003|51005399006|41001999006|6090799003|25010399006|5072599009|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3JBOGJucW9LWUNKM2ZKd0hBTEN4UEVvam0vYjk0SkJtVnVRUHgwQ3FKYjUw?=
 =?utf-8?B?K1hNNSs4QzRSUVRzUXNRYjBaRGZoZllicVMrbk9WMHZhZFVUajFONlM4cFZy?=
 =?utf-8?B?L3JzVi9XKzlpTHFUOHlZTnR1T2dsS1dhRldreE9aRWpHNk82TE1DSW5iNEh1?=
 =?utf-8?B?Uld3a25aay9XdDNHdEtla2J5eFB3emxDSDdpVmNJSmhjUGFwdGdCN0l0TVBZ?=
 =?utf-8?B?azBzeU9XNzFGL1JUYzlMWGM5blE1elNhV0lYdG0wakp4Yk5zMVZmaVBIWGpm?=
 =?utf-8?B?V1Y4NUxiS0dibENSKzRvdlBPSk91eDRQalhtZHN4YXdmYU8wSnRYMk1zU0tz?=
 =?utf-8?B?TzR0MjRSdmZYTGphU3Y5VVlrZk9EZjU2cmcwc0VNMDhFNFpHeHdoeUpVVnBT?=
 =?utf-8?B?YWhBaGMzMzBObjFWK1VUeG5MYytyNjRxKzV6SW53WktSMXd5YkVwMVdLckRs?=
 =?utf-8?B?bVp2MjhPM1ZVZWp0MjVJQ2NkcjRoaW9aTVc5VldWSGZ3ZWJFQjQ1QVhiUHR3?=
 =?utf-8?B?dlpITlJubEFrNFNtOFd5b21LR29FVVp6OXRwYmZRZG5CM1FKV0tzUXFJVGlT?=
 =?utf-8?B?dUZnN2FJQmJaQ0wrMy9obEpjaW10UWMweFdqd3R2RVRsaVlTUVQzSGc4aERi?=
 =?utf-8?B?a042UFJDaFNUdXNobWdWRXZUcENyNU04ajQ1MExHaERkYjFiNjEwendJai9K?=
 =?utf-8?B?Yllxd2pXeTlaSUh0TXJLNmo4RmJ5L21RODV2bVNaSVpUMGlkMWQzb0hySzRa?=
 =?utf-8?B?RVFyMWJsblVjYW4vQ1R3TFF5eGRPNlBuZmE2Y29VK2NidG9kMmdMZkE4UDhz?=
 =?utf-8?B?UzlnYjhSdGtmelNpVEREZitGcGtyY1hsRllLZkw3dnV0dXh2UGpKVEtjVEhK?=
 =?utf-8?B?MVlTdkN1MjhRWWFCUXFvcm5peWVpWDVyMU5xQkRlVEQ4ejVhcTdyRnJ1REhS?=
 =?utf-8?B?L0pORkJBdnV6TTVGMkI1TEFRMnlTNEV0K3UyV2lkM3dNK3ZGVHlFSlpLZnV1?=
 =?utf-8?B?N1pGOUttSUhCRm9YZXhrNXZuY0loVDc4MVZwUWEydmNBc0RqZ3U5NEoyNnpz?=
 =?utf-8?B?MGY5MUphK1QvVUJxeHB6MUpmS3FrSW5WWlNta2dIREpTenoxK2U4WnZJTjB5?=
 =?utf-8?B?ZG4vdSs0RzR4K0tzcHlVNjhyNkoxQ2l1dHc0TmhwSlkzZW40OXk0dmhWa0pX?=
 =?utf-8?B?UnAwZHhzQTh6S1I5eDJZenVXRHpwZ24zYWF1bWZvaVJjMmdoekJDbHNPUkZs?=
 =?utf-8?B?T1d5ZnFmQWh1WU9qTDFRWlNpTkN0dnJGTTZnakUvbjBwSmFoL0l0ZWJaSkNX?=
 =?utf-8?Q?dPY2e9rfpOJ7E40l7p/pw6FZF2kfAqIKWR?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0hHYXdlOWZRQVY2bVBPdTkxYzFlbHI2S0Fvbm81YU1OWGc0cDJmaGM2Wi9q?=
 =?utf-8?B?RURUamt0Tm83SXdiOWx4VXRNR0s3RlFwdCsxSWlZbUcvd3ArL0NObEYwWDI3?=
 =?utf-8?B?T2x4NkZQS3hoSm9KMC8yY2FDSmhvaFNyN3pBdEh3NHNZZ2tnZFJJcUp0dzBI?=
 =?utf-8?B?dHlaNTN3dytYUDN6U3Z4dFpONzFheEMwbkNTbkxqR0ZKUWhKS2g1Rmt1OEFO?=
 =?utf-8?B?K2lBNG15OUVMREZtM2oxTUVTNCtPY2ZSSExYMFlYTDgyK3VTdGdDRlNwRjNw?=
 =?utf-8?B?Y084eXl3V2lENWtnQ0ZnQ3FZa1lKQzdCZWRtaS9md25SWmdPclRZOG4rVkNK?=
 =?utf-8?B?ZUVydDBHUEZlM1hUN2o4TFk2QnE0QW5DdjJ0Y1JPWHhNNnMrQVFLaU8zSS9E?=
 =?utf-8?B?YXJKMjFma0NpaXV2aVpIVEVGVzBtWVFiSTNTS2wyZDNudGxQVUQ1bENhQWMx?=
 =?utf-8?B?V1luNmRGNklrclhMdkdCWCtXWE5TS2FQd1BXSnNyZTFDVytwUjBiZkcyOTIw?=
 =?utf-8?B?ODh5aE9wOGFWRlpGcGtjd1pKME0zMXhGUzRMQnRKRHlZOTFlWGFkR2FxanRP?=
 =?utf-8?B?SGZKemt4cjY2ZkRsQ1VHNTd4UW5ydVI3d1YwMEVaSHhtc1pmazgxYy8xdW9j?=
 =?utf-8?B?WEwyamI4eTBvTy9aMVhzeTBIaEczZ25LeFlQMG9peUtjWXlYVlRHZmdtZnRu?=
 =?utf-8?B?ODBuRjlMMjM3aWVGdWp1eHQ5ZExEaEFPQ0ZYZ3NqMWo2YVh2QlM0MGJKQndG?=
 =?utf-8?B?cnI4S0tzTkZUSDJ5bnIrSXZuSUxvY0R4OFMrVjN6Wi8ybWhGL25jQ1E4SG8y?=
 =?utf-8?B?SlZsVWJjTk9VSngwd2RHVkl2VkFMMFFLajV4VnJYY1ppeUFXK2syWUQ5NytU?=
 =?utf-8?B?M3kvZE1UTXJzQmI3RFRxUEdISFZ6WGdWQTN1cWxHamxsWW8xTCszZ2hFQkh2?=
 =?utf-8?B?N0l4UnF0ckZreDJZd2MxZHhSMzV6dmN6alF0NTAwY3Rac2dDbVJsa29VNlZn?=
 =?utf-8?B?eDM0S1BuLzNxUmtKM29FVW5panJoR2NNZjdEbUtVY0dvbEdkMGJHcVNQZm5U?=
 =?utf-8?B?ZkZLLzFqVWNTUmtrUGF6TTBBdDBQQVR4ZXZ5a1VzM29vdjRTcjgzeVpOWjJo?=
 =?utf-8?B?U3NFcEI4d2RCaFV6ZkNybmdhWTlmb0duaTNudEtDK2RBZjI1aDB3MDZGQ3hF?=
 =?utf-8?B?YkRDRDhvVVhQcWRuVXZFemtkc0JSUERWUWlYbC9xZVhsdy94Q3ptTTE1dG85?=
 =?utf-8?B?RVY0NVFiYkhQWVJ1WnE4MkFyYjFmQis5aHEvaFlncGZxZmtuR3hLY2o5ZTFn?=
 =?utf-8?B?RldFR2Vta0ZidWR4bE9ocXYydHNoTVFXVWIyeGVadS9lMkk5amhZUU9GRS9D?=
 =?utf-8?B?d1hWNGpaWDhLQ0tGVVFXRUVoOGJqUU9xZHMwbXNzVGtEZURKTXE3SGdaZmwr?=
 =?utf-8?B?RHBzSHBsejNZa3RvZjFLYjdQZmQzd2YzekxqN3lEbFNUVy9lWFZUZjMvMU9h?=
 =?utf-8?B?dGJkWGtMcytrNjZtSTdyUUpSYlRmbVcwajZVNjNhc05PdHFVaDU5dFpjaEtL?=
 =?utf-8?B?M0IrdTQwckd4WVc0MnNVemlzWDN2WTVxMHF6OHY2emYwYmFJcENDYm5DV3Rv?=
 =?utf-8?B?VzdhdmdnYlVpVGpaQWUyMGh6N2RGdzE1M3Q1aXJFakl4emZ1Q2JVVXozY1p6?=
 =?utf-8?B?MllKdGlzOEYxbmpaVStFRExhM0ZOZW50TUpoN2RPUE5PbFdLN09vV2dLamNx?=
 =?utf-8?B?ZDMxVEJ4emZFSm5nd2Rsay9QQzU5cXVCeFh4UU9MU0xlL1BmOVB1dktuY0lZ?=
 =?utf-8?B?OHdmcGxXdUgxM2RqV2hCQUVxcU5zbXkwZHU1MW9QK0ViNlNXd3ExRzcvaXM3?=
 =?utf-8?Q?ilTfVNOGH0TvY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e866b3f-8590-478c-19a3-08df0cf02225
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:56:03.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR04MB9230



在 2026/9/7 10:32, Hongyan Xia 写道:
> On 9/3/2026 10:04 AM, jong wu wrote:
>> 在 2026/9/2 17:37, Hongyan Xia 写道:
>>> On 9/2/2026 4:49 PM, jong wu wrote:
>>>> 在 2026/8/25 21:05, Vincent Guittot 写道:
>>>>> On Mon, 24 Aug 2026 at 15:06, Jianyong Wu <jianyong.wu@outlook.com>
>>>>> wrote:
>>>>>>
>>>>>> Hi Vincent, Hongyan,
>>>>>>
>>>>>> Thanks for your comments.
>>>>>>
>>>>>> My original commit message did not clearly describe the concrete issue
>>>>>> being fixed, and its explanation based on frequency invariance was not
>>>>>> correct. After looking into this further, I found that the issue I
>>>>>> observed has a different cause: the cpuinfo.max_freq fallback added by
>>>>>> d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to
>>>>>> cpuinfo.max_freq").
>>>>>>
>>>>>> The commit message says:
>>>>>>
>>>>>>      However, in the absence of arch_scale_freq_ref(), it is reasonable
>>>>>>      to assume that cpuinfo.max_freq is the maximum sustainable
>>>>>> frequency
>>>>>>      for the given cpufreq policy.
>>>>>>
>>>>>> That assumption does not always hold.
>>>>>>
>>>>>> On an x86 server using acpi-cpufreq, cpuinfo.max_freq includes the
>>>>>> autonomous boost frequency, while policy->max is resolved to the
>>>>>> highest selectable _PSS state. With boost enabled and policy->max
>>>>>> unchanged at that state, the measured CPU frequency can still exceed
>>>>>> policy->max. Thus, policy->max does not represent an effective
>>>>>> hardware
>>>>>> maximum-frequency cap in this case.
>>>>>>
>>>>>> Nevertheless, the cpuinfo.max_freq fallback makes
>>>>>> cpufreq_update_pressure() calculate positive pressure for every
>>>>>> policy,
>>>>>> although no effective maximum-frequency restriction has been applied.
>>>>>>
>>>>>> The underlying issue is that cpuinfo.max_freq is the maximum possible
>>>>>> operating frequency and may include an autonomous boost frequency,
>>>>>> whereas policy->max may represent the highest selectable _PSS state.
>>>>>> Consequently, policy->max < cpuinfo.max_freq does not necessarily mean
>>>>>> that the available CPU capacity has been capped.
>>>>>
>>>>> IIUC, cpuinfo.max_freq == boost freq and policy->max reflects the
>>>>> correct highest frequency reachable by the CPU when boost is disabled
>>>>> so the cpufreq_pressure is correct. But your policy->max is not
>>>>> updated when boot is enable and doesn't reflect the highest freq
>>>>> reachable by the CPU.
>>>>>
>>>>
>>>> Exactly. I think the root cause is that policy->max has different
>>>> semantics across cpufreq drivers. On Intel and most AMD machines it is
>>>> the maximum attainable frequency, i.e. the boost frequency when boost
>>>> is enabled. For acpi-cpufreq, however, policy->max is resolved from the
>>>> ACPI _PSS table, which does not contain the boost frequency.
>>>
>>> Proper solutions aside, I vaguely remember investigating scheduler
>>> issues on a Ryzen 7840U. That has acpi-cpufreq with only 3 OPPs. Boost
>>> frequencies are not included in those 3 and are much higher than the
>>> ACPI OPPs. I certainly managed to disable pstate and switched to
>>> acpi-cpufreq on it. I wonder if you can reproduce such issues on such a
>>> machine. Maybe this is a broader issue than we realize.
>>
>> That may well be the case, but so far I have only observed it on my own
>> machine, so I would rather not claim more than that yet.
>>
>> My current understanding is that the trigger would be the driver rather
>> than the vendor: if a system runs acpi-cpufreq and its boost frequency
>> is not present in the _PSS table, the same reasoning should apply. The
>> 7840U you describe -- 3 OPPs, boost well above the highest one -- looks
>> like it could fit that shape, but that remains a guess until it is
>> actually measured.
>>
>> I do not have a 7840U at hand. I will try to reproduce it on an Intel
>> or AMD box by forcing acpi-cpufreq (intel_pstate=disable /
>> amd_pstate=disable), then comparing the measured frequency against
>> policy->max with boost enabled and checking whether a non-zero cpufreq
>> pressure shows up while the system is unconstrained. I will report back
>> with the numbers once I have them.
> 
> I managed to reproduce the problem on an AMD 5900X. I added trace_printk
> outputs on cpufreq pressure updates. Under AMD pstate with boost
> frequencies I get:
> 
> [006] .....    34.096492: cpufreq_set_policy: CPU 1 has max_freq
> 4683471, max 4683471
> 
> You can see policy->cpuinfo.max_freq and policy->max are the same.
> 
> If I force disable pstate and use ACPI OPPs with schedutil but still
> with boost frequencies, I get:
> 
> [003] .....     4.697753: cpufreq_set_policy: CPU 1 has max_freq
> 4680714, max 3300000
> 
> So you can see policy->max includes no boost frequencies (3300000 is the
> highest OPP) and will trigger policy->max < policy->cpuinfo.max_freq,
> hence applying pressure when there is actually no pressure.
> 
> The conclusion is that yes, this is a wider problem than we realize. I
> suspect this might also be present in Intel CPUs with ACPI cpufreq.

Thanks for testing. I reproduced it on an AMD box too, and I agree it is
not AMD-specific: any driver that reports a non-boost policy->max while
cpuinfo.max_freq includes boost will hit the same path, so ACPI cpufreq
on Intel should be affected as well.

I will address that in a separate patch and we can continue the
discussion there.

Thanks,
Jianyong

