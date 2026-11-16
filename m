Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794843818;
	b=bvKlqwN2t5a15xAv55Z0kxZSGgL9p+A16eIMi2zrzSeWOH2jDpS7LrFZGN1xOtL1faJy
	 FpHlw9ZYNvvVqSKzXv+J2pHP96Z+/DO2lkHXWGqXClpf7qZuzYSUCgpE4kSJ+jSbsaNOB
	 nqfPRsRNEy4CBOCmQUd5s+RdG+y6ta65/zrXdoLFHX9JzYRFw5mEZB83n6oTD4n1jYt+M
	 CpjVRAgVuJ9NllVfZfX4w0ja9lIVphtm4Cw4g50lThQJrWZagPeQmG/OwTzI8CsMVrWd+
	 B098ZnZCMblBwgdt2TwKoc2dKxg6mvo3LbO0Psis8+/RPau62TaP945pRKfRBMImr0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843818;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5bRhZyOcHPjKPWxU6uUxaqm1yS7L2k0f40frtkrQHmU=;
	b=5IvIuaKME0m2Q2lZKMP6kEilUmNKaNGC38a/OxFhYakK+xzNWW8pczOCQNa6xbquQieR
	 zCEriZyFZ50d43bBIuLDgm5ODy7F66Pc1BswaVYNIb/FCqnrleSIAZ5+p7NqmNKHUhB9F
	 ihowZIpvVV01bllGhlBpeRPT3cUBCx5C8c8kIZ7GKGObmHI9dxF+uzeLuHhLtvzQHfKPy
	 lvgsrHmXbxc2BmIht7xzmUHG2g0YUAOVTza9pKUBZvjusrgFmK0kGpgkGUuGsy2d/04u2
	 HEhxX8lSyKjLYM8ppUOl738FgfNaB0M5buLKxsFVTrUjGwDfpcLcPP5Semkg47f5p9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="OwEFLW/1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.40
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA2606A31C;
	Mon, 16 Nov 2026 15:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91BA2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OwEFLW/1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAgW0pqPsXqt12IgfZeRTBTrqofhnwx8UTa4Qz0siIus5qWZ2EpI1104zjPlCmqcJbsPfOIk4JzWyfL9PpZcqVg1CLmXEao6gg3SqtTPk4An164uChPGpBn3wyxc4ALlgt9Pz021K8JzAtLTtwM26q0c8qhUmSPevO0+0Lgd3F0cBas9Nv+jtB2CHA/8CK+WWUA+RCvxQdnGBTcdHc7vMGe3LrfO9Zb0v+rO5zdtqZ8+M1R222ZTfC7FmqwimRg7YaPExksNENfGGDGdT3j1zKs4HPZB5DFZgiWqYFeOjWUiGChkotT8Hk37IEM051e4Zf/wN5Mt9Yy4SRbY4sHfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bRhZyOcHPjKPWxU6uUxaqm1yS7L2k0f40frtkrQHmU=;
 b=pZq94atK+8E2u2Rqp9GC5n+s0upubXdC86S7YIuM01vuy+iGeaQYN0zLFrBQjz6/jhs+E5R21EdJVoQmAi8I5arQVqaG2uj5yRWa9t634F5q4lc3YMymkN2wExz99jkPvAmLzRZz98SZgzjnvO8y/KSI/dkZRBYWcq92w5Xm2/hdP5b0hn/wE+PJ32Np0LX25PZkUvWXP5NSx2RaT9aYDd+9r+iMDeNUzCUxkqDPBfJOBaulGkhzg2ej919NpMS+NcMW55C9ByZXRQSf5+6roVRTrsLqdm+Wp8vBm+1DbqLeNMXrBSdELy2YeDP1ttLNXXYqG3fSlxqnwvUTd8nS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bRhZyOcHPjKPWxU6uUxaqm1yS7L2k0f40frtkrQHmU=;
 b=OwEFLW/1NVG7U6nFqYogF6QMNkP+F+tlPicaUP4ED1XTyM+lzMBQkpOqXQ6x4Y1KfnIsufzwuoMs2Jw1NGel2MVX2OCP5yltfksmMluuB1cxZjdiqWtVajfLeraOYHLHeiDJ/DkFOw8/9+0oK6AoojcKbJpph1X1t+8yt7iWY310lagMG3Pk6gqMg5cSKj2Xs5Z/rCdepy/QHgVBoYPvk70IW4hl3Pgu/OfkGN1GZOh/OD08lGGlNjjZWQ7TtExYHBGx4WLTA7BiaTYLhFV6tS6IwiMJI1AoneYQU2SIf6ZgfAKPkPSP0+bui7uOW5KsP//4Y/lKpct7jtEzwI/w8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB7041.eurprd04.prod.outlook.com (2603:10a6:208:19a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:43:33 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:43:33 +0000
Date: Mon, 16 Nov 2026 09:43:13 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Will Deacon <will@kernel.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
Message-ID: <avskkbztzVF_SRo6@SMW015318>
References: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
 <20261116152513.2676573-2-Frank.Li@oss.nxp.com>
 <20261116153139.GB1763944@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116153139.GB1763944@killaraus.ideasonboard.com>
X-ClientProxiedBy: PH7PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:510:174::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 0653f493-81aa-4783-74fd-08df43f85ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HDQLrhaMksaPlzK/9Zli+5Y11qEVbcJaqKNCQ9R3t145vmo6Kd27UdAnUa5eJvU8KujRdhyX1r2X4UApYgb9fsPy8mz2fjsLHah4wch/mpPGlKmZ8p5XeVdjT7mUTyELwXzSX4c+lu8C9nxuxzOWUR3AtBD8ky3xd+DflYbf23lJbjmf2On5E3Q6f1Mn9KdhET7PUjECcmn4yJUy1ZpUjIfCGbUWAtFJhODAKJz9WiMj6Mqb7S2dpA+3J5DQgzZTWjMYcWSVGFZfQKIDRRtmnAau+ZYMzrhxTUCLYIsIrmJroUx73AW7sBwKh2JWXfBbyK5fVDlOgQcYdyKcLckwi83wpF/UQbJxqQGYr67KQBvd+DXHBhnFXEm5c63TuZ90UzfZmBonFxS9IbNAoouxeGvV/o+0TKrO0yFqXoVbGY3Q/jwbnuqMmN7lW6Zi/dXdNTpTf1n+1R5KFZfpygzofcxHyj19E4lkbXDqyJEHpXn6O7TnJLagyAodlMhOtWmJwMgyPnG9N4JFlTbGmE34mUid3fhxqI+V59K4Ug1yzz44wGwNjJrBE39f8mCkJEnmMP4hHHLWoAeFbAvy0bkjf/9YTxGXwioBW14+4A8TLJCZ/USPb3A6Iq/ukp6q+DhMc8pMYdns0KWjfmthyMfG91131chQTLF4Y7XsJg4yX+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261022115727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B63qoeGPAv27wO2c7+88VXiyCNjxAku/5deKv3HOZycaYIPnQ+jmp/ZDmEMV?=
 =?us-ascii?Q?jNPWCklxDpLDOmDPD0jSSB20ujRVj2/+IURNUWaiAxw9N83peG5cuqeTnjvy?=
 =?us-ascii?Q?I2AE8HOa4AwLtvrqj3bFZQeVgTU8m64fq1yyF9POIz5G4fw0jy3ZeAN3vBZt?=
 =?us-ascii?Q?YiWrpFXYs6C4++Z1J2dbzVd9TbbOU86sIOn5+43Ye3qSzOkyWvp8kduKWH9M?=
 =?us-ascii?Q?6dZmmOCCP5JSaFjkE/OZgYngretmkEF3rVSTjUnb5IhjLQjzsM3P0RZFW38O?=
 =?us-ascii?Q?wjULbHh+cIMqcepIsuW5YLn9A55BkdoqJieunhtBlx3mrgvpJeTI0/GJBtyM?=
 =?us-ascii?Q?6hX//xgyhdVDefqlf+FdGig636NfXHvmywQHXHpQ60cxU7091eHuzw83ygh7?=
 =?us-ascii?Q?uoUaatwFYt6fuHnPGDK6BnF4/PfnwD3cnAjJH0fURXf93+rvHmz4db3o2Jy8?=
 =?us-ascii?Q?JZqqX4Bl6YvLeIv+ToYE1hY2j1ay8ptIGjxfLmWWx8DPkJ8f6nYumpthpUkG?=
 =?us-ascii?Q?+iRbF1ehi678fKAqK1JqcgMCrRzb8GjjnwCMv1q+0+HHz1aLlnMfYpiG8IWd?=
 =?us-ascii?Q?SjViTR00BmFO0NuowOnLtWeatDp74xuhne3f9QijL+/YpNMWAUqMZeFQIvl/?=
 =?us-ascii?Q?82XfnhmNA8gkkZOFw7ZfXHCmY6Fmj/8Pg95cWo+hmsi7WtF6ZERTtFq269pl?=
 =?us-ascii?Q?7QNiIc2C+LEI2F+y9Ispw2PBigYy7v0YgnNOO/4V5GfybZA5g2Mvdp2wmpdI?=
 =?us-ascii?Q?oWExMwiy8Q21sFYEV2XHyJ/MNDxKicfzH9cIpzq0Pkj/G6YBjEgF1WwCztKo?=
 =?us-ascii?Q?pkSEINXoskpc1GHLeqy+EolM5Fgdui9G2+DbFZSog64l/OOKBbFhtGZZMcy1?=
 =?us-ascii?Q?iPSJSyDGIKkGcuD7XgKKErsvalcSPfP6t4emBE04voTXrEmFmuRUreZO1BDD?=
 =?us-ascii?Q?b1g+Ii5qM9FjxJH+ugbdZ0Eg/0gfk9WWjaJAIrL9ELhiGIOXwZXfyGjEATB+?=
 =?us-ascii?Q?ZMREiygWe4/Gr0Lt4UrIANvcAPIUvUjW21ts7qCtgfugL464/+SQvEzBWojr?=
 =?us-ascii?Q?I/H9HkhJ4rl8c3Omg78DZLp/bJqdOCi54NKlhPzYk4jMrFT7W4JD1iI8yhjB?=
 =?us-ascii?Q?eLlPmM+e7KRAXGA1M09ECzdcP6fIwIyu+4ePJNgqFlAa9NYOivDbjSTihnhD?=
 =?us-ascii?Q?Z9a5CwIeAGo9ptabye7PT7SfZlfXd9qylNQirBihZ/ABMRSB8czwyjsmJSLG?=
 =?us-ascii?Q?s1wEijNnFTMI9WDuW+Ntc4YOBt+pGXrA+dPPJ6xImzEVpdM3fVrteltOqUll?=
 =?us-ascii?Q?H/Xsb6gP5PYUiwzbrFaf4V3cz8KV2lznVo6BQYswY5TSornPBWFTYh9NisLw?=
 =?us-ascii?Q?bUXzhiFq4KmwSQJPkBycpwqmGwcQcRUerKotSMEQhI2NmP63hZ4NBp19tknj?=
 =?us-ascii?Q?JGv4k0s4RY6TWv6KksbUM8n6QeRymzNVvsy71Khomhs37JQzpQ7H9l45yqYC?=
 =?us-ascii?Q?3iy/IEUVVn39hfBb1qB12Rjpttu+lKnepWELJDYjuLAyzJeiF3dJCNur+tqb?=
 =?us-ascii?Q?a79UO/byAbTj7dSs6p/AjE+O9T/SZkNAHrM5s9wOR5cI4hsmNseuD8liUO9r?=
 =?us-ascii?Q?5NBQ7EaJN1pVCWPCi5WkujfZlI3JrNeVJvy4rJqsQ3LIws1V9dPgCTMS5M6E?=
 =?us-ascii?Q?4XhUXZnf84kKgXnKDdh47cTWVb8Qzx0WPhvLjohlVtsJTg0hCwwNoXNGAdW8?=
 =?us-ascii?Q?FWFRJbX7cWT//o7/bnHFIGFsPxvyYT5i/YvD2bv7MyrRE2dJglaY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653f493-81aa-4783-74fd-08df43f85ee0
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:43:33.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D9DqHxyJ5kPPh8/BzywSql2FPJ4DXROqJY5ppi3g9cGwV+g0W/uR4+BT07lPkot+369RRgTd8/ClfWe2PTPUdfniBzdo485nOddIJLzJrYykrfPypgFd3vy1UUdE/ty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7041

On Mon, Nov 16, 2026 at 05:31:39PM +0200, Laurent Pinchart wrote:
> Hi Frank,
>
> On Mon, Nov 16, 2026 at 10:25:11AM -0500, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > returns -EINVAL.  The real implementation returns:
> >   1  - device is active and its usage counter is non-zero (bumped)
> >   0  - device is not in use or not active (counter not bumped)
> >  -EINVAL - runtime PM disabled for this device
> >
> > When CONFIG_PM is not set every device is permanently "active" and
> > always considered "in use", so the stub must return 1, mirroring
> > __pm_runtime_resume() which already returns 1 in the same build.
> >
> > Returning -EINVAL breaks callers that test the return value with
> > comparisons other than "!= 0 / == 0":
> >
> > drivers/gpu/drm/i915/intel_runtime_pm.c:
> >   if (intel_runtime_pm_get_if_in_use(rpm))
> >   which wraps to: ret = pm_runtime_get_if_in_use(); return ret > 0;
> >   With -EINVAL the wrapper returns false, causing an incorrect error
> >   path in the GT fence revocation code.
> >
> > drivers/gpu/drm/xe/xe_pm.c:
> >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> >   returns false, so callers believe the device is not usable.
> >
> > drivers/gpu/drm/gma500/power.c:
> >   return pm_runtime_get_if_in_use(dev) == 1;
> >   -EINVAL != 1, so the helper always returns false when !CONFIG_PM.
> >
> > drivers/gpu/drm/imagination/pvr_power.c:
> >   if (pm_runtime_get_if_in_use(...) <= 0)
> >   -EINVAL <= 0 is true, so the driver always takes the "requeue" error
> >   path instead of proceeding with the active device.
> >
> > sound/soc/sof/debug.c:
> >   if (pm_runtime_get_if_in_use(sdev->dev) == 1)
> >   -EINVAL != 1, so d3_prevented is never set, corrupting exception
> >   debug accounting.
> >
> > drivers/iommu/mtk_iommu.c:
> >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <= 0)
> >   -EINVAL <= 0 skips the TLB flush, leaving stale IOMMU mappings.
> >
> > drivers/iommu/rockchip-iommu.c:
> >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> >   -EINVAL < 0 triggers a spurious WARNING on every call.
> >
> > drivers/media/i2c/isl7998x.c:
> >   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
> >   -EINVAL <= 0 causes the driver to always skip register programming
> >   when !CONFIG_PM.
> >
> > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> >   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
> >   -EINVAL <= 0 prevents any debug statistics from being collected.
> >
> > Fixes: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime PM logic")
> > Fixes: cbb6a7413b17 ("drm/xe: Introduce xe_pm_runtime_get_noresume for inner callers")
> > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > Fixes: 727538a4bbff ("drm/imagination: Implement power management")
> > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance after fw exception")
> > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > Fixes: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL7998x")
> > Fixes: cbb819c363c5 ("media: rkisp1: debug: Collect input status by sampling ISP_FLAGS_SHD")
>
> I don't think this one is right. The rkisp1 driver only runs on ARCH_MXC
> and ARCH_ROCKCHIP, which select CONFIG_PM. The same may be true for some
> of the other fixes tags.

But code itself should be wrong even though these platform force enable
CONFIG_PM.

Frank

>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change in v2
> > - new patches.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: imagination@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: intel-xe@lists.freedesktop.org
> > Cc: iommu@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-rockchip@lists.infradead.org
> > Cc: linux-sound@vger.kernel.org
> > Cc: sound-open-firmware@alsa-project.org
> > Cc: imx@lists.linux.dev
> > ---
> >  include/linux/pm_runtime.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index de9e7518ecef2..1d983fe55a16a 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device *dev, unsigned int delay)
> >  }
> >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> >  {
> > -	return -EINVAL;
> > +	return 1;
> >  }
> >  static inline int pm_runtime_get_if_active(struct device *dev)
> >  {
>
> --
> Regards,
>
> Laurent Pinchart
