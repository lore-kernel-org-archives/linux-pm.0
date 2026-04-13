Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162061C01;
	Mon, 13 Apr 2026 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776050748; cv=fail; b=nrdlA2f0N/E5afnq6rAY/v4fHWL4orJCmofvXj1+KhCkCgbf+/DL8xrcg1+WUvqguHqNSPEV21NzqzdpVUHnAVzzHFcn1CzIBZ6lrjIYQLscKLS6eD+Yl6MZX67M/KsjswSsvA3D1ugiG3/v/a4oSn//eysRr2icqFGsKsgWKEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776050748; c=relaxed/simple;
	bh=Rl/Nm0kd7ojkJu5PNQntwpM3CoQikHxLdZfAmzMqCFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DEKw3OZS2brkHhFuOdlYGce9Rp11bN+VqZg/JyrJxGxUmFrPMK5UAWhkgNcmSgSHi/v2VQ0NcHMt+VHlsPmDrnDE0zbBS1GbNVWJhHj5xypr7XUQKhfAydFtYf0RHaiQEPT3icSiixvGXXbHn2ZlmlsXiuJ3z/EDFOSEjjqEJCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mKq42mkI; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mKq42mkI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0o0p7fqVUG+kty35RjC7UvnlECTZ0C1lR1x+84wpgS5zZFDtqjMaRol4s3qTQ7Ovm3szxJJxdEQf4XDccLVuveyfuTgeuaSv4Z6/lPIpemvTYWl5D+V/GuI6OFXHLHJMlEmgojfjR98LxQjcWUEIeOs+rJOXcKDM++AneMOy9JIxWnZose0RgmZPHqP2aCxSU2HqKbFJgX+UfD1QtiRMuzpQjOqXGXNaf62bR2Los8U3AxqoBA1lC9/PUrmhhGaISUYnftSzgFim0yifFKf2SdlW+R8qSSicdb4tj2dHJRzJy2A02QMre4+K4mTIRRsnHgxi/rMGd65osqhzmkdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl/Nm0kd7ojkJu5PNQntwpM3CoQikHxLdZfAmzMqCFc=;
 b=nVi+bnetEYYv78eFoMTheqH+rTvLZv31Fs7mF57+dRzGQThzE0ENu9VqTZ1KurJz37xB1rn4hirk7RyR2T0ZFOxZKJ8hbmVs+ZwIfrj/K+FOgl2Ov/ctYHhZzIkmdL6lkk9vMNQpvg0zNk8ubTswIVOJPT7LgMEpwdoum10k2AiB4l8ircNG1UCHW6EDE4ZMuBUMC5zjODKCtGeYSCwMIo248fVeyya4QEhYu94AZHSJ4WR5WD/eOZqrpHP1nO9gGEX6/Ls8wpB1S5vZG4ZGb2l8t4BDfKPqie1fT6HY2wACaUjj9pwhyah9MHJL9Pk3bJVpRagN6IHCtzP6FO6LqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl/Nm0kd7ojkJu5PNQntwpM3CoQikHxLdZfAmzMqCFc=;
 b=mKq42mkIeh3rNjdJjBZTk8cdyMpcGg/G+rZxNRbs69YpOqp5C1ducDtApovxweFmBQVcOB3dslJVDBw777zf64o98hRWjg0HQvL+GN/xhbxXTDZbIzciWf0Fax3t2idgSl2NpXlhVaP+U0G5VLDFoQPhriSoyM5qMghP85yg5sxWC8kU2uscckhSWvjiWlNq1/93hhQaE+3mlZf9iMkGGqWbEIILSqm+Yd+os+587sxMAIYwNIBiZfozkgSyzgCXpDaZa5Bv6Tk0N7rVrPjpDtJHLmrAf1l396LS8usiE/ru62tTiBVGzf2AUIFejCzUPYYwguWMEmFb5/oPW1EtPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10562.eurprd04.prod.outlook.com (2603:10a6:150:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 03:25:42 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 03:25:42 +0000
Date: Sun, 12 Apr 2026 23:25:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc: "ulfh@kernel.org" <ulfh@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Xuegang Liu <xuegang.liu@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>
Subject: Re: [PATCH] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Message-ID: <adxiLObZ5gp2uQ4t@lizhi-Precision-Tower-5810>
References: <20260410092735.1065294-1-zhipeng.wang_1@nxp.com>
 <adrwO8HdZ7d85mEy@lizhi-Precision-Tower-5810>
 <AS8PR04MB84204966B358280D2A89F348EB242@AS8PR04MB8420.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB84204966B358280D2A89F348EB242@AS8PR04MB8420.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:806:28::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10562:EE_
X-MS-Office365-Filtering-Correlation-Id: 231f80e9-b2b9-4b35-be2e-08de990c5795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	T5t/S/d/Hq+5u+km4Grj9unAzDGZbaQzP7aKnJfUBVXU/QmpU3oJwU3YMnG0pe8K34H0QdZmYeRPExmvg+P/fFBBGLbeBnApr8SZbSoPWuZmMTz0EH0130E/yhujQwOl+9E6zPEMmygwsfvUHsf7ZM6mKvEgLTUCZHbMCmtq5ycMay6E/iIrA1DdzwyXGjSUqaug/91jUx9QOJKnFCT5S+ketsgHfXPphRPExVC8iw4kOM3d73ZVzdvQGFnyOm0A0slGRcIopSBV3UAvrS52jV4iaNTqHsqswdqTTQPHke1K0Flril3aWooUfh4PVkdPwc3sBknFWDxs+KEigZQVBPDa+oR1IvurorYWzRaZk9ah7O115RHykAC6mFfngoBA6q8Entc1EVzudPwDRKSU5Qi93ZiZzbc1iag4NNQ7kTXTIL8RSt49bxxtqNgS/1yiBfzsJKPIujayHcqJiqXLrer4P4dfMFkKsOFX/jE4B5jPKiMGCl/7KQ9vS8eigamZBsZ3DGNlFE03AzrqntCtAYgRpqRvfgxr43PAjJLhCjnNRg5tc0613iwZeAjW56cSflEJb30Zo03pisV8AMekQIL4KOJPGWYj2LqqeGhgdcAsSmBAzRN/9DW7i7kkkRlmx0ZSjLaYRnXgI5qDWX2GID+JfF4/0HZ2WYopQzScqnHNd1Oqh3LR3mL2BeAhFajFyjaMU31Ff4mBjayYTaiWIOC35nqYFcdtUuvwXY+R03yPv5tsH1CPiGPTjXaoSDrarB+/PaDcFZIc9apBZjpduxE9yQ1OlGvukIwi4yeGyyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K65e4tHPKKp05Tex8gluKFfgZw+dxaxwDznSMhxpTnd/3aiZVdrDES/DbcHE?=
 =?us-ascii?Q?GSMFa72mT+4p3VjA3dJ2pvlBUoZjlyHAMy7IjhYAWQrCYEH+5BM2JrTwU0vT?=
 =?us-ascii?Q?nuuMw2fSzbMzBfq6ntbzvo3mbdr2FgQzAyRtxrW98/JEjaJ+k45A6V7x2a+f?=
 =?us-ascii?Q?dI8iV+00t7859SCfHgIJLGqTHg94+VfDhimv8pzvPOy92VqZmG9iTWuGBEo4?=
 =?us-ascii?Q?r0wDSjFpJa0NzC8Gfcigr1rYenBTMdk4sMNmasuCtdRki2PLXyjt9vYxaUKc?=
 =?us-ascii?Q?CRTjmcDopQ1qtSkwxQgZmm2d1IRusoC9zk/EtheljrHFxBHZsvjf/vjhXim6?=
 =?us-ascii?Q?9ET6WB6Pa4R6egTzCqd6uV+5KZw2ih01dZKsuarfBHj1AEmAypICOhLR9yzH?=
 =?us-ascii?Q?VMtzd5zJh/AFlT647dy0y0RAQ0M0X3NGdGX0DHc1tdID58a3cw8dYeO0FamX?=
 =?us-ascii?Q?oRwNiHrxReoUWzmfRM2Q/JYP5okJ3/0Qz1D1LQphKb06cGza7f7X1sEk9m/7?=
 =?us-ascii?Q?YH1HDwFnfz1AFwG0V8ou8XHUtLDhdaYT51iRLoqXobDS3xUGJAWKXzc+TG+S?=
 =?us-ascii?Q?SNSLEZ29dBun7+lvCbpo/rkrHlISB2IKez5I3SIJA3PeF7al11HR/ULG+Ibf?=
 =?us-ascii?Q?deNfDyPEISjhkmff60jTM0/ILd+ZBEz5FhrAmKy70KdvwFCdcC14nHwqc7Wk?=
 =?us-ascii?Q?+aahyAbgqBYe5UZOF4XgedVcC1K7PFcyzDzxOMXaCMHDU4jQkGMlmHxs0Jj0?=
 =?us-ascii?Q?9mos81ZDBG+lnjvqDAx7OmYrZyMsacXy2gmCoEETxJefAbJzFwRs12libnx4?=
 =?us-ascii?Q?II9LBZvxigtK+ZwcBi+61xbZGrEVtzZfbl7u+NuUuOjyTuN8fLT+87l0hT6T?=
 =?us-ascii?Q?Jabks4ay7Xjh6O62PGQN3Rlach8GBOSmvtcSBH3u5VqZfoNu9ooUb0H3Q7Zi?=
 =?us-ascii?Q?E2imGREjHYH2l5y1F+SZoqjvGlp2FaVnOemlMiBQB4TUnAlulz0ZSbqpQd6C?=
 =?us-ascii?Q?l7jSJZKalY9kYzO5ZJtVc/JnCePD0rLDrtMVqn04u6j38YxSUpW4m8ft+JFt?=
 =?us-ascii?Q?rehwAVZQVNGBgA/Po6YVGEmuZPJ3hfbr6abLkPRgBkT3ZpYDeQacDx8C0Aya?=
 =?us-ascii?Q?tt02ebP/c/eEmDXo4MxMWxqEGIFpsVt2jsYXMioSwCdSREgpjz7T6SRdZyI2?=
 =?us-ascii?Q?EHnYCJ+nUNmB3+x6oG357GLJkpsAJaBs4hIf83XYGORgkaZsDECSM4P1WaK/?=
 =?us-ascii?Q?lrDG1L3+wnnpcFi76kRzK+i/30GgbN1L0gBRN2bpBQgTRDAL5EdOd6NoRsYf?=
 =?us-ascii?Q?xNishstxm+EJI+qqCw3t8NOhKwfnrwfEx/XhtJ8dinSU9ZYUwK1hCzZWI/9w?=
 =?us-ascii?Q?Ik2iDuW0fcZA+Qu7/JvFMB1D43Flbcl9QywGXxH0e/oahPzYJmbHh44cOnMC?=
 =?us-ascii?Q?lPcXc7aTqtRV/Wylxya/+8pqWRX3TkiB4xeAsw86TSXVZVSHXHCznW2Tj9XZ?=
 =?us-ascii?Q?urb3B3zkKKdrNpHdJNyuJ7ttY830XTyTGWK4TYxq90VLJJobzHP5LWrafU4O?=
 =?us-ascii?Q?Hjc7kq2o2gBJjxY39Bw8chiSOItqqX+U6dd06Dl7NQT7w8niJPwGu0akJZU8?=
 =?us-ascii?Q?48qc7tAe4iVWjbjhegkB6ETqhtzBnlQlDJcCG0FLjthu/mSNsVhzh9BOvIzf?=
 =?us-ascii?Q?G6rALuC/m+K4tW44v84nkdyHnswNh2OV6K0PfH6xyQFgFsFTmjwsTeVTS2Dv?=
 =?us-ascii?Q?7cSGi6iT5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231f80e9-b2b9-4b35-be2e-08de990c5795
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 03:25:42.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2fGvQZouH6lCyJ/OG0baOV/Cb9E2nNDTDZzsUclPxNWpHbTeBonBiNmI1DT0qYHh7MGz6+XxzeeUnEIZ3FYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10562

On Mon, Apr 13, 2026 at 03:08:20AM +0000, Zhipeng Wang wrote:
> > On Fri, Apr 10, 2026 at 06:27:35PM +0900, Zhipeng Wang wrote:
> > > Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate to
> > > allow building as loadable modules.
> > >
> > > Add prompt strings to make these options visible and configurable in
> > > menuconfig, keeping them enabled by default on appropriate platforms.
> > >
> > > Also remove the IMX_GPCV2_PM_DOMAINS dependency from
> > IMX9_BLK_CTRL
> > > since i.MX93 doesn't use GPCv2 power domains.
> >
> > Does it cause build failure at GPCv2 platform? Or previous dependency actually
> > wrong.
> >
> > Frank
>
> Hi Frank,
>
> The previous dependency was actually wrong. Here's why:
>
> i.MX93 uses a different power domain architecture compared to i.MX8M series:
>
> - i.MX8M uses GPCv2 (General Power Controller v2) for power domain management
> - i.MX93 uses BLK_CTRL directly without GPCv2.
>
> The IMXGPCV2PMDOMAINS dependency was likely copied from IMX8MBLKCTRL
> configuration when IMX9BLKCTRL was initially added, but it was incorrect
> from the beginning since i.MX93 hardware doesn't have GPCv2 at all.

Okay, please add such information into commit message. Some

Frank
