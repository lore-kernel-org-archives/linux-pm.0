Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793957540;
	b=sDyxEN6ZfWnNfnrAQ4//2ySuUjiveRwZc0nQbbCaGZZVh3nT0bet3pCmzE8RLJ0KqcZo
	 0WUm/ip1N40LJwudKc07EwFzF5n32TGP2GO3T21qaM3yR9mcE5VUqwyLaHeN/ZuyF9Bpt
	 6SUlgdKdXYkWMmiJwQ307Gdx0a6levj8l4FoYO2SuK0y2KHkPvoodJZknfDSyb97bXEH9
	 ebtk9preqbGDVC5a+427Q9xbGzrn+cy/svTek5UhoJQJOEiRoY5GLndGuYQQ2YQFiEKCG
	 z9mRLmhz4wDrHn305rcczgNd87yxSeGkbdryh/lysxAM3iI9lk9Y7zadT5lK4Xnc7Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957540;
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
	bh=ASPlIG1CwQzrAUwwfTETz17PmLu9/+1u1KvOUg+yRy4=;
	b=x9VIG6dskAWULdfJLWeAEX7b8SiCwAMnJPdyH/BXtda7ZMvgFduuDCASw5Batx44diAR
	 tuOIHMO6i+tfo7rkjt7C2Xw2VWwBnK+bp+/QeLi/NIxrP7BF1dF8AUafEZxZeW2pb+MNe
	 56SygZK9b5gWkU+HCmI4/HChEgwQE8UheuoqkK9dt86toMtvV6dclmGzvAxlEzUuX2WWf
	 xNqNcVzAaCToWGBH/mJWfipdGMYGV8CndHO9oYx68x7z+0/bJB+fkgUaYpwfCJ9AZmg93
	 MaojNOel1jlbU2uXdR608OKT52AGQRmJEfGyIbFcNO/7hzyHfN/Pc8rm9lrA6GiLhhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=VNkTy2yc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.4
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010004.outbound.protection.outlook.com [52.101.228.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137626083626;
	Fri,  6 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137626083626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=VNkTy2yc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0zT/i7X3J4dfrCzTrZyTGYuzMfdqLAzQ9xGCB5zObTTE8Nz8xgKhSJFwvgnxun9Z4VU6h+YnRr6bDxZDUE/PHJOmL1mpyvvOWo5xpw9wGrSNA0h88hrotPY/Ek0hu12D90BPzzAkjsd4qYbr04i68sEmQud6ZfpdVlRl35TP3YfVoTmrAQUMP+4TEYGWQSwWs8+EwbJh2+VpgdiioAOH5iyUso3+Oq4Tu4SlfTgSv9bpZVvuBaZj7MB+UCK58/inWQXIn/lLZAqnskyMiSy+dN/tN6WvvPzULuAPuA5XbgfS44BflmOh9ttj6Qh/KRVv1qiFblvcubWObSF2Q3V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASPlIG1CwQzrAUwwfTETz17PmLu9/+1u1KvOUg+yRy4=;
 b=KrNUWhTrFWadJhP0vWfd6QJ83MEzOsX0sOpSq2vX2nat/JTkesAxB2yCRfnWaLDuoWwOLjrTeUPM4khYYr1MTKnUnWwHdBqPuYv+Nd4C6h3EJrjp6GnehZ+rd2h0m6I/9Zl1OAoVDNceRzw+/J6/u5fA4XHTYY3gFd/vjApm0m3EcmcNQl07UzfRWiwVL9yJteXcffgIhsj88TvKrSp4rNUXMGCPW3LwbLS9stzsHjKSeoNr511pnUHOefGNWRyo5aXyLaAku/7pbH22yLOf4yuzUj475U481wr6ChGplW8SEBOVLhVQa0fp6UADG1luDViyRAsA63AVBMZvqqg4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASPlIG1CwQzrAUwwfTETz17PmLu9/+1u1KvOUg+yRy4=;
 b=VNkTy2ycDZF0JwfXGp+pCTO+KBScQHBYgUikDWxKUsbwCnCFxGwgdYmSzG3b90n5FYVawGOSRA5YP7/ikdRl4l/edBU8azCy6pusXDY2FVuXuZ14Ve/m2tkOqiKxriCw3RsjDvW4RqCQm2gK9V6gLUghxb6GLqSVtMKd+HQhQN8=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OS9PR01MB17954.jpnprd01.prod.outlook.com (2603:1096:604:46a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 09:32:16 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:32:13 +0000
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
Thread-Index: AQHdZ6ey9BsKmfUrHkS11C+eIKXt7rcg09OA
Date: Fri, 6 Nov 2026 09:32:13 +0000
Message-ID:
 <TYCPR01MB11332290214A3035A5EC80D8486762@TYCPR01MB11332.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OS9PR01MB17954:EE_
x-ms-office365-filtering-correlation-id: 5346d15d-b74d-4e82-039e-08df3be8d6d0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|22082099003|18002099003|10067099003|921020|38070700021|4143699003|11063799006|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|56012099006|261009223027099003|261102123227099003;
x-microsoft-antispam-message-info:
 39AVCAlYbuYvBiubEe8IHWpO+OcsP9qHuI5d58jK0q9WGcfGKsNH558TaFD2HUC92AmypgZgO5jdnfI2vGjuaLZ0YuU6XgDGi8diZrREBDGg6vEI3AvsQaBaVtNMz8SE0wempPEcHLY4IT0WCPcCaX4KR8JazDJe4PIhA1rULpEbc3JVtzd+CRN+pOcpOaZFWOymwDgzyRVNhsz6Ml9TO6to6ZvP8S0JzMpVqW/JtyeZFcynY7WU1YxEKI6BOzuB13mK8O7RgbJHjHTbyppPcCHa82JYKh7XOlX2PRrhGdhmpz57Kp7H+akoNsAtaPLGSxsurjYmLmpriqgzCC/U9NiyIqcUEGfwrKahSskPF0cy+R0e3WxN7+D1zMJYm7seYKrmeKpRUtg/88kzINCC8O+kyELzGgBFiIaysgJUn3uv1+YtCQtIegxInYJ111lsmSA/SiDTG4x4oTjSNyaV0tdO2UlLE1wxAqdwecJE41js77dEvbfX64mEfb8w1tY5Hkhq+KjVe352fkYibeTtyw8EBOnqEs7Q4NgMjEoBhd4KBt9lU6lTohgpaQXcKd5/2Dl430HWEvxXute/kSibLal1N/bJuvpZoLnUvNqYE5BT5DmOc5PgLJSaQsrBUCdmQ0QlthCDHePiFugDPTWxLIsoRahDodanGRTLlZvi3krsa6+U+/TvUWkAwJ0/mghfAFGMrjZONWHzY8Y/ZmzqIIphx15rKZWcYzbF1vdG3GUMgdjr/KJ3Ntt0xaxFfJxw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(11063799006)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(56012099006)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BxI0JvlHYuZNQby5o6f72kdlyD7MSNytpZCqEmpLwoI4OcVS6rR7/q9sjrjb?=
 =?us-ascii?Q?00uzefk0QX3mkSisVaby1ZC4TqE0hWqJ2UgwZXt9PuAu2fALIrVYJM5NsMii?=
 =?us-ascii?Q?FSn4ppKqSuekmLHzNTD984C6myd75p7MzL0MRbb9BcIJ8JXGpa+4PSb+VolQ?=
 =?us-ascii?Q?WfpB7ZTR2cqySGy4fUrBX/h1IoPJb9D7mLCr1QoVGjR7jGQYP5CwiiScbH9T?=
 =?us-ascii?Q?44sQBV1ai5z7uvY33SI4eWpZL2TRgllfJUFJsTKwXtAYP8SDEPiBmVG4P9+H?=
 =?us-ascii?Q?OvurOxdpE0UKJ/G1pE56XGSGaBxDMMxtvKhYW4atx6mfR8amE9IRvNXS+J6d?=
 =?us-ascii?Q?FtEw8u6RyKhCw0LkFuwtpaI1rARcb4qzH8u7p/FZLj58/IH8UjeifKLFOG+A?=
 =?us-ascii?Q?v/FtmzW2XXOIWVgt7ytYGcCL+VrjEwiMTbxGn6f2DmCFMoFoxFXY7bTLAd/M?=
 =?us-ascii?Q?IzECcsuuAgisIrb5qDuJeBU5WzKSAGV/v0EId/KwN3fdG5E7eXtvq97FRFq3?=
 =?us-ascii?Q?nY2E9N1aaD8lwpSGu5mnOS/nrPsHAouacE9asoermUZkH87HhD09QfJQhejO?=
 =?us-ascii?Q?DQS3jzLGtIIMP1SSZwvzVPM896E9rwlWR+FVFQO9qZAXY50Z79D6vfI1LNnP?=
 =?us-ascii?Q?WmEjP8EFCKh98GgpRirQp/iMH2zhinHDEIr548+oLX8gYpwbkv6VkzYR2ZyE?=
 =?us-ascii?Q?kPpTqBBW3ROVuruIaZOK9PqHqIN1lrYb4oWOXBzRjH8/5BhZjmfVlr7ZcUBT?=
 =?us-ascii?Q?o+HWPcxE8kYhVJfpwbspNw4O/h65Y+CsVleW0Bj0r+AsCoPFruHHlIGmwH+F?=
 =?us-ascii?Q?UV+xO44V1dqywMlukIsedXibOOOkE8ogZZeFX+waBDMehRGCuUKSlD67CvQX?=
 =?us-ascii?Q?6pkrHbKcQtVtPxN4SoSSVKwEJoP/b2Yr5OfxH01flh2PMf3IliNBFQkujd3i?=
 =?us-ascii?Q?m2sUIz8o4pIIkXtI1ZEbhRXyccrF5yirKvvuiAo9Jbbc+V9KF0gwxxdi5xP6?=
 =?us-ascii?Q?OfJTzPEBpq4UMLvZEpOcRntP8XeqBuaTXrMORDfrzIzAkMPSZS3ZKBHQWbst?=
 =?us-ascii?Q?AQLrto/+xW+iZ4aFG5/vyVwR2rqNrxL+DW/isULyWyQy30NRA7Uc00VAg4v9?=
 =?us-ascii?Q?0aGpO13heN+ZSjmn2nY1f2jGXlk4j8aEgmnkqVwjxrjzPdOGMo7eiq/lBtqz?=
 =?us-ascii?Q?3iqeJg8SnDmD1mIAn6OaacfI/Tgf1GtRTeJlQVnkIhsNQTIWHsjZpU7JirJa?=
 =?us-ascii?Q?hqWt7GILqf+izsNOcQYZCGywYItkWDv/Nj/eS2c/TZcj+9qV+4/3aCxJtBRm?=
 =?us-ascii?Q?aFjrZI0/+wXhA3JbrogbfwTVoRF+gddtvm7UZJVw1RFB+QwXFT+EIIrcTc1N?=
 =?us-ascii?Q?kTQCfqtri8lV1fMvzyfEy4/R0hvyv6Ny1um9aN3L6IfECbMQbwpVSNhqWosh?=
 =?us-ascii?Q?DEA7mQH17SYgkCVyRqxyR5rc8qGA+zAZLVzWKjXh3GIj47XvPDQsA1inRLRm?=
 =?us-ascii?Q?jmLSjzVaWu8XLQo4DhnW2BO8gljiAEUncRGV0EsKCpqM8SoZ4LSBREVRjs1v?=
 =?us-ascii?Q?eyUBMdUbvEmj/+BAqvIHWeFz5t8Dpib6V/3uO4uAoS568MOFbko/cAIx3rrX?=
 =?us-ascii?Q?eDZZjKZfO4sihk90Lp619uIFuZee2pxPM5ceCT1Llp/ghzvXXoy4RuLMUyDs?=
 =?us-ascii?Q?gP5s8H9gnBkahsedpDZf/QUmySmkGiBjcW0XBOmbIAJC5gKlDh+WjGMy5wtw?=
 =?us-ascii?Q?rzrGJlIF6w=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5346d15d-b74d-4e82-039e-08df3be8d6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 09:32:13.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pt+c0LrjnWzBF7xTLVjI08kQYszRvOTHrXUSyQzRibstPBG68sRcJKXzHUB2HoupPkKhV6ZRsTpdj02rqSgPbs0HVT8QuKdXHFX0rFSYULM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17954

Hi Geert,

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 29 October 2026 13:11
> Subject: [PATCH 3/9] can: rcar_canfd: Make clkp local
>=20
> The peripheral clock is only used in rcar_canfd_probe(), so convert clkp =
to a local variable.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju
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
>  	struct clk *can_clk;		/* fCAN clock */
>  	struct clk *clk_ram;		/* Clock RAM */
>  	unsigned long channels_mask;	/* Enabled channels mask */
> @@ -2111,6 +2110,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
>  	bool fdmode =3D true;			/* CAN FD only mode - default */
>  	char name[9] =3D "channelX";
>  	u32 ch, fcan_freq;
> +	struct clk *clkp;
>  	int i;
>=20
>  	info =3D of_device_get_match_data(dev);
> @@ -2181,9 +2181,9 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
>  				     "failed to get rstc_n\n");
>=20
>  	/* Peripheral clock */
> -	gpriv->clkp =3D devm_clk_get(dev, "fck");
> -	if (IS_ERR(gpriv->clkp))
> -		return dev_err_probe(dev, PTR_ERR(gpriv->clkp),
> +	clkp =3D devm_clk_get(dev, "fck");
> +	if (IS_ERR(clkp))
> +		return dev_err_probe(dev, PTR_ERR(clkp),
>  				     "cannot get peripheral clock\n");
>=20
>  	/* fCAN clock: Pick External clock. If not available fallback to
> --
> 2.43.0
>=20

