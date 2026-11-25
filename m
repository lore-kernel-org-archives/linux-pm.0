Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795622463;
	b=ul5lzZYOQDqDRnv/1vabk7mMZ+dabuxzOErG4wo+yHE1bFvht9sGCFoTVgyiTZDlpp5+
	 OnHnVJfHNtLjTfDrdXFlgvZWEPAZqDlwJRTZGzzDoJN+WhjjyajSzZfXDKuXJPAAKck4u
	 lSvL041SCTVFY6/It9A3tYjF25vY/nEf2TpXOu18qwiTBXZcv+++r+DpMYUmVB9MJH/M5
	 WroPJKf7N0ze3p4qQ3GYhX5elssyF4gzoVvm/FhpUFZ2rz3cDtlreY0urRaHyIK9EYhG7
	 ba3ClRkA93YW/RSCNdy0bPaMH4AiIWMMhJGv+nIdvHP2EF2i5EOlA+S34mle4vUexUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622463;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=ktvN5VccKKw5i08DfYGBrc6a93lAsKwOjSIw93pxbgM=;
	b=EyHdz5g2q3VT7N7x+nKfLuFgZihpMdV65HENQBnjSTJZOKdAhF3GD36ANPzbYoKHE3rE
	 en3zhp+bVbe7KmQSvsZkkepZyVJWSeNdUFPsKg5IjIUhH+0xqkZ+D9MiirAfJdqRs2hED
	 h2DTqzkyGeu1fI6kCbLAmyqdvkRwVdD2ttGuGX2cefrkqhvn0uQv/FFXh+1zDHn4oRnZH
	 v6QHYedyN835GM+e6HpV6ZQKuNzutmWEgtLaoxPstchk/DZA9vsq1NpzHe2Lea/wGemnu
	 1CRBxF4XJ4cM3gnK+BCuRK1KnZVK8ZQOWm+s/H6/ClGUsMImJgetIC5K8KUbrk75kOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="h/azBYeY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.32
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EF606A335;
	Wed, 25 Nov 2026 16:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 528EF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=h/azBYeY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmIj9F7X+uSbDI69ts8l+L17FdfkPyAkEMqn0dG9KuEgTOpGQR4sLVBesiXE6Zh16s65V/0vIDmqxxaLiyGdKgz+W0OhQn4kuQRt+IFqsFnxeYohPQfgerROvksO3vtG0sHdeEm5t1xzUuxB6o/iFO5GQPb87vWWP0H6aQPJEcJpzoyVMqKqB6qYXuCRNFuMqMwSXL6gK7DSOoWd936Ik+SDp0GCX77J79UQx4r/G2AldQ0uoBouPjE4r81AXTg6MPcWNM7daIP54aTaSsaBWYU/V72Ko9gDtEY0Ls6BQaXkmYV+v8JeUwMM3gqnxEiKWJQ3HP2b+daUVvj3yi+w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktvN5VccKKw5i08DfYGBrc6a93lAsKwOjSIw93pxbgM=;
 b=RmBadnbGD6ubpSeXBZRTHudoe/4pa8ym/tOBPcmnV+pH72LbHyhyJ9h0BM9I7GXOfoyUMawXvh/lOjKK0hggK+E6g6aPNG/IupJ4rsYixX3o2rX1I396V0+wTMueod/0AHefCdgLep5k+f8IHayVanxJoEa0U+xKp/005XHPtZ98zcN5KebVxCaO9wB01CrWFjcEjHQAKNsrk1Zlyhp1O8gpKIIJAjLd6XQ7qCWY/LEapNvDc9k8pO2hTmaMKN5u1UYxCH2tP0df9Kl/bSaCUGU9tg/S6HiEaFGjS2zK9VPgQU8YyQ+B7xdVOeWEWnXoF6QHMGhzUDGJUFQHdeH0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktvN5VccKKw5i08DfYGBrc6a93lAsKwOjSIw93pxbgM=;
 b=h/azBYeY457SocdCvH02G8TmyoWt0WoUAjQCniOSPa0qnOj+/OQEhAxTzPSQa2H3QFfNeN74abwxWeS6wrsmgU4ODQlAm11KMozXzO/6WlXGv6IfeNnxTSlrFdU5O6Wt1elgD9OY7Jn4NDIOeqTHP8qbwmZr+T6OEyZPmAnon6W2vrJ0so5yGKXrg1mjmmYFOBFBXF4yzOsFNwwXUsNHYtIgHWO30EgI22008WGYQxjGUvHlkziRW72uFiokrHwASTwUq+jZN6p/F4mw1t8GQHIWZSub0Jc9HJku2XA0AmYdCqZ7LvPySNkMRyLs3YP1YdZpzaHZ64HtGEZyVksyzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:00:55 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:00:55 +0000
Date: Wed, 25 Nov 2026 10:00:32 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulfh@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Tomasz Figa <tfiga@chromium.org>, Marek Vasut <marex@denx.de>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>,
	"open list:ARM/Rockchip SoC support:Keyword:b[Rr]ock[Cc]hipb" <linux-rockchip@lists.infradead.org>,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
Message-ID: <awcGINOZKcD-cTvy@SMW015318>
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
 <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
 <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
 <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
X-ClientProxiedBy: PH8P220CA0050.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 957e1111-1b15-4336-235b-08df4b0d49b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|7416014|366016|6133799003|261009223027099003|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|261102123227099003|261026121527099003|261021123027099003|261026140227099003|261022105027099003|261022115727099003|261022075727099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	NqBWBKjhmOlNIW2l15T7ZmpE7lXkQLhngmyGCozcsWjz/umSbddPpn3j6gNlEvAwg7RZ1x5kK2dp0eC5iS7u84Ok4QDPkpChN3aXXEsJgrWc21iW+W5Tf7R7zhEUWY9CZo1/YCE0iD/1deZokcFFTvF5lSYza1HTCrnQfUa4E5/qFhB6Ux7niCbjkweNs0CM8g5yrJhiO0uSKsL0XAI2HSYikcTfrIYQcMKai60kVy9YpVfK0oB9fnj9Y6IPLx01aZVyWK+XcHGVAI4ihaH4AaYqAxQ1KwP/ps8JliH7XbbNNXUD+QWf/RAjjXJXAb5Aa0zgCZLtugH0Kl1sLJjkmB2J6kZIBAgZ3qv3XPgLUYeWBDiiqsA3VkWKx5+0Sg9V9Ic+nRNJcd6TymwFjYBmBJZju/VpSTF5zkx5o+jL2Lk4N3qtzsjjY9Cg9YGSuTM6AXmPKDhMMe39HG5hLzXQcyrf5I+//tFMHY/7JGtwuwO7y4l6tMsVFOCdcHcxPGPdRPJgqFjNck8CWbgirDVTGIhp22wGPA411n9dIHlBz2K/fzFtj/HrvTDfsb4v+mJufC6xnPpMPOkyWE2Y+QrAFJcoef8v58kZWypy4HjFgfASf6s922FUvBDmulhvHLomkEQFspG6eA1Eyn52Ox8K4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(7416014)(366016)(6133799003)(261009223027099003)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261021123027099003)(261026140227099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXJLWWU4NFJaek5MQWVPRkdYNVZ3Z2ZxdkgzTjkrY0wwbHpaMDk2OXd3ckwy?=
 =?utf-8?B?Q05JSk9EQ0JNWTYrU2ZXZ3hVV2tDQk96R3pockd5bWdVMjRoTGFvNDMvMEhN?=
 =?utf-8?B?VHZwN1hZQnUzYjlnb3M5QzFXY2lzZXo5WkdPSFRFREo2MDd2ZEsrZGNoMWtD?=
 =?utf-8?B?WEdjOGZTZG5NWkgvaXU4Zlg4MHZBVEFrWVJ0bHVXQjU1bGJrSklMSmlYQ3hH?=
 =?utf-8?B?eUsrTUhxZUN6UWx6VFNKd2w2aVV5N3ptUWdtcThWNVR5MTAvN2cxaEJISEJ4?=
 =?utf-8?B?N2pNNWpmRG1xVk53RFZUV2Jxbjlnbm54RndXekFIa1R1aDV3VFQ3dnZEbTY1?=
 =?utf-8?B?NHp2L0dxV3lqWnJQeERrNzc4eWFQaFhZUkxuTXJGSjhYZFNvUGZXMHI2UWtS?=
 =?utf-8?B?bEg2NXhnTzVFcnpGWE1ZaWlhTDNtMVZRN3VvRGx1aHpQQ2E0VTREbDhLaSt0?=
 =?utf-8?B?U0sreGFXUWtOVTBMYnVQSHdCdW5PRENrZkJZSEsvdC9QTWl6ZEFzNFRkUTFu?=
 =?utf-8?B?cnBHbHJoOXhDd1RXVFozdnJFMzNXa0JNQ2JvMEpneC9QdE9vN1o2R3FXYktr?=
 =?utf-8?B?V1BQdHBhdGxpQUdnZ3hHeUlESGY4UGt0aFJha0Jtc2ZTN2RINHhqYW13czZL?=
 =?utf-8?B?aXIxektFMnZzdUZrQnk3b3FJVXJwZ0dDTEFsa1kxVytDdS9xZUYvcnl4N3JP?=
 =?utf-8?B?NmJXRCt0eUtRTFJFcTRWN0FQTUxVcFFESjBkenVGdEJhTVB5R0UvUmJyZ1o1?=
 =?utf-8?B?Z0NBNlh2aXRCSU85ZzVCOVJScGtUYUFOOFp3ZVk1TE0wbkkzcUhMbHBtWmRO?=
 =?utf-8?B?VVhlT3pZaUR4dDVhK2Y2RGZwSTk4RTRxSGFhbFlaU2JzVGRodVVGdjgySGow?=
 =?utf-8?B?dmRzcSs2cWI4NGU2SC9GTlBGbXJscnRNUUR4WWZJSFE2Z0ZpT2hPSUxPNzdi?=
 =?utf-8?B?RnRBZ0J5bTF1VXhXRnNESEVoZms3bnNFMnlBbzBxc0V0bFI5V05UYisyUzJq?=
 =?utf-8?B?VzU0WnhBdDF0bDc3Z1VNT2diOTY5VjV6SmcyMnp1TExPYy83eVo1d0FaQVZT?=
 =?utf-8?B?LzRDb24rbU5Gb1VIc1B5SXVYSTVoa0NIQ25ORWd0d1I2aVZ5eEZrVVVPVEpR?=
 =?utf-8?B?ZlFicEFoSXVVSGtkcC9pK0p0N3Vac0w3Y3p0TTJGSzZ1Y0s2ZWxkMERQc3B3?=
 =?utf-8?B?VFFDSjVUd3FzbmpWWkJlN2Yxb3VESDhBaldxM2drWXRJMDYvNW9Nd0R3aHlj?=
 =?utf-8?B?blh2dXhkUnQ5VVpQN0EwM2piNWREakNEUm1lUzNaVGZZMWVibitoN2Z0N0VV?=
 =?utf-8?B?b1FIVWtLdDFzTVNXTmdCMnV2SnI5ZW1Xc0lyUUhrY3gxNDlaSkpSMU1UUXN1?=
 =?utf-8?B?TFl0NUFyM1poN2dPYjhBV290azVRK3d0S3BvRTJpWW90VEtQaUg0OGVtVVFE?=
 =?utf-8?B?QmhDTE13WVVIV0hpL1RWQVVBRzhSc1ozN1RhZnRXQTVXZzlaZHlja05aRWs2?=
 =?utf-8?B?aGh1MXh3eEJrRStkWHluY3ZmS2w1bTlCR1hjc1BPcWFEaUJKUmxEa3JXODJH?=
 =?utf-8?B?M0tEM0s2Mk9YZlZwRHRwVDBCZ29iRUJHbUxUWWZlb2VyL2tvTSsxSHczTHM1?=
 =?utf-8?B?a2tKUno3eGRSTndPNERRL0MwTVB6d2g5NU5LZTJ4QXZJc2xOTWI4NDhmUVdF?=
 =?utf-8?B?OENiWkFKUy9adGJ0dnk2bDQySDY4cWgranhoeXlYSno5MGluanpSdUNtU3Uy?=
 =?utf-8?B?Z1k2UkVCZXR3VUVTTENjdmRmU3BCUXF5OXl5VnJ1a2Urb0ZPNzJVWTRMSW1H?=
 =?utf-8?B?cWViN2hPQ2lxZTVFKytuZEhoRzVnUWxMbTVhWWhyRFlpYXRzNjYxbDJKTVZQ?=
 =?utf-8?B?UHllWHJ1Q2huNG53bDNRc3RmQ0t4U01MWENPUFdxSld2K1JTZnVXWFloM2o1?=
 =?utf-8?B?K2l6Y1BuYVRYQ3lrZUF2WEhBSVdwSndOd2lTRHNkbUtDMUdoQnhvRWdaajZv?=
 =?utf-8?B?UXZNR0hUMTJQbk1raHVrYlNydU81NE1DczBQMFhPT3Z6aGQwWTV6cE9PMXA5?=
 =?utf-8?B?NDREK1AwWEJ4T0lmYVBZa09XTnhIZjIvdFV5NnZ4cHN6YWJoZEVrZ3pXSERO?=
 =?utf-8?B?RWpZdVhzWVE4ellSUEpucEpOazlLOHBMWm9sSzRKQWJnVWVOMUFEVjM5Qzd2?=
 =?utf-8?B?M1hFVkdEOXlmTXNvMWFyNDNZb3RucDV5Yk5JdXM0ZXhxQms0UUZNV0pUNUJG?=
 =?utf-8?B?Z1haM2pZWGFvMFVLNE8vYXhKUlpTa0MvczR1NnRCMU55ZzNtd3NGR3pHMWxV?=
 =?utf-8?B?cFJQNDhJSXJHcndLc0hzWmsxMkhiNkZrR3JTVXJlalptWlVOZ2w4aW9WaHBv?=
 =?utf-8?Q?YXIYGIKmiKf3QIwT+239zOqXBAYHTZf2JhrA3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957e1111-1b15-4336-235b-08df4b0d49b5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:00:55.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgMtB6ytRFYj0OYuxVXIxz51RwRfWFTz5mK3PWZkD9as33wlRmsMShOkak5WEW9bVHktNzisSswo0u/bJdDMHFxpaliSDcQy9+T6Ip+EXQXT3yAIR1wZWsV88yf8OVW3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

On Wed, Nov 25, 2026 at 04:53:35PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Wed, Nov 25, 2026 at 4:07 PM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Tue, Nov 17, 2026 at 6:38 PM <Frank.Li@oss.nxp.com> wrote:
> > >
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > > returns -EINVAL.  The real implementation returns:
> > >   1  - device is active and its usage counter is non-zero (bumped)
> > >   0  - device is not in use or not active (counter not bumped)
> > >  -EINVAL - runtime PM disabled for this device
> > >
> > > When CONFIG_PM is not set every device is permanently "active" and
> > > always considered "in use", so the stub must return 1, mirroring
> > > __pm_runtime_resume() which already returns 1 in the same build.
> > >
> > > Returning -EINVAL breaks callers that test the return value with
> > > comparisons other than "!= 0 / == 0":
> > >
> > > drivers/gpu/drm/i915/intel_runtime_pm.c:
> > >   if (intel_runtime_pm_get_if_in_use(rpm))
> > >   which wraps to: ret = pm_runtime_get_if_in_use(); return ret > 0;
> > >   With -EINVAL the wrapper returns false, causing an incorrect error
> > >   path in the GT fence revocation code.
> > >
> > > drivers/gpu/drm/xe/xe_pm.c:
> > >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> > >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> > >   returns false, so callers believe the device is not usable.
> > >
> > > drivers/gpu/drm/gma500/power.c:
> > >   return pm_runtime_get_if_in_use(dev) == 1;
> > >   -EINVAL != 1, so the helper always returns false when !CONFIG_PM.
> > >
> > > drivers/gpu/drm/imagination/pvr_power.c:
> > >   if (pm_runtime_get_if_in_use(...) <= 0)
> > >   -EINVAL <= 0 is true, so the driver always takes the "requeue" error
> > >   path instead of proceeding with the active device.
> > >
> > > sound/soc/sof/debug.c:
> > >   if (pm_runtime_get_if_in_use(sdev->dev) == 1)
> > >   -EINVAL != 1, so d3_prevented is never set, corrupting exception
> > >   debug accounting.
> > >
> > > drivers/iommu/mtk_iommu.c:
> > >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <= 0)
> > >   -EINVAL <= 0 skips the TLB flush, leaving stale IOMMU mappings.
> > >
> > > drivers/iommu/rockchip-iommu.c:
> > >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> > >   -EINVAL < 0 triggers a spurious WARNING on every call.
> > >
> > > drivers/media/i2c/isl7998x.c:
> > >   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
> > >   -EINVAL <= 0 causes the driver to always skip register programming
> > >   when !CONFIG_PM.
> > >
> > > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> > >   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
> > >   -EINVAL <= 0 prevents any debug statistics from being collected.
> > >
> > > Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional usage count incrementation")
> > > Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> > > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance after fw exception")
> > > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL7998x")
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change in v3
> > > - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status by sampling ISP_FLAGS_SHD")
> > > selected PM at arch config
> > > - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > > selected PM at arch config
> > > - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime PM logic")
> > > guard by CONFIG_PM
> > > - drop tag 727538a4bbff ("drm/imagination: Implement power management")
> > > depend on PM
> > > `
> > > Change in v2
> > > - new patches.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.com>
> > > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Yong Wu <yong.wu@mediatek.com>
> > > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: imagination@lists.freedesktop.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: intel-xe@lists.freedesktop.org
> > > Cc: iommu@lists.linux.dev
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Cc: linux-media@vger.kernel.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Cc: linux-sound@vger.kernel.org
> > > Cc: sound-open-firmware@alsa-project.org
> > > Cc: imx@lists.linux.dev
> > > ---
> > >  include/linux/pm_runtime.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index de9e7518ecef2..1d983fe55a16a 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device *dev, unsigned int delay)
> > >  }
> > >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> > >  {
> > > -       return -EINVAL;
> > > +       return 1;
> >
> > This should be return 0, as we did not bump the usage count.
>
> This is kind of moot because there is no usage counter.
>
> However, the caller may always take the opportunistic "in use" path
> because there are no potential costs related to it.

When !CONFIG_PM, all device is active state, which should be equal to bump
usage count case.

And it'd better return the same value of pm_runtime_get().

Frank

