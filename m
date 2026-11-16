Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794842733;
	b=AbOQvUSlOAZhV4llna+TONf/MBe44h7n4pNsFPBLMHf1+wl2U/Byf6PblEApeudD2Xr7
	 kqlwnUyYCg5JoRG/84+m5Xq4QoT31NpmGM2lDg79rO0hJBXhTeiLRdBsr+/mvi7b2Az7N
	 OAfEL6upMc1qvPEAloZloZYYHy2UB3MMvbd0SGhe5RKFMEB4X2idszYU3NEght70QBReb
	 sR1L8FXhtkIrx620yg06ELXKxAqOvaTO6+HvH86Pex+j0RYBnZFgu9SjbeqQUhhzlnDs5
	 U6lARDJva6xk+z5t7siMwojCdZFfPMUK6QixqVHcRHGYpgsJnG8hhdwOoXq9EcFfoiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842733;
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
	bh=tksoX6H1txsf0780XCYzHcMN1Onn11BpeIEWJhyhQ7g=;
	b=Kpgdkf4oAdTm+CWmmA8pCbMWRSZqmIzRqfNk4c/1PIvJki56RTgRwCJM1Nv2Icy2XSzv
	 bC/9eKqxcOn5i6slzL4QoJ2irGZcqtmuDa5C05VWHl4zw7QTI9Su6FtxyPOQ3Smbj9JVX
	 WwxNZ/t/S3JBOF7tLvvwIGo4q+qt5c2w75ofIG9ruLME5U5UQCX7CIs7W5hhdCwvTK2Gg
	 DiLnrxmI5CBvfm8URH0p/JvkQm27zw9beouvmpcweDO6cSmzgm7VnVbqI93FqjrWntRUP
	 rrC0vqQzneQDyIOb23WbMbLmGV98GR+PRUO0uOpBiJKa6kEtyYY5EbgXrqrUULjq/ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d0gEdhHK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.24
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977C606A895;
	Mon, 16 Nov 2026 15:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3977C606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d0gEdhHK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr+3MbEbbh5bDZ5Hzbqi9J/EDfkrdoXfyy0u1mFPS30RgDkLCsORU2WoWVvlB4N+7ph+xWkIp3uHsecfBRPmR0E40RADAQjpZoXD90aJtiNzG6yYIQa14axCynnrycXcobTjfROhGmyiOC5jeQE+GxzBbax/F+QM2KDkh/rDcz+/yxJPdP1zVLMQVWqqW9NlG/I/2SpRH62UClMBJvFgKmcIYWNQAMC5pt6jRX3irhSleFYUsG2DpckoVjWTmBAHmVkqCqZ7w4hEl7/5uPGaKQt0D/b1punX7xd2gDdINKAFyWQW5DwDz/DDC0crgqju91CaI4TuXWpyrTGYpLFKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tksoX6H1txsf0780XCYzHcMN1Onn11BpeIEWJhyhQ7g=;
 b=QUNEv+zhW8WC8Hvi7jZJof+FfDeSI24mmGumrGzYygGTwMbGOJZOVfxi/g2XocE/felnK/idKCudihk41gUYRrjgBl28oBjYTAgMLnD7yWu3KtkF7LY7xVH1UqMSDMgdfCT8Hny2hZyTRYTjKfJjM7pkGPw+UaZ6tNB4N6IxaF9S3mEl6EWjtTTyXaCbXexxg6Xzs4MV/Frc63gi3yIuUgSEIW/wREiBoknEFpwfS3D1bDDYjWOjxj5SOkMJ7kgfpCJqB8pV5EHRr8MlsF0pLr6ADEC7pC+pSK2CyDyuEosMgX7rjD+BOlH7VelseG1klC89uv/0gEqIf4cxXrbHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tksoX6H1txsf0780XCYzHcMN1Onn11BpeIEWJhyhQ7g=;
 b=d0gEdhHKg/NjpbCVFE5NWe4iWUpI4SFoOcekqwp3ycGdbPgfhhf/y9ANnbbSq5DWPdxqr8AkuZPEU2CxBoTnzOxJABCmwPYJULklvJIJIL2E+/PzQQ6JuGBwG2a75O7/tkKhxwUtdFHA5oF+NvCtqoOQJdxK7g89of4pljt21TGSecjPg6xPvGkqkR2lE3Fw+cjJEVgPDN3Db+eoGHw19jJJVKpy+tlYr2rfm9cUYcYtghCVgmoxJ/QKL8HKIHfPq6D3dmPWRwygGioW3ajPDd9lOUlvSyO4JZL+w7HqXKRNmhgIouImTmrR5LdUJBaOIAtMt1L7zRCbZJKFC1HnBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11161.eurprd04.prod.outlook.com (2603:10a6:10:5b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:25:30 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:25:30 +0000
From: Frank.Li@oss.nxp.com
To:
Cc: Frank Li <Frank.Li@nxp.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	"Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Will Deacon <will@kernel.org>,
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
	sound-open-firmware@alsa-project.org,
	imx@lists.linux.dev
Subject: [PATCH v2 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use() for !CONFIG_PM
Date: Mon, 16 Nov 2026 10:25:11 -0500
Message-ID: <20261116152513.2676573-2-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
References: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11161:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ac5ea6-b2cc-4ea3-75b1-08df43f5d940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003|261022075727099003|261022105027099003|261022115727099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Q+FKjZSKQibUl4WutblBZzzkTgeJWf0aZRRJiEO/fbXG+tmuDIZT3UG6iUh3heoOK+P4jqB1zQqYHxbs+ahekso3VXQ5FZW8Lup0NEM5Xh25QHibH4hFb3emb82wa9IE2oijP+9kCPa23UOlnF3hGJkYWMeMjS2j2MKBDGKBCHl/KTLeW22kpfVAIW8X3kpC02QtfPYFwC/89aSF2AFV73qOsY/5wvLzjG7GIyixBMur+Tu7XZzRoA0Jrh4XYTsFlUpsEsyPVzt2sKZ/dn+NGZJxYBb50cR0FCJL39moPxje7N3RGMu3fE6EmMw3RdQAsk+DH9FSRdVEstnUDw6B5rfH9Iw9NKYZ4Kpdq+KEvvI0E9etbkMo2p8ok9OpenUStvSnN7PkjGmxypS6pwNBpk1xeeV5h1K6jwCsTfx9atJIpRHAjfYK1uu6chswP3JdZ3byM0MB2lZ4WgOioJXPos9EsCbWua6MNEsEpOqPSLyC0B6E4iTGiFA8wKRXIQpVkU5N8N0lD3mNXW8w5dunPLxg70y4/YvBsv0b5ZwDCV+8IVPYlThQutyx4cD94E8Dn7CKEwIYRIHje3JQbOsuTD8w5q055nSuMMZQQHpXhZW3Na2B7FWxJPRHKNSgvvsaqQPxQG3HUWf4F6iUbii4hgFa+kKT/MEngfIOq5Thfzk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003)(261022075727099003)(261022105027099003)(261022115727099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wmbFz9a8p/dPiBwvk32qGYlVyZ+B6rYMUNrfxppAjWItvIJeOn29etIJw6jL?=
 =?us-ascii?Q?L0uTlAffFe6J9W53GKTlBVav+7HlMelkMviZaDdiJY5ffPwzDnYcrvX4rOgE?=
 =?us-ascii?Q?KTpKqGwCb0ILf6U/FOPr61vZJ09A/mqUUYIm9qL2SXzFncM9ZrAD6MLDxkDz?=
 =?us-ascii?Q?GxXsBASoXn4IQncPPfo610NdvyJIVioK0Z+YrQk11MKj1cYkKOLf+atFyJCK?=
 =?us-ascii?Q?iFNTcIwqAHOuxCmp3NK3BeYMivCgNIZsBBndfbF4cujDsAp8J7bT5jM+IB+9?=
 =?us-ascii?Q?xQfG1lnbvnc3BsABxmewVUjwUPB9O2IGIWJt0reMEAA4T3SNC7TTCtbg8R9B?=
 =?us-ascii?Q?WWLe4Df+mPu9XvrCbsUhqzxQMs+vWh8b4lYL8wq5XW8EP8FL3XapPbTe9OzJ?=
 =?us-ascii?Q?Z8IwcKVNEgvWRoqIW+nuosnYxSOeem/9WC4Mg/fXg+mTl3Hbpi1cCy11c2w5?=
 =?us-ascii?Q?AmLfnFlw9uZbwpwIJs8g37S2W5cKGXGDahYduG4QhsmLJotehfaa4uPseYf8?=
 =?us-ascii?Q?P85gLKNPvt8BIHh9VduHdhHj1/5PdB+27mGT4r0YOmtuUyDxhWUXqKYZV+NZ?=
 =?us-ascii?Q?3JqpVlo1EDjB6vkvbIq3sWdFjc7CBl2sk0us8GqzzFyy45t9U0U5IbmyLsQd?=
 =?us-ascii?Q?UZ7VE0teepFWr6Y3CbJgC5gWXHZ9nD3UxYyPJgd9x8sO8WFsCmMmEVm+8GAz?=
 =?us-ascii?Q?+qcf76B5rb42UEyLhzTEN5HXm6YdwoGo3cAmHlOxtA2TkXQYStaDj9k/1+Ol?=
 =?us-ascii?Q?CVd6+hXd8+HDFQewqeoMnjeaYV57aL7wUjLYayceVyFdCucpLrjelhfW8wgk?=
 =?us-ascii?Q?m5juPttGIs3uEfuaIabmxfQfJR/eV1tjIuGnYysHEnixL1aO4KHMDFL2UEQu?=
 =?us-ascii?Q?6tijxT9DI/IXaADoqMwn+a7YQxnGJGW+H/5P2gYogdCx9BVrawVpByL9sb2O?=
 =?us-ascii?Q?KgtJWLCuk0naAXOsJ8QAlEg/tQrux+uNGSl/obMtPM9FPWueS6YNouCKI3OS?=
 =?us-ascii?Q?4IVK6zTQMwl8LA3Z/M6Qyip8gih7cEcBz3zXfdL24TJa+xWGwGrKVCMnhnGc?=
 =?us-ascii?Q?KSTmNcMbRURls58uQCOG+XdyEgBeonKVnXvK1mKM4SoqrxtV9tevIusylNUO?=
 =?us-ascii?Q?cHGAACBgIA5moV1/IZh80BgSyzn+Hfw2zEGWEWhSjzRNbfOeo7BVTVd9FtT/?=
 =?us-ascii?Q?T7rLMjqtLxgOnji/xgUKRXk/KGxa8A0lGXYLeeGAXMbuzTXyBzaT7ep4oFL2?=
 =?us-ascii?Q?WuowrxBFhuld1kWcBlXfRo8fv7Ko3qhxALHMdDgzoH4oN3Fm884EEQY1i/AM?=
 =?us-ascii?Q?NsRAjVI8IIJpvZxW8JVcjvBLgh8nQC5s27GbKX9jtwwyezOKIuiGfsrCQ0rp?=
 =?us-ascii?Q?xN1MhGiBrQhhgzmetExhkFwWGQ1m2qPatu9uRTWaN7XqgW+O73ed9p4uoC8U?=
 =?us-ascii?Q?VORZIQkjL5dAxH/MUfns9F79hI8y+dI4apWsRa3P8ICCF6siVfS9IAafYwRR?=
 =?us-ascii?Q?LSVwPt1ZlxnvqoWndpk829wwRG7bg05i6w4RnYa+8GTSlOGKIBcOYgBzw128?=
 =?us-ascii?Q?pZpLH6Ms9K5phlaGF2bHniVN4gjpzM2MA8Ea1ZKmUaJkyfIlpA1L07BHqxPs?=
 =?us-ascii?Q?pxrlGdCKiScAGbbf7NPXPiSxVmkKQFnuybPR2iGEIqOkrixFNrI4aFnSJHGR?=
 =?us-ascii?Q?AsdiTRI8CTzm/aYCLZ1ia7Ab+DPPQlDJ9ETDrMsfu/hutbStMHW7EyNlXJfu?=
 =?us-ascii?Q?MrBwBrFLJEvNGWsA0Zd0syYkMB3TbTQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ac5ea6-b2cc-4ea3-75b1-08df43f5d940
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:25:30.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG1BIHCvS6DZ72/Qd15pL4jcScuvxQnByT/20yVRwzN1y1GyrOVfMKrzzePKLHG3c3/km3kKIjnuLdGsJK3nTnVIq4YEBY4YBloK/0qdRBILF3jz9PQTxxQzagf8FXD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11161

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

Fixes: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime PM logic")
Fixes: cbb6a7413b17 ("drm/xe: Introduce xe_pm_runtime_get_noresume for inner callers")
Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance after fw exception")
Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
Fixes: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL7998x")
Fixes: cbb819c363c5 ("media: rkisp1: debug: Collect input status by sampling ISP_FLAGS_SHD")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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

