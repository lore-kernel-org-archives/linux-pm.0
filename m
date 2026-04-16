Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C01221FBB;
	Thu, 16 Apr 2026 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776304803; cv=fail; b=b2LkjoXhRFAolCWZ0seKdUuQTxmMeneASF85wx2tvnlrvca1YS4hhhXhnpIVRrj1rYqns2H5vjmGeohsf61IuMk7EgA2ng8BAyUYQHEbkC+d3yvFe9xdR3Ihr5My/DdQFWKp+Y0r+EYVs0ECEej8ma2p9+gb01fa4DmNzJwa5yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776304803; c=relaxed/simple;
	bh=YkD+Oq42oqFRtybATcb5nH8n1vsBP0+FWOVOcq7iw8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UgUATIZZDLoqBCLz1+2zOlYg/pmraCQPKqdixmJoHH7+lddYxLdT/CdWZRFtjp2uflBQ0E3L6378+JuvIi6vj4XymtXvVi0Uu88y9wOCXf2sfiXjiXy2EAw+kRN/KQ4d9kXP7/UwjWnG2y1CVHJFuMlzT0Foipui1wTRHsrRYis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bYc+1/Ty; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bYc+1/Ty"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4gv7n8a782CtSP7xnNyTfl1o+L/7FAuHNP2TZXzrw59EwZpjJk6eyfiezFSGDsQe4SBN+s9/vNgKw2j0pkWUqjvl14fyIA8NCdcrhdMPuJ8Qlq1+5nfS05uI3azQfQaNpTTAcaQxMKMPOOhwt3nj1vr+vz7SzF3Dmd8b9ltD2nMr2PMzf6TKi+bDRjMe4iKHC8hji2GAHhrhnCLxJsVAlSB5I9cDx71XlxOC/WEcWcu9cN+cJkEZqHtBK5fyZ7trSpPaz4MDb1uRECjLRMwf97PL6BrEOUCjpGaYkOCGKjedYU7p/A3NLZD1u6KL9bNh5SJV4L8BjRjl9eKjtqyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ley9z5WRcvPIWjwtcVGhLftQMmDvtzud6GdHZe+3oUw=;
 b=zSwUSbjhVohpnnmWTAj2KhLbxblUWWhYHskug+s6YcU1VV8RcDM2n9e3pj807gLAXsTwaVIhYd0IPsd34NJzj7JY7CgfERHLoSpWI+Ap4Kos3r3JxN8CNAhEiD+++nzdxrQb0jspC0a2GcxQcqIKfg5Yv+VmWfctVMnR+WO3RWqn8FGKyrJX0Z0uOTFYpBu5rXZxzEAP85BeOLDyKWlcfDBiTSYeLXHPfDDOfoXFzmh8619PgYde2LW/E57JTjMAG7i41DYdXJOMTgzwrZfgyf8ZbVnhs+AARbUlUEt6l66ik6bj5BzqFfNUHGnjmEm5PJFQ124DWZ3bdc0KKyQ+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ley9z5WRcvPIWjwtcVGhLftQMmDvtzud6GdHZe+3oUw=;
 b=bYc+1/Ty+ouuWcNmNZwxe/vqZQaJ54i/l5+MMoSxGdxqT2YEegA2FasW1gzV9cKL2QuSuVcKRn219zoyQixcw/OlIorSFseBIuEndOJwG0dR6S4LSsXsXxoLCDqhW7jD1Qm4g97ZTItdd3yIogwhTU3GXN9Y4VNHGqsRD56W2HHyez2Ey8QTPah/G2CrZITOPfuXPqDUfDXnvNAx/LTOzzrM7qIq/Av/vl2g8d+nDLhnPQXor+a5Wm1OCHGeN2/ZqIKVoMCdJNNGFTaShyfChXEVbFEAVUnNNxDZ5WYPiGshGsoPbgw/WCDx5ZyBRNnY4H445mFT0C8Ot5j+r5RHxw==
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5)
 by PA1PR04MB10700.eurprd04.prod.outlook.com (2603:10a6:102:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:59:58 +0000
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457]) by AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 01:59:58 +0000
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
Subject: RE: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Thread-Topic: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Thread-Index: AQHcywa8jFjWeOFOMEiinevo9PMwILXftJwAgAE+XrA=
Date: Thu, 16 Apr 2026 01:59:58 +0000
Message-ID:
 <AMBPR04MB12334512DAE9D0EFE084C241DEB232@AMBPR04MB12334.eurprd04.prod.outlook.com>
References: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
 <ad83MtdMP4rci3Ya@lizhi-Precision-Tower-5810>
In-Reply-To: <ad83MtdMP4rci3Ya@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12334:EE_|PA1PR04MB10700:EE_
x-ms-office365-filtering-correlation-id: 95335396-593e-43ce-7ce9-08de9b5bdcef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 orutSyxKYQK4fkuWYis45+LFzRI7uO03JEpFcmYqUiEHJZKN/j/TjC24RaVLIAkarekADXd2PHjBHpNq2M48lZDrfaypHzFmmRWu1kujs9lmaETP0egjp8eqj1SaJB3wiSoSzFzgicekhe4XKxLWlS/2VlLNZCKynCdOqHmm7ae9zQQR7CYEl4ZNlHrrU+piim+GEooVAZnMmYhbdWlOnKvs7SEFXLlRfu/fRjcFQF3WC36Wd1OhSWLCU5C8OsCyOy2cFG/8pglDRWWMDuLx5fPBoc8bNwyC7ttZDWzfWchhGni7PLEDPJex2ODQRa2hf1j/XayrDE+lSrA6rRNvbTar7zLnO3Qh6yzAFRUuU/yKkifDUAYYyssP5l88YMIjQWnK2wY2mn6TIDSURbZAzisdmcRxq75zHnzH0uLfBXJgqZuvT5qtwUfepqoFEBtP9Q0e8qdWTQ9jmreThm2NdPdl6FZLvb7hI/j/1H/JZYWQhNeM63R+tWXyxkqCmo6kmZ5m9jUaEwLc9kLw1WtdH1Qs9P3o6nTJGiKb5vxb6wtCM8y1EW5bhY2H6qvqkq/wYoo0i8BqxzFr7CIx6UNkDGBrZxXcmXH9MUMFUwOYuZhdh2lC7DOCPW4b4LfiQN0DN+gJkrJJUJhkwnUYBHP0J04akWpjMnhRvqFmJFcXZiI8sRD54CqP6dPIqA4a9B6X6WdiasgqvI+pKRxVgiRVI6cgOwlFiSseqhlL8EJZJ5XAbKdMgoSP/f3mK1f6DgccbzxgZ91dCe1ryQ5ob/Y7chYB7ZMPG/DFupj3Rj4D2Kg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m+YFIiEbss1QjgzAeYS1vwgi5iR8fLvYpSHB3KT1/UInDtjJIbWS0GHSnEH4?=
 =?us-ascii?Q?d4cQ38ySKPDnhTBGMLm01GVvlS1Bg1cmbbzXE1NLt20h2tpGYunqNdmJUjsz?=
 =?us-ascii?Q?YlcJocc19IKuktJcpHGXo/2otYKBlZ8sTqE8Xv+PlhO0ybcSwDUfziyMS9i4?=
 =?us-ascii?Q?lQSD+o1fRyON6/woSx7gLtWhCVoaK0CacBtc8/OE0Wq9PqPokxQc/TfYvOqR?=
 =?us-ascii?Q?P7Larl5oUR+wpQKKL9rDhSsdnj3PEyj6bceX0ZXIBae/9+LEsXo9bHbOc3gd?=
 =?us-ascii?Q?OH5KXxAmxXHUVCGGS96UL8pUEFT5x6yU6YH2N6j+aiVqnv2V1nnhH4kQ4cJ+?=
 =?us-ascii?Q?dYJ/e/xbPRpm5x+8E6tACEnUWFFQlrLyKBXAe3DGHcCXlHKjqiP/O90RQEWO?=
 =?us-ascii?Q?21cvo2VWhvDK/pVLtz9Y88Y9eC4QEzEU7st5IOPPSVlUcKiHbq+NR2ebUfzR?=
 =?us-ascii?Q?9xLC+6NiW3GTFNj60TFXhwEYdtVgBwVYijEm9RYVL4bQQc2UtFgXlZLi6gEo?=
 =?us-ascii?Q?Zb6yeafHPkcaBekcIzDbwMaYHky7gdu7lmKTrjZjFty5AlAMkvURu5wI1JvT?=
 =?us-ascii?Q?+qg4AiXNRmY09iT6i84SIYxyDx0XzoMfN3vxvfpS4iST6AZXBMR8hjOLa9rk?=
 =?us-ascii?Q?OPv7MFsSxTrECZOeP8TjRq2O4z5b0k7X9XDBqulpMEo84oUYxNxLtvFgY+zA?=
 =?us-ascii?Q?HrJ6kZK9k+5R4x3k1nU4r8XgTrI1/RdTCAby6MgD0pC/fS62bVwBMcmsQ9HG?=
 =?us-ascii?Q?enw76J70MsUSSQyhn9tLM8JUzr2jG8OapYnlkidlMFaJDt8h+qAyHkj+VhdO?=
 =?us-ascii?Q?FSwIyfkRlqLb5p6ZvOlLMALdoS3dGXIqde93kzWcOcVnvU1L5n243Sbr7mVf?=
 =?us-ascii?Q?V0UNXtS2ncXfLDqIf5kWaaPF8U2G0hU/ljgHevyCKp1vSzoRWqbSvClOcnNY?=
 =?us-ascii?Q?TFseHjifOMbJR66JxGa2ui4RkHL/6j4Scfshk6gvOfwGz3hkua6aJytzJBpI?=
 =?us-ascii?Q?35x4Rtj2aS/Y3Rd5y/Lfwv5nAGcJlyp0GGlWrjBVnC1yQGmrg4JianZ54O0P?=
 =?us-ascii?Q?aOEVUwW3zFOHLRHJDs2jBxHC8IawNppasI+mPkWdwRotOou0J5vyYweJ8uh8?=
 =?us-ascii?Q?ziG/LZjzXhFdvCywfCEqbvQllcEW1WRZsTNRZK2t1CrrBr/JXxk3gKzCHX0w?=
 =?us-ascii?Q?j+Dv+le1arHObAx128mEll6Jc10/C86cyCKuHRLcFQjHmKS1QCoF4M/nxlA9?=
 =?us-ascii?Q?e+SJNpiV51UQzTrVu/CH8QQbrKOyrz7aBvgSBs2bqTSpNLmC6lIo/xR438FN?=
 =?us-ascii?Q?l6vQN/S9FkgWat8amRdpNFDqFkzXakjKvijyvc6NmqjjJK/fKGClNIaeN1gc?=
 =?us-ascii?Q?d7AGrGGQ1OFizt+DJXvVy3KwIxjV4JKDJmP9LpOdyRZnVRTERjj65QVcCueB?=
 =?us-ascii?Q?WT1g7a/nV6kGLEc4eQxuRY4IfmXi/4ir9E+1bMdUqxX6erMcAZvx8oIHW0Ns?=
 =?us-ascii?Q?gxUWT2gm/uOYhG8Qiw6r8/XtuTWMAGHIviRZx5KAYruavPnClxRsFJHKm9Ou?=
 =?us-ascii?Q?QFGnWZ0SraxZN4rTQzcVKr4d8vVEm1WSx3jMaCS6TSrJcrXUOZQFagPf4Iog?=
 =?us-ascii?Q?xT18ie1EO4F9zUQY4m6NgfgM4JsYIX8qEuqbyBbliXq6p3DMGilRZQ+pifo3?=
 =?us-ascii?Q?jJWw9v1KakMxz6BfuJRzr9eppUSYZiUUGCes6UrGGztihQ5evxN1EbrKugpQ?=
 =?us-ascii?Q?Ln+ngU7thw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95335396-593e-43ce-7ce9-08de9b5bdcef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:59:58.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFXQiXLGrBt1yxrgM7WY/AtkW4sFyH4lTK9qyXmPzfQ1soO1Iqe/wEWf1yic0GWSAmFiNebnMkcIa6popkk24Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10700

> On Mon, Apr 13, 2026 at 02:30:49PM +0900, Zhipeng Wang wrote:
> > Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate to
> > allow building as loadable modules.
> >
> > Add prompt strings to make these options visible and configurable in
> > menuconfig, keeping them enabled by default on appropriate platforms.
> >
> > Also remove the IMX_GPCV2_PM_DOMAINS dependency from
> IMX9_BLK_CTRL.
> > This dependency was incorrect from the beginning - i.MX93 uses a
>=20
> s/-/because
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>=20

Hi Frank,

Thank you! v3 sent.

BRs,
Zhipeng
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
