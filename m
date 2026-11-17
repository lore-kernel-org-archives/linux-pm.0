Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937072;
	b=u20Hb6T/gt6VfnBe0YZVNgk+2Tu5nmFDmfKNEtiEDcdlM4VPqCPV7Au3Y5qvT66k7epP
	 CvIr7slXDQhFT2Qja0Ferq0G1ulUTSo+EHwmkeciuomIymc35VV+bMcbCeoDNP6Xhly4U
	 kymarDbCBVOp8vZ6cugEs4xW8Od4OjjBzRdo79n64y63Nn+WUbZdyQcD54YiZCtFI5IS2
	 ON3c+nxSLbseFnlODoMkom+iZi7+HLYJ7cT3EaNZx9HJs4us4xUo9BhrsQR5e+8n97SZK
	 mqfCGE0NoqUW5Zi0oD7WxSQJIRYW/YHYF1NIUO3U83sId/eqrsiFgYG+YDcV1O5udUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937072;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=KZDINx5lhf7d31ocOX+VQCEAiwgDnXrcbLsOzE74GS4=;
	b=VkjxnKsMgRPPNxzumFs8mxNg79Nj48tXaC/ZFEeZz7XBXcnU6ZmpppNH30ID2evZAcqQ
	 TgSqAluoODrkyMPpB7K2fFx9/y+qcaTSGLhhDUT6GAukwRVJvz+Z1Lq31JrHM5L1jq3IN
	 3OgY+IMkmKTF/JVIdDtgZQtsvBY6xPFQz8tHaYrT0W7LmsNlv5Vc7MdRNyXOuPt9Syxhz
	 Fnmp1B17Z85xU9U6Uj4spXfI5zDzFmzAEJSF8jNhiGZxBNqAj7GRZlOc4SbBbCQMiiXLS
	 H0nfkKpoY3cUA/6HTl8fIHvtNIu2+9o9V06iMTcn0yxnl8yrRMxLvvW0AzGWmXuDkBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vpbSGS1r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.47
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80E606A32C;
	Tue, 17 Nov 2026 17:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD80E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vpbSGS1r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEZEMH0ODW7JS8htOWXrfiAQvVeqbWwn2Y35s05Mc2UEdQ4VzImwVvXZUNq+JUHKadJyeMXULCykLTPCmejFYBWBSqMno2BB4jpoGauj8yWt3tBx6BxCVT1dFY5GQViNsdJ0FUE5us3fJK12/9KrUbuWAOwESPtJmXgeeOrTmYBD4jfwgz8v7oeyjCjIX3h1tmymp4ctx7WY88aaeQVSapsV+YC+38vINmO8rAEQ+2LUr8RQIGxBHXjdJFotWPru7yKfCYAB5DsDsuruub7Duf2hE3O7Bnrm1cmX2fT1fkouUtUNM7nuZCziFtQjVgyKp3AMsFcDF+uWyGY62bEuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZDINx5lhf7d31ocOX+VQCEAiwgDnXrcbLsOzE74GS4=;
 b=k/s90KxTEHCb2GVQ0j2Ak7bqHWrktXxeQQWT6him8m8L2Q4cacGmf3r2dxel7sv/+gNHZGFVXX7LZiWeWEZEUSQJZE2tWSmfiiKLWtjofnWJKKwh+QgfJkDzRvuI9g7my4T4mRxZkKeaOvEwTeTxJECo/kve/GWy0aol4RQ4loCcsSSeQAI11mHPrKN86L7x64ihlsw3GM0gRS1DuY1wFKJAFl1ZOQSkZcZ2m0l3WACxeec44LADfAfHDDfnkK/M2wWUfca7YH4ARiqp9iq5X2RmM6lpPUrJVP5LfmG3ymAQpGtWCgyEb7J+8epcs2Xc1kNVljHMVwZsqsbae7o6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZDINx5lhf7d31ocOX+VQCEAiwgDnXrcbLsOzE74GS4=;
 b=vpbSGS1r3LrWC3eK3w6TKHMkj7YI0XXWQbnmD5K3E6yDuq3kUR9OVbO9zOA4y4WA1hzLZxGEXpHG1frnnfyvuOx0ANJjwMi6Rb8OhtTWzPVWhxpz8AEY7xr8+hTrJs7b06SSLIsrJpKZNhM0QYx3BNuARP6jdJVMMPHwx7ruhgmtXHBBO/1bCYSQruNIpXNaLhRO/7L1iMq9tu/jxcG3xLTj8fq7xL2phHnhpladaIQ7eGwU5O+DfkLzISF54VZimAgSB5KpVkQwQqOUXLp3WPlsouNtda8xsEcnkj9oTDTU9+yrHMa8h670bKCPhMy1cPORjEKnMqI6aYq2qSHcDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB12582.eurprd04.prod.outlook.com (2603:10a6:150:36f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:37:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:37:46 +0000
From: Frank.Li@oss.nxp.com
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Alex Elder <elder@kernel.org>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bingbu Cao <bingbu.cao@intel.com>,
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Alex Elder <elder@riscstar.com>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel" <joro@8bytes.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v3 1/2] PM: runtime: fix stub pm_runtime_get_if_active() for !CONFIG_PM
Date: Tue, 17 Nov 2026 12:37:35 -0500
Message-ID: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB12582:EE_
X-MS-Office365-Filtering-Correlation-Id: b33219af-6a41-4bc5-a1db-08df44d17e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|7416014|376014|1800799024|18002099003|6133799003|921020|11063799006|56012099006|261026140227099003|261028144727099003|261021123027099003|261021121427099003|10067099003|261009221227099003|261102123227099003|261009223027099003|261009221727099003|261022105027099003|261009223327099003|261009220027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	sXtO+HxvVxV42O279f88YaFtOC00rsexvU7RrlOygzOyAv2vKembZvaQz7pSAwPSyEgaSuLyYN/ndIL2WgC6K9nHKydKHmBJZSCmmWvkpOhtcJlJfnLVnYLfiRuuNphj0N8pFjfBU7sT2AQMqOkcgfaJxrVskzJf9oC3v7N2igD6Nb264Szt4kpMUw4r3mL0e1LlPdgQ4qAbmAUJab/7iRdnM8QfMRnD+PuQaoZkmGW7bvwBQlwu/XPVSxXiyMaO5eEUWv2uGp2B0d1WVy1EE1B6pzwEc1wxLAXVA1wQUDXZPPphgvTNF8Bz96O9T1TWzL2gguiaqGOq/8EehU7r4pqBoG3x0BEEGLAPG3jkLvTOtbrHFAOYpB4pSqAcJSqycREhnejO68pesOZjfZF0b5FIgUINvngcyCs+9pQqS7J5QVyS3UBqDqz8ASxuuXpy9neu2BBzr1xPPUKpfyS4vahkWtZq8J2nAiosgXbgrjN3XW0P3rpchBUpgMWgogE74X46EbhSVx/EUAgyWbWKnQeE/nn3k5JFZMC+au8fBsl2fV1ruFYRmGBudJSPb6o0sAdkY8GBWFv+BEWGi+tw0EaSP19Zw4VrSLm71N2RVNq6vTvF6wMyfKol5jlizVkZO6uBNQAhja8ShiJiRSQEOIQZ+VzpBcyjqyNhy8q6KulpM5kCErIdDUAiQ6TTB0fQq1kbPdCbfHpe2Ua6Ghd4CA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(7416014)(376014)(1800799024)(18002099003)(6133799003)(921020)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003)(261009221227099003)(261102123227099003)(261009223027099003)(261009221727099003)(261022105027099003)(261009223327099003)(261009220027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDTlm33+BJQF8p43MTj+HSWKgcn5Ht/MLtFaOkGIBR4hOjuMRc21/7nkHh66?=
 =?us-ascii?Q?DyX0vVH446IPkg2uim0IBgdB67fnH8YS2g1JMsfpjX42O+bfCTH9Jl7LlL+r?=
 =?us-ascii?Q?GyYYqlu2j0ycNLabWrA8tNY4VqaPf7fAbhOuUkj7LO+LwirDH0LRkQMh/S92?=
 =?us-ascii?Q?Z7yFKXaB0zpmmW4ekpJY2V8fJdZK5N47zEYc1sXMCrZ5xuFWOO+eiDtAh7ZN?=
 =?us-ascii?Q?iQQlFsI187UGC3a7CCzWGyFP8oi6j+GbaDhChjoIzxOlWXW3qIrevuSPZu9D?=
 =?us-ascii?Q?U7+B3SILo/NfmZLF1y7aS+Xucc5AxwLKfSlpEFgN0XZArH9z8Z9M/8+YSV/7?=
 =?us-ascii?Q?d08Af6lowSitlGDad0xf9ViFhnMMpf5hiOJUAKYJjG1LNQpQV/UqqxncWmJl?=
 =?us-ascii?Q?QJil/ugVeMesv2sQmbedtutbbueAMZc8C9VeP9V5Wu2jBuMb28ACkYOURQTG?=
 =?us-ascii?Q?cB4UvWFOkTupw5fZXfI1DTzoaYLRqjywcr9vyBENDKftlCP3nONtdQEnw/TU?=
 =?us-ascii?Q?aH/XB2YPpYt8dYDZKITX7QS3Hc4DYvs1HBDowpBxlMqwUe+Qe2Pje3JY0jXs?=
 =?us-ascii?Q?8HcM/hoxaovQc55wMMmQd4zdWJLU8nNIIKC5vKEtKfxqFM+HYmfc14dOP7hJ?=
 =?us-ascii?Q?3d9M0PqfUNgFimnNa7R5gwspa+C1u9dziplilUZLg70zH79CYIvJSqccalT4?=
 =?us-ascii?Q?VgLpfdjufvgozStzxgFjaRBznxIkxjf8H6YPSVaqyp+HN2Kbcf/3fTkEUWer?=
 =?us-ascii?Q?pVk/4qmkfirsmu6DdaUQgnah63GoST643Wo+z1o682FM94vNVDJK3xohWk3f?=
 =?us-ascii?Q?CmoKwCgu+0AlPEpX0Eva26qWbzTfwg3qBwGk0EQwRTZNnPM0zLsBt97YGzpN?=
 =?us-ascii?Q?VYVPMz3GaDMAzsWMSbaZukcD4OEvYUKK87CkbFbg66wpIlnjcp/WAy5pZT6l?=
 =?us-ascii?Q?b6WdCC3Vk+MuF+w08d6Pq/h22BeN8hI40yJEzwSj8Wh+/ybqWSjvUax/xe0z?=
 =?us-ascii?Q?vJt16SrY2nS3XwzMfK04AapeUuyS7qAsD0YP11IZf0dIzekCcbimeizT3bJQ?=
 =?us-ascii?Q?KOlDoLWh0QRSM/wY0cC7NuH3H6ALXosJj56FMSFLFoCEHtozExIadoqepaeZ?=
 =?us-ascii?Q?QfC5iKdHAwlPrQ+7WHRLT/vAJOsytvGlnrlilNiJCn5aWqv0A9pNZBmzTD0m?=
 =?us-ascii?Q?M8BCXvDf0QDGNIw+7csvD9n9Or7GdAPHT/pa54klMWh2mWCXmghs/la27eXO?=
 =?us-ascii?Q?E3cEvP+BfWGIFMC4L6GyKTSGDSfrbzIm5yO/vyR3cNlXrFh1esVcnX/y8BWx?=
 =?us-ascii?Q?1lqB6cQlWEQmEjMrGUv/UCkp3Tbj6o8dvAym6wSCTU7yuFC/vIlY6ctSm67C?=
 =?us-ascii?Q?63iMcwUDwGK+iobxNb7sHFdgZwZvpRgRfhhvCH/LIyCXpHaXsM/04fUseZ9C?=
 =?us-ascii?Q?vGFPR5pOoo2xawok4CdL89Ng1UmiMzqIrrwpFF7/nERWQ/k6yHGuTS/WNDA/?=
 =?us-ascii?Q?5WHExSiI7SxOrFvwNlkTc46FVnai5drIbrYkVj5rqdIalL904tmsGuda1wXZ?=
 =?us-ascii?Q?45B2qr6XNAkHsCofwUW6JwI7LSoPtUAGjBVu3SikzC+yZgKBGdXKwWh/8fte?=
 =?us-ascii?Q?igput+Wohy7do6k/UnppcgCo8Bs/3edpMFKfzw8o+q3iYkocOl6SvqAXAj/y?=
 =?us-ascii?Q?kpacsMUhY5cRMtCN7KjpgRMN4UTNYp6HNODfG7NgOiFiL++SYy9V4hBL/Joy?=
 =?us-ascii?Q?8FFRncMSL2zNEr166xPAQcIe9gjJ/eg5DBLTnz7xkVw0QwTfbHO/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33219af-6a41-4bc5-a1db-08df44d17e27
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:37:46.7668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWfUD6wlehPxnzu4NU3G0iBrBiEqYn3cBibMVadJE6Er5rSdhcaj6M6SwU23gNd2DFl9TxjFKQ0H739L6f38EH4BRzmTW1DDynqmhsMqvSrGrGvqKGs7I07lW0Xr9KoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12582

From: Frank Li <Frank.Li@nxp.com>

When CONFIG_PM is not enabled, should be treated as if runtime PM were
enabled for the device and the runtime status is active.

It's a subtle distinction but the previous behavior returned -EINVAL, which
means "runtime PM is disabled for the device"

__pm_runtime_resume() returns 1 (called by pm_runtime_get()).
pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
should return the same value as the stub pm_runtime_get(), which is 1.

Analysis of all callers and their behavior with old (-EINVAL) vs new (1):

Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
  Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
  Callers: drivers/accel/ethosu/ethosu_perfmon.c,
           drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
           drivers/gpu/drm/msm/msm_perfcntr.c,
           drivers/gpu/drm/v3d/v3d_mmu.c,
           drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
           drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
           drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
           drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
           drivers/media/pci/intel/ipu6/ipu6-buttress.c,
           sound/hda/core/device.c

Pattern B: if (!ret) after get -- no impact
  Both -EINVAL and 1 are non-zero, !ret is false in both cases.
  drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
    in kernels without CONFIG_PM), drivers/pci/pci.c

Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
  drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
    -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
  drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
    spuriously triggered WARN. Fixed: 1 > 0, no warn.
  drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
    -EINVAL triggered error path. Fixed: 1 > 0, correct path.
  drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
    Fixed: proceeds correctly without CONFIG_PM.
  drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
    (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
    xe_pxp.c) now correctly treat !CONFIG_PM as active.
  drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
    executes stall register update.
  drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
    return now skipped, correctly proceeds.

Pattern D: explicit -EINVAL check
  drivers/hwmon/prom21-xhci.c: checks (> 0) then (== -EINVAL).
    Old: took -EINVAL fallback. New: takes (> 0) fast path.
    Both succeed when CONFIG_PM is disabled; functionally equivalent.
  drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
    stub is never reached. No impact.

Fixes: c0ef3df8dbaef ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
Fixes: bd3d245b0fef5 ("usb: core: use dedicated spinlock for offload state")
Fixes: 7806bad76ac39 ("accel/ivpu: Prevent runtime suspend during context abort work")
Fixes: 1524c28b99527 ("accel/ivpu: Show NPU frequency in sysfs")
Fixes: 46edb0a3eb16c ("drm/xe: Fix xe_pm_runtime_get_if_active return")
Fixes: a71aeff3dd0a7 ("net: ipa: kill IPA clock reference count")
Fixes: 70892277ca2db ("iommu/arm-smmu-qcom: Make set_stall work when the device is on")
Fixes: 9ad65684b9285 ("media: staging/ipu7: Ignore interrupts when device is suspended")
Acked-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v3
- fix drm/xe fixes tag hash (sashiko)
- drop i915 fix tag because guard by CONFIG_PM (sashiko)
- fix net ipa fixes tag hash (sashiko)
- Add c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage" (sashiko)

Change in v2
- add fixes tag for patten C.
- add Alex Elder ack tags
- change subject to fix stub pm_runtime_get_if_active()

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Alex Elder <elder@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Joerg Roedel" <joro@8bytes.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Guan-Yu Lin <guanyulin@google.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-hwmon@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: imx@lists.linux.dev
---
 include/linux/pm_runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 64921b10ac74f..de9e7518ecef2 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -280,7 +280,7 @@ static inline int pm_runtime_get_if_in_use(struct device *dev)
 }
 static inline int pm_runtime_get_if_active(struct device *dev)
 {
-	return -EINVAL;
+	return 1;
 }
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
-- 
2.43.0

