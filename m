Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010028.outbound.protection.outlook.com [52.101.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C73A1B5;
	Fri, 25 Sep 2026 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790308525; cv=fail; b=bjB+Tryzs3H6B0gzFTZVfiX37hFZkgMIo13/cE68stazZMDG6myqIciBOFm8BdjviPwfusqol6Zbb5EOOdW6dCtOi1JPRvL9IbAvTVj6Xd8UHoaShwENsJPJ7z4qxGlGLiPlLhf93dy1rVekEyr4C1tDtArh3Pmrz4BBQpOBmhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790308525; c=relaxed/simple;
	bh=8AGjWqDBtJ/NKbV2L/1WfVJQpDKYStbdTwB2lCtIp3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pIHvmwaohPj+rF6Z0kZY79ewdcmFr5SZgQT2zrZiyd0RwPC0t6MfJM2yIeqxmz+9yHgHuJfzd+DE0rtmAcys6y3cuEli8SqFLooJCvfWymeeECmqjztvDxIyiKrvWJXVnG5sGroHOdQMXkrxZlh7lB4ye/7NvyrHPmXQ/sxrCaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=L5mE/pXs; arc=fail smtp.client-ip=52.101.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="L5mE/pXs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMlJmiYyobHkqfIpkQ0X3YGKXp3gVWA1O/qAJLHvHccWc790pbgeY/77ZpzFsOfHuDLo1t5he7IZAkgD0gWK8BI8WRPiUvk1x2Aw1FDN+ytSYX5K2G1191WQbArxrjyk8YcPmbHoDrxKnXwGg/UeXePepLB19V/xTGRXuHpC97ZtjUffuFDDDkw+275hDkqnAvvnZjY+zzteA8rjQvIdHZ1d71NtdjHDZCMzq3hxf2JwGRRYj6PGJLxvt/SaQXFDul6q+yvxTIEPLEajg01p0hxvitdUAJLMXNEThmVxnz9lRwpoLQO2/Wom3hChldCQbPYXa4SUQkyBpnZZtcyffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfoKQ6PQjZGToAO6agXYXdxtL6HkEQNbKPb742Zx2b0=;
 b=jTngiP7IitCQ5bQ/GYcHTc2lhW4KCrggjDrgiYMdODt5S+gmPX47a+aVnHaJmthc+i3eEAVwzPjNEQ1656+jQ7GFSsj8zD1Nt2za9r2PokYBdg0vY9EQdZeUiS7rm7Hqch2McdbkpvIVzA2j2nKYWTbJdLuB4lOnuI3xUo1R8AXMd9hV6ILafaTGOqbjnEYJaAmCUnNcjDqMbGaeKEIoyi2UD5DJ8yXRETeDIZQAL6WVgi01Lui+5W7taZdRb2L/z7RUYG5wkW3jSBV1OGkBk/QPQIaBtuZ0cKFI4ikApRSHp2O/7iYusw87Ct8I0OZdNE2pd5eUAVZFhA8BfKWdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfoKQ6PQjZGToAO6agXYXdxtL6HkEQNbKPb742Zx2b0=;
 b=L5mE/pXs7XH/8ncqbv+3GEToxSv6QSNu+WCpLKwi+Ipz0m+x9XqQLo6TtuSdAVcC/hyxtTqNkBPmUsaCzonPb0lLLU1HyvQC93hnbtlJqzLiFLpRmOc3bPeLuJSiLo3rGi+yk+4c2VpGOrl6+0Ey7QOU+13Hc3APw/m/7tR5kxA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB12503.jpnprd01.prod.outlook.com (2603:1096:604:324::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 03:55:20 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 03:55:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: geert <geert@linux-m68k.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to
 max_channels
Thread-Topic: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to
 max_channels
Thread-Index: AQHdSkrL3beyFjHg4EWFvzMYrSXvXbbaqjCAgAEpnqCAAso5AIAAD1Ng
Date: Fri, 25 Sep 2026 03:55:19 +0000
Message-ID:
 <TY3PR01MB113463E1457DFE9AF62C7FE3886802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
	<20260922042707.116378-7-biju.das.jz@bp.renesas.com>
	<CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
	<TY3PR01MB113468E77437603F4D230FD8386822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260925035522.08ab45c7@jic23-hlaptop>
In-Reply-To: <20260925035522.08ab45c7@jic23-hlaptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB12503:EE_
x-ms-office365-filtering-correlation-id: 0daa0c0e-6e00-45b3-21e2-08df1ab8d16f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 afF2+gHNkYxXZ2+qpXgnZFC3VfO1//+5ZLChWEmtKIOWMtUGdRX9XDq9DUq6SH6ofDj+Pth16mw2hWjOuYbFqE5q+3QU5FVZY4fAU2tOrUSEGt+KSf/cRnAi65eI6+kkaeHDt8vMxLnzYnnANxsLfJ81KmMklBsdmO3xvPNBJOYsOzdQXJ8AB6ED3Hp1T2rPf1Ky5keZOZBb3im4INrHMMAcITwj4lzkSn/La18PeVxktiYKmswBNvXQ6Why6pf9dgqjnrqA8G0qaK7jMP6bHzUBcrRxRAW69pEOpLuNKiFfK0un7KgfKoW1aGV6tGYS4j3FzNfA8dwhvjJBrRWQWR0xEQaNmbGO+imgtl0fH9zcXq4Fl9APUPt2V94efQvJ2AuNDPraGkAjTn4+8NjyF248PF7Utl2rczn9EILcGMzXEARrAy9kXnKNk1UQykVRms/ce4btAwdOh65r9wQ38HLUlCj9aQjJRIlUrjk/uyfsVmqIUkB+hc0/zV5sLDNk67HOulb/WB8PLVYre8JeCUjMlC5VjAURNs9t7f6Ed0mS0txlG2+A3lG79i/krCHIMkW8xqdaFwzmXByBSMIPyxZsFAm/qJmYcI6ph78opSFg/w6DOIvbCK78glZqtWdPBbH6YMwl1OUTuy8x4TV8shmM00++9PRbmIQRGBpnMeVDI5uyOjBhSBSVwn80hcL2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hS07aS28eMmK+hG8VnKxeiqHQryhgwS5iFqYwhtkZOEopGDZQvzcHjxKW2?=
 =?iso-8859-1?Q?yzNVrcoNPRnqWuUOKVJNgdRFqHfGOEiQg8q5cDs52m3C2omwpteYf31fJq?=
 =?iso-8859-1?Q?C914ddN98KoRldoiKY9licsyuVzJwV2atEv9XH8MavPV5+zKHqeV6jw0mh?=
 =?iso-8859-1?Q?AC2ssp5r4CMsdos0b5tUiPivCUpLT70v8LNtAtcMwRJhf9PsZPQE2HnShk?=
 =?iso-8859-1?Q?5tetjIVHv+ux2x/fcnXniu9ekCu1qJYkWEpUJdMNicQythNOlzyiQ6ZpbU?=
 =?iso-8859-1?Q?/14xQ2sWYH+x9Jn+JA3CsHPm5VGAcNM2SAKqM0YqdPGqhkCVW7dZGNQm0J?=
 =?iso-8859-1?Q?pF7sYNsE8ED3JoSHEQ4QyqU98ULugduMxpahLiSeDTtOLEG2BsShpjNbUW?=
 =?iso-8859-1?Q?UzhleJiMslYW4SyQzBgRmzQ8/ohDGWGqerv9IHjvhJp7+Ro4TzT3377i5f?=
 =?iso-8859-1?Q?RTll534pE4JfAwB7fC4ES1AHj9MHWDQ4QvguA/G8rUUIU5Vgv5XrGP5nkO?=
 =?iso-8859-1?Q?wm9I02mgxJCWHjtVu4jCif5yNtLcfg6Gm3vh7OkqnwUiDTz7In2270TSF0?=
 =?iso-8859-1?Q?49frynjnA8LVg2ok398Q/JC20QQcT6ZeJQsi+6s1RAgIhAVSlAxOK3f/Yj?=
 =?iso-8859-1?Q?3gx4ejyLWETWHcZIYZz2plHt6VRuZ0aVoXPv0tQd5weQxybiEKekY0N+p8?=
 =?iso-8859-1?Q?KThYOkQiUtRb5vDiD1jORgGKK/bIN/dTAvf2uTkts6BSDJAn2jNCXWodgN?=
 =?iso-8859-1?Q?d8oj8kMsHUQCSjZ/7DfCP9egQPeX+9mnX2GCoJ5wL/hdXfYwd8jFlC+qak?=
 =?iso-8859-1?Q?mxzW9RbwqEbbgj3dlTC+lnnHo72PjopdVLNNjER4PgZ3X/YWxUQksV52/B?=
 =?iso-8859-1?Q?pSPkkbxZ/W6Oo/BpVd/HihrH1Wjdl3fRvFxVZilsnsj2ChLcCAUX0Y9+3R?=
 =?iso-8859-1?Q?ia5CkdP4oaRZecUfF3RSv1L97pOQPbRRbV/o11cVWhnMdJZA6q6QaeGaqe?=
 =?iso-8859-1?Q?N3YdnPzs7bad9RYZ3JGN4WOai6VgOwyUV2r4WAPWRga+sZKeJZHSZjq4qT?=
 =?iso-8859-1?Q?tGFxZPvfCjsuPI+TJtuqxCvrMnk8lFn+XkuH2UQSsFO7hsnz+WH1LSrHB4?=
 =?iso-8859-1?Q?KvGwDucMtXjga+BJK3oO6ld6ZfZShStax+hj4y2/b2eLm3uUMxlWNCimJl?=
 =?iso-8859-1?Q?PznUmMEIsSx9hDNTKsk2jjjXzba7BrQrk9EjOCfcphCq30gRww9v7I+4Hn?=
 =?iso-8859-1?Q?JhmN50lg33A3WSVsWd0eGrA/VpPqMeGjNxrDjE+FXac4Uc+ENUafo31CHq?=
 =?iso-8859-1?Q?6zIjGvAnjnykoaXuTPJs7v4hz9sVuzy5gY2KHFMIdpbRkMc6GWVxesn4h1?=
 =?iso-8859-1?Q?hn0d4dv+sMRQG5NebsytoDZdpbyfMyuPenKweWyp5BimI2TlcSuJmXBSGH?=
 =?iso-8859-1?Q?uWRctZLZPoUr4/IeOrc5nbgfz81Uqy0mBNhlN0FkLf1+dw0YTSq6dEcFRN?=
 =?iso-8859-1?Q?LONvtZx4nkKieub71jqbmKuGWi0KfGv7KOgXSISAGKc8wVuzr2WrmepMys?=
 =?iso-8859-1?Q?4Fd06IYUommapQdRBlC4avN/lMdvV1QsturAvRzmKSaY+Krs0FMbKIFtwi?=
 =?iso-8859-1?Q?Y9VfJ8cgaoOUe7pYE3TLzi76sdchl6QG+iYjbc5mUjbnRsEAZpHzU20t88?=
 =?iso-8859-1?Q?ky50qPz5rY5AfSHfpQYyx2LDLT2Zmt9qU94YwrI+6hgcA0GovP8yd5qxCK?=
 =?iso-8859-1?Q?1LbZa7xo7pT2UYAY+0Sn/7qYKyBtHe8YHkMeFJBj8MwD1P9mCv2/G4VNxl?=
 =?iso-8859-1?Q?wTWJ3j7WgQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0daa0c0e-6e00-45b3-21e2-08df1ab8d16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 03:55:19.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuLfJbC3sbBHcLh8qHbdXc7oprX1kwnb2LdNKrzg5j33FlXhaECURX67RHiY0or6SEaPVI2YB2E3j+iiFGd9oPFVjrt0Ir2Smt7YTp1J/O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12503

Hi Jonathan Cameron,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 25 September 2026 03:55
> Subject: Re: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to m=
ax_channels
>=20
> On Wed, 23 Sep 2026 08:21:29 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Hi Geert,
> >
> > Thanks for the feedback.
> FWIW other than fixing this up, the ADC parts of this series look good to=
 me.  I'm assuming they can go
> through IIO whilst the rest goes through whatever tree makes sense?

I think so. Binding + driver patches can go via IIO.
I will send v4 with fixing driver + Rob' Rb tag for binding[1].

[1] https://lore.kernel.org/all/TY3PR01MB11346568D44110BCA1CDD146D86802@TY3=
PR01MB11346.jpnprd01.prod.outlook.com/

Cheers,
Biju
