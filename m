Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6831F9BC;
	Mon, 27 Jul 2026 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138155; cv=fail; b=sfo+q5uA2j2tnLBS14rbG33QNeVcGtTNSRVMjQiKNJvTUWIqsXVklTF/cvEiacwZRQQ21M1vyG0s8cvjFcsjJ+Cf5e3oricTdn1rjpHQtxISkjw4WswRb6pPOREx5fZYNPDE+XgnsRqoRixEDqgKREkCTVH0iNmhJCh980r++o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138155; c=relaxed/simple;
	bh=MQupnrWN2q//SCTRz+YvcixFuGoStQIwQLVWAVWhTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BCNnMZHUp9Z8ehMcXBw5DRXxHoTdm+x00k/kEpwkxxKh4cF5ih7mOnDUM1956daIsE7W1otlZNHvRClyc1FojwNoakxy47F+hYlm4S2up05YRX8qIlt+HBbyJwoW0sBnIAQw/WUNWlAz1xkingxCKlGiXcwz6+hVleffPSNZIFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YzSNGHWA; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YzSNGHWA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gn3o6xWZpsXu/WXJrH6JxJdnzY9CZMVTXrHj98JbmAurM/cbdVKb1f7kgw0vtSy5NITlYqxCvGPMaFKK54fbLVhykxqtwTfdGA9uX71+xHYn0NS5bbqu0ac5jA6hTHOIleOztn61xrQKK+fGkMYqUXHH2NIp/8O3wTvnrEO80rA4L6PhKf1zPA2z4e1se6J0+w8r0RD0m2VWl8JLq07FyEeIK74SLgBHnIORRAzyfoZdZrpIu/Xa5WmjqTwoVum1gJbl0NPeDlXibGRcIDWCA0cyhVQWqSCJGlK5KZvqXaqGVTyC5JXN71OL6kHuV6RURMPEvoTOG5yu+FlQIODhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQupnrWN2q//SCTRz+YvcixFuGoStQIwQLVWAVWhTV0=;
 b=t6JUy3t2sVoFAe2UVGY5hIhmFM9Oly3HZNg7XAbBhIRVE9c5XR1JuUf7mlfddfCSI+74rHpGtsl946tHC4sSC+eVl6kqcRvYoGxHGBjKG2XjU05yP0x1iFvvT5VoEu/70IMeINvucS1If32NKVKN5U/2MLNDMAU65ARW/9eJ4KGcWXi/PeTepeEUuX21xnol7SYKjh9wW4lZUpLsS4wTXcGxfUHCFj60vzqiCEKPRcW7CU21du/6+VRmiwlFfZZTVNQrriQt62nWRyxEOR3r1YTBRkBLTJNEMegHRl3OB6mCVu65nQtIB8HIuHiKVeV0k3RIfufmV7gX24bY+6hAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQupnrWN2q//SCTRz+YvcixFuGoStQIwQLVWAVWhTV0=;
 b=YzSNGHWAep6UWC4H9OG1c5oTjFBKpcKTjsDgV1+tJrRoc7x5aDj6i9IIB/P5sBSYruQ2ULcztwDCF+B21vSJbrM2/W0N2ivPddOjkmswhjBSdBCizhbD2jtQ4qYHoLuBhso+Hw6KcW5/l4yTGh/DoxAA6tizYPjjxM/vmkqk6ifpRgR2oU4/Mrd3Fo0gELuvwDPQIOiPSjltbbEayhEttkH7UTGDDyghFPUImCPkVZX2IXqGB7X2FEIYbvu4N2eyZK5wAE3jwwtQA4iMiBOmE78cuWLi1Mo005UcQKrECWnJ5oW4KBN9JNg82bAaNc5BvD1d+vayG6FK5h0wJxIdKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB11331.eurprd04.prod.outlook.com (2603:10a6:150:29e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:42:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0245.010; Mon, 27 Jul 2026
 07:42:30 +0000
Date: Mon, 27 Jul 2026 15:46:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Zhipeng.wang_1@oss.nxp.com
Cc: robh@kernel.org, saravanak@kernel.org, ulfh@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	jindong.yue@nxp.com, xuegang.liu@nxp.com,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 3/3] clk: imx: imx8qxp: add soft dependency on SCU
 power domain driver
Message-ID: <amcMxdNzd7M5kSAF@shlinux89>
References: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
 <20260723020524.1886806-4-Zhipeng.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723020524.1886806-4-Zhipeng.wang_1@oss.nxp.com>
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 981128ee-aaef-4ddf-6436-08deebb29cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|19092799006|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1TbYI34tTQEzlyhGF08jgcjNpecHzKWfOVBW30mXnHNtLIGcvClBD0tp+RpBtKqvcPX7QI1R/PNmrphsLyFvtTcyndlHA4ItHZez35/Q9N1m+ca2AsnexGUOo3VJ/sN0NxUEkpUAnAog+X1Ihpz3oWg7gGKkjqGE9uOqHxl8iVmNEUMtq/mpLMkzG6EW1kCyp47omtPKRmWLWKFD4h67BjLgXV9zGsXldzYZ2cof7I4470QD80JR7arC4ttl2zK/X9ajoGxLifFugax5xo5symXgob3WLYoSOlOAS3QlzAJ/HNousJOiauT2eaoy2DrEzhHGZy9czoI4QI5iUJgwK5lmUFOM6VoNc+yEKupGigeCGqoiwY/pgA0EHBco63EYeAihUpOR5u4YTg392Fvq4bqf/ivWp+6urtIX6lTiwdCCyZTgDu2DXh4LgieTjmoY9Mt3vdWlRKV0H0vAs7dl0HxfofI2vHCbm2IZTnKTG4AiWIthkMxMftc+4Pulc1F+i/THl2D/nOqjIQ9bDNHjeQ7O38o+0zP0q2rXDF8JVWf5owrueyvvMmvknFvIW5GmaBsshxg+p3nD0usSQDsMZwp0z7rp+hEiIy5ZGIOaZ4XF3xexR+h3AEhA0h8nedo/KkheMehJbuRGShCX03tbXKBW9dwHnM8lbe326/QJT2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(19092799006)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxEF/4IhzyTI3SDswi7/I7v7GY/1/jjdS8sh4YVYJd1u0JTD3HTWW1gU94f+?=
 =?us-ascii?Q?S6uJIftWFfVZJxS+ibfxRG1n6WrfiqZUxQEN4HTOuk19+hVaz4Ziq1SF7cLs?=
 =?us-ascii?Q?UbdLDKzGJvd0ZKkLidZGgjUt89s5F6u6r2+7vwWR+wUlZS0PmznFZ+SLJ2qU?=
 =?us-ascii?Q?jNs289s4L/ZkziA1qCV9Hb36zgEg/HdCe+h0sEgObqt4ylQAt5BGD1dlS677?=
 =?us-ascii?Q?D47JyTjgzmqpfFva1sOlK9KW3ai/OlLWAB219cnbn1WuNtGRCUxxg5BMPnx+?=
 =?us-ascii?Q?BYMpIFukfRL2l9X7GLfE7+V4MsU/k5dgGleH99OfVqFIe2gd1MozvVE/s7SM?=
 =?us-ascii?Q?Cim4H6UiPg1bb11mJe0RDXZs6YwX1TEbDim5BU/13BOpWlr6Ut4RWtzJh5nq?=
 =?us-ascii?Q?vn+qrwkvXEsWl7c+tiOj+dw+Tezeax62g3ZS1QrnQtYm8YgHd+xJY+ZoJ2sH?=
 =?us-ascii?Q?4niBbxLTF5iBTnaVJxtGL5ZZ3SboXuqzGh1qre9SxDro9Iz5GQ3MGFUTzEaa?=
 =?us-ascii?Q?kKNONLVRdu2sfYDFlFgwqLl3TSKwGIOWk+rijJJB8g9iBnzJMI4fpIP834fH?=
 =?us-ascii?Q?d8pSUa6jFSojAL1OFCT/Dgw138nVOs+g40WUGXkEGHqlhZmdXHHIW9VSogiz?=
 =?us-ascii?Q?0bMl5mkl4eJfVNKSLvXSKZOaXuNF2uh5IQemg+TGEJJ2bWMOpp9L6rlKQoPe?=
 =?us-ascii?Q?bfI6yWlllGtuFZ0/7DeVSjZVnqFgr4qZOuVk5jhBQJT+elB4cw1Qvx9eSnmG?=
 =?us-ascii?Q?dM+ZzuyrZcIaFCqVzYr5RnYIaPP7Ga/Im0nnA3Ymc7u9YmuJgezKQtzlqIRp?=
 =?us-ascii?Q?tvO1zBKLyXE5GxvIoCUt0YIb9KxI0Ng6Zwyh40n/CPWit3fr+tm/6rlj39KO?=
 =?us-ascii?Q?EeRO0qk8t2oABOvxtac1ZDpkTabrPxpU7Q3uQT482cq62Vl15P5SblLwOCYb?=
 =?us-ascii?Q?A3nAiFO2Oxst/PHVmxcs6qfofbX0B5n9Q1ZBS6G1cZWJOs1WJYxV0ghu4JDI?=
 =?us-ascii?Q?AUMvBetgU2rdasSnqoZJyTAXkCiPzw628PhhtyDH4d3oZ9G1VZOOvPI+WYNg?=
 =?us-ascii?Q?OXL/OoAqHobc1/P6C3+jHaJEjiS/JtRWPFzLhbjt6MqUv999zf1HvaL4PTOJ?=
 =?us-ascii?Q?X7NNpj6HFbcKpvKGF06nizuZErrJMQvkPWmzlV20iz8mai3cVfnPbmMer8U5?=
 =?us-ascii?Q?vR0+1YFpxvLMRhYm7o7+njsrNHH7QWywMszR3550gqNd5eKCyWUyUCDjLWFo?=
 =?us-ascii?Q?W+uZmcVqgAuZe46ceNIv0nKC+yPiAEonPBsx3KPiawbGHuO/JFvIqeUkOHpC?=
 =?us-ascii?Q?cBdR2kOqEWas1ileso3FpOg6kmmIXaur1/5ud8KA2tHEg+dOuXjLc/WWAH7r?=
 =?us-ascii?Q?3JbITHlFcu6N8NdOfPQ9+65CxGByF325Lc6g/cQT4+pyOpici7f188gR5a96?=
 =?us-ascii?Q?3I2NdD3nvMGj+k/h/04GvboM67YkulAJRHuF5t6sDbqvagA9pa+yLGa9A0ap?=
 =?us-ascii?Q?s1cTmIsbfariHsxRv/AF5dP+YFfaM8pB3g2qlBKJnVm57Oy0zNVseUk9+Rgo?=
 =?us-ascii?Q?C22PeX3/IqWxl3AGkBp7PB/jT79TQP2FpcjUgx/baoH02jNmOSM4VsSmDKK9?=
 =?us-ascii?Q?mGL1vPsEvN9BWgT/T5WB4063HPn9OQUl93am7p2oL+dwreKGsMIC5FWxNouI?=
 =?us-ascii?Q?sBxglt1tlsjdZBPTEet4y/AtXRG9h80cpgHNdfXctzr9Lc5TfKBni/XCHOcL?=
 =?us-ascii?Q?k4DFqjeVKry07x8LpEpZAOMsTqvoLsPI3gRwlmtVjsflVDf3JkYl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981128ee-aaef-4ddf-6436-08deebb29cf2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:42:30.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FQxfkY/NDoRRNvHTAMfuAvPKTMnGi/T3KdgltMaTq1pGMvOqMg64GGyaicy9oUN/4vHTPDp3LYeW4IxpihKfOu4DtYYXR4Ayu5PFNR9Qhv1UpfOBu8Jn7xe/00C0JeI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11331

On Thu, Jul 23, 2026 at 11:05:24AM +0900, Zhipeng.wang_1@oss.nxp.com wrote:
>From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
>
>The i.MX8QXP SCU clock driver manually attaches power domains to each
>clock device via of_genpd_add_device() in imx_clk_scu_attach_pd().
>If the SCU power domain provider has not probed yet, the attachment
>fails silently with a pr_warn() and the clock device is registered
>without a power domain.
>
>When both drivers are built as modules, there is no implicit
>dependency to guarantee load order. Add MODULE_SOFTDEP("pre:
>scu_pd") so that modprobe loads the SCU power domain module
>before the clock module.
>
>Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
