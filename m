Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012056.outbound.protection.outlook.com [52.103.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81641DDF2;
	Mon, 24 Aug 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576809; cv=fail; b=T2G/YZtTS4gEGKRkkwBqPtne6bKY/f5R35MOmX5F4RWgV/cUUPE/+Du/8vsY0adyB9s0iv2k/omevnPY8QDtEmL3eCSMQA8uaT0yUl42ki7SJvH5VI7wqwb23Jy2NlRlI2j773sM6Qv2B2o4IF6cj49f1tIsVrGzX+y/gqIAx24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576809; c=relaxed/simple;
	bh=sU+kdKLm995xUKrYQqgY4GQU3IX2furNfRTIsLAer5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fFDc4ws2R4fRejv0Xqgokc4grB9W3RKpgwyw0hOMyiW18FEEwJYJ/BpKwYq6CwgvEce3oJWF0C5ir18dFZar4cxZ+u5qhKJTpFMWXLKm+Nh3JkStFMEQ1sFE7DyNh9oRXEMYn8p5XJRClQvFiQGxbhWBC2Pw1ldyIY5kNDLsNxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NKbhFiK9; arc=fail smtp.client-ip=52.103.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NKbhFiK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2gj9HqUal1hNySuFglDUIKp/ueV5cQwra40YZZlpVumdACo8U++k+02b1OwK2WVZ4HcjJlYd+Nz1aYuB9LKTiuTqgu8wqOkmW3Ldw0/mPrhPnxPctDFH3CHZ0hSmCLE/Zay01icGG8mb3XwqLJdCAhg5PEWomi3dWdVRbVRqLKBN/3PGkFYSNrN/gSotc0x15lgzVp9EDsc7aT0NNHbkHUzEwpiZcg4S+7huoxsIqoo6r52wb7jX9Rq7pA/5bh14N2sxHeGkqX2+C7c8qBCmDJn1vkllXpUhEI7HHcMIipI1lpN4PmCJR0CQTg989D/mewhWdpOfFq+A1OON3wICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAuVtbrqt9jpRa/p4YTFyZN1IisVgFiXtYOEerAnjns=;
 b=vFIgIm7wUiA1+6NB+epbsKJ2m/kxx4braY7rD9oHopMIOZCY8cFnInBp+gd0BlmWsDT7VkF6Hilwa6GvKFaiZWiTWan9d1JSytTJvIt2EzsLIInPjliIcKNWer4Ob5dZ59BJCmHNZfVTxC+Vx/LCjl5M8ByJjeQl1yxVToc34V2ygCMGStFPXc3OvV5xRRmcTCT/SQgpZDxoLBXnlTyIfyVcC7oyQRPrgen10ADqJrS8x8hXkLgRDCM6l2P9waWaXlLQ7Uflrbx0tLtb5BW/u22vbxr6Vz8F5GCZ8xy+rmiq8gr5Ah7I+ABPStnpaMKfz8wreAtvcy4PvYr45kztgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAuVtbrqt9jpRa/p4YTFyZN1IisVgFiXtYOEerAnjns=;
 b=NKbhFiK9w7UTkZoiTJRyaACMUHWjMNEaLCo2bHWrOOggbm/dQZHc+RR7XnN4ps/VGyswlfVEyO3cT1nJPUczQWX6PBp9u85QjWmBDM02IvEZz/z2ISKK8Bpv2TXoVOYlY8KaekyvnVELIUyXwRq5nIUhzd70TDIK0kXIwNZukzvFuOCQsEkImV2OyV7jfkvn3BDmgkwF7KIHYW/6Z0YcqHKrKHFY6rcukYI13vuiCEF2JWKEepRqjFsh/Ujs/3fsaR24qBvgYUhz3sDQ5p6UfKSPKOI1oECcFMnELNqv9LbG2EwxvCw2sif8ThXKzfrRvNnnxfm+odRCinFNdgHMAA==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by SEYPR04MB7723.apcprd04.prod.outlook.com (2603:1096:101:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 13:06:39 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0360.005; Mon, 24 Aug 2026
 13:06:39 +0000
From: Jianyong Wu <jianyong.wu@outlook.com>
To: Hongyan Xia <hongyan.xia@transsion.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
	"huangsj@hygon.cn" <huangsj@hygon.cn>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Topic: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Index: AQHdMUC/r5X8cuCab02pF7K2A36l27askygAgACdZwA=
Date: Mon, 24 Aug 2026 13:06:39 +0000
Message-ID: <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
In-Reply-To: <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB4931:EE_|SEYPR04MB7723:EE_
x-ms-office365-filtering-correlation-id: 4b080189-a6aa-4708-cd35-08df01e088de
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|31061999003|8062599012|15080799012|19101099003|25010399006|4140399003|52005399003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 gey8tEUQs/IbUjvqWVz7+FJ8wFoW+rgJPt8NZxABKgWVWTG/x0klm+cD3A74BDtElnsVmBqlycnV5iV1x6oBGVwVC+0Md8xfvSco2tPQD5ToZ6u/oAAjAT5rUD0Cj8BmsJMW28p7sf25I/aQVI3/Xu8UyaMcMMAZXwAYBfbU5e+9siQYiKQGfEXpoCkXcq3/P5N0NAGx1dSVybH6LXe/NcHfqti9lPoRQQ1z9VFR/PrNRXHDWsM4MibRVRXtxAUQeUdNDxA8AjbToHYdsZWfsMj6x9h3UzPsVn33EwGacXi8p7pMt1qJL3+wiOvtGmL/6T1ZM5Ha4F0r8Oiyqa8pt/K05AjDVZDIn1uMwB8/76wB5Wt5DGmCwXHTqAAfFyC1oq7dJc+E7BulJrHrTcXpfrRAfHtayVOGvSTckNLC8Q2jx1E0Nm0+cv0kTtIf8uA703eMsXx09VlD5dlHDz8aN1kfF/KLDKS03bIlLzWooAg49baqj4Lnu1DCSglbGUm5RvPhVCW/dwsiltIKUitIkW6GkdOP4tdVuyt/nESM72ILQ8BP/3T5o4cKpq5KVMXnM3iWZVQ+NWjLMkDb3cPEvRi+0wE/yR0Pm9gdbkW/PnWXtwLog3693VxCRPQREJaZ2F2x4YxLF1H6bboPnkGd9PwoP5YG3iWNfbA+rm4ZvYVROsMZ56C1CcSpOvd5W1mG0AaVSeA3LK1npOHsagHw/peQH8qKUDfuMYy3ed0cr7lfjM92jhwMpJTqbZEeXVlNPDle7Z8xgduL93xb7UQIV9zzqkd71mFdHlPAM7VjITHG5+M1QkFAAi0KsxTM3SKJnsstaYTGJPJbiZcxGKsxVLyny+YfsyUlWXegnBE8vo+zn69AcaqIcfpHkrGDxcOnsevzKerUCpTgBmGtODwhzbHpNymF4FlOY95NLD3kMo1kQ7Ohd3xaOxqYz7GbE9Mj
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gn/tf5hygZu3cMwIVS0uJ3ZDWEtuExwJ17jrZ3zHpzKbsk71P+5N4XJbkUag?=
 =?us-ascii?Q?MtY+COpLMrA3tH2TGWtVcITEW/BWDHoPsLeVzeYHzZbWhDNQ2lENUuvujGSF?=
 =?us-ascii?Q?U1w1iYgX6n00xXR+zklQrVL+5vYT5tBj1ApmIoIGoLEaCpRV+7LOuHc1OQaa?=
 =?us-ascii?Q?nPk2+ukUXXwg2bhXrylhhObRxEcIxpo4Cb4SZE880hIpEaPFirhhtWibCSvZ?=
 =?us-ascii?Q?0zNc/uR0tRkz/cYblQ24R8kZAjvVTSAlMCNqCpsbFooybuXUbkrzKDEhPnmt?=
 =?us-ascii?Q?W//1v47Ul/gUkbBNNtQ2uwaFzY8kz4Z+jOZZoF69/woWlxQ4OeaAOE5NPLXO?=
 =?us-ascii?Q?myWYwiL1k33rYAbYRf/NNR8gJ8tYiF1jYiXZUUQ2xp7AWs3PkPwqfKrLwBhw?=
 =?us-ascii?Q?WLMX71FvPbxN4unUt+cilR4CeMUgBLGgqcLoo8GhZI4t0y4yIyKH5DYAKsVG?=
 =?us-ascii?Q?P+XyTRMsrH9/uUoq20m2ZqY1pddzYMWeyOx1rfclBmHgJV5RKw8d8STkzbE5?=
 =?us-ascii?Q?EVaU+h2cauSqzW7SQ5I/35fHgANpNs3uDoRReLE1sy6PkFwilME9K4BwOYYm?=
 =?us-ascii?Q?2ZL2H8A2V3PZZs44elrReahTeOnMY0h9fUR+6g1ksreH2AsC9TlVkdWbQi+S?=
 =?us-ascii?Q?DlSboQi9fXy/0KW1kuIMSOnLAg561qbLnSLW6qehz+xJ9nCtBO5VgjcSJ3bZ?=
 =?us-ascii?Q?CQlufQ9A2G3UnOIwcZM8zl+tD7LPjymrBX0PHHd7K8m56xW9jsSJAPIUtz7V?=
 =?us-ascii?Q?qN07PSa6C/0c0Z71gp2LMEBUFKE0Mi6mH1ObvalHL9BcVDSx7WKdSwPb4hg9?=
 =?us-ascii?Q?skR+ResLy8T6P3VANGiGQmutGZ3t6GPVBhU32N3cjE9wKFrWZGWWe5LLflEo?=
 =?us-ascii?Q?zwVoU3K0Dfcic6LjfMdMzLtbN7HG/olcFQQN2r3PjB30/ukAOsMODmdkVGyT?=
 =?us-ascii?Q?BOyhIbObVkKW/AVAgeeKUCg7Ihp9plL9dfoMHnzbQ/2FA3zzAKDwS6sTHquH?=
 =?us-ascii?Q?R1EyA5E2t1SU+iqLzvmBv/pdOfD13LUDhQMoh7AmmKgnerGnStRY4YNRYfQH?=
 =?us-ascii?Q?cKj7pcH2Br0axAzucudyDtxoX6pg5xxray+jeJSLKgohf+pIPCjjoZFW9jLJ?=
 =?us-ascii?Q?IYq6FZm2AZNcNowMzDcwi+XTMaFpj13wzDC7VH2gPrkU/JD+g8WA6sTZx1bE?=
 =?us-ascii?Q?JV30q1FqkHl6J/T3IUa/ImDp26VVCyPTpFtN7Zplt3nfPc+hA6IYrecFaqaQ?=
 =?us-ascii?Q?Xue5F83ANdEJ5q5TldfOtgfDYRVIv6xvaHLURwer0932BqkUr7Prfwm2MfR5?=
 =?us-ascii?Q?ZNPGxFnEjlYluANkiFbmJUFp/GV86G1Rta0HKE/NGVwHT2fK9+Ak5CEzC+GC?=
 =?us-ascii?Q?sBAz0DxE5cc5klFp58XFSzpGmO0/PJlJR6OW2T6TCUHlx48Zzw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <041235A4040E1444A60603343A639399@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b080189-a6aa-4708-cd35-08df01e088de
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 13:06:39.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7723

Hi Vincent, Hongyan,

Thanks for your comments.

My original commit message did not clearly describe the concrete issue
being fixed, and its explanation based on frequency invariance was not
correct. After looking into this further, I found that the issue I
observed has a different cause: the cpuinfo.max_freq fallback added by
d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to
cpuinfo.max_freq").

The commit message says:

  However, in the absence of arch_scale_freq_ref(), it is reasonable
  to assume that cpuinfo.max_freq is the maximum sustainable frequency
  for the given cpufreq policy.

That assumption does not always hold.

On an x86 server using acpi-cpufreq, cpuinfo.max_freq includes the
autonomous boost frequency, while policy->max is resolved to the
highest selectable _PSS state. With boost enabled and policy->max
unchanged at that state, the measured CPU frequency can still exceed
policy->max. Thus, policy->max does not represent an effective hardware
maximum-frequency cap in this case.

Nevertheless, the cpuinfo.max_freq fallback makes
cpufreq_update_pressure() calculate positive pressure for every policy,
although no effective maximum-frequency restriction has been applied.

The underlying issue is that cpuinfo.max_freq is the maximum possible
operating frequency and may include an autonomous boost frequency,
whereas policy->max may represent the highest selectable _PSS state.
Consequently, policy->max < cpuinfo.max_freq does not necessarily mean
that the available CPU capacity has been capped.


Therefore, this patch checks the wrong condition and is not the right fix. =
I will drop it.

Instead, I am investigating a fix for the reference-frequency fallback
in the cpufreq subsystem. One possible approach is to use the highest
non-boost frequency-table entry when arch_scale_freq_ref() is
unavailable, and only fall back to cpuinfo.max_freq for drivers without
such an entry.

Does that approach sound reasonable?

Thanks
Jianyong

>=20

