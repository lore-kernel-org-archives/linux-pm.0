Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013076.outbound.protection.outlook.com [52.103.43.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA8471246;
	Thu, 10 Sep 2026 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041480; cv=fail; b=lxYul4LwCe8zKcCtIE5Q/mmI+a7g8KaVShP5Cv3B6giBdhmVqhL6KCG73CST784otvl32hNCR5y03zsniJshU3ZezY9ZF4JTC1SgJkt3AhC7jv2Umm/3bCdbY85VDpopI8viN5uTK6gPp7EplniGQkHZDYZiepXvdBl3L9gmul4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041480; c=relaxed/simple;
	bh=y481eIMZRir0dn0dk/Fo4emoNhrTdSWo3nMetZKyvWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSksWZEG1crxNpYAuncJeZdanmnq+EU/XDuGurckQIcXMliHLgqxNra4IpF3TZAs8jZCqfRSR0STLsF+o0JhiKOEU3tBHQJymZpake3zKE/yGO9wFuI11nfiJF7zdX1OjO/szJfJDAruAU3jhjfV2a/4+/TzcSkB61ttvdig5Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XtVnJlTc; arc=fail smtp.client-ip=52.103.43.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XtVnJlTc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJrsAROJs3k1038O7ac142+oWEfba229sLlPhtK1kPEHFx1VPVobvSyyd29+8puV72yFHwEMlkfhwxLp33tX33msTHYR0qitVI54yAo32Erqzt7c+Knfm1czZj0u/hAYZOB0iZYIfI4rUZ9msUpOc7qeMcnDVfBo4ZfSIFiZrx1AVBcYk31lwvDYBiqYsYPRH294FCFJnLoaMAMzygsyIX52atGMgPrKj+DgS/0PweS1WRjIKvt3oBBDbsSnQToS4KE17v0Q3XkPP5R5elo5wrQbj+TJGu0/gqmxu8dZRRcdPKFT2yvOes9wVNRHtApxFIL/haGFLRDRP/T3AoUPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFsV9pjGC0s+l8W7AsAWn9Z/8bKGO+en2Jy3hi+R1PY=;
 b=BE0AdrfTKZGOIv4aCLrWFuVxQzsrWIdiAqFZ2Rti9Q4P+2FwsdfdGhfRxM28yao1+TnYs6POXteLIYO/RZdxnxgX6rsIczke9bLB8uRNUZkK7jqxmOBMtj73nyOrtWUjqKuI6GeH5CikBUpvbNv/ln/wkR1/6crGNQis1+NASaTVYb/3X0RTc5xejICRdXKmgatHbI3MNM+8bKdZQUqDidU9LsXiC7lnIzfwUpd5Sd17sq2JNL+1fT0q6oQenzGh4JgOSVwwrU0MDl2SfMseyNInETqOyd83h5cjZRkEZNnu0x3hY+UR7MQa1wfXP+grzqd/JZPBnMG12vQ7dNCV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFsV9pjGC0s+l8W7AsAWn9Z/8bKGO+en2Jy3hi+R1PY=;
 b=XtVnJlTctU5kzCGn0FUVB5reXhm4bs+mLmMjPVSaLtvOlJEqMd/RgiQksO+U7TXMWSXnui32Od1h3nU7y4GC4z3zk+q6NHxtF67gJTpxsBggpBs0gS8rZNhOT5p/Bzpqtm5cuYc0RInInsWHDEHIuv1R/gKgpHwvqBKUSWirH68fG3tDxR0lkQLFXSdiMKWUX0q69P/Z/qwkdDPRxaYdaObFZU7SmPFyrXbyHodtyRJG5IaNIbMpXQjAaGYT9/3tQExQGNYw72Rk/OsHUhwzgDhAf2CQWKQPa4pQsCcI//QVbQhrkV79rWGh9EufKBXxnAOJJGotghPOS3aD20AlgQ==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by SEZPR04MB7353.apcprd04.prod.outlook.com (2603:1096:101:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 11:57:53 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 11:57:53 +0000
Message-ID:
 <SI2PR04MB4931989689C248FFE72602B3E3BF2@SI2PR04MB4931.apcprd04.prod.outlook.com>
Date: Thu, 10 Sep 2026 19:59:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Hongyan Xia <hongyan.xia@transsion.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
 "huangsj@hygon.cn" <huangsj@hygon.cn>, "Rafael J . Wysocki"
 <rafael@kernel.org>
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
 <CAKfTPtBji8dkr5ixhtZjkyrWLA68TF-KHLrNYWoewPWLyuUd4A@mail.gmail.com>
Content-Language: en-US
From: Jianyong Wu <jianyong.wu@outlook.com>
In-Reply-To: <CAKfTPtBji8dkr5ixhtZjkyrWLA68TF-KHLrNYWoewPWLyuUd4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
X-Microsoft-Original-Message-ID:
 <081de5eb-7175-43a5-936c-cab226c5ccae@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB4931:EE_|SEZPR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 28dc0456-0eaa-4c5e-bf00-08df0f32bdf4
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOvFQLQ9ENEdcm6tiiU9FgK13K2bu0yhwBXLpg1xTKwxN/zUCKRdG9Xf9dl/WtyhdnaB8DZsKrsJV9LO50KaMTqIpLw+/Gj7T2x3xUr2Pm0yXR34SbOwkw0C04O31cdOWddGFsBNVGdPoBUDNbpTa3NJMo3G+ilh5JwaWvzf571xX9tDoiidknOf/IoNc8HBRByObxtgnzsS/54mFQkOJBZpnWy1OBbp+gbhrVQDULxWd9wYvtpbAm6SNZC3pMKrU2/G6L0H8HYhMsNbh1lbSZ8xXQxf7TfnWPFgx2hRTm4Di/pmJ4RbkN/mXYjX5EOweW6buUrkW9EJV30xRaP6hCnYAlHi4Bq126k64oNE6XSxk7f+2fCE1n7ESdq0LvDe928XALnS9MEp5Qq1jxMgfPy0FINenHWX5uTXBluNKDKUF4LPIpl/LKiR3b3HVhIZ62mgX6sCl1+7ufdSxFZTrGcGgCD1Lxxwtsb7oSWmdJpoF0R6LP6zIJv3elhNKxcs4jKbR65vRQPPt01jdewZLTaKccwsXKQ7qfhsccplorlM4wfG9f5Hl/LZiMXwOkzLErtxSGGpADiVVdE2opsYg+pVx1ielPCyef0KM1PlI0UYHyoMhE0BMmrk2N35m0Ms95sfkJaoJoeJvcv2X/eBZCzcG108jt+5YFDVhvtMkUxyEkU5jS2shPejO4egA44MMiWxHVBKAYq27oyNQ6Zkow6Kezi39L7k/TPB46P5Z8Xgw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|8060799015|15080799012|51005399006|24021099003|41001999006|12121999013|25010399006|6090799003|5072599009|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWdVRkZwaGx6V3VoSkhwSkozMnBGc1duQWNLYWVEQVlYb2lmajFhakcyamhp?=
 =?utf-8?B?c3V0N0ZjWCtJelkvdERqWmd3ZmFxUGEyanlmU21HWlhmUEdYS3ZzU3dFRFJL?=
 =?utf-8?B?ODZLYXNMc2FsVFZ0K3ovQ1B6YWNCOTV4emMwcSsxK3psVzR5Y0VkU0t2TEcw?=
 =?utf-8?B?VUFKMElhekdxc3JHbmcvWDZvUUpHTW5KbW1EeGVpYnFWOEpySEJhdzQ1VlRy?=
 =?utf-8?B?ZjhFdklvQ0lXOGdQZk1aYWdoT3hScURySk5UdWNMcjJhVkQ1NnJ0bnJrd09M?=
 =?utf-8?B?Vk1FMG5TZHVWREJEVlg4Y3RRVWxJUVpYTmdRR2V5Y3RsNWkxV1JzeFI5anZB?=
 =?utf-8?B?VXRXY20zQXlBbGZXTndiV051WmU3cmgwblJqRU1FaGZyaGxya0Z6akk5SUE2?=
 =?utf-8?B?bVdNcjJBM2wyREJyT0RCeUJ4RkpyY0JqUXNDNWdsZ2s0cjN6YXdPbVQ1bmJM?=
 =?utf-8?B?WXprUWttaStPZFNWVURVZWt1QVZxN043OHhGMjROeWRPaUJya0k0QUJaTjlK?=
 =?utf-8?B?MjlCbUdVYUd0dHg5U3lqbGVabDRzMG9GU3NMT0VSMWw1SmVrMElORjA0S2pC?=
 =?utf-8?B?RjR2SktKUVdWOG83a09MYStPNkplK3JNdmlSb2t2MXpXTzhVQmJ0QkZ0aHdv?=
 =?utf-8?B?OU5qbmZhQ1lhNHlKUlBHdG1FRkJvOHcrOVpLNUZjRm42cGZ4U2FRNFd2cTFq?=
 =?utf-8?B?TStORzFaeE56bGRRRDN5aytqQ1BnS3VJRXRrQkNOU2Z6RkZ3MXBOOUNjU3oy?=
 =?utf-8?B?NXRzWGV6TE9QWWI0Y0RIcWtQQ29kbkdZTnA4NGN4NXZDMHR0WWJqdlVqVnZQ?=
 =?utf-8?B?SWNtdVdKa1lVWDNDR0hjYjE2WGxEdUc1ZUVpNEY1WFpKQWFBMXpKNmRPY0NI?=
 =?utf-8?B?QWVCUjN3RkswWnhJUWRkYVFzUm5qeS9NYXN4c3Btdmg5Y3R5cUpJYjNtMzh4?=
 =?utf-8?B?Z1VQSnJSaWc3U0RVMmJqTXpiQWFCZSsrTDdmVXJWRDVlSDNHYWNWUUlCVzg1?=
 =?utf-8?B?M0ZCeWJNREhIc1dvaEQ4Um5KSmFrcCtoSjE2SjdQOXVXd1ErWTdYcU9STmlW?=
 =?utf-8?B?WHRKdDQ0aXFzUkEyT2pVdzl2Q1dCS2VGMEtTd2hZOGJWdEdNNUtmamVsb2R4?=
 =?utf-8?B?TktVVll6dy80Wk40TGV1UWh1SVUxK1J3NURRQUxPTFo4THZkSVZtMjBIS0E1?=
 =?utf-8?B?am1nck1UbnVkYTMzaEJGYUxCMEtSWWd1ZVZiOTRud3o4RTV5NG5SVDRNODBS?=
 =?utf-8?B?OU1sWFUyOUdpa1ZjRG9sV2xCenlKUnpnVWJaTFI3SDQxelFHMXlMaCswUndU?=
 =?utf-8?B?OFRWaFJhbllMVnpCUk5UVHU4d0wzdzNNblpwMzJSeENTUUlQbDFTUlNXVC9D?=
 =?utf-8?B?RkNDTDlEaStXNnc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXpXbklCaXM2RmliNDRDQjhvdHRaYTJ4bzR3b1dvQm50WGdqU2dCM0g5L0ZD?=
 =?utf-8?B?NHZRNUxFVEd5V1pqeklEWGZjdFhXRUw2cENJdTYvd3dtV2paNHdxNncwYWhq?=
 =?utf-8?B?c01SYXVPTEgzVzl3dk5TMmVjM0hTV3BnbWlwY0oydmhLZEhhTElORzdySjZn?=
 =?utf-8?B?dUhrOHlWeE82UzVWQVRRTEUwZm1ab2hyN0ovcGRYUUNDWHpVaVJ3MTAvN0Nx?=
 =?utf-8?B?M1lxMzRSMFdyNjQyVXZRZmFleWNoTXZka0YzQlBZSi9GYk9SeXUxdXNBajds?=
 =?utf-8?B?czJoRUlRdDl4bFlKeDVVK0ZPMzZBU0dUSEo3SjB1UnF3ZW1qZUxhTkxKeGYx?=
 =?utf-8?B?MGF5Mks2WkdRbTBhMjNYcm5lK05YbjNHUjRrcWFkYmdmSEIvQU9EVlNBN0lm?=
 =?utf-8?B?K3RranpJVHhmVDVnVjNndzdUWmhDdkpPYk9HVTFubjNQb2RMejhUNmp5cUJC?=
 =?utf-8?B?SkNaYkFBcnhhMVNFYitxZkxxcGhuTzlYeDdlUzIzejhRYWN2RnZmUldZWEZH?=
 =?utf-8?B?SzN2RVRpdjJ5dmdFZ0NaaVJtRloxQkZwdEljUGh3Sm44SFlVbHpQUEd4UFlQ?=
 =?utf-8?B?KzVqOG1uUVhLWGpKTzVRcXJmNm5SNGRta3Q0QXNMaFIzZ1lEM0JLQ3IwZlRy?=
 =?utf-8?B?QXdMNTJhQ0F1M0RVblBOSmNHZm5iR2xPQzJkSExPbWtTZXl5MG81M0pua01B?=
 =?utf-8?B?SUU2QklPU3ZnUkhNdXU3eUlzcnlSRDN6VmtqVTBBOG5kdjgySjU1a3J6S1pX?=
 =?utf-8?B?VSt1YTRqNjNPTXJIb0ppSjhJb21CcXJYQXpLR1dYZTgyblJMK0NCY1JzU1RM?=
 =?utf-8?B?Zmo3Ykw3dEc4azVGNkY5MG03VlRJTU1GTm9Xb2U0eUR6V2NLUlp2SmlFNlZU?=
 =?utf-8?B?WFRUd2FJMEdiKzNJMUoxa0lVK0htNjdyVWFnalhjdGN5bmI3NEZDbElmSTll?=
 =?utf-8?B?eXNYb09LVjhXWUdybGRvcUJaaWJ0YUt4SUtMbEFsek5va2hoUzhjb05tUEdx?=
 =?utf-8?B?NGUrN1hxVzYydkQyOVBEa1VBMzdVL2tHeXc1dzhGSkJkRlRESkZheGdYcnhh?=
 =?utf-8?B?S3phd1BiaHpmNTlNSkpTQVpwU1MxTlhBWE5TRU9OUUN5Qmp4K2puTjZuNkdJ?=
 =?utf-8?B?eDdKd3lJUFlHUEhKY1puTjk5TE4wSDVBVjlIVFY0NjkzSXJjMTZQNXdodHUy?=
 =?utf-8?B?bkRldU9ySkNrR00vdWpCZU54RC8weDVUS0c1VnBmOXJLdVkvWVhyMVppRzZt?=
 =?utf-8?B?YzI3cFFVWTZFaTljd0VBZSt3d1puM0NIRUNLeG9LVVg1MUZURTV6amNLKzNN?=
 =?utf-8?B?V0lYR1pCMFllWno4TzJNLzBWSENManBsemFlVllFTEVVU0NwQ0pUVDEyZitn?=
 =?utf-8?B?SUR0bmJGUGtRbjVyVThRUjlvaUJ1bno4UzY5eFkrRmtNVkVBRWUzNTNNaXlG?=
 =?utf-8?B?cWUrTWR3VVJYMkx3SVU1TWRQNnBqSmR6QUtPZ0NMMGRSZ3dwY2FoaXErZ24r?=
 =?utf-8?B?R1BYT1RXUERkV3pOenA0SjF0RzR4a1R1blZmbmhhOXNxWEJ3cmVvZXVUNHA4?=
 =?utf-8?B?bjIrRVJEb2tyRk9tRjJuUXYyWHR3dlQ0N3JmMjNrek5LVlZYcU1FMkVYTSs0?=
 =?utf-8?B?ZFlkN1QvOEV6MEN5bXZmUVNoYTk4dm45dVZtcXNRdWRKcU1GamdmeGd2akhD?=
 =?utf-8?B?L1ljbDhwWXYxUlVkUU5yWFE1KzZRTFhKL3NWd28yNzk5byswUExDNXFSU1BH?=
 =?utf-8?B?MWpQK0FSOStweHozYS94emVXV015USt6cTdaRE9BSHZRQXRqMWZhS1NxN29k?=
 =?utf-8?B?THNmbVlta3BHTFlydWkyWlgvc1hXY1p5TXF0aklxUDZ4T1YvUGc5MytCbkJR?=
 =?utf-8?Q?tIGsl7njZlmtq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dc0456-0eaa-4c5e-bf00-08df0f32bdf4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 11:57:53.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7353



在 2026/9/10 16:05, Vincent Guittot 写道:
> On Wed, 9 Sept 2026 at 12:05, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello Hongyan,
>>
>> On 9/9/2026 9:39 AM, Hongyan Xia wrote:
>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>> index b898b6544069..97f4a3ba5107 100644
>>>> --- a/drivers/cpufreq/cpufreq.c
>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>> @@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>>>>
>>>>       cpu = cpumask_first(policy->related_cpus);
>>>>       max_freq = arch_scale_freq_ref(cpu);
>>>> -    if (!max_freq)
>>>> -            max_freq = policy->cpuinfo.max_freq;
>>>> +    if (!max_freq) {
>>>> +            max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
>>>> +                                      policy->cpuinfo.min_freq, policy->cpuinfo.max_freq,
>>>> +                                      CPUFREQ_RELATION_H);
> 
> As long as the reference frequency used in cpufreq_update_pressure
> remains fixed whetever boost is enabled or not this is ok. We don't
> want the pressure to change when boost is enabled or disabled only
> when policy->max changes.
> 

Thanks for the clarification.

There is still an issue with intel_pstate (maybe also amd-pstate). 
Suppose that the boost frequency is 4 GHz,the maximum sustainable 
frequency is 3 GHz, and the policy is capped at 2 GHz.

With boost enabled:
policy->cpuinfo.max_freq = 4 GHz
policy->max = 2 GHz

With boost disabled:
policy->cpuinfo.max_freq = 3 GHz
policy->max = 2 GHz

Consequently, using cpuinfo.max_freq as the reference gives different 
frequency pressure depending on the boost state: 1 - 2/4 with boost 
enabled and 1 - 2/3 with boost disabled, even though policy->max remains 
unchanged.

Resolving cpuinfo.max_freq does not address this for intel_pstate, 
because it has no frequency table and __resolve_freq() returns 
cpuinfo.max_freq unchanged. This behavior is not introduced by the 
proposed change; it already exists with the current cpuinfo.max_freq 
fallback.

To keep frequency pressure invariant across boost state changes, it 
seems that we need a fixed maximum sustainable frequency as the 
reference. It should exclude boost frequencies and remain unchanged when 
boost is enabled or disabled. policy->max would remain the current 
effective policy limit:

boost enabled, uncapped: policy->max > max_sustainable_freq
boost disabled, uncapped: policy->max == max_sustainable_freq
capped: policy->max < max_sustainable_freq

The existing max_freq <= capped_freq check would produce zero pressure 
for both uncapped cases, while a cap below max_sustainable_freq would 
produce the same pressure regardless of the boost state.

Does this match the intended semantics? If so, the next question might 
be how to obtain the max_sustainable_freq.

Thanks,
Jianyong

>>>> +    }
>>>>
>>>>       capped_freq = policy->max;
>>>>
>>>
>>> LGTM.
>>
>> Thanks a ton for taking a look at the suggestion.
>>
>>>
>>> NIT: I do wonder if we need a full __resolve_freq() each time. We could
>>> cache the highest achievable OPP on max_freq updates, but that's future
>>> optimization.
>>
>> Sure! We can cache it in the policy object during
>> cpufreq_policy_online().
>>
>> Jianyong Wu would like to take a stab at it? If not, I can send it out
>> early next week.
>>
>> --
>> Thanks and Regards,
>> Prateek
>>
>> Disclaimer: Hygon emails are routed differently in our organization.
>> Response might be slightly delayed until my NNTP rule finds the email.
>> Sorry for any inconvenience.

