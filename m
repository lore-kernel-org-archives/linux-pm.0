Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04736367B94;
	Mon, 24 Aug 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583794; cv=fail; b=MvKIK0MQ+dQLSjUc8MK5K+zVo1B2qDh7GDpOOKfxDqF9xrA9vFQm3ZKOQMQIhGJdsgb2y61ZX0CLO9BFKEh9zKNebBWyk4XXMwZmvwQgfz0VhjlGT4KZI+lUjQJn2nQvlubTv4AdROaw7MDPNMDrnU4gOB7xYEvAaiiYzNzt53s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583794; c=relaxed/simple;
	bh=/N8sQ6ghzRppE5z6iJOJMwqQfM+3Uam/Noagvp5EDjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UZJ08/CoNr/JHkYq6j9hSjzlfUYRLmW7B/pFkpLjqA+pbIB/3mUEN2J/wfHogW2Q5UxUOmMnMOFd4JzcbgGnzIzNpatN8cmsWnWQfDoPda5f/VmO/mcvZb28/m/qS7ywyVIL1g9mp1uGvVKcz8Ot0kabOngUzUpHvlEk542bJbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JWol1ldU; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JWol1ldU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNAdFJVbiv8UUeIAwJ5FWUk6s/oNZjZAKUFtIqM2TW5/WIAsGahAWRVOwZ8BZ8PjWmXO10fgLQJQ38amELp8Ai9exwaGI+o03fpWrll2mEk+X2yR3kXm+B4vFeT9qeS9IQaV1WWICht7dHcAudZmAYWVMlTrNuWOT5tArVDki6oBi3qyOFJBnKkbyg9n3UT+kWX/h1Kj0q5VecnbjXrJo+wByOkkvZJ8ZWSKCqLat5FZ+mdy+tvzwLdH/Y2Obe5jo5pgGtN7oFShKL3HxK272d1jsiTwxfDNm44H1qXV3pqmpYPUHSY8Pb/u+fTtxCAjkVGzDb3STcLR1gurNfIHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N8sQ6ghzRppE5z6iJOJMwqQfM+3Uam/Noagvp5EDjk=;
 b=PmrUju58lu09yYNJA8VG1HC5Dhe+vmxiO+TgK4DysoxVuTaseJ/+5OqYZfVlC1o/EpzUwbwkDKr4Ce01fx9Kzi7N3558gDVgSUF4Xys9bcZqN87bvfpLx9phMviT/f8vXJA6F8YEeJEzeB/kFt15DnxcacDFmfX7TyPEt6DFJK9TblltrJ1tgXTeVEodTZ6LDZ9PTX//vqNgtxdzu8yIldCk6rk1mriVPt6R86yj9k8YFh1VM8ywFgEFx332eMkqgc08dDkF5wgiBz+sOdUY60V4FjQxK9Xoi1FE5TYZsdbeKPGY+G0xVnCGkWJGcx8gLl/QFCWqoTIyAO3KxfDR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N8sQ6ghzRppE5z6iJOJMwqQfM+3Uam/Noagvp5EDjk=;
 b=JWol1ldUOCWNiXXmYh6HQfqSUP73zY2gaWQe9TFuNLBKGAkGY6bqShbEFEXS2EFJmFDodIXjuITNr4TnYd9LFsIOkc28UA9/W0pBZwvWGsLHMqHxhumeo7KjXm5lQMVUTPRy1z2XzizNzsPAlVFCHny3N3UX+rLt0pbjc6bdWgmf/nXTEFV6HUl6YKfrs9A4DXetMstzehc2G8rf220bhkDlnoijKdDG2/jFaIuGuRibWjXScRUyEMhOkEQd3LLHhvywvixpG6ivFDxDpadsj0gB/TBnHslXS9O5ORT3qsRIZ2hsLd/zn+jj0UhPX84TbdArdTvJKmlKDX2NI9ST5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11697.eurprd04.prod.outlook.com (2603:10a6:800:300::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:03:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:03:06 +0000
Date: Mon, 24 Aug 2026 10:02:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8qm-ss-conn: Add USB HSIC related
 nodes
Message-ID: <aoxdHbczp4c68q6W@SMW015318>
References: <20260821-add-apalis-imx8-usbhsic-v1-0-fb93d73ead44@toradex.com>
 <20260821-add-apalis-imx8-usbhsic-v1-1-fb93d73ead44@toradex.com>
 <aohtVk57YIWkj05I@SMW015318>
 <qyrzrmrvymwhoziwf3we4fxwb4nfyhb3s7hiuqauzoco52auns@7rihmyhkti2v>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qyrzrmrvymwhoziwf3we4fxwb4nfyhb3s7hiuqauzoco52auns@7rihmyhkti2v>
X-ClientProxiedBy: PH7PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:510:174::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11697:EE_
X-MS-Office365-Filtering-Correlation-Id: c769ec81-631a-48a9-ceba-08df01f0cd31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|366016|1800799024|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UyUCPzfPmqkhOWH0/LX2pT2oSPpu73iqCOOQSFrXbFJVF0WVZKaPleoX/JxkkdkYG1qH9D7sgk7uh4R4C7bhdnw7x8QdzjFJWEdZeAGQfHu6aeJnGX0SYj1QI23g0BkeaI3WJ+KRJ7N+ip19Umppg3wAS2M3+EBk7ojZD+gwUfIFfLJwRmoR6j79398CfriLTH5VKdNctYvzht9rtCgHCw8khvJYtTepAqM2jTf1t7zkANNuJT1l5y626PtQpIJ/3HC0izhuT/oO3/S1pWImJQV+K6ArHpQt41k6C4XOSPYrlyWH0rtAFM/FJyNZqiEycJuNpVm1R8H7N1mk8JxOcRQsMfygplEIaDub262uAlQWBGZ6uiSivsJ+ATP1JiqkF1zv9gFc4G91st+ZB6yRlVO9UbFe4J+8kki5RszB74tF/FyldRu6ILJEQy40rD+aAGttq7iiYaVX4QIvecqg2y37zut3KEjIMpXJ0VLroVR8mUyzujimhp4cKSw3e143/XGd+44O8IxsVE64l6/zJuamI9yFdKXWScRCOILqTN1/zubJkYwgrsfB0VxCIlA/PjY/4JruRkMv/OrZQICdbTK2+iAjiM6SunoAQfXnlH2YqSJtwp1zpeUIPXQp5asMqnCtc+k5b/BuC1Il8T3Jh851uoj6S3LGLiI5ht6gXN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q61o9DhKE2v1zIl2ejz3pw9il2Wl8AE+FSdRMgIAxGom4Qt3Lgqt1HVEHQBG?=
 =?us-ascii?Q?gc6CoYmFkE2kJg/YZos7B0nEwu9fAQxKS1V1ZRUl7v8CTVPi+ZIxlqrKpY9P?=
 =?us-ascii?Q?7lOeD/19bjkbsCoGQVRMR5nl7qBikDzIxESgjDxzefJDVCM/45BL2x9pH7KG?=
 =?us-ascii?Q?ZiGHxVA18mz4AZlUAZHgRPTnqFYO3bVtiF9rVH4qSilnZ4jMT87SMjEJx1i4?=
 =?us-ascii?Q?TNxqi1n1E1X9J1VrO1zlZbRGOgqA7TMLdBHrwwZZ+MvveGW5tRE5DE2rcaVy?=
 =?us-ascii?Q?Okb3L2XVKmfQCZlO51SUWnJpUJRgUAhS5Gh7sT3+91Le38BLvf2q4d5xGVbl?=
 =?us-ascii?Q?RP4RoCQbtu5OphDzeDXXoOCFu00mILuYIYCgb+ALvoxVVTMWt9UBBjgR6F0K?=
 =?us-ascii?Q?4EPorPSetjnRAJUkDNTJDfdLj7LhbotsjAJrXXZCH2MTTfTNneE60r3bgWI6?=
 =?us-ascii?Q?561iJcQYt47IKBZ5Ub7mwTQvQGg2Ozlm2DNo+NPhjlFjhO1o2YPYOe0duY8Y?=
 =?us-ascii?Q?rit9Y3uAWrCs9fxqGeuN4rrOpLKa+5GmFkjSjApAuumy2dAmNT+utBWJZpNZ?=
 =?us-ascii?Q?24VyPGUYjl6StNjCb8R15NKH/em0FgwQa3WIPG4E1R+HAo0SHAs3i1GiwO62?=
 =?us-ascii?Q?oET7OBiASmRdzOB/3WQc6yVZpQIutc98MIpIv5clPRE+g/kxhN8tpFfVuAkf?=
 =?us-ascii?Q?SbTi76757EotJnavzUe7X4IGeZKX/nL/1yjPwVBgM2yV+f9oxfiMkaXkrhSA?=
 =?us-ascii?Q?qxOLwU+HWGSdI46p4IXiSIDBPJVhBT0EsDni6IXerLTsWrqkyIn051To/Gxt?=
 =?us-ascii?Q?FnTrSdpC0Pn4ueueXu+dOJdVYxeyoM3g24bDxPkZHZVBibc4O86FbRnEbeYO?=
 =?us-ascii?Q?YX3hTQLDkhpfJRbb5iLYiSDdxUKq7YLnLNWKtnbB0PfKBKMNT/Ouy3z9KJ5+?=
 =?us-ascii?Q?MBw3Zi+w7RW6boSnbjVVYUH9344Af7fLmpUdePMiM8t53Fxmt0W8eYhlW1Le?=
 =?us-ascii?Q?snTDBg/gGyYME8LJMRel5EYAST9/CbddYWp9YcceoG8YM8k+EHF3HijmA4dg?=
 =?us-ascii?Q?EZix8DazIKDBPb9MJ/jMYNCE17Xz4LJ/5FnUo+IHSLVd+Etf4EtjhC3Sh6Fi?=
 =?us-ascii?Q?8B63Zu2OjnwWNpVpTRgox3BXBfLQ/uqpNjar4mdbr5bJOq4ujaxTrEjipSg7?=
 =?us-ascii?Q?BpjgkKZaua0hOlXpzcmW+QOcloA+g3nTpqEpNmLniBXdU7ewibK9bROzgaRk?=
 =?us-ascii?Q?Ca8zQSxY/Cx6nrWxIsh6FPkkrC4LKxG+qLxJtp8Y1d5NAb2n1KsDQFAcV3TT?=
 =?us-ascii?Q?Kf3d7F1Iyfu6P+pSk2WVp0L8lV0JdncxQ9gnnLVs8Wp5TEse0xS9Vsn6/42f?=
 =?us-ascii?Q?B3OPNJRPS4EeuCzZQhRQOdW0Sx67pQWymRumndv1N//eH8kqX5qtYsyRFtqh?=
 =?us-ascii?Q?mdh7EPleLQcjpDE/gS5kXfxFrDACvAjNRBjFIH0ox2RGF+T/mEYjXB5jZnh0?=
 =?us-ascii?Q?w5s/jT9IBAs65xqwAYTW9FLQvA/7An933O6sLgeQSgxBeQ9fiWWFZxyXum6P?=
 =?us-ascii?Q?YHEn3svQVQQalJmdxNvxK1ht6izcBkl+RHbyDgXYnMTP77YoOyxtwTm9mC20?=
 =?us-ascii?Q?sZh6P6UwO/kIMu96fE4EQ1lJEF3l1MgQaCfzEAgiIZffvb5ryTXmdu3i6e1w?=
 =?us-ascii?Q?s8xDeBH+nFPQoemm1+Yg2C/vKGdoyfZpn27b+YyHzHvtp8FeKhYuUbfmmEEg?=
 =?us-ascii?Q?ZQFcz1aTqQrAp6rWZy1cZwBxCrQezr7z6PNy/mOI5LasK/ayloX1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c769ec81-631a-48a9-ceba-08df01f0cd31
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:03:05.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7+kfsX55VBO+HnqJFTd7RX6u9S6tBViCw+66naMztsj7syP4BK/0SRNWmVprqpPwcYA/QrGIMc1F/UMJ+NL2sG6H/S4H0x0eARH95xFrkl79au/MQsocOqCQFn8seXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11697

On Mon, Aug 24, 2026 at 09:19:58AM +0200, Franz Schnyder wrote:
> On Fri, Aug 21, 2026 at 10:23:02AM -0500, Frank Li wrote:
> > On Fri, Aug 21, 2026 at 04:58:57PM +0200, Franz Schnyder wrote:
> > > From: Franz Schnyder <franz.schnyder@toradex.com>
> > >
> > > Add the required nodes to support the iMX8QM/QP USB HSIC host controller.
> > >
> > > Keep the HSIC host node in the QM/QP specific dtsi to not conflict with
> > > the address used by usbotg2 on the iMX8DXL variant.
> > >
> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > > ---
> >
> > I already post similar patch at
> >
> > https://lore.kernel.org/imx/20260720212401.C2BD31F000E9@smtp.kernel.org/
> >
> > Frank
>
> Hi Frank,
>
> I somehow missed that imx/dt64-intend branch.
> Do you want a V2 with only the changes for Apalis?
> Or will you just drop this imx8qm-ss-conn patch from the series?

I can handle it when apply.

Frank
>
> Franz
