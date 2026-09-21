Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0A1A6834;
	Mon, 21 Sep 2026 04:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789965500; cv=fail; b=FpC2PNN6uEp4jzylMyCd0l+FEZMWFbSyNATDNAUGKlpCW52BEaruEXa13iBscxg01kG1NTlFQIPZAMdRS4DV1Z10RtHTMKb9DD/EE+gYFoF0EIefRBer99STaXbvWBsOL+5qcqN9oyGDk79EXPszJBwygvgKIAEOWC+viGDp6Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789965500; c=relaxed/simple;
	bh=niAikodydVJb45yaXz7mY0+RAhumABM3bDimYLFDZAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GN1vyntDSLO0JVS+5RazPXcHglDBNv6mnD6UWHYwHAchNdwwvgHPJqyxB2coftNlOiUlefnh1+/Jbhohuxh++zWN6g5wAnvoBcH0G2R2rrGZ6kRSHJ+eK9/uLaOz+ggocUyFKKBiBH3eErjGlhHxQU9WjL0dzznpZqpaUly49mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ijYbvafO; arc=fail smtp.client-ip=52.101.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ijYbvafO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnYcsf2lgrznlxcsLw0rkMhEqlgHw7kIyWQ+mTV2giTOvvYDpB7XKHWJWhanpKjSInXjhGxjpUMJIgPRxbqKbHGkaaaH1RGBFZZr8PeBHYeuceVJakUMG5bzHdI1SoFhhMdzPc0kQUaxeBzJrj7I4sFzWwsAZPP7KS06WQkHdPU0sDrA+JV0VOv/plxWMNH8HZ+pIO1L7S1Z/55Mbasv4nj1sFwO0RjOk0NbgEJ/tz3gV3OqLoJJGD4eGKEOll7cUXkfqdKnFxTjVDiXIM3iOq287O2NvSTqv7wvn9S2QB8UkQAMyBf1q48n1doiz86ZW8goBKGexMp/ZDmqsP4vGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA61JdoreSmII/GYk1bfCSwlOcwSGRybZ8pwmWEOPLg=;
 b=UtJKP6Fg7e8eQ8xZDsIHEpX5xkyXvnSfO+F3TetfVQqlSGWqEDuNztJbBX6wM3/e0uCxHx60lO3fyuz+eiPan3xnwdDow1zYmN7tRIgfiSrW/Wgv7qI/mRK/yG/c31Di9449ijgzrVdef5OBBx5hJ639TO0wccpZuRmDIzG1mwbQxxvW+iDuMyjbhogkMFwKObeBn2NRYKTUZWflVmj1Hx0HcshBn0DfHUHM8HKczQuinbnkOu+fr1RKBMeoaoTUxjt1iYHboZTntqzygQ/elVOMtsnq001X4QGCDGzS6coL4V51P58Hn7fIqm++xgwSBHTJHUQRW/HMkt+rDCimEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA61JdoreSmII/GYk1bfCSwlOcwSGRybZ8pwmWEOPLg=;
 b=ijYbvafOnIRGjpP+PGz6G2GppnX6zod05nQfEDQ1hfCnEGeRD/549AbakmP0wNTCi/Al+MI+nQ3XaQmBH3psa8HN5wqHepNqxdQKV4ILhmxydU6XlSNzySzgA5X9gz7NWaS2KDx0xpBsGr7hBwv0Koy0nOdRwHULnBZH46qegW4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB12976.jpnprd01.prod.outlook.com (2603:1096:405:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 04:38:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 04:38:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU
 support
Thread-Topic: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU
 support
Thread-Index: AQHdR3+gbYQYz7FwNE+VCb83YQjWtbbXvvYAgACCoQCAACHcgIAAEk9w
Date: Mon, 21 Sep 2026 04:38:15 +0000
Message-ID:
 <TY3PR01MB11346BE84BCAE4AE09DF0D86F86842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
	<20260918150730.122056-5-biju.das.jz@bp.renesas.com>
	<178992596603.706584.10389874816454714845.b4-review@b4>
	<TY3PR01MB11346ED0D17722AB3821E3F4D86842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260921042809.4eb4b952@jic23-hlaptop>
In-Reply-To: <20260921042809.4eb4b952@jic23-hlaptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB12976:EE_
x-ms-office365-filtering-correlation-id: 4ab7576b-f45f-4e78-9bb8-08df179a26b9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|10063799003|56012099006|11063799006|4143699003|10067099003|3023799007;
x-microsoft-antispam-message-info:
 X4mZYGV+AQ02Z+ReGxZfk6PoTplcq3JhmhHYvtXDzDSJABTDnvWdoRpgUwT0LWWvOdT177Slk6WDW/OI9qSZvGDaHhqPAO0nJkzfFi3kyorUiDEakdPgRDDuz/FLaLGj+rEuIeWIVbVcqHiJcpQz4ZQPgcB331cUCsK5dtxcWAKIZ70MGimuTJCbSSfwtoSy2CAARk/TZGGE6zA8ZzM1rTlmJjaP//fTu2/QGwYQjMvaNB8FBI1WgPwfLcrdHnh1AM+DMkRFEoa9BMtJUrPzFoeBmesjfI0d1GvxXrwdeI56q4orAMeNOcYowPURGsemcr2Bqv1pqwde1I7s6dyE0j5+GhYn+lU+HOrdGm29y7UxGAYc0r0NDoAnjVImLwS6fi0A3nac1eVjhtiRJTM9UfnHxS+3Cy8+Lz7Fpn6vJK8+g84wZaRPlfBMf5v40rcD2ahXPmBS0q7TgVKdabVAWQ9n+DWbiCrXI2kyNbfxugXJnmUj5WZiRPAuwEc2Qewcfkh6jS7lCLm/zzuVESt4bwiRd5I1K9Ag9AFcOuRs8xoSYP+ptng25rly5GcLYMglb+4M+LIcsuQ25er6qSXfxB6deUorhQuhfE/Hl55Zz8kfwa+VWwdr1jCgdS2dj9HeaQWbdG8RXEbICl1ph7ybZV84fbjKLrhuYcIDoYLu0+B+B4FfCpGUgakkYPeLTCwWkzZNIpbQJ0Jj2Xvk6nOeNsjNHsXVQnAqhkeEFo7pbb4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(10063799003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h/by+EB85E9wOoVCp2r8fIX5wBnj4PJqOgMtomuvLW6T1DAKZJf/fkvnxvX4?=
 =?us-ascii?Q?VNfmTH7d7LGTkfVEA+yGx8evhRT4bqL93Y/wLT8eb5e+feDxs0b1yyGSOUy/?=
 =?us-ascii?Q?ihx//3e8yfA3xjAOXjFbTPhYEMpiZz3LlI56bCnvr7SrC/6gTe8pHDtMrsl1?=
 =?us-ascii?Q?ybztyv07ivvklh1QFLNyPDQhGWHg13JZDFOzrEKz4UerCVpN1pJDnGFVHHuo?=
 =?us-ascii?Q?6hDbFv1pQM35Dl4oUFrkPI8YlVpcMrQ6APkL33oUYGMNJsOhI0FKpbizvyt5?=
 =?us-ascii?Q?YKLqRxr1+O5mKdWVxGrshNsRXBidOtefcmWNJHFtOx8HK5G5XIMoB3+P4GdF?=
 =?us-ascii?Q?VdoFVlElv3ObBmIKkU6CGtfZvE1Q8zd7scNoYu5MyOrahKfN/uwwpmmigRhu?=
 =?us-ascii?Q?MSdDwaKj2H2vp9wF9hkUExae3uiVAmebAXUoAp8vsA2zE0sSk8GbP+u02lJ4?=
 =?us-ascii?Q?9ICUbvyGZ0cc0omvNOmj4KVumbPl/r4T/K+XaitdWyUJHQEvl/kCMKPE0cY7?=
 =?us-ascii?Q?lpOnqbfpq6yjxa1ZgXkAOpUQuKyYuCfFadXZ+wYSBkpCzZb8rGVl5f3JPa0k?=
 =?us-ascii?Q?T+vcbcfOFE7hH6LJL1dfS470yrwbpqH52gf3N/ELKz69KoEeEOrPLYDs0++J?=
 =?us-ascii?Q?akU2UsnW67YL+hrn+rdBIRv8DsSBn3y8+/NKFMjVL/88sd/++U9wMp27C85Q?=
 =?us-ascii?Q?M3TKhur3xdV5pyt+ZPjYyNMUGYkeDFBWTTS+eWJferlHQJn6I6lpSpIh9M8J?=
 =?us-ascii?Q?kTKjFSVMVp38iNhOPQm+kX5pfaX+MRTK6M+eXfo7os530bextDBoWkeXRV7d?=
 =?us-ascii?Q?prJSlG8KRhKr8SCS10uZds/wKt+dD/PLrTis9opzlrjA6DnYhIMWuqVVvkpq?=
 =?us-ascii?Q?ZLqANaiqnkfBL6lAMBS0/IysVQvWyBzj5WFAVXyEtVFjQu+M4gBhp6GRV7y9?=
 =?us-ascii?Q?Mgcb8oknqKqfrxjiwfDOGQzPjpeycILifze0OrxJr6omuazUqUOzxxCLfX1q?=
 =?us-ascii?Q?gE5bs6ypbX0KOj5EZ/XFmFxSEXLWN0l+PmdO0J+LJugE3CcSsfwldyTP/RW7?=
 =?us-ascii?Q?FbA/njIutLrXdaslolvIs3im4jWUJ9T8GlugMOHvXX3gNW9VU9xPczlEyVW8?=
 =?us-ascii?Q?zE25C6J3MPnvBNaOvY9a6vwNME7PrefQh/vCoJqTJdaGY2T+idbEWtCGr3nJ?=
 =?us-ascii?Q?PaJOehfcXjBD4lkLmQx44Q1YnNYxGEqlgXAeLsfo0B6LmFM08TApaLVCMCqX?=
 =?us-ascii?Q?1qteCuL4EYPelrzf4DxJy2pc0ioaqHJtADlLrWIKKzynIVJuOAozve8MLZvP?=
 =?us-ascii?Q?Q6QPinlPS/N34bWQJ6DhPLHAPlqasZlqcUBY28NvM2RBvr4JR76jfoaT5rM2?=
 =?us-ascii?Q?k2gzjUK/ZjYsVOOvSGjJumAUbDCc1Ns50TW1Um2bRH7MHVJs14maT+bW0H6b?=
 =?us-ascii?Q?OdcORd/MdWN4lg+ZlRfkHRE1FxulOLvmlibRH4VY7yXj/BQ9dw3sZSoCoMRl?=
 =?us-ascii?Q?rri7/WFxRiKtc7gI2LsThMCHPc10GdH8tsr3QFsESg4UAf4xGoSPnlkKKkGu?=
 =?us-ascii?Q?h59Pg2zN20dR7kBQTcFIJNF7+AYyYM6BOn8MMVGIOgL7iKEBfBG+HpsBx+8L?=
 =?us-ascii?Q?esxzAC6nJOhBU21O2x7RQhEG+HvaqhrHIKdctPO/fsqVvBCa4DMwxVWIdHA9?=
 =?us-ascii?Q?B5r+HRx99s4L28/3XLV6qAuRSvF6We9KutWHVQETH3xcElK3IyWtmVhXT92f?=
 =?us-ascii?Q?KGQ524j4Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab7576b-f45f-4e78-9bb8-08df179a26b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 04:38:15.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjzIjZmRkrQKdxXirGmkinSHVPyFQBoElh8tyPaDiB5rGSO4xPHHQoraNJbJ7IJ9tivfhZGp3u2fBvmJXgLeO7bALY1Mnr7HVb9YQgDw7g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12976

Hi Jonathan Cameron,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 21 September 2026 04:28
> Subject: Re: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU=
 support
>=20
> On Mon, 21 Sep 2026 01:44:20 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Hi Jonathan,
> >
> > Thanks for the feedback.
> >
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: 20 September 2026 18:39
> > > Subject: Re: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add
> > > RZ/G3L TSU support
> > >
> > > > Add a conditional schema constraint so that '#io-channel-cells' is
> > > > required when the compatible string is "renesas,r9a08g045-adc".
> > > >
> > > > This is required because the R9A08G045 ADC serves as an IIO
> > > > provider, allowing external hardware consumer nodes (such as the
> > > > TSU) to reference its individual channels. The '#io-channel-cells'
> > > > property must be present so consumers can correctly specify the cha=
nnel index in their 'io-
> channels'
> > > > phandle property.
> > > >
> > > > Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu:
> > > > Document the TSU unit")
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > I think perhaps the description should include why this only applies
> > > to this part , and not more generally but otherwise this is fine by
> > > me.  The connection would be more obvious if it were the 046 part tha=
t you were specifying this for
> given that only has the one channel.
> >
> > I guess there is a copy paste issue as you commented on TSU driver
> > patch
> > ("thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support) instead of
> > ("dt-bindings: iio: adc: renesas,rzg2l-adc: Make '#io-channel-cells' re=
quired for R9A08G045")??
> >
> > RZ/G3S ADC has total 9 channels out of which channel 8 is 'io-channels'=
 provider.
> > I will add this information in commit message to make it clear.
> So if only one channel is used as io-channels provider, the device sounds=
 pretty useful without that.
> Hence my question on whether it should be 'required'.

I agree, it is not required as majority channels on RZ/G3S SoC(ADC0..ADC7) =
are not
providers. I will drop this patch.

Cheers,
Biju
