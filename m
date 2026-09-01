Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011054.outbound.protection.outlook.com [40.107.74.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB4306764;
	Tue,  1 Sep 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271900; cv=fail; b=Uwct0g6AuW6anECmmt6rEZc5YTR5tuDW4ESSvFxxUVLLwFzarWxoVDjPcN9sGSKZE0xvt2hC3LuPMv/FDFKdXN/t1uClDyxup852iAeuPPR4Gn9UB/qqVvM65i6qiETPlSFsQA40LG0JVsbwwWakxZciXtHXsHujbXg5jTTnQJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271900; c=relaxed/simple;
	bh=q3BVu1POFwS6/Do2W4uqaywOhLEkYlmvZ8ZZi+xlhtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jZYbRojkkj5m/JX9TliZz7wfGI79BF+RPdcddq0ZQY1Fy20zW5p/tUHnqzeZxtbtDRn2lpnHR2LQN4FzsD1mAmQIbtqK4xsrpG9c4EGIDp4BEI9XDFD4ApFyIfhtBl0PgP6x35EYIV8JmPk/NRmFSAokzOqvg4tYxkbmLQNVvPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=RzA1LAbh; arc=fail smtp.client-ip=40.107.74.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="RzA1LAbh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gocgRzgoenNt3i6T5SxNwmpD/GyzVzHK0EKjDutGfbo6Rjk5xX9+hNzH0woyeuoU84AKgJAv20B3On0IN6GpyvuzaFGSL1Qu2PyFnSMLBRanAOCWp+POC6LQ9Q3n0uihrSJt9Ud3vEhKhO5/rgUQTbZi5rQYI3IQ0F9rwvxJsZuWOT382oqyTmYhwr/1rsEZhYWHT2pXUdYzpQ1Nb8XZFiyN1PzsJt/WhH4hGyh1yhuLRHaOQFp+KzVMTz915uLjrC+GmKvg/y80Bakd3zmWPcjRTFmHJxEvUEf7VOMrWZeNIrf4vwU2JUnftcoi4c8rGckqZaE4jgjre6Plrxiuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eENDf7LxN5BaT6FIkC/FoWCiYXcU/4rmPUxe0cNlQgc=;
 b=oEIJhs+tTLnQwKGxd7QCkvdw4YJEKdUY/AjzkR6GqR1QKeIqFFjo02JW9dvwzZLnA2BpZIv8oT6KaXtwQNjJQDSlFyBPtuK78Hi/bonLeSWvp0zlYfsSiseO9zkifcnZ8eQ4KRdjYiLyuaE6qMe+le12OT+jOm1fLmK5ASdr987xPWmppPNXFXPKmiQtJgw8nhRKyF6ovoiST61t9RuatqezVnHtJzjjfMNwhHTi+KdJ8+nAaU3vvHfPzEmMIi9Ex2/ZSySAPHv1ORrymYWmK+2sNVb8pwe9o7b7kuFm1Nf6MA3Vem9J299p4CXmZ0i2tBVwvZ5pvfpXTqVl7lndTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eENDf7LxN5BaT6FIkC/FoWCiYXcU/4rmPUxe0cNlQgc=;
 b=RzA1LAbhV7ZYhzH+zt+Q78kcZyXMsjftd2axJXudtg7Hh4pzok5tAB81GIbkYtcS6E0qHv8BkK7zlDAwiMbnZl0iiQgVinWdhmk2VkHlQq4P38lPD5qoj4+JAmF62+zG30kujGTQlfSSVMpUxYTij11Xlzn8bWvO2aIljQSmCIM=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by OSCPR01MB14950.jpnprd01.prod.outlook.com (2603:1096:604:3ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:11:35 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 14:11:35 +0000
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
Subject: RE: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power domain
 definitions
Thread-Topic: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power domain
 definitions
Thread-Index: AQHdMX5892WN4kO9QE20wnaOSC1ofraprQeAgBAdPGA=
Date: Tue, 1 Sep 2026 14:11:35 +0000
Message-ID:
 <TYCPR01MB11865BD2FC199EFC6BE613A5DA2A82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-3-ayman.chaudhry.kc@renesas.com>
 <b2f486b8-a391-41bc-8a7f-dc81c6752205@kernel.org>
In-Reply-To: <b2f486b8-a391-41bc-8a7f-dc81c6752205@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|OSCPR01MB14950:EE_
x-ms-office365-filtering-correlation-id: 485ca316-a500-4b14-9a77-08df0832ee77
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|38070700021|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 9yi/KQ0MbtTdex9Dmlo7o07zSEA12RmNM6o4XWu20yzSafXHQvPfNzTn2RMtb+OZkchTlMd0Me8Dbz8VBMCB8CZgEPFR5dZTyrDv7fRURL4CwGIruR20pfl4eUMYVbR5yO7M6Jo9YrQsKg3DLbLbp/97bk+TuUM92TA5d9kB/RS2vqcA/gVGHJs95SF8xRSVqQ9wPeBkU5jNq1qNjRjd1j2jHfjXabWGAoeANpydmvuToScmr9jZmbTa4g7qLWMyS4bFqQze08cB0DjjXApK6cMdbR7XiqLmuvstDlmJaHF472LScxvpMjLG9NoOAw6rMXVVb0Ob8Ym4gSWqn8mrWmsaVfyHuqHxT/CI6t/ysePV40KrTegeX4YjypFmefJRxJbPb09rJ9S9Unjs4qFQPDvBjHxNY7mrvc46wFerSBjCj663YMDDmH3J+hYXMRN7zck7MeE8jFCjIACsGJQm4/ASsxaAsTKdUTJccz9tgxahC17h9par9Ns3qw1ty2mHSiEPK0JMifCx02M3l1qTumOHtU8kVQI+THA/Ms4voIG24pxiCidJ8bhC9EJP7UrUCvg4Tzr0RCnZoZZDbU69i2XJPdCq0b1M6+Q5a1E0ft0KgL9ce6nMc3mGh9kVB7mU8C4N+2yqlXnZAV9prQh2GWHZTuT7TePxJoAkHGynKfei7dcKP9njbe1cQf4tSirF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qtfDzwHkieUKaMdU4+d89XWWMuuSB+DoBi5RymB67LrlElyuU2pRduKBhsik?=
 =?us-ascii?Q?dxpmNGE6cG8f8m8o6hIlZ8HkQBDKrSS3lCHbV4nR1yIaHvSEvHHklW4Aclr0?=
 =?us-ascii?Q?ncJsyRJQyiR+xxR5WJit+pmPgLxgL1hEzSY3Ci5BwG79batoLv7YFR2/mePA?=
 =?us-ascii?Q?7oUA6ymIQPgI/3SaJnLZCkRNquBhgwLscEBLvAKVj4AHPd0zQpO/K/mdLWpi?=
 =?us-ascii?Q?YHFoDVhCrQK3sGfTyZskCFZvDIlKMRGoRBrG4g3MGiInkpVu2916/0G5lpbY?=
 =?us-ascii?Q?Zx6rmdYmYYCMbCGm1cPiiqwJHppvWaHfOgBi86O0ebWQa1XF8Bu1/d7S8/bT?=
 =?us-ascii?Q?Y5tCOLGdHlBmZAxEwYfD7fV1ahOXpSc94aTBVlHM/nCkA+txfTJjiER9Pdb/?=
 =?us-ascii?Q?gnEsbrMMpfaIWZ4NEqOpu4GqrkHQE+v4BQ9O6tkP8t4Gt6XSdmkNEwNooR0I?=
 =?us-ascii?Q?pxI+2Lw1Czw9gNtxH3jHudTg9Ccqgzu/ik2DGcxk1viDEj6Bqd3HZ7Fzptdh?=
 =?us-ascii?Q?mM5cdglCFiTRr+TpyVOtL//EweyQPsfHvlHe5AqXpBOoFSDAI5sUR5ecIU1u?=
 =?us-ascii?Q?mdBQBPYXRkftuekgM0lNlrY09F8VgmgNwzf7KH+poeehhziIglUN7hJcCWNl?=
 =?us-ascii?Q?Ran1+MJ143cXWWwINu0+qiBcrd88AfpcWJpD7IfO8G2ISYA7Iaj4SxzjBIFM?=
 =?us-ascii?Q?p2ZQEHL25PToSK7lNu1iR6D8XoWtDqNTPqCu6aLZmdItLd/917EWnLyrvTmw?=
 =?us-ascii?Q?nyKBqMIjYku4ETuuSs/W1RKV7ddaEuuJbmHBYaqErsGNEFkVfTRL/g0go6ZF?=
 =?us-ascii?Q?4GXrtoiRz9RiQBrQoOblC8embPKP0bf+Zm5YoxJbpTKVddZfkYUL2YvxIqeX?=
 =?us-ascii?Q?zC4tERvQsYHNVOkd+A2Rh4nhJRjF1EZE/8L33fAyFQzWfSw0wSSTXbemb8ug?=
 =?us-ascii?Q?8S4XSucsW2L7qqw2KJ+oxZxIEdBPK1b136qhAbPWLGlKrcU3JeATz934/xgM?=
 =?us-ascii?Q?ewTvRgLdxtD01Ax7tV/y65qUCFp2fR2+6kLyBP2PO0aH2je7CBfISKcqfGjz?=
 =?us-ascii?Q?iX9o1wOiUM4/NABLdF3BQYIxUMnS6TOU2qAr3x2sHKspY4Os3/kwJi4bGqOI?=
 =?us-ascii?Q?Y9eN/8R/NJsNfZi16S+Lb6VbeqCAwMryYQV8BA0Lb0js1/r8LOK3rfB/jvZv?=
 =?us-ascii?Q?cI3aJCvvpgVkW5TQVs+Y6Ojx1x2l4sSL3Ly+a0/+Lvuji4Tj1/NODtj+ioMn?=
 =?us-ascii?Q?Vw3xrlwlhbkuS3BWN/xMku/o9u8cdZ5dELNWNvsqcLOzcw61A9Dbw04uoU9t?=
 =?us-ascii?Q?tnxse5rv3HZowbrV0WnrEYE4Ar7qH52HLC/amPHarXmE+w5MDhbwfmOe1MSz?=
 =?us-ascii?Q?70Vs8SWpN8A0Q0UEsiKeFra30fCy9SzBYIPoZ7ZKZSDlyDXGY3icsHPIK5eO?=
 =?us-ascii?Q?QwUWU01s/Bhx3+FJekDaH9CXRb7Uk35A+YiTdvBmr69tdwCicVmrpO0KGtE6?=
 =?us-ascii?Q?ylUMyjwEAwaLOlySFoBjOZko8FAFSSIS/aSrq/iVEO4Uuj3iHNTML/yT8V4B?=
 =?us-ascii?Q?I2l/ve1wPLU3qy2zspWF8U08LKz0//Z5p0vjE8Ou6jTrmtL0SmAUV72WnTP5?=
 =?us-ascii?Q?nGpnz6/BZR/0JRSjfGx4kUZgRyMozhru4CHHF52ZYS9gouXmbkH1EcMdAKi5?=
 =?us-ascii?Q?R1VDLdYITwn5Iq/haEu6FRGPpBT+bs8KCXAKHsPjhrv/96Ii0KzJIZ7zb/+l?=
 =?us-ascii?Q?LusIN8tc9+fnP/hnBZlpI1Ce2oNUSoQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ca316-a500-4b14-9a77-08df0832ee77
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 14:11:35.1620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsJMsuHt+42BQNNhqEvvYSitgmPE7ohF7jqJDd7nhGO6P7CigW96sOE4sY6aET1llVYxDLRBVudDEOMWPd+sYy42qNpcKc2Vv0wT8/I5Ls0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14950

Hi Krzysztof,

Thanks for the review.

> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Saturday, August 22, 2026 8:30 AM
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
> Subject: Re: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power
> domain definitions
>=20
> On 21/08/2026 17:03, Ayman Chaudhry wrote:
> > This patch adds power domain indices for the Renesas RZ/G2M v3.0
>=20
>=20
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submi
> tting-patches.rst#L94
>=20

Agreed, I will update the commit message.

> > (a.k.a. R8A774A3) SoC.
> >
> > Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> > ---
> >  include/dt-bindings/power/r8a774a3-sysc.h | 30
> > +++++++++++++++++++++++
>=20
> Filename must match compatible.
>=20

Agreed, I will rename the file.

The bindings specify the filename, should I add an exception for this platf=
orm?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D981a340540381532652731a500ba9df768bcef7d

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D61cada8da2f4c67026e41915f91673f045d4b18c

>=20
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 include/dt-bindings/power/r8a774a3-sysc.h
> >
> > diff --git a/include/dt-bindings/power/r8a774a3-sysc.h
> > b/include/dt-bindings/power/r8a774a3-sysc.h
> > new file mode 100644
> > index 000000000000..5694a422b771
> > --- /dev/null
> > +++ b/include/dt-bindings/power/r8a774a3-sysc.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * Copyright (C) 2026 Renesas Electronics Corp.
> > + */
> > +#ifndef __DT_BINDINGS_POWER_R8A774A3_SYSC_H__
> > +#define __DT_BINDINGS_POWER_R8A774A3_SYSC_H__
> > +
> > +/*
> > + * These power domain indices match the numbers of the interrupt bits
>=20
> No, that's not a binding then.
>=20
> Also, why is this sent separately from the binding?

The binding is already present in the kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D3eb434de00b39c843249e89cf151757410e8a6ad

>=20
> > + * representing the power areas in the various Interrupt Registers
> > + * (e.g. SYSCISR, Interrupt Status Register) */
> > +
> > +#define R8A774A3_PD_CA57_CPU0		 0
> > +#define R8A774A3_PD_CA57_CPU1		 1
> > +#define R8A774A3_PD_CA53_CPU0		 5
>=20
> No, value is 2. Or not a binding.

The values are pulled directly from the R8A774A3 hardware manual and
as a result are not sequential.

This is compliant with header files for similar devices, so if we were to c=
hange
the approach now it would probably make things more confusing for the
user and it would also require some special handling. Given that this is
compliant with the style for similar devices adopting the same bindings,
it's easy to understand as the numbers come straight from the HW manual,
I would actually prefer if we could stick with this numbering scheme if
possible.

Thank you again.

Kind Regards,
Ayman

>=20
> Best regards,
> Krzysztof
