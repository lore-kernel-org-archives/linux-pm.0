Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953054;
	b=s1E6n4tXVbV2ES3eHaqrmz816HwCJtYSJkCsGCuoQzKqlSFEcS1cKB1Ul/7uPcxADbgL
	 cb8A1pDF7KmLdVtSctIDYPFYb4t/ZdoC2RGWeucAAJKGKSLfxOmQ1dR9tUVfgLcAnciUG
	 uQO/dP+j2EHPbp7/uTyqXROTGmHiaVnS+0scO6aWFx5OXh9Z9C4ybxot017FmoLGV6bL9
	 EulVXalt4P0TQUPmIrDyfxJ/mdbSHA+JHeJvOL35UOQ+Hn6zyOjG82WdtEb+GTYmpV1tz
	 tKrqaxpNrHqsVpAQNNHQqC03CA2425JyQiMCi3NI9vzQ04RGoQz0zID1ZQykM2S+YzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953054;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5D8blpd1HRUTeNUkrcvTLG1Mz/LrfbXsp2AqJr+Clp8=;
	b=N4tAGmUxXRxadCWipCtlHtWVIQZGt8FSZ0crOoa+wi0m9TYOoNQIpdO+y7oUY6xgMgsZ
	 /aPDRjYITrtVmDOf7kEjiWkoMEt1mAdMjg1WguShQnwnY3/DIraioGid4j9tPwChRGfI+
	 QfxAIwqYR4neubDjaUE87YJskRTxgwp4XzI9QrHP0ZZpQsTFHbJys1q7pH4wdabkWNXyv
	 KbycLQ62O+tv3hoA2mTnb4afgetoS2+jzz2GJOmMgkgkSlgAs8+lcHns0jrLPa+CeIs7G
	 OWUBmqHLoxa0LiqpcQwJ/mxgWYootQs6xLMUGClM4ZvTYCTKjPfzZv717d+gflOBUgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=h1z9YxMa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.26
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011026.outbound.protection.outlook.com [52.101.125.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C43606A32C;
	Fri,  6 Nov 2026 08:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C43606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=h1z9YxMa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OB+SSv6q2hahMWHNkAqTUadq/Yvwx8jLU+D9GftMFiJyQuE4yqN085dsUKmCf46QIIM9IgK40Nc9Mft/e7xERxiBlo4rQ3xtJSEopQeHAufaWLCHSSEpw8C3lVS38VI9aXkJ16EPe8ZEvOSnTxfgftPRbRNoCRjx5UWQ+vw69USCbDvzjISKsYPHw/YW36c0XjfSzixbp26OeTY4ywEDfMEfjVj573WrWXS6o8Vlvo0G8jw20jsiR5XmIIDWblE/CUG+5KoZW+Ns29g/fW1sfQ9pzldj88jSJs6glKMKoOawNM/m8Et4gu5bVbaHXSYx008IjMdTJtUqm2eEmLNfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D8blpd1HRUTeNUkrcvTLG1Mz/LrfbXsp2AqJr+Clp8=;
 b=zR5heVCVoEJcSgeJWrg7bhn8CprD8htjPT1c91+djSJCwz9/KyIRlDvnJPtIwKfcz0+p9jOqkoOAlvf9U7CMDwXiKMSGjqhsvcNfvEU+1oSoqv+mHVGkFHwbvkN4qsW3XwjGZyJ8uPrguXqRUjjd7LrMW01qtGnI+sgC/LcAlqQmDzr3PWbkmXSgXu0E1cNY+hmExxAR8pEhnkN/Tq2SgZMTOUGrTbQ2ZFB9VrJKuX2RmJzkYSPOAfUpWXucgGwBG+VzCLOhLJaXBbsHMkfamhnzbQUKBLarVg8SJf6xuVpsXwLUOck/+o65RS12GGCn25CvBJIvHw9pnKToKP1Z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D8blpd1HRUTeNUkrcvTLG1Mz/LrfbXsp2AqJr+Clp8=;
 b=h1z9YxMaBivPd1vQJpvNtrMGN5WIubONChpkl1LM7dfTfstiy/nY42Iw5Ja5tpHdlPW9i4A9lUDwU0raVATzz/Ypa7VvI9A6tyjond+Fiu43piRU7R+h4M10JuKLZit5k689ff0sukPzoejghF41ajcE8yhypOxK64iqVrQ4plE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB9529.jpnprd01.prod.outlook.com (2603:1096:604:1ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:17:30 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 08:17:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, "biju.das.au" <biju.das.au@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
	<bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf
 Hansson <ulfh@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH 3/9] can: rcar_canfd: Make clkp local
Thread-Topic: [PATCH 3/9] can: rcar_canfd: Make clkp local
Thread-Index: AQHdZ6ey9BsKmfUrHkS11C+eIKXt7rcgvtnw
Date: Fri, 6 Nov 2026 08:17:30 +0000
Message-ID:
 <TY3PR01MB113465CCAA88F962CA6BA2E7186762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1793278754.git.geert+renesas@glider.be>
 <415c8b26718e2e5d53f74e65daedf9986c76dcfe.1793278754.git.geert+renesas@glider.be>
In-Reply-To:
 <415c8b26718e2e5d53f74e65daedf9986c76dcfe.1793278754.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB9529:EE_
x-ms-office365-filtering-correlation-id: 804c14ee-e02a-4353-3564-08df3bde6702
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|38070700021|921020|11063799006|4143699003|56012099006|261102123227099003|261021121427099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 EOCX2jop6Ecis3gWl/BfxmMsPNTK50We3gOiE97UGdqkjZi767ILNWvjVkp+r+QBSaq2+ZihK+LOR8mSBj/EqERvK2SqEGq8zgTo9tkPvLtEoO1x0chlnZ4Hf3lwwSjy7+D+ftQQm4xhUsNAFYLXtfN9F7Q/gYhQTnDqdjp9n+ujM2KuAUk3GJkzd4ivyhDbv1vfQtH0rNxgiMR2sh6lmyYJS4vAFLsss+L3/tzumH/aKRL/epOmzrbwoohXoIWWAnT3tQWZs7dlKJ7F9AUeNqXStBz3E6fM+Ko1Ic+p/KZ9OMb2XRFa9WOKYiQyCUIBynHrOgQvSaqqROLvsu0a01ToOToHLgI3vGczdEQwxnEAibmlKLs16kNNuPnRkKf4V4UBxpA9/YU9hxggdl+iOVzcODp72Yvcs3wNdgEmMtTdUWnqHrN8TVtywu6uoxg3PCaDgWeitWdo2hzRhKtuMb0fF0YncQPWyn9PVag6waQej2uXOw1Z7u67j3HCYXmKvvor3lmLK4RZOsBeNjH6zibMiYnsaaureIqyetdf7iEI5hFCYo7Ot31eEJ08rtCQ6NHaDiSNWQPB3vcJBR84Vwf7IhPQ9ay5YWVLWqBvDLSUM9Uf68p5NYT30T/voHInpZ+bPD8sPRXBjf85ur20F2+v91Xc37Zl8KW77pOQ+Yeg4Eq/l6BTGOrIXKMmjdwFGtIUBCXou9e4k2nfpZwLajlL+PMg7fSRCUYISHJjSGRaDanwkUO02LEYk/c07DdS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(921020)(11063799006)(4143699003)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GTykzw9Y6EG5X4/a54rJbhdlKejesYTofAg2kysz9vECDZw0BIfY3D23vBCA?=
 =?us-ascii?Q?G8mz5BCRvTQtxMN6Sbl238PenpkAtDesVNB1oQsldfwT4OdjLWn2OLdgaSPE?=
 =?us-ascii?Q?9Zjzf6JpM9RGD5aJlt+S/OgFrDuqQIVdhv3HKKvjy9Lo7Un++IBQCFjyZU78?=
 =?us-ascii?Q?WC9h7o19Yq0sZ2oRVT0q0/tFlTngShN9qonUWhxOUJyfDfXqhLhHLVa3Inkh?=
 =?us-ascii?Q?YN+KqCa98fLekULHwqkbzAA57OXaEmWexC9IujvW0goDV0ISenkG7XFJI4YI?=
 =?us-ascii?Q?pk8QhDkVu6fbhKk582lyF8/I4eNtE9pSe3kCkRazv7+w9KIfNk263baUzTdf?=
 =?us-ascii?Q?BfPhzesj7UC7bbjD3Jo10J19PgWam7HSKeeiAa43dN+GDYpsULr5Q3p1y3Lc?=
 =?us-ascii?Q?SRSjkMYnXTsJC+HN3WH9Lywx3bt5yAmD11WVR4Ado/gNIecBqu8VJ0LJvWma?=
 =?us-ascii?Q?iEbcA9k36Dna6m6Nl6OAtd9QuQCipDZTTr60vZvCZl/wjvgye0PCUfUWIY3m?=
 =?us-ascii?Q?kXoLkhHTJuXVIr7I2kYT8SU++CY+TV5CADBu9Mu9WgTvwd1QTMu6TIPLja9I?=
 =?us-ascii?Q?uSCjpuH2OSn4NLInk1qaSxJC3M0FNVXAg8Q34QYNe1QQjkwgJMcSLhV1XWQv?=
 =?us-ascii?Q?PeUvvKI1Cy1hk/XhM+YnIvoa5kLeJjBJ4X9UZ7dtuIwfeOOKYCtmwkfPQ3wF?=
 =?us-ascii?Q?Rsbb9Kzhu4yg28eODZdk9qRH6ERNRPxdJHe69r6SWKwEJyqKwayyifY4p4hY?=
 =?us-ascii?Q?GwXZ9oq3xEKbpdftW+Q2AY5RyOSe9gYY3CuFY5XFEJDECABq95oGKM7LD6Fe?=
 =?us-ascii?Q?enCZlfRRFJmYQVBkoXAaZCNMatvm2TVaVgCcDvPHTOmSi9P4SD4mUSzOQ7rO?=
 =?us-ascii?Q?oLmXFxldjHEBU4o4cZR5j1D21YN9X5Cgi+qOka0sa0lpuMIk3HTD2ZUjDK1K?=
 =?us-ascii?Q?bIq5gkYCXSsE7b0RpPN061ZG50LCfEMjzgdZ1jehrgoiQlN861z1+5LSUohC?=
 =?us-ascii?Q?kwu7+8fiNwXahbd37hDDHaGjWIlwXq6xu2KJlBZlbHV3qaSY5MhJbTYjW788?=
 =?us-ascii?Q?ztCbfPzJGoSV+50J4EnOG4feSR2yNAVcOvzLMZt/zTV726XJ6Ce9st4pK3bJ?=
 =?us-ascii?Q?0bFp0I6+rYr5gyo+OWCvk3wDuV9BIz08hqwAF1kreXZUT/HyNYEp6VZguDn8?=
 =?us-ascii?Q?NomywusxOguVzVYmJMim/p3yLgIIUEZXI6xUbnhz1YaEr4qwStbjQb/hse32?=
 =?us-ascii?Q?uKv7OWCqeWtqLs6+RIR5lX8jtolnFNZd0wZoMFd+vBkZXfKtXaFG3bBVjty3?=
 =?us-ascii?Q?tELeBZ4f1IJalZGvhB44b0ci1+HAdxNfLq12VqO6f4RpviKoPWp7yFHD2bEU?=
 =?us-ascii?Q?g+jqgWKq2eOIh9EaZntzxsTPkkMJW7CsTaENuQo9fPKV9EwOxJ3dnear04dS?=
 =?us-ascii?Q?G8J5doJn6er1U6k5RQDRCQNH52tCbVj0lYrIFYcTv2EQur41v4bJkSXTr4xk?=
 =?us-ascii?Q?7lFpL2iB/uJ85xMoNejN7le4+znhRV7gAMR5OSuQpShtZpCC/DPYQ3uxv66r?=
 =?us-ascii?Q?PAF0Px0bsu+vhvWPe+PObFfEOpuSPzac63x4DOYjpoWNJsw4JUitC19CvcbN?=
 =?us-ascii?Q?1N6Wlt/DyMvFAiXx1pVHMUH97q9XwXElFRhjVCeHiPr6p3Cg+JYwRkiXkotZ?=
 =?us-ascii?Q?wH/UhswDbhYVrypJIXeZEQIHSOzkHIK8dk4YXdr0WiTl7Rtz7R6232GWG46X?=
 =?us-ascii?Q?1w6sUWLG/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804c14ee-e02a-4353-3564-08df3bde6702
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 08:17:30.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8p1SOoNPLk8eOA0Pi7Jj6rQXtAl1coJTScqyUT3FBTrB/+r5AMuCXTz/4Tq5zpz2c2SR1NqhKFamPnvZdoMqoPWplCAbuEr6SgmqSc7QcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9529

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 29 October 2026 13:11
> Subject: [PATCH 3/9] can: rcar_canfd: Make clkp local
>=20
> The peripheral clock is only used in rcar_canfd_probe(), so convert clkp =
to a local variable.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 74d9ffd2790587b9..9dbe44710dcced80 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -467,7 +467,6 @@ struct rcar_canfd_global {
>  	void __iomem *base;		/* Register base address */
>  	struct rcar_canfd_f_c __iomem *fcbase;
>  	struct platform_device *pdev;	/* Respective platform device */
> -	struct clk *clkp;		/* Peripheral clock */

Unless I am missing something, I get build error

drivers/net/can/rcar/rcar_canfd.c: In function 'rcar_canfd_probe':
drivers/net/can/rcar/rcar_canfd.c:2250:55: error: 'struct rcar_canfd_global=
' has no member named 'clkp'
 2250 |                         fcan_freq =3D clk_get_rate(gpriv->clkp);

Cheers,
Biju
