Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF67342CB3;
	Fri, 21 Aug 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324976; cv=fail; b=rtNSFwL/BOb+lltd3nu8+3UaFrJzbsIcexKb+uURLv9cqjcFO3PWn9wcVOQAHrA6xqVDY/MbJ9UAZEQlIRQeSelGQHSEIWy1+CT0hFvyarL655b/Bu5R5HYIZm1RTCePGMB4Ste3xpECT1ETa7QdrSd8ByN0Z5SNY3CC9u6TR8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324976; c=relaxed/simple;
	bh=vvXd+36fnUpUrJKqPx/Gy7SCTl+XVQT2V48Jc6CFxAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nwKUc111pczXEWLmgVu8xafVUqk4euwbt3ePblsNsLY/HVwJQncrtnIEZwHF5UckXthy+lxWd0K3ku2Ht40SdcFQVi8ZOOBzSKv9qcQT2dPuTLL+wtG1GMThpv50cIsUV95sgCyox3QB/Qb6Lutw5BTlVsJ+GT9hGN0DL8jTy3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SfmqDlJE; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SfmqDlJE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBWdnuvlDeYpG4NrUVlGRoZPofTDx1dCohczhnr9hSUOdYQT3sY61SeJ5Ss/tmkD9JSVUftnkhOHU04YNhoVraxyLp40+rOBox407WBW3slFyyStksZxgZb+qHwq3Yqgtv1fWGRzNA6fxK78nuSn7iW3a7PV/7I2IxWz1l8SFwPIT32aMX4POObiVRSojzbAHZLA+wpZLGs+K4iTz69olIOyfhkb6crkeAXTzMUtvU/ZV954COvFVTWJvq9Arwq/t8qmcFQkig4IgAFSlPWa3Dqp78AclG9iNfcw1Xa8xJ+Dw+M274eQwFTu6Kd6KtIgwv32lBZ9DwZusHOT1o+hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usC3DNBBIj4TQugu5d3XwlmyqLcAb1e/M5i7z3Gh1qo=;
 b=jGa6jiT5mbyl8s13xzuwg7eAGJ9NDIdlLVERnxs/U7F0R9nnE6shg81MkaA8YGX1vcckySECVxV948Di5b/TONFMSjOdl4p3vA2iwkzRreRjaQSiD8SNLnkcy32yAef/YIqiu50d59iO2NCREVOfzmYGvMz1dVMNJUolNq4THkzZeHXIUl6WSCRCg3wuZBofU3mFTjwdem04kV3i2EjRQsPMG+aM4YZsmIx39LLl5T5S6jxOUoGmnf6UD2CK/WPhTcAxfq2yOnCagCjS6eS9EhBtnz0J7kiN0cXgldCFhR1xS3/+md4y0BmtyqC3QfKERbFIdVPxjg438Hci5aFKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usC3DNBBIj4TQugu5d3XwlmyqLcAb1e/M5i7z3Gh1qo=;
 b=SfmqDlJEdLr1cpcDmPQeQ6QbCws/VpaEhYki1l4dJ4NDJi0jwIz3MJld9ztcGGsqvAT6XZP6huIufYez8akw5u9kMkIdFNAYAM9+XKliSFkW7MWB0Yozxcs1NDIDmAuqlabaNSfnHlG0h9YadMMDZ7RlZ12fVW9RfuOYxOQ7wTsl6/7DA39sDkZxbVdeDPj2mt6Xa5gNWirKsItG4kX9Qg9a8uswgzHAtkgSfePa2g/U9ldzmUhbdYMf5xQ8fDG/UE0HwL7fHWjeok4sXY3hwKP0qtMMS4xy+BMWQ7+Iqs3TH6Y3kK+Ez3/wDEJC/su8kl3MnoweYnRGo5iSFWj33g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:09:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 15:09:32 +0000
Date: Fri, 21 Aug 2026 10:09:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Golla, Nagendra" <Nagendra.Golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, git@amd.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 1/6] dmaengine: zynqmp_dma: Fix PM usage count
 handling in probe error path
Message-ID: <aohqItUOivG0UXhC@SMW015318>
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-2-nagendra.golla@amd.com>
 <antKJr1N3A111W_V@SMW015318>
 <25b9e249-053f-4560-ab3c-eaa30bf0b240@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b9e249-053f-4560-ab3c-eaa30bf0b240@amd.com>
X-ClientProxiedBy: PH8P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e971bc0-3205-4610-c06f-08deff963429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|19092799006|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	UoEtNOi7EUn5fnnr/oW+F/czsBEgUUui2/iMboUVOuL5vOb7KipkRVqZ7UT1p3QbPUeupEzmUaE+l80ZU51vIZOqIWtPEYSokFVX9YhmOP9gydkb8aEGVIs7mfOTPas1JkP9DuyJZswCfqanatsCeMei1y1SNcotg95aehvgABtH357q+cpe7pacZkF2TX6vrl1yfYD7UgaJgWNMVCU6RKMxt2mxrZoI+ZAUElY7H7aZBSkmEGGjdw0AGqIvBeGocWiUDhZwdeJLeEBClqVTs/ln5EkB28bV2i4WCNOcSyqhC12ac0UWM+5O9hHrk+qv+1FjGTPBYOiMgq/LF72o1cvAKaeE6nZy7HE9VrA6MUay0YBpUpr4DLYJP7PGiJIQhS0tGkSKmrG432LSg4W9pGnF/HpP4Yewzq8zfD6El1oQ2xSIDHSKDyQGYTXHqec0bc7ACn0tq0vqJD7/4B9pvWcZiZvkO8vYC3OzmEUHu+Co4cWTpAJSviCtiCnxdq+CBoeNWuOSAbqU9LIKKF4cfFXbwEH8Wun/jCBQCTNJz8EeHIVjhJuwmUUqkX0A/v5ursJynRk8m4gtYsLexhyiCruYZZsLm6pOsRdkcVtZznirNSSh0+zOYY0SurwZdfkSbkxZmhyJuYjp/0p9gv5Fg5faUWyKnXP9dClLgMJr4sI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(19092799006)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q5sSk6d3HEIVOD285KSnx6kVwCYnTsPtriFbT6DS4rjYsTChmvZWBisj4FJR?=
 =?us-ascii?Q?KCC/j226xfOfhx2GPbBK1QwoCYKseR8O++BIf2prD2uuLThqyo+WKKUlIOnc?=
 =?us-ascii?Q?TBA0TedVGJKOYcGIYwezZgrVv2GleSn0eZ2clL0XXlMhp5CiajXEDhHi+/o9?=
 =?us-ascii?Q?EdYRf4gr4PPctMsNlouxdmRc3/ciyERPvpFe2vNbniDUh4wn/QxH3+U6pMzC?=
 =?us-ascii?Q?/Ha9eL8hWncHb8TPnqqFsjaJCsMM2aVs6vQ0P4GTRyWsDfDi2a33ZHobmHK6?=
 =?us-ascii?Q?IUfctZa74iKOLnN9X9BhPuRzBiTaeuscWd7WxxByXHe+z4QdnYGbCVPkJNYP?=
 =?us-ascii?Q?DfD6hf2NklUmagSY/O0xeZIcPQ3+a1FPYjGshuuYlY+kTzE+JahGPzf9RrPx?=
 =?us-ascii?Q?i15lFLcQhTLRbZ9Zgz59+UqRODxKA2FSvZzZoiwAdFs6Fh9BjPGRcy+TJk8B?=
 =?us-ascii?Q?geVLBdjOsuzX4TpE5E4ErBhYEiApQ/AbxmmwGQICkKGvQLhVGlwPrNr+bCYJ?=
 =?us-ascii?Q?mUM8S2wDdOmde9uR8D7TBp5FAFUdZCSEYZEJGxTZhyEpe4BmPjsFdxcnmK2D?=
 =?us-ascii?Q?T/laNSlYxSWOeXcidtDsUBqhuPjPDbJOaPD++s3DZ7fdJCDx4/oBKPPOCJEj?=
 =?us-ascii?Q?TXtN9EQUxHP5vls7/ErcSu8cX++dC5bG3GCurXqdJ8tOPi/RYhsiQ2eg2pqP?=
 =?us-ascii?Q?Zb3Ykz7KRWbMfkEt7Tfa74D2KqNuSOv8eYTbGGGFqIPPKAighuNH6+YmxZaT?=
 =?us-ascii?Q?cN99NzIc75uWQ7c0tHSh9CL9UeBGgoCcu57Qj2ROVfkDo2y1BvclqEVTTSjh?=
 =?us-ascii?Q?v+82g91FZZCxf3nmLruE8sg0f3V0KYQktJr7OMVOUqVMd9AiDeC+kpvTlBDe?=
 =?us-ascii?Q?a6sT/uHYMdv7kBAmG+XAbcAe90p+x5nhRf5q9rZv+x1Aos4n+VrUH13Gq6eZ?=
 =?us-ascii?Q?zOoDbb6pRsfbmIET1hX7v2f8P6BKcDiJD8IeflgYqO8SAjtiWTsbnYOGrfX8?=
 =?us-ascii?Q?GYgX8HIJrTfGwLBXH0pvNhFEfroKnw2EHJpylfA8yh3RlrrOwDOLq8Gw7liP?=
 =?us-ascii?Q?86xxmabQuWuFAzg01MELiOcMeGYMIir2CmqgKyw+/byRwqTONnQUHw/LZpRo?=
 =?us-ascii?Q?bNJDwu9r0sp/79R3Z1QZr9s1+47D5AKoLnZ1Bk2MeJ2VP8KA8rrhaCTMVexr?=
 =?us-ascii?Q?2X4SFP4VR2by+6oHyvrLwci94CvWL806aIjiIvr+V4PP96k2vuNqVX/E6/EN?=
 =?us-ascii?Q?byxm6D35xsj4hu8kywpENOIuvvOBeOG56SPZbXQ9aTF2xfaazaC53kywL15s?=
 =?us-ascii?Q?5xtOJteVqYbCfcTP0/oNH6Ydq4n9eeYN1MdKDT27wVY+ggl974mntzAvY5bf?=
 =?us-ascii?Q?bUuo2SYoPewrk0ZGirpkgmQsy/hYXkHkS6ucm5M6jaoAAG3Uwa+v+HJ1c8jZ?=
 =?us-ascii?Q?ltV4dvNH+c+Q9Xd0TsjNAopZZtTgYMB5qFkzZE1RhnhukErJJrEnKTlIBTxD?=
 =?us-ascii?Q?yk2FeozzRka7hfdu+5rSnrw2VUxHvSYJgyFAiITfSW4DLlu+nDfUtKNZI9cv?=
 =?us-ascii?Q?C0KH+QBVLHp5jt3Tja7wP8+vrhlZ5xEkrfhkCjsEmbEhMYp9FAnPj7/YWew4?=
 =?us-ascii?Q?beuAuL/AMj4rWKY+HVV6hKjuLSTQMHXqiKRU5RM7VE5MR7xq+4+n3c0PvUHg?=
 =?us-ascii?Q?gry5aftZvTUfXpamsS2P7idKEbl5411a3SuOYBVCSPYJpqAV5f7XCmBrP9Sl?=
 =?us-ascii?Q?4y85Lpf8wUvPTF9q26luZbxDme9rlh6s1wVwoGQGK+3HoxzJevG3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e971bc0-3205-4610-c06f-08deff963429
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:09:32.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/4gN2nckKpyKWwC8fcNi/dUzf30V4UH4t/fLPHNlpIa/SKmzn5R5J5qKxuSu9PVJ0a2D6ms8T4mTydHEU2i57D5xqBB1xsmWiAK/0gdRabdZsqxG1l3eM8DIn6tb+B5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

On Fri, Aug 21, 2026 at 09:57:49AM +0530, Golla, Nagendra wrote:
> Hi Frank
>
> On 8/11/2026 9:43 PM, Frank Li wrote:
> > On Mon, Aug 10, 2026 at 03:34:47PM +0530, Golla Nagendra wrote:
> > > When pm_runtime_resume_and_get() succeeds during probe, it increments
> > > the usage count and enables clocks. If a later step (e.g., channel
> > > probe) fails, the error path only called pm_runtime_disable() without
> > > a matching pm_runtime_put_sync(), leaking the reference and the clock
> > > enable.
> > >
> > > Add an else branch to drop the usage count acquired by
> > > pm_runtime_resume_and_get() when runtime PM is still enabled, letting
> > > the PM core suspend/disable clocks on the success-then-later-failure
> > > path.
> > >
> > > Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
> > > Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> > > ---
> > > Changes in V3:
> > > - New patch: split from V2 2/3 per Frank Li's review to keep the PM usage
> > >    count fix separate from the per-channel reset changes
> > > ---
> > >   drivers/dma/xilinx/zynqmp_dma.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> > > index f6a812e49ddc..87986f65d24c 100644
> > > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > > @@ -1152,6 +1152,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
> > >   err_disable_pm:
> > >   	if (!pm_runtime_enabled(zdev->dev))
> >
> > You just enable runtime pm above few lines.  Is it for CONFIG_PM?
> >
> > You should check return value of pm_runtime_enable(), or change to use
> >
> > devm_pm_runtime_enable().
> >
> > if devm_runtime_enable() failure, you can direct return. Need check
> > pm_runtime_enabled() here again.
> >
> > >   		zynqmp_dma_runtime_suspend(zdev->dev);
> > > +	else
> > > +		pm_runtime_put_sync(zdev->dev);
> >
> > This one suggest use PM acquire to fix this.
> Thanks for the review
>
> The probe error path already holds a reference from
> pm_runtime_resume_and_get().Using PM_RUNTIME_ACQUIRE_IF_ACTIVE() here would

My means replace pm_runtime_resume_and_get() with PM_RUNTIME_ACQUIRE_IF_ACTIVE()

> acquire a second reference on top of the existing one incrementing the usage
> count to 2, and the guard releasing one at scope exit would still leave one
> leaked reference. The guard is designed for cases where no reference is held
> yet (like the IRQ handler). Here we just need to release the one existing

call pm_runtime_put() before return 0 at probe, which have not hold
runtime pm count for IRQ.

Frank

> reference, so i am using the pm_runtime_put_sync_suspend().
>
> Thanks,
> Nagendra
> >
> > Frank
> >
> > >   	pm_runtime_disable(zdev->dev);
> > >   	return ret;
> > >   }
> > > --
> > > 2.43.7
> > >
>
