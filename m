Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DEF40DFAC;
	Mon, 13 Apr 2026 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776049705; cv=fail; b=Ny5G4skGHkeL0NuS4gySyUIhuCKFzCTg9QOzyroXNmECMR1Qqb88IO854Hd+z2CeZzr/Zw0Dra8lPR1BubCb5ij9GSudQMUrizYenT+EQ5aZ3/3ZRJe+Dz32X0aI7jD5JseeGaCuDoILR5veLdUIi8gKcjtg0UGcJy5TIKJdD34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776049705; c=relaxed/simple;
	bh=vm/rXP5geZLAq6WL/c4ZAZ0DWjxqKGJBJ3TncB0TinA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ASWUhIww+a2hUtVnCqL3Qjqz6LXB5hpyTOUJycwr0dFknzGJsERIEhdhOm8QRgpKJX+6h0z6uwkrbCDf1iO+/IwhX6POWjVwagH/wYjlEqLeu+BQPhsfdhPP/eisucF0Tmgu7+oLnQAwD9PHPlR8KsBi9h8CO5yYD/buD/1cYzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fEmHQ6Lm; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fEmHQ6Lm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlEX0zbPNyJhgWHMe4z4SFksAEhn1Zbq1NwGgZqzzKt7vMf92Ei0/y2MAHirGOzUerVBs0kWcZg9KMlQB5tjObPXFvS6m1eH4S/EkahRT4AYqCVFWVLc5hUmdhQnjw3Tpl/muK1CSyV/mRsXAkI2nl12gW48VgBGJr6HzsHfnpVZBXHqMLbRan1EDeYvNeKyrbrOVnWBwcgKwclCrEWUYYnvhSyHXKAzmg7rGAu8grvSbrtajvRR5fPIxWlR90Wl8oFAr4U3rtu6ljNXGJUkStM9y5exz0JCuBsoRkOHQIVaKgVnDZCBr/3nGopUyOdFolNseG/6Zw99PkLxLKdYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOKGa8CecIuKFiX5uyolrzMd842bbs4sr76eVhdo3p0=;
 b=HDSyEU1Z/FQjLE4uhA+fUydjm6hknSQ7OAJmbk/BnH61og83QnuMMrJZ01cKYD0puB8VCH1D11xOLU/mCoDb2aJv6i0CBVl9Vbc+0XtD4phrm0Rl5XvYQrvQj7XyY2xYvxSUbaN34Y+c50HoMZfNcLUvAqqNy8LPDdvQ53Zr75NWCS67uFKOC/juiiMhgRcKqIguT6K98HX7xMBF6+x0fROmJ2uF5clEeCmKUtGw6Rdpxm9QPSmebTj+YkdyVF2IX6h2KXzghYiUlMmZ/VO5zhMjU7OO+EEC/8AY9TA7rVnoFAPEo7M8bK/kf/fGRD0Eyk+K3lzQgEZprFAi2w1EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOKGa8CecIuKFiX5uyolrzMd842bbs4sr76eVhdo3p0=;
 b=fEmHQ6Lm4mctizkBQwRQ9fGT99URbVqZa7sSsHvpTVdLAWqY9JKz/1BJegWJutnGRU1rR3YalbZgUYj2maqQTLmTIz8y7HOfy72eeHp6nVZOqvWrU9ZnqwPxB5UVkak4d/WN34GKUKzfIxMULyZHSuakKn2iaIKbGOqa8wg0VrYG0eNNsD15+VQOPTksF9DkLlhtcAZkRjwwkDbD/hkE+ulww6rxvF7ZvXhagPPh2fzlRZ/rH1k8K0h8bPQDhJf3nRiFeFybNZkQWHyzWE+0XdaJWOKFF5ah0Bc7iD4QWzPTDIjf3ybBSXeUZgerdD7Z4w7aFgwNoI7KewisHyeZeg==
Received: from AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16)
 by MIYPR04MB12573.eurprd04.prod.outlook.com (2603:10a6:290:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 03:08:20 +0000
Received: from AS8PR04MB8420.eurprd04.prod.outlook.com
 ([fe80::3f0f:857:96a5:17f]) by AS8PR04MB8420.eurprd04.prod.outlook.com
 ([fe80::3f0f:857:96a5:17f%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 03:08:20 +0000
From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xuegang Liu <xuegang.liu@nxp.com>, Jindong
 Yue <jindong.yue@nxp.com>
Subject: RE: [PATCH] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Thread-Topic: [PATCH] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Thread-Index: AQHcyMxR5yqeo97CDU+xsz/4jCXMMLXan8SAgAGzW3A=
Date: Mon, 13 Apr 2026 03:08:20 +0000
Message-ID:
 <AS8PR04MB84204966B358280D2A89F348EB242@AS8PR04MB8420.eurprd04.prod.outlook.com>
References: <20260410092735.1065294-1-zhipeng.wang_1@nxp.com>
 <adrwO8HdZ7d85mEy@lizhi-Precision-Tower-5810>
In-Reply-To: <adrwO8HdZ7d85mEy@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8420:EE_|MIYPR04MB12573:EE_
x-ms-office365-filtering-correlation-id: 0a505a1d-6961-4d8c-9ce5-08de9909eaef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Str0/hV9koZXNms4NFfYV0ApzvUGrg/EIdHjgmh9MNI7OVVgzIndoVu7H+HHBo6p5nOANX0QiopHSz+ynQhZLK5WQPrGnYGOPEfHYorzvzetsp2PBhNtrYKwGXMuJUdvfs8A1TCBBzbjxhL4TMOaMIn1r3Jzb7M95xjUSwqysrxvpqWnU0lFU4RNc/TqfBRf1K1pfroJkV9kuiLdJDzy9mVO4EaDLR8rNjHCY2vYQcikSfUkSNLI0gdKipP6DPektXO7cESChmWct6QnQqIeuNxc60t3CcJ3J17G91pTvs1pA+AHCnV1HLVPq+FnCKloEWKFi4YdZXjdknH49YumIJ5xppwValnZd45CrCSwn+sfHBdzNwxHiTmDDxvLV3EWyvVq134UD14orULDK28tikY8OrGB1EYdqy0sU/i7KFso9g8Fu2/D0B2pPIIN/wdIBz4Oc8FW4GEl5Pn2GenRLvGvPhbKdpzm1Uynj0LIOCcffJScrrX0Rl2f3ywcaZbo7xCPJ0C019sXtEECbQbEnLmiUCDdUzQcs+yxD/vLc/TGNHTRotKQfFkNhWWTLYNv06rzoext3y4tA13bxZamLIOCopOa9woM99khQRusyM+WjHZ12y4ouIyV+lWpNNN07X1BGFbWUx8acbatwpTnuATuht5eVrtmMB36BqKA3gYsWgMgi4Foxt26P+Jh7iru0hRuyW33r6I3Od+tDN7AGxCZDzwTLcDbYNyUPCnjnahttU9VlgDEolpwvlsrT2+cgIadYFXavq2/cRFHM0tfigRi701KJT3ynniRKZqQ2/w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8420.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j853+IAYU7DnczOxORUHmbXS0sri2eAW6Hq1S9Xvp/jT6ll3fNekNkZLK9gH?=
 =?us-ascii?Q?u32zhajQFlgRjFOc1ai5c8yfzT5nuEp2sEy3hxFS+ZQ8AuuMDkhxnnpe3spi?=
 =?us-ascii?Q?B9BfuK4JRhgiHtW9Fq3JQVCWgn0Tv8FbZs+OXf7Wp+5FLOW5Ryg+TDcaHEpD?=
 =?us-ascii?Q?G9phwCBGdbzDrDCirUW2VTZma6a2xiS86qghTKv7n6BmT1T7BCmlpwYaylFi?=
 =?us-ascii?Q?a1p/yBZohLifN3Q2Ale2rDrZvKwcfEhw3MkOdEfPRv2/nxGgDeDyBN6D8EN5?=
 =?us-ascii?Q?/L3H5s5r1cYjmgL9ENjTLe3W0HRijMOMH+AM/NY6NSuY3mz/eNLKfA0VV/GJ?=
 =?us-ascii?Q?ads/iJuRmoVZfnhq7NDIsKk8jXXAgi9fwMqs79PCJEnnv65ZPGMk0E14BSe6?=
 =?us-ascii?Q?ZkP5s1bCRFYbo2PcL/nqotz3JQYlLkP6P8k93NTMqolVKShExfi3PO8EUpha?=
 =?us-ascii?Q?/Ubh9uFvvFGptmkeADOV+COliR6iGmE1aT6w3zLT8PiXclEGxkD6L1U+g/sG?=
 =?us-ascii?Q?KQHPCVIU0U94OxY3JIYk/Kg2Dw9Wz/96ihL2zd5wEtHoExEzvUS7c3J8unQF?=
 =?us-ascii?Q?4h9Axdx/D3J7UchQJN1WuDRUqK+Dd6bw8QwOy8GR7tCmb+dtBWMcwn4GV+7x?=
 =?us-ascii?Q?pBXoFLYQL9h+rFaMTwo0eKkW2128hvjb0Hsm9OHqlBS6XmEAxNieauN0Inrk?=
 =?us-ascii?Q?xc+TXt2+1xm3ABTYlkGW7uEiIGTTHp81QO7EmCue18Y9m21q1dzGFeDW63lI?=
 =?us-ascii?Q?hQSEN/mdUCmWQgbjgM9nSS6H9zR+ZEpfGr3235x04YsVMgPttcbZVpcVE4Re?=
 =?us-ascii?Q?X0Amqv3XgJLMSJPOPdXrpwBONTpDGbfaRPwgOnl/uEpBWSgh59ZmFlWF8A6E?=
 =?us-ascii?Q?AuuKILDvY0YD9XQzu2S9fYPI453DwEi8VvNxqAYWn1CM9xben5RB49AKxPiX?=
 =?us-ascii?Q?dVE0XufKnK0o2dV/OIwOHiFpum+ePhN/3dE79W2jQv0v1Zpu7O748dWJKT8x?=
 =?us-ascii?Q?wMziME8AL8Xswsx/q3p6pU20yRF3pi/FAYyYbsZGVWydJTwJ7KCc1miY62gd?=
 =?us-ascii?Q?cRJxOF5pEkRlpg2+cUENawD1fT2Oh3cyYewrkewF5XD+l8wz7jzzXQFmIbHE?=
 =?us-ascii?Q?MCoCB2ov+4Bw7Cp67gv60LWYl47lBryl5iJ3SOFlir24vIDLuU8ma41qnsbi?=
 =?us-ascii?Q?vQBteglySvAWcNQzc2J9yz2lREdtOy8PAFN6Kvfha5cGnSBazYe9Bh4iH+/n?=
 =?us-ascii?Q?eZH+kucRSCFerDlGQNrA7NH9OLQVswa9mYydVeBIKfpor45jkNW9PFyzlHlq?=
 =?us-ascii?Q?/YPTz9j8egRCkDzkjxH4uEFhM6umZFr5AwhOutnsdCP8VE8f5jCAZJoNVAdP?=
 =?us-ascii?Q?RBCy+DcT95Zq53+1R/+Br9KkmwU/lgAKRZabLOz6d+PRfceNWNWn01yWS2Fd?=
 =?us-ascii?Q?qhc6+kvHA/+XChENvk0mszLa0d1ekaPG3x8FLXGE7y5kLpEJ7WmS2Nc6jqWT?=
 =?us-ascii?Q?9f5lVwUCpSQ2i0RmnG4tJifS1GjK29+yJ6mvETbHib1va819KwnIv9txHM+W?=
 =?us-ascii?Q?lVER74NIAYThP1YDYs3AxkPOPoBwVeuLPyfFlRbjBY/9BzY0VWsnqCg7yeIg?=
 =?us-ascii?Q?O0phERKgYH3NvhIsApxiL1q3CUqtzSYB4Tx78Doc9YynNN/TJ42k36yoA0+3?=
 =?us-ascii?Q?OkYH0uMiRF5ZW12sSSLHVIsjEwdw88BA9k3bXXtwKe+hZEBTsQoNsj+dmZj1?=
 =?us-ascii?Q?lvyejOzEgg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8420.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a505a1d-6961-4d8c-9ce5-08de9909eaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 03:08:20.8238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5II4NUvsZmG2ghXi1FK79AhN+aLThKAyw3pk7A9w/ObH0IsNU8Dv90eFDejSNN1wpWdArNM9Zzpe9LtPIJ3Rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIYPR04MB12573

> On Fri, Apr 10, 2026 at 06:27:35PM +0900, Zhipeng Wang wrote:
> > Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate to
> > allow building as loadable modules.
> >
> > Add prompt strings to make these options visible and configurable in
> > menuconfig, keeping them enabled by default on appropriate platforms.
> >
> > Also remove the IMX_GPCV2_PM_DOMAINS dependency from
> IMX9_BLK_CTRL
> > since i.MX93 doesn't use GPCv2 power domains.
>=20
> Does it cause build failure at GPCv2 platform? Or previous dependency act=
ually
> wrong.
>=20
> Frank

Hi Frank,

The previous dependency was actually wrong. Here's why:

i.MX93 uses a different power domain architecture compared to i.MX8M series=
:

- i.MX8M uses GPCv2 (General Power Controller v2) for power domain manageme=
nt
- i.MX93 uses BLK_CTRL directly without GPCv2.

The IMXGPCV2PMDOMAINS dependency was likely copied from IMX8MBLKCTRL=20
configuration when IMX9BLKCTRL was initially added, but it was incorrect=20
from the beginning since i.MX93 hardware doesn't have GPCv2 at all.

So this patch corrects the Kconfig to match the actual hardware architectur=
e.

Best regards,
Zhipeng
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
> >  	default y if SOC_IMX7D
> >
> >  config IMX8M_BLK_CTRL
> > -	bool
> > -	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
> > +	tristate "i.MX8M BLK CTRL driver"
> > +	depends on SOC_IMX8M
> > +	depends on IMX_GPCV2_PM_DOMAINS
> >  	depends on PM_GENERIC_DOMAINS
> >  	depends on COMMON_CLK
> > +	default y
> >
> >  config IMX9_BLK_CTRL
> > -	bool
> > -	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
> > +	tristate "i.MX93 BLK CTRL driver"
> > +	depends on SOC_IMX9
> >  	depends on PM_GENERIC_DOMAINS
> > +	default y
> >
> >  config IMX_SCU_PD
> >  	bool "IMX SCU Power Domain driver"
> > --
> > 2.34.1
> >
