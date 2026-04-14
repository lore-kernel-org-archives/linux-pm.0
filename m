Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785A282F21;
	Tue, 14 Apr 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131991; cv=fail; b=h1B8UIG9jFEOTNO8NRnE6mUCmA52nEZ7ctMbjki2v88MSQRWWZdaQ9MZPKCV9TTux9fRjhpuNJtDmgku0V3T8CgJbfR1kdOg3L+b2gEW8uFi0D6DEFCAyoDsLHgtPBR5sdqiZT/Lnt7VVDNCSdrAusAy6pp4dLos+R318c7cEVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131991; c=relaxed/simple;
	bh=TbUhwGfJ8ht0WM+vTHjZc0UDhOp1yiVNUsj5qaPJUHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBiO/FZE2jllUeWOIRxcnHYzdIXjujXxpsJZoYIabO1G/aH4BZ2NDAItOqvcKYJkzZBThikiTuXjEukuwK15jvTRZVime8FJ4ZiXn5tfQ7y4sUASRVU1YbeTmKNlCLIeN17GHKq++h2ATtFf9eRntmG3cNf453Y5XTQJwEG5VN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oVaZy2zc; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oVaZy2zc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3c2+nZRAUrmGMtatp+lbsXTrxS7QbZaEJUnBKMpdNTFoqSXLJU44fpr6cVI++XahFJQ1M/lG1+mIGXM7H7kl9YlxktfWyEq5YX7pm5ua8yosQqble8d/9GYrS4XYk0KbYYAOLHP84o2xNy9l8OzqggznRQR80NBqC5b/TiaZ4dPzJHsVYglvITugCqTL/KlaK+6XPDZvho/tGQkJLdAOqUUOCJsH6otwzEKWN5m1lR8Trg9jwF/LXlvT2p9+9vvnK97bHHok8q22hLgG3XesiYbOlfc3XZGXT4tiOEgraEToBmilExLEzieIY38f8z8ql2gPGdHvqZF1gX7KtaEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KERwm4H632tAu4LtrweC5y/QzzUflqPKLt6dbiDg6Xw=;
 b=Zns/Wvu6KBBDjw1V84hpWQU47c2fU8eYUEdxRvXJrC0YkbTIFqI3wHIKZflr8ufWdjgJ5IBWu1iYfa5BIPE0x/8gpRHRYxJfrSLg4lc2gcTX/ypS4xCgSq2zHmovO2oNkoRR1yKC9AQn9aE0uHLBpM1T2MTC/Bo/XXISqTucN+ywCIgnGhcCEfY56QAQr/nWrH9bUNjky6aVO9yYG7+Wgj1ZC0e76YYzeey/cIybLYZkbrpauGiyWJOJVvGOlOKjXlfeTwcFZGM1fqVGBOa6ofXooDZTAjkSU+2fKVUc2mmRi1nEPsg39Nc30kYF4G3Zuahw2oy+BV32bkZQq4KY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KERwm4H632tAu4LtrweC5y/QzzUflqPKLt6dbiDg6Xw=;
 b=oVaZy2zcxauI9eFEUSPoP2wgEu5OHYm140TcHINLPAYgBmSALIu4Eeh4czdW2QolvIYW9EqUHz3JgAB6WuumsR2iiGa5wqprtdja7fOS4aFDifs6RhlK4RuoAFQvUlyfg1ZF+ruBACZFfj3zdhJRqvhPcVy7+qXe5dMauQY6EfRkzNvzHRd8cbmLoKYDGeMoVLc8WQ/goGtaEm0HNKfq8Kv458KYKvmqmJqRjD7+IrxJGU86+zfYVERwceXBxQKPro3XHvh4a5qKP7I8QmhLUHVzFtmUJwLak7qS02mja0KdK7i/mD5p/XIQ+B/sTXs1I7JadP7/QbDDLxviW3Nwpw==
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5)
 by PA1PR04MB10227.eurprd04.prod.outlook.com (2603:10a6:102:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Tue, 14 Apr
 2026 01:59:45 +0000
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457]) by AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 01:59:44 +0000
From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Xuegang Liu <xuegang.liu@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL
 tristate
Thread-Topic: [EXT] Re: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL
 tristate
Thread-Index: AQHcywa8jFjWeOFOMEiinevo9PMwILXc+CcAgADVNaA=
Date: Tue, 14 Apr 2026 01:59:44 +0000
Message-ID:
 <AMBPR04MB123344C1F802528A10CEA7FADEB252@AMBPR04MB12334.eurprd04.prod.outlook.com>
References: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
 <ql2c6m54fjjwifycaan3hcr3p3bp4phva2vdux2qcramt7wrvy@4dsvpyct5tqx>
In-Reply-To: <ql2c6m54fjjwifycaan3hcr3p3bp4phva2vdux2qcramt7wrvy@4dsvpyct5tqx>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12334:EE_|PA1PR04MB10227:EE_
x-ms-office365-filtering-correlation-id: d493ec3f-60fc-4c07-c3c0-08de99c97fbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 lKoWVmJgSAs5fHApFugkOc+3is02qoha8oDhdLaqkEwhCO8ruymMQlRhrTe+D+6xFv3UU1mNoBSGJQyriHdUogPEX4wBMCYJURwoHz1NEITWn9myUPE5LJkWYNHn7/7N4NZFf/PRi1WD4q4Y8WUFYDvhjnv3WC3bMGZ/0o9JKXvHODsTSgmYltA3McMI8fYhgA5H0xjKckECMQwXtZ8DRZ29LdOEuufD2+4DvLu53aqPurLgzdfoaCjDY+ubv0FMRc5iwx8D0JBdg2OzjC1pCtsMYPPiFQ1DhvmnKBI4i8+4udwyDhi8NwPuMVEvYowm7TP1rAVWZivC3MCgmn+ykHxH1H5aUXVxbOsL3QAQQB6NlhZYhIODgNX88//Hknp1Vp3Ev7lWfdC6S78d31X/3n7sJKhXDlCzX/atcYFDd5Z3hmru0mSuxpr6ZleKX2eesWVkBP88DkXw8gNoc94vX4j8Nku2WK0D9VUMrB1p/qa3ln5wOR9CErRu6geNoevvQ9K/sW5A/BoKawBJ8LCU7T57jNoOH4e4On05gPnkDaJdlrnuw4bTEbr4vzv4j7b59yRWyggSRB77RDq35jbkktJaziWc1uUo1IDQdhwwsC0bhhbror8nnN16Rac5PF1OS0uZvN1g8B/fkYAO9Mfw20oCN57rhJlm4nX9sm6MWEp9mL3P7JmVTV7KtSBVVWUSVjT5s6cvH6Ug7eay4g8mtV7Bt3mIsgR9vwwThbxOLcw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qDyi9MkIR7YUvhBkBDWj4VgwSaM/1HGdfYty/sW6A70nvwAOG/8HACqw8/pp?=
 =?us-ascii?Q?kHADdqLg3Rli+99rSJRZPY1mylW0FIIKt2I7TZuGQKXSM+RA4VRIQtfuwV2N?=
 =?us-ascii?Q?KGDpFUKp8ddCsPcB8f4yc0gqVVQo1No6Vi9KsDTy/GjnCGLMocnd0W2mFtgL?=
 =?us-ascii?Q?VvaeULz9Eu4cBOsUoKor0aJIqf1TVJW6OitNhKLPtxeOIeZt7x2iUi8GrAgc?=
 =?us-ascii?Q?oEsGdDj+iQx7tE25niatfXI6H3Kz3FH8hffObPuahfsMNy3PTnp+Wj0EgiCb?=
 =?us-ascii?Q?wWwRQUjYzNH77WSpT4sJzjBlz+yt+YSufaCsCrnPkltMC79c9VHfsOC+3syJ?=
 =?us-ascii?Q?JiB0R/LyZaBum7Y8/gDblRsAaiRVUpoU5QzX0g+uS5yDIZd4rbSZcHHraEeW?=
 =?us-ascii?Q?KWvUVlUlZiVLidK2yz+J7ifIcXhInr+kKVpHQigS+S9gDLQQrI+rAErEh2gu?=
 =?us-ascii?Q?7SOp0dMlXzOi1L/1+vNSSNuN1w0qfnA1tfrHB3fMTHo+IIjZIGEv3WUbzqnr?=
 =?us-ascii?Q?dl5jBhRskLXtDTZNrc3i3fb8LNSgIMOj7CGrO4ekTGSWDlCrFvJYLg9ULu20?=
 =?us-ascii?Q?Fp1nuq0qloShhPJBgDW8NvLTIDRG8BXss9ScvVnZXmo+Guhz/BVeRWnosUI2?=
 =?us-ascii?Q?35791J3SzxZWGd8W6pasjOBONne1GBRjn8MrCuOZOcf2Lj0bTT9UzgzXThRA?=
 =?us-ascii?Q?EuvIh9NevH2pP2peMJ0q/T7t+A64Mythq4LATpvvS9yZcBiM4nNrW/wLS9/t?=
 =?us-ascii?Q?gkT3Hkjtlr6kdQNcjZF7RUvhQSNF8CYeV7GOYxHv88qvRqbZri3JNG7ZErJ3?=
 =?us-ascii?Q?ld9Z4Pz7zTZv4rhbHWez+IBPFwejrTRHzDIp+NDv6BJsFL6LOUrZ+upeVmIe?=
 =?us-ascii?Q?AYhAdaKq48SYvLq6TKSo7Zv+GGjU1Gd/GdRm8XHS8kIq4pjwTNwRv8J227ZM?=
 =?us-ascii?Q?1H5hqd6xqaxt1mcXEs+gsD5G0wMgNKbo3ojTbIr7hh5GPRDiLpgNw++kAxfn?=
 =?us-ascii?Q?aDuBQRAFaFu4YjvDuwndABAToFkGYNpdvYFQb8eJn19iQda2iMlH8zocIf3M?=
 =?us-ascii?Q?ETDuKunYNc2DnAe2MafIvuzwhgrnpeuObE0Vn8SXzkXbNa7bRj2ichRTIhCo?=
 =?us-ascii?Q?ElsoK1Y2W+uUw2xwEfub2HQTUX5hCoMUMKBS77gR2FatICD+wwPWuhXQoX8A?=
 =?us-ascii?Q?y7k2rGsJtHCf0/JuyInlkOt+8oIQ98vVvgtkOYsUr9XSEkL0As0CIe7OlvMd?=
 =?us-ascii?Q?NHUKhAH9HA4+lTBwfyKnpfG5FMfZJ17BL/CugxZH0DR1PxhWf3KGBcvxuKKb?=
 =?us-ascii?Q?17ELOFrOismqb8TUa6S2QFdwON07vRBoFemYcQ+Mw7B0Yj8KzyV2wSMvV5hA?=
 =?us-ascii?Q?I2bEe8hn7TPGS3+ps4M4YyxU6J3MhO2vBaUmV1geLM3gKslza/zhzdH8OchZ?=
 =?us-ascii?Q?m6XHjmJnawwkEcftEEJIcyhTeQkfBtHng2tqfAGlGR1HwTF/M6q632WGe3lb?=
 =?us-ascii?Q?3MgkASAtR3Lyj4xdtBXQgq+p+gp9iSmNG0C2G1mVg5+MPaA4hvNeg7oOLzex?=
 =?us-ascii?Q?5ahxwe5P4b52DwCLi5Ex6RsGxGbJ4wSR1h1WvPvxTJA8ghEle0ecF7eap1MT?=
 =?us-ascii?Q?VT/mfahys+EXna2rbeDOFNaf9PxzpZTVujC0S9em909djZRQqyS8mI6w1vUR?=
 =?us-ascii?Q?lBcnnfDn6rVelwguLg1gwC3YgHO5HqQdv6qSJm5GDf+PAMCN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d493ec3f-60fc-4c07-c3c0-08de99c97fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 01:59:44.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbvE6wCpNaDZwEm4fnywrrnRiXZTx5rVs4JDa/JgruN2ww23k4LOOKDQTOXdqO35g9aGBqPisvArSTYJOQQBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10227

 > On 26-04-13, Zhipeng Wang wrote:
> > Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate to
> > allow building as loadable modules.
>
> Out of curiosity, why do you want to have a PM driver to be buildable as
> module?
>
> Regards,
>   Marco
>
Hi Marco,

Thank you for your question.

The primary motivation is to support Google's GKI (Generic Kernel Image)
requirement for Android devices.

GKI separates the kernel into two parts:
1. A unified kernel image (GKI) that is common across all Android devices
2. Vendor-specific drivers that must be built as loadable modules

Under the GKI architecture, SoC-specific drivers like IMX8M/IMX9 BLK_CTRL
cannot be built into the core kernel image. Instead, they must be loadable
modules that vendors can ship separately. This allows:

- A single kernel binary to support multiple hardware platforms
- Vendors to update their drivers independently without rebuilding the enti=
re kernel
- Better compliance with Android's kernel update and security policies

For i.MX8M/i.MX9 devices running Android with GKI kernels, the BLK_CTRL
drivers need to be loaded as modules during boot. Without tristate support,
these devices cannot properly initialize their power domains, making them
non-functional under GKI.

Best regards,
Zhipeng Wang
> > Add prompt strings to make these options visible and configurable in
> > menuconfig, keeping them enabled by default on appropriate platforms.
> >
> > Also remove the IMX_GPCV2_PM_DOMAINS dependency from
> IMX9_BLK_CTRL.
> > This dependency was incorrect from the beginning - i.MX93 uses a
> > different power domain architecture compared to i.MX8M series:
> >
> > - i.MX8M uses GPCv2 (General Power Controller v2) for power domain
> >   management, hence IMX8M_BLK_CTRL correctly depends on it.
> >
> > - i.MX93 uses BLK_CTRL directly without GPCv2. The hardware doesn't
> >   have GPCv2 at all.
> >
> > Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> > ---
> >  drivers/pmdomain/imx/Kconfig | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pmdomain/imx/Kconfig
> > b/drivers/pmdomain/imx/Kconfig index 00203615c65e..9168d183b0c5
> 100644
> > --- a/drivers/pmdomain/imx/Kconfig
> > +++ b/drivers/pmdomain/imx/Kconfig
> > @@ -10,15 +10,18 @@ config IMX_GPCV2_PM_DOMAINS
> >       default y if SOC_IMX7D
> >
> >  config IMX8M_BLK_CTRL
> > -     bool
> > -     default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
> > +     tristate "i.MX8M BLK CTRL driver"
> > +     depends on SOC_IMX8M
> > +     depends on IMX_GPCV2_PM_DOMAINS
> >       depends on PM_GENERIC_DOMAINS
> >       depends on COMMON_CLK
> > +     default y
> >
> >  config IMX9_BLK_CTRL
> > -     bool
> > -     default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
> > +     tristate "i.MX93 BLK CTRL driver"
> > +     depends on SOC_IMX9
> >       depends on PM_GENERIC_DOMAINS
> > +     default y
> >
> >  config IMX_SCU_PD
> >       bool "IMX SCU Power Domain driver"
> > --
> > 2.34.1
> >
> >
> >
>
> --
> #gernperDu
> #CallMeByMyFirstName
>
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Czhipeng.wang_1%40nxp.com%7Cb056e
> 81e107a466e482a08de995e4054%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C639116827251261199%7CUnknown%7CTWFpbGZsb3d8eyJFb
> XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp
> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DqeSCoz6%2BawDiK1ISgG6Rs
> %2BtKScilTDoryyrt08WQYiA%3D&reserved=3D0 |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9
> |
