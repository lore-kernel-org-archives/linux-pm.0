Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011040.outbound.protection.outlook.com [40.107.74.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B34266B8;
	Tue,  1 Sep 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275034; cv=fail; b=LUS42FOVwcrJhZNEVeKNXNNg6wdstjaH/lxaaLKux9KpjqyoC8R8VZ55lO1ylOErl6AgdcYsXxmzVXuEX9fKqdZWelPjT2ZP8kTNG6rI+BXNfnOD6CqPdA0zPfV2amqfkOlmh1EtCGmoAb9Yc5yBqgvTj+8bWZF1sLGRYUGCRmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275034; c=relaxed/simple;
	bh=PtezxTE9OkfLliuhREJq++3FCjXtBdvTsxQsHBK/8PQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H3azO+UW0UxQE1T6nnpcA6gxxSRSBZwRJ7W5xal+hyqR86tT4nvF3POZOH+2USE+No6sv0Ip50JcjJNf8rn/OAyZkO+jzkV1GJefYpME3a/I9hV9+oQAZZoiYvHhi6qKVDcoQCcKeeV8gZcHxuGgVun0a9BzTvr4vtv0opeeJeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=HSAC5yeQ; arc=fail smtp.client-ip=40.107.74.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="HSAC5yeQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NohyxBxlHtvlq7brfTkYdx2hUVKX9wEgTQrdy99GM8lyer6bW98cBFwJpO7j/lZLOw6kFOTyrwl3qsHahDNjsLiMbEMES0c6lg8NoNWbwTdtrUN5M02z/dxI743hXTFRXr/avXI0T3Xhm/wuSvk3CQoUDYPHSaF/C57PMmeM7TBqZQE55wdrIsOkPchBjfgWfuU0YwbmSvejBmGX1dYqDaSKAT0ra5s4IOV9635x5zsxe5o2q7lsO6hMOdnQ5EVgltZ3IlCJzNLfMzCTOcPBKOeWDMq92yUYAIu14JcG1AIZZukx5K43Fx5eWmI++Sz9TQv6wtbkhlNgGklg3zlxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtEhAjBpu1nGqq0uYx7xu1U6cAQMY2qOn0gSTIM3feY=;
 b=V3G5WGAFS5pAV3hVKEYOKIJyMDBL4JSQs7LKIpkMQCfrU35MaHDiGEgftmmscmE/BbEyqkSVCC+01bc+GpMkhuKXMyL+4eP/bP3xmhCr4ptIdArXDJ3804NSver/DqtP06hQjZIzs2bC/8MhftRVnWfGhIbAMf0qLT1iteprJe1LcNtaluYkEVO9CYDWewxsOP611hbWreDdiJHZTONzGK5Qm7VTGCnItI9ispe8OMjE/e3At6M5cjqsLK4hbIx5zybSpjIQHkjDbCeEMQeR85zZxkkPSOnT1BlIxvpyX4vj6vbJNNWgRuK2/uKyjF+3Sacox/PUwW02I5mOm9CBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtEhAjBpu1nGqq0uYx7xu1U6cAQMY2qOn0gSTIM3feY=;
 b=HSAC5yeQJedNcOQOpJ3iUXENihOgKtBjpkG78bI4Ag/7Yh9NWja6A2pgXEn0joZq0RpoxEVgmUirwQSh3rQ/zhrLqM/toMrYiDHrIAMhwy0odV1vUTG/7fTiPUOVhPhdZzJ0HY/KSF04RLPM98BviPUp8VM0Z/F3qURCeWmrB8o=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by TYCPR01MB11887.jpnprd01.prod.outlook.com (2603:1096:400:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:03:48 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:03:48 +0000
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
	<bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf
 Hansson <ulfh@kernel.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 06/10] dt-bindings: clock: Add r8a774a3 CPG Core Clock
 definitions
Thread-Topic: [PATCH 06/10] dt-bindings: clock: Add r8a774a3 CPG Core Clock
 definitions
Thread-Index: AQHdMX6JOUF0xlBbdUCrikilGbQwXbaprWuAgBA0xrA=
Date: Tue, 1 Sep 2026 15:03:48 +0000
Message-ID:
 <TYCPR01MB11865F6778D781EFF2F0B779AA2A82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-7-ayman.chaudhry.kc@renesas.com>
 <74e1a947-39ea-4451-bb4c-178a56b6b4ad@kernel.org>
In-Reply-To: <74e1a947-39ea-4451-bb4c-178a56b6b4ad@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|TYCPR01MB11887:EE_
x-ms-office365-filtering-correlation-id: 4c73f7d8-29ec-4a94-a94c-08df083a39f4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|38070700021|921020|4143699003|10067099003|11063799006|5023799004|22082099003|18002099003|3023799007|56012099006;
x-microsoft-antispam-message-info:
 VFsebQKkYzT32Jg9OPNe1TVzBAQRhsHpC/QR0v/ANwDGSEMuv8WhVr7cRx6VBGRBL9s8F5sXLQcdmL9xPC/9X0HPREzTb5ZZ71C3mYnES7BOwKxg8UtPvpqwl3Xm60RIZXfCCOjK2HVjvq2/qxebNKiTR0keNCZcodoFhlZOCqYUK+ZfCLXH/c8ub1WMVbQaJTDHfXqlMArfVB90FrRmGta1RNBIHXrcjtbWY2P/E9Q2JvQQBYqrNuPa4hnDq2ASgfhcoZUUt2MJ2KuoCsr5VpNsvaMWj/T9iz3XwLEHl61X3c2I7LytCrzu3k3QvaECHouFWbb92mfHslNODLcM9uynrKArC5dFvsnHONSHInlWTIshJMZDBY5+RTvsQwSxNcxSRanakecCSeRoyaOcBbCZATIKg5riL8cphNZETNUk6F9A/I8YCEW0WnUxJCawPpnPy+Jw1sV0XSQMMLjOOTVIHIpia/x/p1yH/D3Nj8ptkcIOzhV/B53/w6TUF4cR6QZwtgdeOiqMxZQnPHsilvJADgNiQgMMrXqKbCwaMcICbav3712nt9WL0MV+FUpd7q/2ZYD14gAnofXvJt1pXcU8pnIMrkMsOEQB7f/VXPv8tfRg7sHJeWHLkRiyQu4nDY3t0wlDcSJByB5kptxSMyiJtVAJ76USByi9iyapGCiA4QZQzvbowMo9t3oAMx3UZX2F1ebuDyZPTo1rC6OcvJZllaLN3NPaiCNRixa+YpTlApjo7Pt6xxmKbMnupyYE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(38070700021)(921020)(4143699003)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q7iKgT3zgzHi/UTaR3iahZbtVzEyCU4pvkIDhq7e+HNKrv03YdMDSoxHOVSD?=
 =?us-ascii?Q?oAlBLUgMR+oClEEW2SAbQErzFQvluDj9FAsIKLB+UhQTgu2QzV76HGTMCAop?=
 =?us-ascii?Q?ODzFpTUDSSFaz/7VfFSpAtUj9nww+OuYXpIyXvOlRA45s+IpqHgSn22otuX8?=
 =?us-ascii?Q?pBvFBZiMJ/IWMcVyCf3xBlqe0d+stCgmvsNQtDRuMLqm3jpNuS3LpqCp6jgo?=
 =?us-ascii?Q?BbGjm3sH83J0t2+5r+1WnUmfU9I6pc+Mva1jWVYlOGSBhPp+vD9nRPf1p4ER?=
 =?us-ascii?Q?X6q7HgiPXQId/Limdgx0i49c9PwqEAdF/p2tx6bTs3g6UcsLBQL8RgkN1CW3?=
 =?us-ascii?Q?HMaVkPpQoXLdQ3qPqn2aku9ZPYCd3TivsNy16Lp6n8uHPLMG4K3NHksONt8U?=
 =?us-ascii?Q?5auE2y3S3XOmMLqeWq8CKHPBHrhrON8O/kQz5YTl13hhYuRYWy6y+N7Ip81/?=
 =?us-ascii?Q?MKihfrprA4tatdGehGqplYeqvHd/Goa8djjPHnnpaaHfiOhYK8wl3J/9jajG?=
 =?us-ascii?Q?6NjIZPDwvfcxNGFb1/uEQgIs0dWVTJy70C3/u/msq7rT9wsE1jnN+oPVrlfA?=
 =?us-ascii?Q?btwQXip1LlPAvAF+Zt8o88hvRJUqe4tergz+WxeovMPmzOjwF0GMkvadw68u?=
 =?us-ascii?Q?7vpPIEtnkOXftxvL+Hg63SfjBERkWiTg9H0HSigN060zKxMDtaRdB31hcPm3?=
 =?us-ascii?Q?ncPFkvzDH13Xs6pn/s9prm19FLm6zKCQlMmY522KgN9tQLvYOtufKu/vL2TY?=
 =?us-ascii?Q?Dec4zF/dxWEiUduo9iaZj8/Ks9l4uMrTB+sCBsrHPLF7kv6P6dt9EQtOZvm3?=
 =?us-ascii?Q?ydoo9+wOhchiCLbWye8afe51g+kc18Hyjm3EsMsr+d0k9Xp/yqIzUlyOV7RB?=
 =?us-ascii?Q?az2LssW62eRkJR5YOc8rDp8nH5Pm6sUmCIDJTWLNQQd2bmWO1HqNAiGUJ0tX?=
 =?us-ascii?Q?rvRHpTjAefM1d0vKbmZo6jhkgpP0+WRjrKdW4i+pVZLI82lhxrsiSmWDZnUd?=
 =?us-ascii?Q?/AQs8biqgFgeaS+52WyNpSN1d8AJt/lPKPjVizK4o+y2hH+uSMXZRFnLC/18?=
 =?us-ascii?Q?9tWUAannLoarFnEDm5bjI9TiMveO5SvMdO6C5akML4QbFg2U1KAeQ58tpDtC?=
 =?us-ascii?Q?lDoDgwqDhw7xlD/ePzre+nVueirXnVo4/Umni4Q/3GnjlRbpQGFbOCv01YHn?=
 =?us-ascii?Q?NiNgIdEKy1dUWirOW3CB+nTyuKnj03ApB3YszyvdnOmYRNDasrQvDt43uEcu?=
 =?us-ascii?Q?98yV1pRcCQEXbFh3MP6mFO5yHwALDtvq30pAz1vzSbO7P4LWJ6MwzlJ1uolg?=
 =?us-ascii?Q?D88Y84E/IIMNCR0NxVeY55m2pFtmVGbSuVNgg5Zc1Bu9zyMeaDZ+a/b6+tkL?=
 =?us-ascii?Q?GRGBG/dJWpWvfGBVYzG2f3F00sVLWuFwWJlJ0okpQdgdypevQf4BGkknzJi5?=
 =?us-ascii?Q?v230Zj56M0UItg/+a/G9K7AQ5klz3HWTZivvQOw7YblAb7lWMbCUsV7tv6Eu?=
 =?us-ascii?Q?ibWUcXj12h6t09WCwp/xhQwZWraacTXST1txlB7fOIyhvCQM/LiXNRhaHg0Q?=
 =?us-ascii?Q?SmtmmklSig7k9WAU1xSjF0M74sVfsKsfz0IFffsxGX06b2soI0wnNevfoVDY?=
 =?us-ascii?Q?l7dM16wuybkmABLPTRblsVIWnjXpfUEimq9SH4HV+nEgq4H6kWPurObzzPk+?=
 =?us-ascii?Q?2yJzPsMKgVEmJpTSEUVqj3coGzjt8Nk1p01SXFmkVayth5L0jkzVa2D3cpCN?=
 =?us-ascii?Q?WQX+amSCz3v6yAlpHzaAElsHD8FmaAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c73f7d8-29ec-4a94-a94c-08df083a39f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 15:03:48.3250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA2pBvFVEN//ERUWhpUZ6PqWwk99Qgxp66YOR/i9xHGfB45f/Mh7TAJkVMPHY7Zh+vPFXAqIb032LKUnNnIhgRjcH1KlnuwEh5mxSkICIXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11887

Hi Krzysztof,

Thanks for your review.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Saturday, August 22, 2026 8:31 AM
> To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>; Geert
> Uytterhoeven <geert+renesas@glider.be>; magnus.damm
> <magnus.damm@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Stephen Boyd <sboyd@kernel.org>; Brian Masney
> <bmasney+clk@redhat.com>; Jerome Brunet <jbrunet+clk@baylibre.com>;
> Ulf Hansson <ulfh@kernel.org>
> Cc: linux-renesas-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-clk@vger.kernel.org; linux-pm@vger.kernel.o=
rg;
> Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 06/10] dt-bindings: clock: Add r8a774a3 CPG Core Cloc=
k
> definitions
>=20
> On 21/08/2026 17:03, Ayman Chaudhry wrote:
> > Add all the Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC Clock Pulse
> > Generator Core Clock Outputs, as listed in Table 11.3 ("List of Clocks
> > [RZ/G2M V1.3, RZ/G2M V3.0]") of the RZ/G2 Hardware User's Manual.
> >
> > Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> > ---
> >  include/dt-bindings/clock/r8a774a3-cpg-mssr.h | 59
> > +++++++++++++++++++
>=20
> Same comments. Why are you using discouraged naming and why are you
> sending it SEPARATELY from the binding?
>=20

Agreed, I will update the naming in v2.

Similarly to the SYSC binding, this is already present in the kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D4b3b9cdb7db191ba262256972d08802b7bd8c7d4

Kind Regards,
Ayman

>=20
> Best regards,
> Krzysztof
