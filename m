Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010008.outbound.protection.outlook.com [52.101.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ADD1FBC8E;
	Mon, 21 Sep 2026 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789966209; cv=fail; b=mSyDA+Doik/lylpBWAAB+dc6Xvmv4QMHQ35bEI9OfwnCA3N0uZa3IctDTLMAImNOsZKh5so2jdweBDtnIGqBdzhMTpB69lHF717aSppAat8xbHTNl1eTgp91hpwhakazMHwKpR0kl4787etMLbmEH8HnhaG9mrDUQ3OYNJY+yuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789966209; c=relaxed/simple;
	bh=6Rt9UqJmJo0Db2kP+T2GIrMWgg2OaEb7lcDUoxf+bLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MVAiYk0rJD/tkPH/mgDyVJK+OXPpT5tCdz5JHtfWN22arQ4rpQKv5shnG4+d4sFFtGdXt+wApV19JjoA9HroYPaeXnO+TWiTrLwi6oCpU5GjbVsHM4KYlY314cDZLx/iIbJqD34rlOkWeZPpRr/zWNBsA16Y5aQRfb0LFzMIAVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Kf4QoMAL; arc=fail smtp.client-ip=52.101.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Kf4QoMAL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXp7du7Y/rxdmVFbFiw3YsK/ap88Tklduqr4zKIh5qZ42zP66amIXyAAliEp+Gt5+HnTwUZfEvv4VrwE2FFPIJ64TsmSc9IBAatl8ccUUYUT5HFgsnsbzny42pnpT5kaCQ/9vSW1AF6tKtDQV484gXY5XzPDn+ihKTNKmwKUuvxKI0y0WsC4MLVjBglvQrZy6yMEIWnBpJWZFGQ+UnITL6d64Dyrv+WEo5KLtmiYcEVNrVovMT9+8i5RJcBDQvb16xqUiziUeXcZZyTU4ljUvIKay2qKbNZdfytgTY4zG9iJJK+vjb6PLtI53tQQEnIJDJalGMZSXGcJ3EYnFf+Pyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6IL4UI6E+ubEySRa8lAA+jSbaGy6I1cldx/DQuihhI=;
 b=voMBAhHA3egrnucjRaeV51dyX3G1DH2oqnNMO4Nr/Yl0CsoyXdWImKaEZTIbJhYzKEyil6h2HkD+sCuaTMENQPLOFN/coBqH1+KDLFsBVuT+n9bOWtxN5pFFlSNDxQLBs8mEzG6PkbZWz6ckrb44slPi0Sx9Y9V8Q/uEfgZQb3ZHhD2F5yabFVibHlAp336OHuciLuVQsEIsP3Pumboyw+bFPwJG+yrgqMQ9HBt78dScW1wH1Ze+jDSw1pLtQUISJlhEy2bCbduJL44pwHg5NBSHsSey+Kl6QUtdYUS9dGGBA0h6oB2Trr/K2pPdVoY60JNNv8jgbOy68/Icxkxeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6IL4UI6E+ubEySRa8lAA+jSbaGy6I1cldx/DQuihhI=;
 b=Kf4QoMALNhnRuJgwtXRmgNnYPTI6z9Cdm7zX6M8syzWAFGBdvmlay935XdlaC6UYG5sigiegN02qFhV7juOWsYarfqfQ4jlyE2EY/VPWu7qqEi0Qw9MDGVME+9keFuqYIaoD7bBvORbYAO2r7HqUOTaUa4FG7RZ7n6TuGckzSIQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7457.jpnprd01.prod.outlook.com (2603:1096:400:f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 04:50:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 04:50:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, David
 Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3L ADC for TSU
Thread-Topic: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc:
 Document RZ/G3L ADC for TSU
Thread-Index: AQHdR3+mk+uISRMiQkaZ58GDWCu11bbXvvYAgACHuFCAAB08gIAAE0yg
Date: Mon, 21 Sep 2026 04:50:05 +0000
Message-ID:
 <TY3PR01MB11346730CAAC35AFB483EF3F986842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
	<20260918150730.122056-7-biju.das.jz@bp.renesas.com>
	<178992596604.706584.10451227613547984363.b4-review@b4>
	<TY3PR01MB113466E3B9C0DDFC619C2549186842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260921042936.548630f3@jic23-hlaptop>
In-Reply-To: <20260921042936.548630f3@jic23-hlaptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7457:EE_
x-ms-office365-filtering-correlation-id: b9c4e40e-6a4e-4f54-9b02-08df179bce28
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|38070700021|3023799007|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 icpcIBtEYaC0IMhDqv5E3Pu76JWxc5Ir0OURWQQmrh6NG0ZxaH1TyA6PToR2qxBx78bnyyi8Wnw+Yea9bu1NPZ7dzu/U0mjLDJJSXCI5BN2nza7Q3SgBhXgz70vB3MpSQ7C2Uzx2GcEAVE+R0hS95yx17TErbYixJFVCPcIb3yXnP+IrW/CvAYxLAMzvGqqbSSA6AqmxVc2cHV9cJO8MfAAfKKzry8NqMxbtYJJD4WPbeLW4HrpAAbgndVY0zhYiQjozhGjavrkYWVkNLauYt4Ohni3Ck39eKqqJgD0Sd6TXlCNpcDYI2uAxg8Z9EDobeASdU6k9EbHpovurQ2TTMXk4YsYsysj2plbD5+7ctRSZ/cYcJfc49DU146W8lzQMvI+v7VZ28ovUfIhQs4dX7/x5Su5YsIWv8/B8Icxp5aweWamsvHTbrPAPS9cmRwY24Hr/mAKefgrjxXexrfGA5Gf+ERs0IJWHXr0eNehbSNAPNLmgZfQBSz42fxHiMV9Ob8CkDNGWOiIDMstjqgXraxyVvGkatw4BnZZ7aQJTKyl8i4ObS+KnjRmU+5azn8NjgebisTWU7xH442FmTriWYkurogtF0YNtyh4EGloKiVpx3Df0+gwwAnGkRtImCGBauJiuF8+0hRXRkS2QOSYjohU9ZQV8Gu6M5XwYR5tgsGSQf82KwRlTBIVd8/U5CpeJf9TqhHe331cNMxN9VVl8vG4EGM26IJmgjoPPehmvnDs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0CbaaOsBwgewe29YvcriYeL9ydo6ZJkLX7AaB2iaRSYf98Gxi295QQtPKW?=
 =?iso-8859-1?Q?VRLjv5OY+hstCYeRN4jIKbPfe7IopL+6UJLIEp1hNJxUtY+zM7XBmAlSbm?=
 =?iso-8859-1?Q?52Qs7jFw6FXu5v3w+ki+a7XX2Rxh8w9AwTYe9UBczPAUwmiZOrjvK4VS52?=
 =?iso-8859-1?Q?Um5D4opA2hGMCKabzWmTjqhvqCfFHkLr4MW9vy06O2bxaU72WLpe1pf6vD?=
 =?iso-8859-1?Q?KNryUxcOXyYuWdFoxFx/UvqHXGxRLAqOaWqGo65uUzo/URV+baFU/nfzp2?=
 =?iso-8859-1?Q?+tr6X/6oclqKxh57USX4Z3M/tsqXmv+WCkygO1t8cQPnW1bwZcfxuTf6gt?=
 =?iso-8859-1?Q?oo7fQzvrKeAt5a4OgYkrqlQCrfzySHOEkfYFcu4LSogV9SSaF7A1BU061o?=
 =?iso-8859-1?Q?noaKvUGn1SaBg+oDqyhhnem0uW7rkxSzcwQNItyYG4Ho+0MIyHxi93X7xV?=
 =?iso-8859-1?Q?nuCXH3rRmsn/x3jt4zw3XIIqpiMFSm+uSPNSxOP8h5i07EgRTF1burg+8o?=
 =?iso-8859-1?Q?hKNAzgO37SoMlBjc5+cozRXKKXQY+tpDhi/OvClCUr3SfGka3YaWDaNwHw?=
 =?iso-8859-1?Q?42CJ9llDEiV4FGRw9GXPSL8Wej6G0/4ajUtr6sxEvzUG7lqnDCc1xBr09b?=
 =?iso-8859-1?Q?8l6oAls3GD4LGggfRgChxxExD/pfs90FjP4+8g4I4TVTjDuVmWZo2gNyEN?=
 =?iso-8859-1?Q?BWNcK/rN37EDNzFuBn7tk81BLM7wnG4Ey9JVbbwp7tQnPH/S984spqqESj?=
 =?iso-8859-1?Q?2Iy+ibmeDb2QbfCzBG7oUsZ9kHhh65hngDLrVaM4nA0oXZNMlTeENsoE23?=
 =?iso-8859-1?Q?0cRXUZqbc/CnFvLDQFR/6OUKNpxK0zE/h07v1CMIAAMZWY7Cjg7eSZnq4b?=
 =?iso-8859-1?Q?JDvf+dYEAREAE1FG3t3DccDZCfqOPaWxyp6uC6MtCqBkehPKbHLmWrgFnc?=
 =?iso-8859-1?Q?xeUd+8duRMgObifBS7a0YyY4komb+tdvFoGL6p+IZfG1PBpQznOTZKXrC5?=
 =?iso-8859-1?Q?4OfpLld1LiB9zQyba6q1WItc4ItuG8EN77Du2VqaJmAdDY3btXA0p8N3km?=
 =?iso-8859-1?Q?6ruSzVR0aZXGKm7+A+Ye9ndvnrJaUm8KnW5ia3VUHzNGLpjT4YjtB8tBUH?=
 =?iso-8859-1?Q?oTtSyTxgf+VsvqVd0snEBRuVzNjkro0DfMC7ixYfURkzJEg65tOgdXsChA?=
 =?iso-8859-1?Q?eej3cun48n+QlExCf4+218UE+vTuOIGV5lzEEdGbAAx9HaKPnqIfZhymHA?=
 =?iso-8859-1?Q?bDpgUAQSekiNBYSt9eVAnxP7Bo3epDo08HJpT07lN5Uf8SPF/MDq6/cYZ0?=
 =?iso-8859-1?Q?dC2IU+E0gnWw2DQXNGV/3vgx3oGNXolLcZtMDtTz0y9UolMSPp8phU9WTf?=
 =?iso-8859-1?Q?PXaSZrLAnPFkikJTfyQg3YIiB/4ew1JP/pTCFbllzWe/J6qs8uEdf7nMU+?=
 =?iso-8859-1?Q?lSWnbggXadRGuGlV8W4RkGBGz030/wkruqlxWFc98hSs9H6M4nFzaReBtj?=
 =?iso-8859-1?Q?vL5umABufRmpKMsthtAlqCQXC5XWO8Vug5CiA3CRNYJpKJSvND1iHO0QxV?=
 =?iso-8859-1?Q?Grv4aHrNkLSZ6vomQwGQR/5M6Xxt8sd4tn1L+tOk2vPTrQvEi6iZm8KxiK?=
 =?iso-8859-1?Q?rsbt+mytBSeAJTnf1MQU+c8Q+TM4C3BArAG5Gr7ipJDaTyCT0H4sHD6xbv?=
 =?iso-8859-1?Q?RLdc2xmv846dA9Qu/sSEMGmRfRZUcu/SI+GIS3BOoqq6+ecl8ZNFV5MMqo?=
 =?iso-8859-1?Q?kImV7Z2bpbgX/pftT1QU0m+2a2iW7ys+CpQ7Lz2xHpgMLeBnlUi+89YsOF?=
 =?iso-8859-1?Q?18mO7QgpMg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c4e40e-6a4e-4f54-9b02-08df179bce28
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 04:50:05.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKoAy0G7ExhGU6s8yq9h5bV7vr/uJObgpkCoHol1Ytp+B8KylZiecMA2XPLnGb0AHL+AHYh/+imXNwxyo5bnZZq8+TThIXYB0rYSVZusQvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7457

Hi Jonathan Cameron,

Thanks for the feedback.

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 21 September 2026 04:30
> Subject: Re: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Doc=
ument RZ/G3L ADC for TSU
>=20
> On Mon, 21 Sep 2026 02:03:18 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Hi Jonathan,
> >
> > Thanks for the feedback.
> >
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: 20 September 2026 18:39
> > > Subject: Re: [PATCH v2 6/8] dt-bindings: iio: adc:
> > > renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
> > >
> > > > Add renesas,r9a08g046-adc1 compatible string and its hardware
> > > > parameters for the ADC1 IP on RZ/G3L, which is dedicated to the
> > > > on-chip TSU (thermal sensor unit).
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > > diff --git a/drivers/iio/adc/rzg2l_adc.c
> > > > b/drivers/iio/adc/rzg2l_adc.c index 408fbf8c29cc..35eaebfbdd77
> > > > 100644
> > > > --- a/drivers/iio/adc/rzg2l_adc.c
> > > > +++ b/drivers/iio/adc/rzg2l_adc.c
> > > > @@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_=
hw_params =3D {
> > > >  	.adint_inten_mask =3D GENMASK(11, 0),  };
> > > >
> > > > +static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params =3D {
> > > > +	.num_channels =3D 9,
> > >
> > > This maybe needs a comment that only channel 8 actually goes anywhere=
.
> >
> > Yes, it deserves a comment as it has only 1 channel and its channel num=
ber is 8.
> > Or
> > change the variable name from num_channels to max_channels to make it
> > Clear. Shall I change the variable name? or still you prefer adding com=
ment.
> > Please let me know.
>=20
> That makes sense.  So yes, please rename.

OK.

>=20
> >
> > RZ/G3S ADC has 9 channels{ADC0..ADC8) and ADC8 is connected to thermal =
sensor unit.
> > RZ/G3L ADC1 IP has 1 channel ADC8 and ADC8 is connected to thermal sens=
or unit.
> > RZ/G3L ADC0 IP has 8 channels (ADC0..ADC7).
> >
> > Note:
> > Looks like copy paste mistake. You commented on binding patches for
> > Driver changes.
> >
> > https://lore.kernel.org/all/20260918150730.122056-8-biju.das.jz@bp.ren
> > esas.com/
>=20
> Don't think so. That was about the binding.  I was asking why io-channels=
 is required which is all about
> what channels exist and how useful a subset is.

OK. I will drop the required property 'io-channels' from RZ/G3L binding as =
well.

Cheers,
Biju


