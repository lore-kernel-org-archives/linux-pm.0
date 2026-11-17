Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937085;
	b=hLxs0VUsi3Kbv/yGLEfe7n0bjkOERjkP7weynkV3BUw/yRuQLSLwld6GcEZrxxUY/pMk
	 RMxiDDgJ/Yr/B0AtATZ0yl/4rx/KHJ4YPxmpRZ6NJWxGoLRMbW8h+gKVSWU+sLOvULHxB
	 l/UCgUV83DevOsx4VPGh8aaNYnUY+UlBPoLdr5EvCNH6BhRUqrKIczNUBAFwhzVEYT+g5
	 5i0Sdla8c4auviZtYJAQ2c4/69dgkyZFtl4E/KE+1Tr1x1bdbeQxC8v/yhOARJznVpjqB
	 DiT+ZRY+IjfTt7NnuV23amfVoTcWK4yYLIb8YmAoyiuB5ahV+KBC1VuYoIO0mZCh5Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937085;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=qEIEbjesTAOD1nbI62CqLO0IIeJJxpM0OwDRh/bA1WU=;
	b=TZ6nnHiqHsxg4Z5G3p8hOOWKtdevlcdMB12bzsx99KW6KoqgR0HMrtCFkk0W8zF4xK2G
	 8EbjMkCjxVqWp3Rp3PDVuKCBIzPvJWK6qkBLvFnYiyfz3/yht37AO7kliYZiSjiaM41+8
	 GiPvJxeapmBX6jGycvo8edCti9eyQWzKFEclw3uPctW/Nc2pU4L4XhnG5arlDImW62Tvd
	 wISgWt6jZtNj/teykJv7kkt86EQeBSKjB22VdpQFgHRTzxcvfQcY7gRyLsqvlF6l7JNZk
	 vvGEcgjOA/OqHM6a6sZMTiFYwnS34xEep2/iexgsR1S4ybBWeTVhG4NQBdt1W3OXjRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NWoRQixK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.3
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864E606A339;
	Tue, 17 Nov 2026 17:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A864E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NWoRQixK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyi+eGsTsaD4j9NJ6dD02Onw0+IJXwJKvXWXo7EN7PHR8TZWig5JqOVMGx88V1UawuXlqC5zq+mjTkq2OAlSJ9foh+eDICvbzx637+3Uncdp5CqZoY+0YF2CgWeMLroiSEvO3MkRh0D9QCp8c4XHjXqhGOqri2YSQyNOZjJr/FmadFt6h+XkcQCnMkrwETpcj7sW5V0igegzfrg0E5qKXGLWLCG2/FYM+rTKEezFh0Ol79fey7Hf182SxXz0ScATlTlCipip2dL9elidz+Qf5qbMwTZln+sl8+4O+enW9SGc1bW24G2GmJzIzov4ddXBWOrNHnlI7hCmwTum+mw2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEIEbjesTAOD1nbI62CqLO0IIeJJxpM0OwDRh/bA1WU=;
 b=tXJM/0eGAxORdvox5+DfRYEU6M8DaWVF4wFbhXPel+LHoJybHTivj+qF52kiMBjVy9PJUHqDpZVpWvdljGfteweYucNFakMFnVoAfjWXzH55M7LuUt6YTwIj0h2BWWWU1NWgUnRU9ReYJLSTz27La/OfEAvVqbFB6ApOkhjOHny7mF04QE35Ujtouoa+dy9fqdmypdN5UHWR28AwK9FKQkcgNqOQLGM3B7uh+tNC5nBlBv58u05zj9zjNj6Alw8BTuwxKm5MlssypjXmVg5uuZ0dRp8SsobofMsBtImcXDOWfeT7O5fS2CR/byeR4s/vNnCDRq88u04Prln8SBRUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEIEbjesTAOD1nbI62CqLO0IIeJJxpM0OwDRh/bA1WU=;
 b=NWoRQixKJTPLtqDyOH3Rrr+VZXca784i/05OYFYnTRxPTfDAxBj3NPdyIlcgfAIeH3ES3VgeQkDDiNyr8osahqjBhWpt9qQ9mXxV9t9l6KMI1jSHDRdEIx+/Ofw2NMXrmngU/t07SU52s9GwVDV+MnU+obUlVfYrbVNuozDZNARh3mq/fUvKO5dxLEtb6pYrDtbYWL9OUvpTMAHq1yAFaabxjoFVbAUZnow7KfvKl7TMQtWu6LN/pnxhU65ixELfYVxcWpolSlptvY4anPqHK9am3FBCTqfNNfrzrweZTROF6Dd2i0vDN/47oFqdjpIbVVsEJr8ZQ2NApZRruXF87g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB12582.eurprd04.prod.outlook.com (2603:10a6:150:36f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:37:59 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:37:59 +0000
From: Frank.Li@oss.nxp.com
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulfh@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Will Deacon <will@kernel.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Marek Vasut <marex@denx.de>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support:Keyword:\b[Rr]ock[Cc]hip\b)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	linux-pm@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	"Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	dri-devel@lists.freedesktop.org,
	imagination@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use() for !CONFIG_PM
Date: Tue, 17 Nov 2026 12:37:36 -0500
Message-ID: <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0115.namprd07.prod.outlook.com
 (2603:10b6:510:4::30) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f388b5f8-7a45-4bd7-f30a-08df44d185fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|7416014|376014|1800799024|22082099003|18002099003|6133799003|921020|11063799006|56012099006|261026140227099003|261028144727099003|261021123027099003|261021121427099003|10067099003|261026121527099003|261102123227099003|261022115727099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Jj2sg7l5PFXw+H4AOG9zak2KGj1d+ODAhuCpyyuTvVynNI12AyrNGkVRDG9O0BiiXAX58Buyb9A1oQbFiXzCxnxC0Q7P4dOhlH2N3knmCZw3gO+/66T1Y1SMbZLPMULPLH+HM6l4xa5V+ZmS/+iXhrbaCGZ3vamV6PvDNHHnTA7UcY5yjJ2DoiZvzGd9zpXsKTg+W7TggFzty7yHd2wUFZJze7RZwYMVjDvNmeueleZA0i1NdNPu7sWR05Z8eToxWBtBNiSj4aoSGBbjgbM53KMt4i2iHLaue3YNoWn3CDFlw0sDvJCY8+FfULLahbj+8lVdfXw5/VYkLu3IeHk0m1k7E+4x+Fk/wrPsiWRUoSlio7w2UuM78MsoeATUlKSHmZ//IHu7zz33DcUq2dcOxS4zBefHRMKswBcyBICouIQfSmQTtNbXcFSUb52kccUF94jQH6V5H/9c3xQhUCQrZa05caJndIMSEsEvWazvtxdEqTsNux4I3dCPAFHN+mNAo0hrtdhPaNMv0/E4L9VsQvKR82+nKRmZ9mDXEwbQzoLLyDFJR0BAQ3lSZ53VobAC8HPY7NQk8mORmzNTgChA+GKj89PAkCLBISOlj+Dw725szq9aWec+cLwB+o/ZPkLdpToOlgvrOhZV8Jl1s5A0KhAh6MRXl7bp5QnrENqhyHOy/W4Iv4yZZtHEEbliGuq8i3OakGQd+T9uB3rxTvoi6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(921020)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003)(261026121527099003)(261102123227099003)(261022115727099003)(261009223027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzhnqsgxvfcKxhSHph9G4PC2oJg6GXYAqAfdurnIjDUbyIOY2MKptd+XshMD?=
 =?us-ascii?Q?KgYvPJNern9edV2PCM/Bkz4nj1aEGWTSS3lrQTcUJM74NhixH9jwjA2OFDqD?=
 =?us-ascii?Q?XhxuZg+KPGb9nDh6+Zi/2LBwVPuc5uq4U3aYYVOYZWkKhw+qFl3AmWFHwI9O?=
 =?us-ascii?Q?hngcGn8nYBeHf0hjm7xjepqReR1DkNTn19D6I9iC9fZSpmYgpqMeqWxJPKLe?=
 =?us-ascii?Q?tmz0O6MTuKgppHJSS5fd65lR5O4RIDHxU4tINhoMOvQ45GiQrVfdejKb52EO?=
 =?us-ascii?Q?VcT5M/A2n5If/ol4W/5KyvdNVWF+N3sLEq5zOVHoAFStSjZDF7MBPlISU7nQ?=
 =?us-ascii?Q?6pb6iIawLyO9wCSinN7LBqmk4rTKwryaGf+3SQwP0rCKYXVFupEQ/3FWXlW3?=
 =?us-ascii?Q?Y3QGmWE23AkiRDiBKfINQaSCH5gzZuRaU+Q3fcGRJL1/+aC+5S9eWpTSXP4M?=
 =?us-ascii?Q?fnCwVqk+Hk3RLr6a4d9B3irEof21dqggGD2vfGrON9b1Goy3l/czG2txV1yk?=
 =?us-ascii?Q?HvBDEEgFTt/HNS+3746NkARuHpIpnXa17d1bh3EdDCmbNqSXo24Sayox6lbR?=
 =?us-ascii?Q?3xGqeG67WAL3eAOOq5FiJfG691ez0JqIFyRF8+RC2C8uouOGE8uaI9eH7XBl?=
 =?us-ascii?Q?hgvDuLXYULwJdSxwpzgA9W6h987wJOInTTUalgoWYbVw5+NaNdI5b0kWoUBI?=
 =?us-ascii?Q?2n/9FHNIRCbMMsbovyGZm3MhsN6Y+Z/kb1MVWPZ/6jdSVZ4NctTYDfy6AnGW?=
 =?us-ascii?Q?8MX8Scx8/0n838CC9D+8kv9luGzPc40z5FXNO4Zow1r52AYlnupziFn9d7Yg?=
 =?us-ascii?Q?glT3Tzs8UHxYY/hh31py2GEma4oa2o37tYOTHmKdra6XPmtZemxKhbWVwkY0?=
 =?us-ascii?Q?7Ift2/DBjZZdeOnGUiTOrhJiCwskgVcKyybvYwPhc1skcsHN9FTFlx7/DNvv?=
 =?us-ascii?Q?9Y2q5Pu/vzjk14CAcfEUKh8P+GaMtwvCzlrjWbbQQ3FX9bZyQhdxHripsyHD?=
 =?us-ascii?Q?aLgwppAaX+kENdq2D+WooSKm5yTSDnlSRV9Zc3bkC/N9NOZ2N1p33DSGAR0l?=
 =?us-ascii?Q?3t8QUA37QKdrcvDXjkXNP+/OCath8+xmyyJ65HjynA3vqz9DAsTeSbs9Qlcp?=
 =?us-ascii?Q?T9RbyfxCx1w0EpJiFIFnJUo8zYTHFeJh1rkgAgVSO+tkZngLM0E3450nDqJ5?=
 =?us-ascii?Q?cRFbAuN6Y0uEWFHzQ5KpnhnrReF/EF9hP6Ma+rRNyx63uniLzFQ6OOAtXiyo?=
 =?us-ascii?Q?dKjT7hgAVTt3sA+HZB7c+E8pZsjoujwaTtcBiax9S8wbAuC5aPTEvIdRizvD?=
 =?us-ascii?Q?s9gJb1ga2YSaVCw8eqU/W8TA6RDLfTevgQW/4oAgte9rhBhHDTyIOEgNMw9t?=
 =?us-ascii?Q?ltpLtP8WwlnXvdC8cp4BJH4byffBm4U3XnbjXZRED+vkKXFHAsv2wAoLZsgn?=
 =?us-ascii?Q?WxIVZwZJUQREyXIBdFAwatoW3bdhe7Fi7rGEMXnqaPyUzwEfqWgRm4wHw5lj?=
 =?us-ascii?Q?on4WWXvB5d9QcA3cFQWvdWGYwjgEpEb7MBP1j+lt5do1Qg57lF/X6ZDFOU/w?=
 =?us-ascii?Q?3ZNvwIJnCdKY66QE46TRUDiF3FzdNjLQHEfg2iNupMXPWa37z2aU5LSEpBm9?=
 =?us-ascii?Q?1VSBk8nsAjloCLmtHnmvqEHQ9FnZJFTp2AyVXkmLN13OWnenKJjw9UzEfN+P?=
 =?us-ascii?Q?E4BaVgnv0m/2xXxSHofgFj3KfcdTTFgojz8qQEBC25lyHK/WPFwoU/yHvlJ/?=
 =?us-ascii?Q?8OfqMXmKcubyEqGfd6b0rGZ4NRW07Z0Nhke1TJd0CwBkQJJ0X2Cl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f388b5f8-7a45-4bd7-f30a-08df44d185fd
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:37:59.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgIbX0QllbpVHh5CBK3uQR4gfDILGUBrlWOlvh71oaviY0NpvVLk368OZVogwC5pDC7A494j0lDv35OICEayUpJRI9Nb8Rw8/f5PTdB9aCVOvYod81DVcxzff0G5IJMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12582

From: Frank Li <Frank.Li@nxp.com>

The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
returns -EINVAL.  The real implementation returns:
  1  - device is active and its usage counter is non-zero (bumped)
  0  - device is not in use or not active (counter not bumped)
 -EINVAL - runtime PM disabled for this device

When CONFIG_PM is not set every device is permanently "active" and
always considered "in use", so the stub must return 1, mirroring
__pm_runtime_resume() which already returns 1 in the same build.

Returning -EINVAL breaks callers that test the return value with
comparisons other than "!= 0 / == 0":

drivers/gpu/drm/i915/intel_runtime_pm.c:
  if (intel_runtime_pm_get_if_in_use(rpm))
  which wraps to: ret = pm_runtime_get_if_in_use(); return ret > 0;
  With -EINVAL the wrapper returns false, causing an incorrect error
  path in the GT fence revocation code.

drivers/gpu/drm/xe/xe_pm.c:
  if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
  With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
  returns false, so callers believe the device is not usable.

drivers/gpu/drm/gma500/power.c:
  return pm_runtime_get_if_in_use(dev) == 1;
  -EINVAL != 1, so the helper always returns false when !CONFIG_PM.

drivers/gpu/drm/imagination/pvr_power.c:
  if (pm_runtime_get_if_in_use(...) <= 0)
  -EINVAL <= 0 is true, so the driver always takes the "requeue" error
  path instead of proceeding with the active device.

sound/soc/sof/debug.c:
  if (pm_runtime_get_if_in_use(sdev->dev) == 1)
  -EINVAL != 1, so d3_prevented is never set, corrupting exception
  debug accounting.

drivers/iommu/mtk_iommu.c:
  if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <= 0)
  -EINVAL <= 0 skips the TLB flush, leaving stale IOMMU mappings.

drivers/iommu/rockchip-iommu.c:
  Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
  -EINVAL < 0 triggers a spurious WARNING on every call.

drivers/media/i2c/isl7998x.c:
  if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
  -EINVAL <= 0 causes the driver to always skip register programming
  when !CONFIG_PM.

drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
  if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
  -EINVAL <= 0 prevents any debug statistics from being collected.

Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional usage count incrementation")
Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance after fw exception")
Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL7998x")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v3
- drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status by sampling ISP_FLAGS_SHD")
selected PM at arch config
- drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
selected PM at arch config
- drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime PM logic")
guard by CONFIG_PM
- drop tag 727538a4bbff ("drm/imagination: Implement power management")
depend on PM
`
Change in v2
- new patches.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>
Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Dafna Hirschfeld <dafna@fastmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Michael Tretter <m.tretter@pengutronix.de>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: imagination@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: iommu@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-sound@vger.kernel.org
Cc: sound-open-firmware@alsa-project.org
Cc: imx@lists.linux.dev
---
 include/linux/pm_runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index de9e7518ecef2..1d983fe55a16a 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device *dev, unsigned int delay)
 }
 static inline int pm_runtime_get_if_in_use(struct device *dev)
 {
-	return -EINVAL;
+	return 1;
 }
 static inline int pm_runtime_get_if_active(struct device *dev)
 {
-- 
2.43.0

