Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BED4D597B;
	Thu, 17 Sep 2026 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650547; cv=fail; b=YrfpuE63ty8lU6Uf6qs9awiueZWFFdp4piRYN7ApKa88BRwKsxTNoExsQHvBm2aMmaOeqt9L3XdoHuEUoSkp6iN67Owfr02sMz28r0sXSfOeWmcoeu2hMNi4J0g8CtAjQPzRSNNuqeQ9PFbtc6dgOiz3i9g1BBlqMSuOaYKeZxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650547; c=relaxed/simple;
	bh=BknMmSeaKkZVbPQeiE8N5YcAhRMc0qlzeIGvD1EdCKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdrlJvfhy6AlfnWlaI1sd4uWOzOgJgDjSk6VkPmT7HYLECsHo+wSlBzTowqNAp8JoVUpUZFXCKPnYY9kiT1geURK7PL3FqW19E2k9eVZnDspOenf8lIfe3Q/yhZB4aXI0g22veVgqt1t4/Y0LGegNq61pXrJDlzC+Y+hd+ihuPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=B6iY9uLg; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="B6iY9uLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWWQ1gCRoo4HX1JuyBSQdMRy5oRAL5T1lxx45UUCGUJpPKIQQ/o5yjA63xziUnMxDIH5R/TktjCF5RgQCla8xbHsYY2eiryilIsmv0qwwcun7NlxRL4PjgGipw4TqeMb5ePESA5m0FnJude4osWxiZ/MOYQth9LVV+RqH9m9Vs5AjXVjpkTmmmmJJB+KJ4g3Y7QpCppMQBT1IgdHmbsNvDhMxx6XSHb16WSdqYHW3eNHguIJEU5CCfSrDHuJUwBLub9xq5AbMROG0bDMM3WfCCvRn6l1FZLsXE4w6SOisOhNTMnDLV/7aNPajhfJxujjqGw1HYav/ITIp1FwZ9K2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsUO9tpIKJzSnzK0wJPJXu22C0qJLFYe0hFX4nOmFmk=;
 b=D/1y3N75zkXjGYQGo9IaBJ4Oh1fqcBm0/NWHnAUnwR90zs+IYz3bvBzGiJj1wSCyn4XVnziDpNdi4UXZ+WiqCppwvT2XbyYCKBQhAZzP8QbcG0qoqOd9mnI4FPNppGbdGlyRAXAePk4fTMJXFrJ6CxNcFvIEusRXYfD5tP1aNnMOJKbXO0oozDRQrFnXgUJa656zO6n55MCG1FtXo3kk7M6LMh8GsGcAJ8sQKddFdEOEqYF8qIC9s6MADASfkag1yv26UaAN7z5ghYGkr+L70pdAcrtHcuTPnQ19DqCIr1XD0p6ydaQ1zYsoPjfWUPZR6oEMvIjS8XrRKNKssO6wTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsUO9tpIKJzSnzK0wJPJXu22C0qJLFYe0hFX4nOmFmk=;
 b=B6iY9uLgJROqFNPgVxQ3Lm9TrWVIvGWqoULyBA4d5oYoSC5rRKYfhGErvyn12ACR8HuKZS9KaxtStz87/TviqDStRAVmebGbQShj8gY3BHkSKaFkJCYH7J9BWJCOhDm5LmmIYoSaAY214hoz6o3YMmiNEsJXByI8j1PYfkmverc=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by TY3PR01MB11073.jpnprd01.prod.outlook.com (2603:1096:400:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 13:08:52 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:08:52 +0000
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: geert <geert@linux-m68k.org>
CC: "magnus.damm" <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 03/10] pmdomain: renesas: rcar-sys: Add r8a774a3 support
Thread-Topic: [PATCH 03/10] pmdomain: renesas: rcar-sys: Add r8a774a3 support
Thread-Index: AQHdMX5/dPjx0ySNWUKgGyqdvbBHELa+mdoAgBRMZ8A=
Date: Thu, 17 Sep 2026 13:08:51 +0000
Message-ID:
 <TYCPR01MB118651BE60ED87BA4CE9D38BFA2B82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-4-ayman.chaudhry.kc@renesas.com>
 <CAMuHMdWH2ojjcpKK4vDWQWw7buj67H4y9=Mpf9L-xn-qD_4U6Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWH2ojjcpKK4vDWQWw7buj67H4y9=Mpf9L-xn-qD_4U6Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|TY3PR01MB11073:EE_
x-ms-office365-filtering-correlation-id: 78ec62ee-e25f-4325-853a-08df14bcd207
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 RoShSXAL3bFG4D0GzmFAUjxhfK0emMjhaKilRt8bXN9pIcNOwB/fGpy1oHVb+H4KTq8hrVi5dgBHfE7on7hA0SEV/KWy87j2TkqaNI2Y7r7LZ98pdBitGagdZY0RWJzLebYRt7/useP+ixYy2TZgT9j2o+ZLqfFfPRLXqM34oaXHojppP5UDTXsNn5Rmj3nDz5nN6N7nyUXo+crof2rOPWnJ0MQS8R9waQNaKlKDVpB/bvif9BeLobqyraJZwpsSDtBK1BFkuv0C9MFCOJlTCgP+YZ87UgPftfr58xQsU2EaXu3RzkOVS7iEoAA8Y0qZoYS9qATvnj2M/IAiIXLG1YbLFKZyipQ84NFQHFlKo182OYT8w47GNrA5UU0cWkXL1ydchBPwPXD5tZxWl5daqBVM6Vm1oTHynWgFxat2cGKOo5ofE/8CsKXLFhgxGiaSqF4tbomEt/FrYQIMmrnP+gr2bEFzfNZ/l9T95CKx4Xb8j/fAt7BSTu1zJRzx2gYpTIMIp8DuoAzVPooVSUb27uYfArEv0IiaU9auELUm108DzpMzQshrDTdVRDGd7u9AV9XhZ6ifvHW3rztah4UkQAe+OgpHr2e9qom92FGQySpE0/4EHV2rjBHzVaFNgEKIP5yU9ac/jyWV8tT+DVP3uo0VBnO5Sy2ytJgYcAg5bojaHEcv2+dJSWZFzVVOEBJk02LS1AW7LTG7OHROeBfFpFUaFOXA9meXYoKbEJj/9vw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a5yiHrbBBFCfKMo4aeT0jXpqz8ACML/Uxmwz2uY5FgP1eQA6yZzv1bNHAawQ?=
 =?us-ascii?Q?0Tff3oWxdz41QsHJlTAbKrndb9mmT5XA1wyECj1XKKe1027OQe4GypbE8Wa8?=
 =?us-ascii?Q?2Z6/bpKgHutHFbuZUQ75d4K5znWWsg2hZa4gnjDMSr741wAkIKpf/RV6a0qD?=
 =?us-ascii?Q?OJB2o9HLkBUCcVyDvN8ie/RYtEM6yZH80WIU1HbF7MGW/bJ+iOQtDPmOgwdv?=
 =?us-ascii?Q?c24I/UwWsQYmVJLaPP4ZjQPTsbM+A3FDsdWW1oGE4u8P+Pgi2kIGJuxu4KNS?=
 =?us-ascii?Q?PA9aFVWrktZriOhUlD6Qkpg2c2miafgKOKMVrT+1oJXOOGmfHRsWomgb0IcY?=
 =?us-ascii?Q?tO1B6NritSBiSXkxDqhy4PbmWPYiswGQou7zVy/lIUJl3xX4MXx2p8yFoy9i?=
 =?us-ascii?Q?z4lNK2hZ7/p0MWZygmV2eccQNIcIQaoRybaMKscXpOZO83vB74cwjqXQ3JkE?=
 =?us-ascii?Q?yqLdSewB3+HsPRjoePnkmUIa12z2Ow7XB0WFXPhk6adXoIOjnaYtivpuIj+T?=
 =?us-ascii?Q?4rEPYbHa9fbAuht25/mm9p3kqIkM7BRsGRwzmIBUAyV5zEkrQ1Pgi0EfHOR5?=
 =?us-ascii?Q?krb0l3TObwS+kmaVwl31Un01LjSxCIn0s6pAqIXzqGYbAt8ZDA9aW4BTEMO1?=
 =?us-ascii?Q?MbPf4QDJqJt3ArpujnnodQbxzp6VjXnbTdjCBf3Lkn8Xd7RvOoFKIa/di/I9?=
 =?us-ascii?Q?BpmSsV10dY/zEaVD60HRKOBHVCboZhbRGkr7QRu0c+jMyHHQ8Q85Qv1QGyMy?=
 =?us-ascii?Q?6NdZ++1Hd95Ov0VBcpbm2RXdMKk9lR1x75NkCmm4pe+bMFTXwlKF3kJRxPdu?=
 =?us-ascii?Q?XoYyYITJa7HBPEmPsnCx3lUKC4QcCANICVUNJzxM2gZ0yf5Yn7C095bJaqbj?=
 =?us-ascii?Q?cHD0RmJUjM5Fr8/SoY0Nj4gl8Q324WAaW+8hyalFQd3Rbs2lDkeASTw7Gc19?=
 =?us-ascii?Q?3SjxA0qBfZDabKulMGBOSBkun82S2xISJ5A4Su2wU22L8AoGKpqYqik3cO7M?=
 =?us-ascii?Q?muZezoKgS/pnkUSY9eLNrXVqkUEcVb9xrx7Uy+E/qxidKprlZZPw19LZ2ZD3?=
 =?us-ascii?Q?JM6RIRS+WuKOjYIjITSFZXH4K0cpfqwRfdGfoFLgm5PsC7wgh4qGdtyywTaF?=
 =?us-ascii?Q?Rs2Ghfd+Ds0D9CM0MWpi5+aovw/QYXFw0HyQL/qf5OL+Nx5TU0YyBNjCBrjD?=
 =?us-ascii?Q?GyEX2TPrLORqTxMvaCpgV5dJBtD+HLSrQPwR3C/cgBNiVuO2OUoCwVM5/sOk?=
 =?us-ascii?Q?Vmwb3QG6AJdStes1zjjJwPa1m80ajAerGEyLXebr5xLZ9Cjw9OuivVQtloiJ?=
 =?us-ascii?Q?Dbj4zLH+jj7VMdJEl6kVK17wmiXo82KCQFyy4SvMNG/YPBkREf+EuNt5giTC?=
 =?us-ascii?Q?uQHSeE+mvSAEdug8eT/8/VMJjnW5TWPGAhLYjg0MpNHBqfIo56f74zYC6mFi?=
 =?us-ascii?Q?/W3elHyHzQmFNtRuTT3O+aepBogh0FR4s63fGIPUG3zp6JOnrQCrBTU04DUr?=
 =?us-ascii?Q?rkJ083umiNWDL6JGFJlGciLwjusxVaWtv8VrN2ZObuLmLj6oWWjIwfGZRfUA?=
 =?us-ascii?Q?0vbWvZjjIavKnOpLUHngH2B+tj0I9zI4HJUrqbXiTpSFjGxT5P0Y3Jq7HP1j?=
 =?us-ascii?Q?iXFNkGw417mu8L5lDFuYm7wfsHGvJVcIZwWrKPlyoWREYl9zKl5NTGpInntR?=
 =?us-ascii?Q?uRUif74//LiSIAgt6dNK/2X/9nXHcU9RRobfrpfmB2haRSCwv0M59RY1v+9K?=
 =?us-ascii?Q?BvnM1CKSiq7vMMMlGtJ5Ltlryu8PY2Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ec62ee-e25f-4325-853a-08df14bcd207
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 13:08:51.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrGBVjPv+U2H59prCAeGnVjd3PVszqrEr3AzsX/4fwucUynYRp9Mp9aqhYuqLl2x/47fdGF8gAfrpG4onMs2S8CuauoMhwnd3zh8cE38LH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11073

Hi Geert,

Thanks for the review!

> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: Friday, September 4, 2026 4:03 PM
> To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> Cc: magnus.damm <magnus.damm@gmail.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Stephen Boyd <sboyd@kernel.org>; Brian Masney
> <bmasney+clk@redhat.com>; Jerome Brunet <jbrunet+clk@baylibre.com>;
> Ulf Hansson <ulfh@kernel.org>; linux-renesas-soc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> clk@vger.kernel.org; linux-pm@vger.kernel.org; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das.jz@bp.renesas.com>;
> Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 03/10] pmdomain: renesas: rcar-sys: Add r8a774a3
> support
>=20
> Hi Ayman,
>=20
> On Fri, 21 Aug 2026 at 17:05, Ayman Chaudhry
> <ayman.chaudhry.kc@renesas.com> wrote:
> > Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power areas
> > to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the
> > RZ/G2M
> > v1.3 SYSC, however it lacks the A2VC0 power area.
> >
> > Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
>=20
> Thanks for your patch!
>=20
> > --- /dev/null
> > +++ b/drivers/pmdomain/renesas/r8a774a3-sysc.c
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2M v3.0 System Controller
> > + * Copyright (C) 2026 Renesas Electronics Corp.
> > + *
> > + * Based on Renesas R-Car M3-W System Controller
> > + * Copyright (C) 2016 Glider bvba
> > + */
> > +
> > +#include <linux/kernel.h>
> > +
> > +#include <dt-bindings/power/r8a774a3-sysc.h>
> > +
> > +#include "rcar-sysc.h"
> > +
> > +static const struct rcar_sysc_area r8a774a3_areas[] __initconst =3D {
> > +       { "always-on",     0, 0, R8A774A3_PD_ALWAYS_ON, -1,
> PD_ALWAYS_ON },
> > +       { "ca57-scu",  0x1c0, 0, R8A774A3_PD_CA57_SCU,
> R8A774A3_PD_ALWAYS_ON,
> > +         PD_SCU },
> > +       { "ca57-cpu0",  0x80, 0, R8A774A3_PD_CA57_CPU0,
> R8A774A3_PD_CA57_SCU,
> > +         PD_CPU_NOCR },
> > +       { "ca57-cpu1",  0x80, 1, R8A774A3_PD_CA57_CPU1,
> R8A774A3_PD_CA57_SCU,
> > +         PD_CPU_NOCR},
>=20
> Please add a space before the closing curly brace.

Thanks for catching this, I will fix it in v2.

Kind Regards,
Ayman

>=20
> > +       { "ca53-scu",  0x140, 0, R8A774A3_PD_CA53_SCU,
> R8A774A3_PD_ALWAYS_ON,
> > +         PD_SCU },
> > +       { "ca53-cpu0", 0x200, 0, R8A774A3_PD_CA53_CPU0,
> R8A774A3_PD_CA53_SCU,
> > +         PD_CPU_NOCR },
> > +       { "ca53-cpu1", 0x200, 1, R8A774A3_PD_CA53_CPU1,
> R8A774A3_PD_CA53_SCU,
> > +         PD_CPU_NOCR },
> > +       { "ca53-cpu2", 0x200, 2, R8A774A3_PD_CA53_CPU2,
> R8A774A3_PD_CA53_SCU,
> > +         PD_CPU_NOCR },
> > +       { "ca53-cpu3", 0x200, 3, R8A774A3_PD_CA53_CPU3,
> R8A774A3_PD_CA53_SCU,
> > +         PD_CPU_NOCR },
> > +       { "a3vc",      0x380, 0, R8A774A3_PD_A3VC,
> R8A774A3_PD_ALWAYS_ON },
> > +       { "a2vc1",     0x3c0, 1, R8A774A3_PD_A2VC1, R8A774A3_PD_A3VC },
> > +       { "3dg-a",     0x100, 0, R8A774A3_PD_3DG_A,
> R8A774A3_PD_ALWAYS_ON },
> > +       { "3dg-b",     0x100, 1, R8A774A3_PD_3DG_B, R8A774A3_PD_3DG_A }=
,
> > +};
>=20
> For the content:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
