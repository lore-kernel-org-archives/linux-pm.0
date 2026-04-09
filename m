Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CF364952
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700005; cv=fail; b=KHBk79UeNBAOzpyRjU4ku/JFYOX3cw5/5xtrJgdeJkrl4VeACP7S7rOI+LRBHpTE5y1JyEsMjPBavRV0SMYetFigFZRzaaVc5EY9AbuFTZXtTETSHNwSRqdCtjECFrqda/S2r+iRVGTGZlBIbzsHhAjuoteT2Ms/LyglMhhCawQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700005; c=relaxed/simple;
	bh=Z25JyrfLG3qVKI301n0UK4wHEjU92XecGJncVBTWoLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R/XIhMvO/Gn/BoQbY3NoyLoeinfllJwlSKxtwZPwjzxucFKnZu/0FXWrQ4A5/5+G+l2SxXQcDl8lvFmycLgvuumJWdh5W8CS2wh1bPkqO1SHGu62zWbOLobT7+6KLLjlnvyv3TszDmkmcgh1lZGLqhrXfT1xUGuXG+YwD/T+I2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N9G+SfJs; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N9G+SfJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbWDd9DeGTqzm7e6mzzZbp3ebrmUr0Hry2qU7hCKVPsnUS+o6uQZPIXsXMS0R2IfZ7CFdyHU313zzmSRy1PGKT9JZKK08t9uye6KukdLfJW3RioMkGrJ/x1Z5kgJ9RjfPipO8yakp36+8/PuUpt0r4J1ZryofjeJYgFvND27bqYGq8iqAWPH0LWqTq117vzGzhMR7uig9cxF3IFotLIMnMx4rr+0e807h4xM7cv5VjReio59aae4LZ5CBzkSGxdVqt6cJ5peLOWwa4SwqXor5eWxI165/ThQLn1qtLSIE0UuuVvEV0uGmc52PDQBAL0fZbGWYm7zTH1YSJEd64taOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z25JyrfLG3qVKI301n0UK4wHEjU92XecGJncVBTWoLk=;
 b=FBROrvADgafFeDMG7+lZcpNEgH/5u3bpTrd/QPNEoXrTXXOMgmwsfpaiqXFlb9prH8vuepkjy/daj/eo3SWY1JXjm8JkstiWFHYdQjRbe0QvDoUS1dgfMy7zFOzxL80dopbWpOMt4YRvO5sppUNAIxirNL2+MDaOLCRVlQEDUvrhkz6lcU5T8+oO3HnPbkWbBrJUb0usljMWk4LMlJ0wxTT0nO+zyV8Km9fIntoEpiXNeaWvW0yq+uMm+aREYaRXzBZGbyYEsYjdimLwB259bRZbb6ngz5DHnW671flzNpNh7pAX86yFlJjpTaTwsPL6iY0ESVsOnfR8j0GFvHRfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z25JyrfLG3qVKI301n0UK4wHEjU92XecGJncVBTWoLk=;
 b=N9G+SfJsgR6xAkh9FMqI3tNqj0pVdU4M2WAIFo8GOKTXuFoBpihx2Oa3pPUTlKzVSOfEI+74fNQgBIBYUUu7zTxcCgWK6VqQETrFJFAZ9CLF0i0+QrVKh91Zc/T629Os5m5EbuGvmmaG3uTnlvC/GZl2jgsViajwo8GtQVDQvHLbk+fxNM8HezXC/me7A2qz4ZO4Rt+GECr61nKVJXCPUlg75n/TGcaCOjzk2DxMNTI1LAMl5LUyqzHa1ebo705Ue9+lVKQhTvMGXd0n4Gi3HQ1hKF83SYTEfQqLIj6j1SEsc4qW5eF2JNGsuReN+izGehSnAmvj91iKKk0l0zH3FA==
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by DB9PR04MB9580.eurprd04.prod.outlook.com (2603:10a6:10:307::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 01:59:57 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 01:59:56 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>, Alice Guo <alice.guo@nxp.com>, Frank Li
	<frank.li@nxp.com>
CC: Fabio Estevam <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
Subject: RE: Status of thermal support for i.MX93
Thread-Topic: Status of thermal support for i.MX93
Thread-Index: AQHcx2xk8+xl4qIVtEW7s8atZixwF7XV+Onw
Date: Thu, 9 Apr 2026 01:59:56 +0000
Message-ID:
 <VE1PR04MB7213F2EFD584BF30B1FA2B7F87582@VE1PR04MB7213.eurprd04.prod.outlook.com>
References: <1ad05dc4-9eaa-4fc2-a665-e17521fd333c@gmx.net>
In-Reply-To: <1ad05dc4-9eaa-4fc2-a665-e17521fd333c@gmx.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR04MB7213:EE_|DB9PR04MB9580:EE_
x-ms-office365-filtering-correlation-id: 4722b84f-faab-42ce-7e4c-08de95dbb2c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 OmbNsT6TQsuchk7NYTy4pUThwKWGHNRIMpeI0hiT2jjGkI2B1dsxbrYGwAd69EEt+p0lR8oI/bO1+85epRQO6W9tustaoE6keh4/VlgZusD9c1nIDXj6YtofVxmGGjwXRGzjRixG1CkvgTlYhe970mTFqe/o5VmjC2nccuiM/93CSssBZ3qk6AOnh76t3GPYhHUvPLGKjlJRvLebYaykEBcJzWaklt+sYu31u7L+0tnqTEtrf32qdlqPtoQ/qnD8jNEzjIQ3mhHXx4fIPT1q/7REqspR4/HvqFM6PdGkTiSQqxW59cTgFeZglfBw6ntxK6xBg4yaKsNtXBptUFj5R/6TZmLRFUhL4k+P2AFHvKHthDcnaX3NfdCIPYejVB8oZtiXhU6PZ5KSkbbuIblsBX5NzmM7+h+4YqRxL6ID/ut8obTiBpQN8ubBpF2PDd2B64X+GjgAI07s1bPd3Dox9RqT4LzaGRoaVzr4uxKWM2MEcLsgTlOleip+iGHyV7QR908ByLdgA1V2+yC6jjl2rzv69EhyuymxVnbfonaj/P/Wt38cdLjPWran22tpGqFq2MT6S6dt1RARVeIcIPUPPGUX7kUw1O7ACgzwPCcNXyCuLyHfF27L/z+xPjjp675PvlXBypcomnL7N8kzbKwR3cjVcJXYSe+E9VqraGBcpEYG9CeYWA66muOEqzjddjQBHBeFqRn4vuuV6ozNMDzoc7DLKYgaz85ayFf4Mzg4pjGwZD+YwiV02lAaU3ia1VyxWGDdtGX/x7ITM4/14IZosQX2aG2sBluhomT2NI2Iboo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?htPRhcBqxTsBbkjn0Z1EPX0iCghVidnVj1R8qpCfliM9qZwzbwbi3aH+p4so?=
 =?us-ascii?Q?5F8UOt47KWm8RDspZdfYlpO9M4dLf90RMIT1mhbYaPQRs9T4wXtRO0jfQXcp?=
 =?us-ascii?Q?dTVPa4oJjTJ8q816stC3G8lJ7N+nI5xZ0xL66owWIrWkr7cRzcPk6fz2y3hJ?=
 =?us-ascii?Q?ncnlP13dUwKMjzg+QhZlFchocSSD78Ecu9yyDjVl6ZKgGnJhXpC2cOWvadex?=
 =?us-ascii?Q?SUymk/EeRMhfCpPsHJQZ7sEkM4kOCERLbRNfuuIyDaA8/gS242i+S59Vry8r?=
 =?us-ascii?Q?EhjmMdIPmOKLG4unKsUC/Xdn2XSdif3PVYzZXb1DG1I1eeTg2k27MUb0XfRO?=
 =?us-ascii?Q?0K/CFegYhGKHrxo0ZWFUYcGgfKes5JEHbR1DCk7Qysx00GFTF6Btg8MoYFv8?=
 =?us-ascii?Q?Wv3/i1lThaegslZ25vt/FJGbPoADEb3GxOqD8aL4mCQne9zOnzJoOQF2QhAH?=
 =?us-ascii?Q?tEnAq8Xs+eiSGT2+wQLI3eNIoDgHqAQcueq1C9lP4wmtTWbP5lCXS6wJ4gty?=
 =?us-ascii?Q?kn5gvIYlKXA9UzUCMvbELkub37/IgB88GedVxfKTOAJZuBFZK/O3Hw3dcMUp?=
 =?us-ascii?Q?lm6bfXLq+nlOGUBgPpKx8YdAzUJHe2s7cp+G01ObP4thrhYS9mt30QE3hGl1?=
 =?us-ascii?Q?koINPjBCKacZWbRjHE7GF3ZrYDoxb5iBADCOlcsbqlweoG29pHe5EMpuasZC?=
 =?us-ascii?Q?ZjLjaGg38Yz+KYI8UvP4Tzhmtsl/zAQ5vaSmOOAnLqzg2eDdMCliJ4d+UQo+?=
 =?us-ascii?Q?HMS+nGs7yWYXUTOtCYoe2//H1Vzob02+AhT2ylLRcivkoVhtcBfeaD9wpjvO?=
 =?us-ascii?Q?BDSPa5ClPY02kT8E/35RLKOmE6QWSpGOefRueYO28k5o2AuL90Ip/y2rneW+?=
 =?us-ascii?Q?boe9Bw7wfSHgUJiojkduo4ZfsAhUgj27GSJiRek9f2PMC6O8rDI/C33YLXUH?=
 =?us-ascii?Q?yQQG92YrNtNoNFiNwIrstu+OKiHvv4p6ctytX2OwChVwDzfOTdLfqpqzBKim?=
 =?us-ascii?Q?1WsOuCmFZ+iCnz9eMzFmc/RmOxsDgvnRnIrHIUlLYlLgRwMaTWhWiMiURYQs?=
 =?us-ascii?Q?YHpBjtVXFYEsA7X2eOTiZg57YfIS+wKhe0IZeLGNebhsIdgjFI00dJCSq8k2?=
 =?us-ascii?Q?mksqGZCs0X/cU36JfbOy0qHQ9ogHEHfNBzeu9uAsyk3zawuGQiA2LTMjqQBn?=
 =?us-ascii?Q?6547406XDOwnqy76iLLnOf7PqDzM34JpjafFna8iK7nmSPUgfKHgyWzDjbWo?=
 =?us-ascii?Q?H8u9jOF9mfWRnFwJFilBBeotMXNWlIkPB0r0tch1VIuEjdjVRI7rgTAq6AnR?=
 =?us-ascii?Q?fyu+r4pwrPKxEgrLrsitxKPjDUn2NLIMBoYn6POR3alTnkwLwpdkeqTnVtKk?=
 =?us-ascii?Q?ghhCgwGQFRILkqq1ff6zPSa7l4KwYZ2b113VuvsRYN5FfoZBjP40Mf2YghcX?=
 =?us-ascii?Q?cXePuls0YVOxBbx3jQd27VRvD4Py3cjFym0nJK1I0dnuw7lpACXsC96zidUM?=
 =?us-ascii?Q?X5l0+x1/+mULEpjb6jpqclrwYMpZuRVXGpoc9Af5DIwrAZy/am00uuCtGGIe?=
 =?us-ascii?Q?xCys/ObFnR3t5XTQEtygU9yagpXz6koKbjvlmzvTjvCR7slhIfr5+ra4s8Rt?=
 =?us-ascii?Q?do/HAklZEzQTzfkodbCFCGLx6nHikGfX4itu1qUXCK+GmuNB9UvOnNhaIQCm?=
 =?us-ascii?Q?TcUdPEzFCS1W20li7jsm+6QIoBXYLOJkvcksq0CzjqBUyeQQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4722b84f-faab-42ce-7e4c-08de95dbb2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 01:59:56.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFL32eihYw6pjJn0x6n74K56TxNbrsNXyKnJjzAI457Ezq+7epJp12LaHEpFAjRrRae0yTcweBAOFaaCfIg0cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9580

Hi Stefan,

> Subject: Status of thermal support for i.MX93
>=20
> Hi,
>=20
> AFAIK the thermal support for i.MX93 hasn't been mainlined yet. The last
> version I can find is here [1].
>=20
> Are there any plans to finish this work?
>=20

I thought Frank answered the comments and no further action to do from my s=
ide, So it slipped
From my memory.

I just rechecked the comments history, it seems still have some comments ne=
ed to be resolved.
I will handle them and send out a new version.

Thx for point this out.

BR
> Thanks
>=20
