Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437376;
	b=nOs+ydwv183lxs5a+cUnqlDQekzc3t69lvbSSMqMl4xKYpFuYnx3ZjqocThpFqTx+txt
	 8ljY4/+8ysrLH4GbBUh4NdkaxC8kD6B3t6yhIhIoGM16N1rOt/e8MR1Vy2u2CjGQdg4M1
	 KkQOxFOrN5jusmrV9CEWp8Omiq49v9fuaO7gtDK2voQYeKneRSBiZf8MqwdDqJZwDb234
	 PlA4lKKtA55SJHJNTpnB5SThCqu+xuoWpfpzZ9Qs14WfiJh9nNJ+CJitMbv8IE7AkcHTn
	 y0aiNUkQYL9U3y2ETvksz/3EYVJ9oM/ByUUHrNPM6yQmMZWsNrLLA/4/l1r7ZkwwKuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437376;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	bh=9xWC0KoHAcSDP8ELe2/LleHhHQQQUDZ/sCf1BRHH/ow=;
	b=xYx80CIDBX98lS5gp2rGYGJSUgrIISKOXSHb32W413jN26oNsq4hAinWC8oiKXhmUOmR
	 jJ67ccUhlci3D+isFIsjKeY+cghTXf4nE1GUBhA4AE4jl592jkagaXP9uRXw8IStXOBH5
	 Wj6OhxM9Boh6Prx32E2LONjIC1WCdyx1jnX6KLnjtuV4zAMlC2nho+QpEL4DyVzpddxgg
	 8i3jnDqQplUZ1F/wVIjQ3POvUdY4W3ODE/LDy5Qeo3LhN9lZZ/l+D5qdZ0ViTY6nm1gOX
	 6uFOXaBRDcV7EZHaXBFVJNYgd+DEuXiRGaUmwN2fyHN+2Rn9CjYO07nZYKDtrHhlXqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JaiEhzAI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.16
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9C606A336;
	Mon, 23 Nov 2026 12:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C9C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JaiEhzAI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6bhZVfVSP91/sSE+A5+NPTvY9rfA7dbuzdPJqspSo71tAMhezG4xCdFSVZjwZaGmvbYh20utKg6hE7XA8VnNsmlkxJDyghEtlC3Lyg3F5UWsWaKaVMfukqPceyFXQPwP9DY9eOOuLmQRsVETb27ZYfjHgLxIBGZ5kcsJOImuw79/JU45iFz/AaxQVWsOWewnJhoR2hENtYFVlOAmf4NovluMiU+PAJCHhU0ZSgdMc5VCYEDIhtDEH+qn91iF//XEJu2z15j6IIqVzgjmKEOr5wt6yqYq8H0Js105THt5hNXY66RtQACLJbLMkr5Ggw2gOGw2XmMtqwaun8evCTjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xWC0KoHAcSDP8ELe2/LleHhHQQQUDZ/sCf1BRHH/ow=;
 b=lkz1s/t4iCHxCPgH33n0ICKaufrlUxFMW/XwjMk1lAOAQvHVHjJMdn/K356JO5BPWYk7tptlLwUKxi5Og+ZsniDr5HbS/oe7Uqb6ixJ4WDPt1E38LavLtD+sl1ipLEXe90jkbFyvuWI67uWYRzncRVUwi97bWBK3AB44ixArhNGiW3znCEAf/wYQexXcTi7yOUs5v2ejfd+qDUxpFf0iEAHtwNQHMJrMfRtVFtn7eoEfYjCJMXj+A0AhCxpeomm7+asapt5HPdNR07V7KelPfWWvp68T36Ps29Za+J4BQI3dH64cfAbWOs7qOBMNQuJc+rKE2Ct0TQycPNuOYH2WkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xWC0KoHAcSDP8ELe2/LleHhHQQQUDZ/sCf1BRHH/ow=;
 b=JaiEhzAIvSRzENwYGBHtDV5BeGOL+S/xpg3S29h/7QEOuP5nmTmOMiC+etet3k6wDFPEyjmn+L9bIgg7AW/37zlAWAbVGHHQegLNbkW7HqflWU6hC4ZVUZBC1P7y9k/OU+BPr/6qsK1p8Xa93i1m5Rwd6Ud/GafT+8Ta8n9h7ec=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYCPR01MB6560.jpnprd01.prod.outlook.com (2603:1096:400:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 12:36:12 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 12:36:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
Thread-Topic: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
Thread-Index: AQHdez8n11tqWYAHqUqCrqPpCgEtFLc7lviQ
Date: Mon, 23 Nov 2026 12:36:12 +0000
Message-ID:
 <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261123113755.3033436-1-wenst@chromium.org>
 <20261123113755.3033436-2-wenst@chromium.org>
In-Reply-To: <20261123113755.3033436-2-wenst@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYCPR01MB6560:EE_
x-ms-office365-filtering-correlation-id: e37f1eac-abfa-4a69-bb46-08df495e5bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|261021121427099003|261026140227099003|261009223027099003|261022105027099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 3YNXq2qJsKDD5NdJxumZyWjm7bgloNflpWLPTjOOBkziueRNqCiRxj9JhtzskT+Gb9qiTuMk0xieuXVOrXM9xkhlFK0g/3PnZewoJ/rrFi7Y8bgRvkUGPF8e2tvvyolV5BPBDaxohimCAbBphqesubD54o2sceZ6LgIYEzodNsH39GT/Y+UB+onjKrc5XPbdeDY5+USaVJIrk/AfxOOpq3F9VIMsrE14vgHz4ENFoBN7Xzv31xItMzdYD0dJoy3ppfp1xL82RbWpoP7qrOEuNiCCyjAZ+EIYrFmd43/tzqIi1hOYpRVloUYOBj7ZZmvuDfDZT1PH/eXKmWp1PlaSiTizzUYCzi/txPszWuh0w4av5lA+Iaof25FE1P/GwIy7PaKnpb76QUABhoPBaNvFgdUeUuI7gO+kiUW9AXgF4J2K7gDpGb53bGC+sOAFUECkOgCrpeqzRqUzCwDnMrootO29jo48SpgGT7zaMPieCu53YlaG4inm8X01SCg3Wk87XuYdYIFE03XKzq/7sqqPRAXOg0On/hfKx/EodZW6AIwevloW5WJ3sYu2LKS8TA/Cd/Ks8wU0giDgX//IBP1JyHcGN0y3fct5utiHAcVyzxuCG7qYicO60+J+2YlCLqN2TdjT1EzlagUxIslGst+8BnF7GdJMjoiDs2TkrPWv16MsQzLfiLJJm81gCzIdyfgiUJkpDM/HOfYQLQ84NVN/41HIo1zQR2l75r2IkwhDa8I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003)(261022105027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VStvmCEO9U6cZqJWkkIn5QhIU1aPM+s3vnB7baBR0u321YPrsiQLHlr35m?=
 =?iso-8859-1?Q?ZZsQzDW7gxZ5nZuJWCohVBbzB3IvR6chAsYlgt5m6rgPTI9gznC7R9Ur1W?=
 =?iso-8859-1?Q?2aTuLARXE3AAof04MzcYMizC4qJIHz13Qvr6TxIfi8kH4A6vcUtJwM3rrW?=
 =?iso-8859-1?Q?y5q7f2Pjc0Z9YVnCRCGuOeWDy2ewC/fxWdBkfKRKVVfF04opfOP6TJNIdg?=
 =?iso-8859-1?Q?6zCLQJmg4ZVanuDaS9xlVuz0KYBpqQXUM1bXqEDEpjxJqc+t4hYclbKhLo?=
 =?iso-8859-1?Q?BFd6ZRdTI1bnORRkqE2wD21M0nFrkRiUzfkRrEyvMCesPgmHamdwUmjiYd?=
 =?iso-8859-1?Q?xchaGvj9mUQG8A6m05umeVNQfwhRSONqifbF9Ex2UveLP8ihwYkWaf4Eux?=
 =?iso-8859-1?Q?2P2MYSVcSPEgdX6lBvFJA5QZGPo9ABUG9mJTJN4h5mfuVagYhMdMk+pN97?=
 =?iso-8859-1?Q?ywreQVhqCZ5bX+N03JluxjuaB/ij5k8Zap45+dQ1vc3co+POxQlBkP4Ug7?=
 =?iso-8859-1?Q?UzDtihb1MG2Z61IVnJpldTMyPC9rKv9zEkrZFU90MfZ4Wqte+6Si0qnUZi?=
 =?iso-8859-1?Q?YiS7R1apzLhXb4l76qrsLE2iYjj6+YqVCRaLDmy7lIxrs1EhM+5vONJfWd?=
 =?iso-8859-1?Q?pGkpluCb31/8rixGjz/3UxxR38enilP1nkkXXyt8+tX8S1edCXBuJNqbuD?=
 =?iso-8859-1?Q?xrj8qcLot6KOH4OenQ8rXcpqsLUwKIVazpF0nVlNRa0zavdVIF9EJwi+6F?=
 =?iso-8859-1?Q?2dInaJoRKaSK946EiGAY+0cKImcAt61UbJe2zgc3YYbnutoL1P+O1fEXWR?=
 =?iso-8859-1?Q?XOhJFKiUvzof6RzGUHC1HxdSNOCgO4lfeVzHI7hM/DW86PWZUCi7CihvGo?=
 =?iso-8859-1?Q?/e9ImwLGGHXHvR0FTQWyshw02cGBDr7uIxgDBAcFQj3ghJuvV0QV70u156?=
 =?iso-8859-1?Q?ByDrl9RQFD2fFJNlAoBczpf9g2T9TY8HKqLHvtgGhCw+s7lwliV9B4CKs3?=
 =?iso-8859-1?Q?70T1iGzEpcIrHFUccNva0huYUbu5GDgDV31ZAAHskBBdUG6zZep7cj3iK6?=
 =?iso-8859-1?Q?F4svG73Siw21ro5ZwDDYvX0A2foTXxmLsm5iM5PpyvSNKk3W0MB3a+YzwQ?=
 =?iso-8859-1?Q?Jfyo2oaQNMgH4oQRwrOfMnOaxuF+WTH7135g87PsBj5E/8NeXglrkZGnQb?=
 =?iso-8859-1?Q?8UptnqNr+mvpF9Jd/Q0xrrs44CGOlHLCU6P1uTJEmlk7EdLHvYQio7rkLk?=
 =?iso-8859-1?Q?HfRLcj2ilP46VKVCCVUrViY8IWm/z2DLfKd8JFlc0G57il9D0wx7F1R5Uk?=
 =?iso-8859-1?Q?TDf3t3LBwfazYjzsjo8ckwQ1x4qpV7cwW8AP1CdXvlBf7fX0hHUGTr4DsV?=
 =?iso-8859-1?Q?UHkQEU9BRlV8tDemAvYHBS5CROfUh6B2ijuOTQ9OWVrJC3PHsY6FbN6/P0?=
 =?iso-8859-1?Q?DAI0uraIo93gga7q6hJiR5S9UyqZ23+297t75LLmuLI2lR2LvyCyq2X7LJ?=
 =?iso-8859-1?Q?Z10VspmCBOaIVrsFkWjyZ5bKg0FEeiFMyThZhoMvXsgty/qf+2hLUecZUO?=
 =?iso-8859-1?Q?dShQdkW/Dxmd0a4+UPyxQwiEPqpms9UpVlUTK00tj9BvcrRifsaMyyoQje?=
 =?iso-8859-1?Q?dFjCKvqERhnbib3jrdCYBqCzVjiA0TCnnnODrhovdNL/ZvomE+lwsCIxqh?=
 =?iso-8859-1?Q?K8EbMEAqP4vnXMDZCeCTdi7oYIEfZQiOHysTGpe3DeND1K6n67uhUzx1Rf?=
 =?iso-8859-1?Q?QQ39Z97FYMfYyD08abfvAePscR8UwwNv5e2h7zNY2gXFjDet51gyHZQ3nj?=
 =?iso-8859-1?Q?d0wfALMtCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37f1eac-abfa-4a69-bb46-08df495e5bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 12:36:12.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/p7WrnoDNQKw+BfxksXTpZy9Z3ckfflz22yIwuKwRuboL+3rlU4GygnpJ9sHc6L34Aual1teZWCtH3RhpM+F4ROKxm5RW7t8y9U+MxrARk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6560

Hi Chen-Yu Tsai,

> -----Original Message-----
> From: Chen-Yu Tsai <wenst@chromium.org>
> Sent: 23 November 2026 11:38
> Subject: [PATCH 1/2] power: sequencing: Allow desc=3DNULL in enable/disab=
le stub functions
>=20
> The non-stub versions of pwrseq_{enable,disable}() are no-ops when the de=
scriptor is NULL; however the
> stub versions always return -ENOSYS.
>=20
> This would require more code to deal with on the consumer side if the pow=
er sequencer is only needed
> for a subset of the supported devices.
> One such example is the rzt2h_adc driver. Only one of its two supported h=
ardware blocks requires a
> power sequencer. The driver could be built without power sequencing suppo=
rt and the other supported
> hardware block would still work (provided the Kconfig dependencies are ch=
anged).
>=20
> Align the pwrseq_{enable,disable}() stub functions so that they also retu=
rn success on NULL
> descriptors, acting as no-ops like their non-stub counterparts.

Could this make debugging harder? If someone disables the pwrseq Kconfig op=
tion,=20
the stub returns success, so the power sequence is silently skipped.=20
The resulting failure (e.g. card not detected) would then look like a probl=
em elsewhere.
 Should the stub return an error such as -ENOSYS instead?

Cheers,
Biju

>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  include/linux/pwrseq/consumer.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consu=
mer.h index
> d24b5af3e49b..5b3c61e963eb 100644
> --- a/include/linux/pwrseq/consumer.h
> +++ b/include/linux/pwrseq/consumer.h
> @@ -54,11 +54,15 @@ devm_pwrseq_get(struct device *dev, const char *targe=
t)
>=20
>  static inline int pwrseq_enable(struct pwrseq_desc *desc)  {
> +	if (!desc)
> +		return 0;
>  	return -ENOSYS;
>  }
>=20
>  static inline int pwrseq_disable(struct pwrseq_desc *desc)  {
> +	if (!desc)
> +		return 0;
>  	return -ENOSYS;
>  }
>=20
> --
> 2.56.1.831.g720f3f5937-goog
>=20

