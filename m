Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716254A21;
	Mon, 13 Apr 2026 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058375; cv=fail; b=DouKpWM9VhZOSJwwNME4xOr10LIHV8cyt/sdH/vHLxH8GWVwfXX3Ke4WuWMHWhjbNRZ4B0cRAHU5UhGezstswxpdzWSrtmCz9BklrXP04OHGJzMEoj0+zJ2wov8M/Sz9XO4fKHblqqvNBs+4shYR8Coth8PVYW/2DTlwCrNQJKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058375; c=relaxed/simple;
	bh=DjIpIGyxxwlFss1n5rVZMFkoyyMNAaP8Ge39Dcnlvrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eW+e50QBu7LCSG62avVbopdBgw33Z9E4mVhUz/rytVbpyvPALb89bsITHI89Pu4vqBEx0jGthQo1tqoY2NHP03uBDHASNv/2wrVzmn/ZpimPB14mdZdkiwclC/WieW0lh7tIUe39UO3IkrXK8RcKr/WRz6Rt+5y/ukgN+EvKcdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QokCvjGi; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QokCvjGi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUXTt0uDwQCrSLj1F9BCUduw6tLNrIm5z7KCD5vLvXwEcn4hbJ1Aj6Bd1IEDtRjCrli4S0b+vWTDi78WHFb5tSJD2Y2ojTdloLVeGiZlxjHo4QCDue7x0AyUkVhhTmQrDfdCfBy50kHsydyL1DduyG7qU+aPB2nBubesJQR9tNKpbYyy+QQupKir8fIbgUy/YUI+g10Hd1zyBvxcyKTqzN63ET3BFDiqe9bTadeOn/hm9lEarnj33Llx6wKB76xmbCMN51X/phHZ1NLv+mOkjyHUuYpGJI1xnBd3km90mPYBw3btOhNei+JetH9yJT1LMNYPBVK1rnjrQAFj9YF6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjIpIGyxxwlFss1n5rVZMFkoyyMNAaP8Ge39Dcnlvrc=;
 b=CMVdYso/bT7SR4VP1psFq9qrIUv7/lVSCKy7a6oPMyZ21tZ1gTBu3ww6oEkYR8tek28giPdyYdtO2/sf+g7hKkAct2iCG9c1DBVAvvS0VLRTAXswzUBOy6U8rTiN6gqoG8AdCDbUzekNS3ltqazM4aJmjkWpDMjrL0sfcl8GhHE5GO2uTxXlk/+E3Iag8KqixuCSmIcL44yhiqQFleuQtwjg6hGfd9ri14FlEkpflbzsigxpTJzVZM+tlBhKgKCRcGOlGawNfc5PiNb2pNIbaFhu3MWKnq6Manjn3l6+l38T1Thvj2pQVJ5Sff6GY0ju1FYT5PEXcBktwIvqsYPjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjIpIGyxxwlFss1n5rVZMFkoyyMNAaP8Ge39Dcnlvrc=;
 b=QokCvjGiVoJKc4g3V3b6n96XhRMRCCKOKf5tSypiAVHUCOMKkz02MkHt4OXBpa4Ad9+o10j+SjamWGNCM81inGFv3qJYb2zGGikiYXgGI4XCDFayXclL3Vg4wXCnyE6dYCQQpe5j99QJ7QsvBlBvRV+EKp3BNFGWLYkUa2+6H9aBZHqTmb1/EKrtYD0ViII/FgHEixNeoj6uVeUGyJA5pYzsk7Emr8hQtxAA9TXrxQe+9ON7JpFveHTU7Kw2Zz3AYc09w05tQa1/rrulhVAOpqkomBHEDhHc0bdDjcBaybGevyatmiV9O4YWGwyCzbzXFXXfmKh0nXaTyH4Igz+mAw==
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:32:50 +0000
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457]) by AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:32:50 +0000
From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xuegang Liu <xuegang.liu@nxp.com>, Jindong
 Yue <jindong.yue@nxp.com>
Subject: RE: [PATCH] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Thread-Topic: [PATCH] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Thread-Index: AQHcyMxR5yqeo97CDU+xsz/4jCXMMLXan8SAgAGzW3CAAAWmAIAAIyag
Date: Mon, 13 Apr 2026 05:32:50 +0000
Message-ID:
 <AMBPR04MB12334697C190CAE090C7FBE36EB242@AMBPR04MB12334.eurprd04.prod.outlook.com>
References: <20260410092735.1065294-1-zhipeng.wang_1@nxp.com>
 <adrwO8HdZ7d85mEy@lizhi-Precision-Tower-5810>
 <AS8PR04MB84204966B358280D2A89F348EB242@AS8PR04MB8420.eurprd04.prod.outlook.com>
 <adxiLObZ5gp2uQ4t@lizhi-Precision-Tower-5810>
In-Reply-To: <adxiLObZ5gp2uQ4t@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12334:EE_|MI3PR04MB12440:EE_
x-ms-office365-filtering-correlation-id: e6e75982-13d2-4402-a8f8-08de991e1aad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 QJ9xA/bi/TIQj/da9lMW3NsfpX3EAVwkL+h1gziisivaQbR0vWl2USp8pfxUSttOsbbkBifP6xV2Sn93n8zBEzDZ2pFH4ij11ArfXs+eNkLZLgoST8JPa9UyIIzVQGO/ht7KXyL20dP88eG6CHcjp9HTL0OvYSbZ7KM0z4cTTh4fIYr7kHzB6+zjDJRXSygLZ+bYjyAkxj77q3C1ymCTXySmwwXa6LCbL0PX2fjkQOxQoNFhr1mP2QDEOoI53NX77S8hLqworz+GijugKlM5cGl5FgSFNDdoypOR60VjyhEXYuAinOPrFhr6yyKi3tGx8OmKGVYBr/1wj6q9CDH8IQo7sSUeA6/5Kx5Gsyjj8zDXvS2P0gi9+GDnJXe0XIomAOeezw61NhQY0ewOTYrPAd/0gIB47sc1qdzBq82aKt7m7suNckZYMtP6m4zWfkaLiCNW1nwws7P19VfZyNAVCMq3BEWlzxioD+JjSyFaFbzYdmwFpeKJrel/4Rmzy7YaFdcfgylT3tzPQ05wmpj91EfJso9x6pVsm4sR7qM3/UmtRqriT4L0ZbdkhAjKfjR5WNhI6ZAfnVbxtV2Qc8XP6JIdubgz7uesXTIB2n/R8zPXTpnn0H+LD/WV+0U4zJ7+GcnLV7tVcbwaZFjibsF+HvSrhsrFSNL/m+VqwZ8y8SfYhNMSCbdPQ05qa4XDQ3nTPnhda6s25IKirXyjSXCZ1+rmPSP3v/e8BA2fh+wkGHEvKPUPtYonKKdfSDsTxJwX30Z4p6i5MVo0udJoJqS/S24nIlEUFTMgmLTKV47jBmk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JfXMfCJQ9NMXzbQCMsJm/BBZi8J3lmpJz+AkXxClV2KhYgZrCxObanlT8vuH?=
 =?us-ascii?Q?SN+3H4RItJO1g7q40z8U7Q1fR/zXYHy0+96xzEh92vmEUb0I0M2bVciVrP76?=
 =?us-ascii?Q?ps5vLHlWf2YDRkgcBx4u97Sw048kXwrEtIIGHh10lXjqS40Q9wBJL/PrVw15?=
 =?us-ascii?Q?/ZWoa5gevfRml3qgSa3vTGK24dpqNV2HrmigSYEdltK3N4sT+Uh54pV6Q7Z4?=
 =?us-ascii?Q?o23PI0BcoimdIgTRubOc3PphoyDuaDtS5Z0eU0VDjDapCcKfwZIcNhozw2cB?=
 =?us-ascii?Q?UX6qpCOWohxfqnTvo5ey4kDVuYoKCgIQCfosHDhhV2z+1faWhyTJI+fPuYmd?=
 =?us-ascii?Q?G6QnJcG8L00v7z8mbKbPD2BtWlHNaEuBaSzFKWn/RIUCLcsV29WCWtyx1Sih?=
 =?us-ascii?Q?YQ/wFYNNODrsCnzs/ovG5VUpl8Tq+tbniMeIL4TvBb31fQDrlLPb8HA3fGQS?=
 =?us-ascii?Q?deAWUXZVmxw4yFL4pRsgrCO8zQC6jhuweFDQPBxK1rm4xwGb5GcNkWcfGuGq?=
 =?us-ascii?Q?T4r/2pStjB54H4bdfymneDgGgjx9PYQLr25w2D+b7L02B2UDvO7twtVjLk68?=
 =?us-ascii?Q?LiQbtyrvZe0VwJyPxRHNQWkC45ShzECeUF5OslSFTB7JV82N8ruWMpiL09Up?=
 =?us-ascii?Q?VzJRJnzzFUN3G8cn21piu7nx54cnG39n+ofarojtZ9mKbJ0BbqG8wBO9xWnE?=
 =?us-ascii?Q?B2exLFc8lVvWmI0UpCr2eXsh7auGDZSqCQl3DQDaoVPWlry1KyGoaqCnPbu8?=
 =?us-ascii?Q?bP0El0XFyWOgJ39oP4VzEp84RUEKJIqlVbFF+DjzA0u3nyhBMK90yFiG4Utk?=
 =?us-ascii?Q?P9XNNKIB1jp9fg2cqXWS5XHup4al61ubYV3nEQ7tE9Ub3qx9sZZOVEVR6OVp?=
 =?us-ascii?Q?fTJPy54FWBmnthv1Hr6vFW6hZ7jipvyHLvYffJB4uDEUBFr8wxPwykKEw28Q?=
 =?us-ascii?Q?YHY16VpFOOHn5MTbTL1lTthxiZAyDRTuXAJZVKeL71dhTUOkcm/8HdWiWB5Y?=
 =?us-ascii?Q?tF3Aw2ym/ZbVoBBqycp1ECL1nmOPjiSr8oMk4C0oqt1icSvkMFoWLvpOYi6q?=
 =?us-ascii?Q?2Y0h82iXyJGQbdWBADbHwnbe5PWqvCWLyOhZG3N6Yt2zcQ/W/jHzG9Y7AaOc?=
 =?us-ascii?Q?YPUia37TNCLFVo6uaY7tW4A6lcjkzzBrT6zYo+G83B2JmO3I4FLZkTWhtNK9?=
 =?us-ascii?Q?R8N/aOQSeN4MTx7mI7CuYqLgu4H6Bc9MOKjna0TaYezSkdd6W/CntZfXabe/?=
 =?us-ascii?Q?3zLGsh5vNOGAngpF3aqTXJPZnr/EK6yMocfQhALPtZur7lVqpn+thTWhQFGC?=
 =?us-ascii?Q?jZtJKRIa+yN4Ewc9Bl73a3mTXhHsxO/k7vleqgvF7bAqP37khXTi/EwLTGr4?=
 =?us-ascii?Q?Zc8xmyeAPPiaPZdC9wW+CHXgoZ5ntKNEWnf2t/4E78wVBx4heiLHgZnm6seX?=
 =?us-ascii?Q?Zpdz8TISba7kIks2Ne2wEe/DjsHTxaPZ8kqP5Ayd/fbjXHXid3VXWifqqMpO?=
 =?us-ascii?Q?JW8lyQvLitnJtXBEDoT+h2SBfK5j0waDfz4jPtSOGl32GMzJKigxIiTEniHi?=
 =?us-ascii?Q?eqX84cZkzbJZ3KJ1PEM4hV/QHvlWuir95pdzohdiRIujLSp7Dq8BkH0MVGmt?=
 =?us-ascii?Q?LIblFtxBRC2bCrO+9JeQNarjuuAUAmkdg0eXgBolI8rP2zRibRwQ634YyS69?=
 =?us-ascii?Q?D6xrCwc+OorvaQInSRSObToxB6Oo9nfHz8kZryiQD/gce+jMWhpH2ZUnvf9t?=
 =?us-ascii?Q?K0rP+FUWGw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e75982-13d2-4402-a8f8-08de991e1aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:32:50.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBLm1Cm3CvINn3pszxwHrvUiFqTNNrcbrrLZNpVxewA/cHqFBwd5WwjjXbnjhFURHiqF/Mn/nk4Y/3kNCNwnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440

> On Mon, Apr 13, 2026 at 03:08:20AM +0000, Zhipeng Wang wrote:
> > > On Fri, Apr 10, 2026 at 06:27:35PM +0900, Zhipeng Wang wrote:
> > > > Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate to
> > > > allow building as loadable modules.
> > > >
> > > > Add prompt strings to make these options visible and configurable
> > > > in menuconfig, keeping them enabled by default on appropriate
> platforms.
> > > >
> > > > Also remove the IMX_GPCV2_PM_DOMAINS dependency from
> > > IMX9_BLK_CTRL
> > > > since i.MX93 doesn't use GPCv2 power domains.
> > >
> > > Does it cause build failure at GPCv2 platform? Or previous
> > > dependency actually wrong.
> > >
> > > Frank
> >
> > Hi Frank,
> >
> > The previous dependency was actually wrong. Here's why:
> >
> > i.MX93 uses a different power domain architecture compared to i.MX8M
> series:
> >
> > - i.MX8M uses GPCv2 (General Power Controller v2) for power domain
> > management
> > - i.MX93 uses BLK_CTRL directly without GPCv2.
> >
> > The IMXGPCV2PMDOMAINS dependency was likely copied from
> IMX8MBLKCTRL
> > configuration when IMX9BLKCTRL was initially added, but it was
> > incorrect from the beginning since i.MX93 hardware doesn't have GPCv2 a=
t
> all.
>=20
> Okay, please add such information into commit message. Some
>=20
> Frank
Hi Frank,

Thanks! I've added the detailed explanation to the commit message and=20
sent v2.

Best regards,
Zhipeng
