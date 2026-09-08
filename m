Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012048.outbound.protection.outlook.com [52.103.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF7380FDB;
	Tue,  8 Sep 2026 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851881; cv=fail; b=PCgrBhyAFi5NcFvXgYSTF4a+vBeHwsEdVLF9a2KJSss8Yjxi3TQNdRxdCyPTwf2bD5xOrXUDCJOO9ShBeEdTBhmKzT8Qb3eO/JK3SRIOgd3q8ovR9+ifIaivpTwX4EOrCclkNctxCaCgwb5/tb2MxPXmmwZol0A2ANvTXNoT/28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851881; c=relaxed/simple;
	bh=dprwiTwRHxJ1zO+O2cV/VurOAzdcbzIa7hG5mB5vksI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IKfjNGqQC3RAVfCauw7Cd3ILKW//F3KxPpys4kqfgzQLdjE2xHTcdhdLGJwCsgdfqWOeAwsDPecYfNmtpIlQ3l7gTyO0BJzYyV+lLoGv8t6OTAs/85TrD/dG7TXBiGzz1G7MYtKAs20T7Iev/0LPX2/DOm2t9XR2FcmPtAhe9Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OY4YoYmr; arc=fail smtp.client-ip=52.103.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OY4YoYmr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ+LDpDLFuOwsxdIeOvGZEiYghN1jl6bB+1A6Z+MeazCBt4GBzxNj4+oPGZbxgJzSNU89k39WvT0IdCtz9+o0no8L+ee9xhf/9gEa2B0Cp2lq4xyPNISk8k0zvVv3RbJiTndAam86aqWGYw+rrcc2ArPSHuJBnJeLHJa68LBSae1xt7gI70QqRdfYTLnMl2AEZOJjqpIxkbkBALJFtyfITI395IWicHVXoGCXqpWkBlhMd8XjKQkaiJD2PWvf+pudNvscddqcalAx5eiJapRVGmAPUrLGTDY9oXacgjC7xm1ZvPbQdudTQFBF8jUkcFwGmH0aMmiArBiA5jsmN11GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw9u2AxzTRA58GzjudjEsuRw6SWDT6o59YUCRtRHIIk=;
 b=aRyn1GYcXwrXxVAyQur72aYWuDe1Gj8LgpszyLlWL4ISWkcTp6rcB5UbFXZDsAbBNBeRPdFFv8DE88QWgX8NiUaCJjnvTQUJHs1imBJLhcXBuQ9+yjmaydxhT/OT6MCjCglvRerf3V9HyNcgdY2jB6SMOgpjmHPFtPnxp4/BvatdmAxAg9rvy40F041dtVBTIux+M4wYAjURFA3g/iYJhx021Qs3kMZg5sC0k6w0vCry3y/wcpCSdPytJ1ejkGiNXNqKIqXSJCyWV5u1gDJ1UUf6MKuxXzXtrTF92HOBsWcZedAm0JexuZ04ONueHYO3+7XhQooQkeNUy9jUsrhdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw9u2AxzTRA58GzjudjEsuRw6SWDT6o59YUCRtRHIIk=;
 b=OY4YoYmrOpW1njzGMb1r2gqA693sBKg1Grn1NdIkBLvLLlD7CbTz+7KtfKJKeCDi1py6N1Ei4fMOpSpyHcDb+7/08fLPygyrCtLAPspMYCLs/dEGXlap6fxRv5Y+BvL6v6wUtv3mnHxGRTAFHxFdnKT6qwSMzky2hEWV1klV2XQTBojuhBkphGrRKaG+FBznPo59kpimzBkhJiTO0qTFMlzZJhOIaLBMV3R6fMCi/HsTIj3SAUeTVioW0NT4BPZOV5j4gJhw6Us3s9yJJmeAh7lQUJBOvwngoT6+FMjPiPH/m8OSuuJcL1w1W4PN7z8RXkv0BsxkBTnUfHVSdjom3Q==
Received: from PUZPR04MB4922.apcprd04.prod.outlook.com (2603:1096:301:b2::11)
 by TYNPR04MB9384.apcprd04.prod.outlook.com (2603:1096:405:3b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:17:54 +0000
Received: from PUZPR04MB4922.apcprd04.prod.outlook.com
 ([fe80::4c31:36d:6ab1:c530]) by PUZPR04MB4922.apcprd04.prod.outlook.com
 ([fe80::4c31:36d:6ab1:c530%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:17:54 +0000
Message-ID:
 <PUZPR04MB4922771B19195F4D1BF89EFEE3B12@PUZPR04MB4922.apcprd04.prod.outlook.com>
Date: Tue, 8 Sep 2026 15:19:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Hongyan Xia <hongyan.xia@transsion.com>
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
Content-Language: en-US
From: jong wu <jianyong.wu@outlook.com>
In-Reply-To: <4e39e935-2339-442b-8b14-a688b605c35e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To PUZPR04MB4922.apcprd04.prod.outlook.com
 (2603:1096:301:b2::11)
X-Microsoft-Original-Message-ID:
 <ee4f5fb0-fcdf-4cc3-b5e0-92f4c276093a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR04MB4922:EE_|TYNPR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: 36968821-3eb8-4869-7284-08df0d794c32
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|24021099003|5072599009|15080799012|25010399006|51005399006|23021999003|19110799012|8060799015|41001999006|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3lHRldXUHhiU3phRjVidlhxdUpsNS94Z1BzczRTK0x6VDEwTFNnWGF4OXFI?=
 =?utf-8?B?c2h3cDloQmNTUTB0TXJIc0RIdnZiaWJsbkJhN0NyTCt4cDh2THBaSWh3YUhr?=
 =?utf-8?B?L1Y5bGdRR3lCTVA1YldOY0lOanM5NkxtMGVoaFdkS0RLejlteDNiWHRVU2gz?=
 =?utf-8?B?SW0xZkpsbU9RTE9lazQvT28wQkl6UmhaTmhBWjEvTjJLbklyWG5aQWhJY2I3?=
 =?utf-8?B?YnVPUTdVNUNxdEhIYUJzaGVGdE42endOL2ZOTGh6dERwZmxjdVVBLy9EVmJ0?=
 =?utf-8?B?OHh5SmI5YUp1ZFZJc1RQSU5zdmU2c0xQK05WdzdrUExEdWtYbDZDbFpBeTJB?=
 =?utf-8?B?UDU3d295MXNXdnVoeXRYWDB4UEFPZjhDK2FRSlFHaG5NcmVyZHVLVUF0b09N?=
 =?utf-8?B?Rkh5QzE2dHhxeTNTSGJpT2RpWVdNbEJCeER5TnllTG9WcTU5Q0JKcEtKU29r?=
 =?utf-8?B?MVdSVXpqZUFta3l4SlhYbnhTblRmdDFwSHRDMTJjMUFkYnY4elJhQlJyczRs?=
 =?utf-8?B?em1temlaZk0rSG9BSk9XbkF0S2RVaW1rSlo3QUw1VklwR3Q5bnlHeGhFZTFP?=
 =?utf-8?B?QUdYVGNtOUFPZitTQStXL3dsYTd6VThhc2crY3Y3eFlRYWZrR1prR3FQV01R?=
 =?utf-8?B?dis0cnhHUGlqNVJYT3pyTUdvSkZlVjIrS2l2MXptZVlhaVVEclhrcXNkQmlh?=
 =?utf-8?B?aFJrY0hHMHRMZUNqbjRJV1FlcWVrcFNjajlLZXYwNkUvblZRSHlaOFBrSXlJ?=
 =?utf-8?B?UklxNkppbHJCOWNYWWkrRWRCZ05LcDRrRmJ4R2R1ZnhFaERNS2ZwUFU3SEpx?=
 =?utf-8?B?Vi9sUmszWmtEQTIzMnFkTnRtdFBlY3FyMzFoMk9xYnVZVmpqamJTVm10TDlv?=
 =?utf-8?B?MXNZaG1iT3B0TkNKV3IvWWtUY21iY3VMMWRTd0prSU5BNS9ubDNLNEl3c3ZM?=
 =?utf-8?B?Uk1paFlCL1dENngvTlFqbE0xNzU2T280T3c0ZHp6V1Jtc2FFZE1BczUwU2Fv?=
 =?utf-8?B?K3dSeEEzSGR4UEkwR0c5NmZDQUNJcUl1K0JGWFN5ZHNnbmg2eDZTZ3NDejdL?=
 =?utf-8?B?ZllQRldtZ0lIbUxqVUtDTDRCeWZPYUpRd0NtYTcxUTBxVFd3Ty9vKzVVRElV?=
 =?utf-8?B?NE9xRk8wQ2h4NkRsZFhESjlNUEFzMWIrTmVrK0lJT2JVODRyd3dYQlErRFd1?=
 =?utf-8?B?M09KRHlsRjVHK0dZNFB0QkRzK2lKMnN0RlE4VzBYaTU1dVNuNkpjNEJMVTRB?=
 =?utf-8?B?cVdTN01uYWZyLzZRSzQxS2lEVk5XTkp6UzJkcWU2d2kxeHdYcTg4VnBjRDJp?=
 =?utf-8?Q?qV8XlsuCmirJv8pPHcFBxfDn4joeVrhHC2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXhyL0FWcVF6Z3pUMGNVNnRMRGdWRDcrbm81VVc0cE5QdGM4STBWaVpGZXhk?=
 =?utf-8?B?bng4M1hkMDZ3VkNqVU0yZmhyRGJFWVB6TXdLWWk2MlZLWHV2ZEdsaEpjNUkv?=
 =?utf-8?B?TTkrMFh2Y3UvZTl1WFpkQjE0NmxPZFZ4VWkrbE5Hc3pEWnRzMjJ5VHNtSXBK?=
 =?utf-8?B?RnlHTWxiNUNtRnNMSEpEeStBa3grTFdRQVNFaHdkVVYyb2hoWEJsNjMwbElk?=
 =?utf-8?B?aHl0bWE0Q2s1aEtMMWtGTHZqZXpNVE1XbDY2ZWQ4NjNLQ2Y4UUZFdU9wb0l4?=
 =?utf-8?B?TmlrOEIwY2w5N0hVNlZ2eHducGtwR1JFaktuZDJ2L2JTbTJnSk91UjkzamRX?=
 =?utf-8?B?SjlRZ29LYStZY0FGZVIzdnJjOW4zM0d3SFF1NEJXb1VDa0NRQXFQVUFITUsv?=
 =?utf-8?B?MyswYU1WMkNCcHZ4cDVBQm1COVVKSkUraEtmOExodzdlMkw3SHFsTXlGSFlJ?=
 =?utf-8?B?blJFbDZnS3pYSGozcXVrbkVxQmM1emZzN0xGOVF5bkxLK0Q5NnRnKzhWbUM4?=
 =?utf-8?B?TDduKzRQU2M3QkRvbGh1UFFyOVhHdlFEa2VmcHZWUmNNVlQ4ZWVVZW5XQ2lR?=
 =?utf-8?B?dUhMTXd2NS94ZUVLNSt3Yy96bW1jUVF3RktPb003ODR5MVR6RmIzNmVSWWdT?=
 =?utf-8?B?WHlGRnEvK2JBbmRCZkhDUXRYd0pDOE1RcWY1YUpGL0ttNmhDQUc4ekdId1ZX?=
 =?utf-8?B?anE4czlCdmxmaEVpOUpibmtORUV4b1dwcU9HY2M2MlFTckFwRW5BZ1NpUlly?=
 =?utf-8?B?YVhTaGdWNzU5SHAwOUFmV3R1M3hPMUJTSnJpNWdsQ1JpN01hb2pBUkRYYzdj?=
 =?utf-8?B?dHlGazhURTFoV2JOaHF2aVA2MmYzRklMZzBzbE9KdVRCcXpTRWZHYmpXUFdF?=
 =?utf-8?B?K2JzNm53clYya1BGNVJsejJuN2FHOGV6dnRZb2RFSVN6Rlp0b0xKbXBPcjFl?=
 =?utf-8?B?R0cySWlrUHRQY1BoQUoyQTZ2UjNMUFR6TW5HclFNOTVWSXJZWHljRGNPRGhI?=
 =?utf-8?B?LzRVVlVLV09LdjYxTytlaEhZbWw1dW1veFdMS2FWYXgxV3Q3UVJWVTA5ZFBO?=
 =?utf-8?B?WjN6OVk3SVlBSGZ2Vk5LRVFvekJNdi9aTmFWZTVGWDREYWYxczQyclBOSmd2?=
 =?utf-8?B?dHNEM0EvNjN6emVpeWduYVF1V1pnNFhRaGtWNTVuL042bjhCVm5SeVltOFhO?=
 =?utf-8?B?Q2taa0RjVUpSK0pnN01yNWQ3aDJCc3hHQzdTTHkwVGtiNGhxM3BNbkt1NWxx?=
 =?utf-8?B?ODFZTTA4ZEtzOXJEZlJsYjhjS0hKZjBRWm5iaFUwY1RRc3BNTmpsUS9oUThy?=
 =?utf-8?B?WkFQYkNuSW91cE51NkdFdStkOVp3N0U4aUloZ2ZNUWFRUHRrUUF2Z01tWXFi?=
 =?utf-8?B?T0JvNVI3U3l2YXRzb0hteWhDcUo4TzdpVWJOYjlMaHozanlwTWk4YjdjMFBh?=
 =?utf-8?B?eDZUMlA3N1BSNlpWbkg5ME9ZT0RFWlE4cFFtbE5IblhYRDQ1dXVUTHc0UXU0?=
 =?utf-8?B?YmN0RHoxeHd1ZklaNlhySE9rYW9PSkhGaHlSak9ERzBJN0QrK1FpczVMSGVK?=
 =?utf-8?B?K0gvbDFQM3ROUnNFSHRWNnhSK2RVNUJvTlZvNVE3UlVrMkYxNDJ6Ukh4S1hN?=
 =?utf-8?B?ekdNS2h5MzJRbVpaVVh5aG5jL2w4SHNYVUMrVlg1NXh5d0hGQ21TRXVXWTEx?=
 =?utf-8?B?Z2U0WWdJVXhBeFdaZWFQOXdHTHQ1aXRrallkdkV5NjhkazJENy9XTDVGQU9a?=
 =?utf-8?B?WlVjMk1HbHBpNmtIaU1rSVpzVG84enNrMEg0eSs1bVhLTEJEeVBNUkF2dlhM?=
 =?utf-8?B?OVdjemRlb3piZzh4UWJGM1llUDhQOWd4ekpUTStrbmc2cVJ5ZHhLOG9LbmV6?=
 =?utf-8?Q?5lihScUBxvwCr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36968821-3eb8-4869-7284-08df0d794c32
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB4922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:17:53.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR04MB9384



在 2026/9/7 16:37, K Prateek Nayak 写道:
> On 9/7/2026 1:37 PM, K Prateek Nayak wrote:
>> So, I've been trying to understand these bits and looking at
>> cpufreq_policy_init_qos(), the "policy->cpuinfo.max_freq" should be the
>> frequency including the boost range but I see cpufreq_update_pressure()
>> and it says:
>>
>>      max_freq = arch_scale_freq_ref(cpu);
>>      if (!max_freq)
>>          max_freq = policy->cpuinfo.max_freq;
>>
>>      capped_freq = policy->max;
>>
>>      /*
>>       * Handle properly the boost frequencies, which should simply clean
>>       * the cpufreq pressure value.
>>       */
>>      if (max_freq <= capped_freq) {
>>          ...
>>      }
>>
>>
>> Looking at this, I feel "policy->cpuinfo.max_freq" should not include
>> the boost frequency, or x86 should implement a arch_scale_freq_ref()
>> to know when boost is enabled vs disabled.
>>
>> If cpufreq_update_pressure() indeed has to disregard boost frequency,
>> and anything above P0 is not considered as pressure, we can simply
>> do:
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index b898b6544069..068e6d6e15a1 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>>   
>>   	cpu = cpumask_first(policy->related_cpus);
>>   	max_freq = arch_scale_freq_ref(cpu);
>> -	if (!max_freq)
>> -		max_freq = policy->cpuinfo.max_freq;
>> +	if (!max_freq) {
>> +		max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
>> +					  policy->max, policy->min,
> 
> My bad, that should have been other way around and use the cpuinfo
> fields to prevent capping based on policy limits. Updated diff:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b898b6544069..97f4a3ba5107 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>   
>   	cpu = cpumask_first(policy->related_cpus);
>   	max_freq = arch_scale_freq_ref(cpu);
> -	if (!max_freq)
> -		max_freq = policy->cpuinfo.max_freq;
> +	if (!max_freq) {
> +		max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
> +					  policy->cpuinfo.min_freq, policy->cpuinfo.max_freq,
> +					  CPUFREQ_RELATION_H);
> +	}
>   
>   	capped_freq = policy->max;
>   
> ---
> 
>> +					  CPUFREQ_RELATION_H);
>> +	}
>>   
>>   	capped_freq = policy->max;
>>   
>> ---
>>
>> __resolve_freq() will cap "policy->cpuinfo.max_freq" based on the freq_table
>> entries if it exists (acpi-cpufreq), or otherwise return
>> "policy->cpuinfo.max_freq" as is for drivers that uses CPPC based scaling
>> (amd-pstate, intel_pstate).
>>
>> Thoughts?
>>
I think this is the right way to resolve the issue.  I had written a
patch for it as well, but it is more complex than yours, so I have made
a small change on top of your version instead.  On my machine, where
cpuinfo_max_freq (3100000) sits above the highest _PSS entry (2700000),
the CPU capacity is back to 1024 with it applied.  I will add a
Suggested-by: for you since the approach is yours - if you would rather
post it under your own authorship, say the word and I will stay out of
the way.

Thanks
Jianyong

> 

