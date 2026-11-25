Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609023;
	b=UbGxoZsmTNX+ZbmLzYOQKiKEisvPGF/0/HmUB+N0syW83L/5XMJnVZfbFmvbSPIG2FgQ
	 VSBqWFI5nNRTIQmJaLkrIOswYWHa/aFdn5RQqHiIThTndnDrvcu78SxLrhf8Px5C2gGkc
	 SLBEpNQHy+mmqwcJXbh6ngNWUak8tNzPTw5KDsrnqTwzFT3knO8So0h0Fevz/gLiV/UHB
	 +K3UJHIUPJrld/6cSOOSnwlTDdOPRu0063nBHZUo7gniOI8mgdCzA08i2JA+xbD0aokDN
	 DCj/5nHTTHcQarJi4CmsKoIPMPDod3PdFT7QJtnhLaGjn7xflFQJ4IWf4B/BjhBBdLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609023;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MVC8G6V4uBF4a4DPt7PhMWBoR3clEaNughSf2KEBRyw=;
	b=oOVP4D0+URBDmi04R84ax4+7LJvaDD57ySzueUeE+l/oVJm1dY7pxXHp79U1Mav1Tipm
	 XHSt8GjlSLdEdFY8/kLSwdu7WqxclwZJN/zc6AxBgA7ofGd9cE5wqpSItul9IThgVgdks
	 NfZ6IX9smILLKRcq4BQQJB+nLUSCcg5Js9nCV4QtaGJ5iQuVE3zAVANO5MJ89EWhMfm12
	 3l1bWT3MUpuW6Kb3L+hwdQf9ZIo5EVQ21jJS0SDVvvOnP1hGYJUzo4L3vcq5ZTrrQsYdG
	 wn40wrlZ83iAv3xkoZZOQQbdUEOwvUOyxzH0ikW1TwCFcPJi/kbCUA2XSEOh8rC+nyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ndDC93sf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.25
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A7606A329
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C2A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ndDC93sf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVp1uXUqVMBZJYvCVCymkUDcwV1L0goTofklBUYJl1eyfj1d7yghq8MTgjDCYk7igSB82+a+O3HxP/ojtu7oHWmpcp3lfI/qerWC3EFm9Hzf8RCI8ufz0G5I45lXcBCg83fKnxldRsZmxXUdIoQ1+ItjKri4k2eY6fCQL3UOIw7SMTIBrp/jt8wAcfRn0K2WxoPVvNjvMuU9SKDadAEhIcp05SZ5PzxCeatCIIjLhRuyCQuQdrobLsaLKEoIhxr9+fTFzCMkz6EPuWhPkCVxKAJL0J8pKPNi+fHUwzaPLT1Aa3VYpc6mBV2mGcm+FD7rQ38khX3MSljn1Waqf1lQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVC8G6V4uBF4a4DPt7PhMWBoR3clEaNughSf2KEBRyw=;
 b=WXwuMonMT1kCAFo9altbVLwS4DpXbalZ/FRiqThZy+zzEiw2ltz2+A9iPMrYML3pA6gAmsCV17hJd46ybxxDdup8cG4UrY2B/Ue9vH3LHy1DgG2kZbAdsicmafcCBsjyW+ATAa9sudMOPI5L0ObIu33owldy7KwEQGqaN0tFylYTG3GxyqnEwGCZvagLksiWV7ixLdDr1DYsSeKbtsZrgBMIp/hUI4knYxqcI8NK8JP2ppMq+vBqh/4x9zD+PttxbdBkicF4+KSTvCYx7I/jBL0ptnrthDseKxU7LmNI3ou7dhBxgCNB10T5yeQE0yOMln/dy4YCFFROR9TDRYzaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVC8G6V4uBF4a4DPt7PhMWBoR3clEaNughSf2KEBRyw=;
 b=ndDC93sfMUwx1ZwesjUojaoCjNO3+Mlu581Rf4y8c81NX7h0udtMGcaVQwQbfJ0FX6Tib3k+dLEAhXaGiJ6kvrJ6i4bMwcboOl5Hy/H1NtXQxhUS5x9sLGEE7M5TNQ2dKUM28PTaDmpFrXTxZnUoWvWuDUJ5WpwIvJtaTO/WVo4Dh4MlMglwZaFP2acE68er4OetFzUnmFfoF50Knc9hgA2T+6yafbXBacjw5QLAQnu2SiFqTYw7czKzg04Ibz96CCCrh/esr1QQyGchpw4HkBh1a0IoSXa0AiYsnze0GAehW9M3/pU9K2ee7oWAGB4fNXO+2ynXqkrdmjaqMY/orQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8456.eurprd04.prod.outlook.com (2603:10a6:20b:3df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 12:16:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 12:16:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state
Date: Wed, 25 Nov 2026 20:13:59 +0800
Message-ID: <20261125121400.29474-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261122205136.138173-5-dario.binacchi@amarulasolutions.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 983caff2-5e4a-40d1-f827-08df4aee0064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022075727099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Bw0e5dm6zTohntyMy/EqNhj/p8k/CF/MumMYuSuOksEgkyyqojiHA/frZ1kgn2hdvacelcUHUNIE46iQ86pqJdi0qKbGLOL1H5FxN4oROavnEMDmytg46J4viGmEb1hMLBA6F+wy5qMplZczyRmgGhTNU5JUDZHuKQ/hiE/bIgyKRpEhrH2tJS9jUTvO5QUrVYTzhLFdimI/oG0lauSQ2TwF9KZYnHZQSUZiMoJiu5E2mBCOuLBXJnpdGfsyL6O1oNRoHtoj23UF/JyVxA9MtMJ28+NGhxkR4fU4lIKPktO2AOCz+OVx8/bXtyp8I2aqUVcgYBKn8t01afS93ipJot4g/icwsOOhKo6ivjY7W0jyf/0bfSAmxTR9ITdQwwDCIb4b3xqBkm3ZXRt+Kd2HxqO9SRfLg4uwrwZ7j7DtAe5EMe9b4yrPBPDcYsDyy+Q/owvGrHWYOcA0DeT02R2yRUvLZTMPYSd5VZl8/Y0ISb8f3qksz6dPcUYH5bQZ1RZBvpCfY4bvPnVSekXaWcgOhVxB5xXDaAWQHH+FI3rLynJDWgdknGdGEjXvIG52OWhryb4ooS8OnRLrsNPPwx8wavoNFDsLS6DzkNWR5aJ6KkpNWldFxBoUoz/DdJO5icJgTJx4SA+JKJagRnYLzAXsLmE+G+ThFIb/TkNHRkXgIwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?An9chuJx74zyo0Pr9ASCEmFqkOm9CemuJFQtkCeYnms2O9kQPvDFtlB6bTP1?=
 =?us-ascii?Q?jCRZ8B1UAmcU2/jYkkyEnsTcuEtgVpmsDcgl6Z7FGN+yXweUXXbwZQZ71jIG?=
 =?us-ascii?Q?fgy+a4w6D/3dSO23M5T3ZmtkH1kL6QmKxnWX7MXInLJBYY9UAZJfyJurZe4U?=
 =?us-ascii?Q?ZKNCXthRWImYW2/KAnJswZtAEfqX25F6yFK/WsKMmybc+16jfSCnTQba32Mw?=
 =?us-ascii?Q?wmYuSBTF0hgDcVpqifpOjbJrexG6p+3FW+qUoYf7g4Zj1NlLTSvvvgTKAYXk?=
 =?us-ascii?Q?HYw7QxPGB8maaW+tcbYja4doIr5FVo9eSnePAAlE4hr2ez/+mKuK+oD3urwH?=
 =?us-ascii?Q?wVuk6uMlasM40CJvz1qHJnRPqwiuhIpvKqrHBccmbjyrkoDnPJpb7vz+mP54?=
 =?us-ascii?Q?sgliH7aklz3SUzj71+lht1D8rA2jJyQhbFr2Jd4SiK1AsnPUups1ZjYzRiDp?=
 =?us-ascii?Q?9OjuXed+ZcHB08xOhqvDrmbfWkgGh62+MMaAe0B+lr4LfDoOcIMXSFIFxwAn?=
 =?us-ascii?Q?HFOGmfzfY9ORZRUNDNDvpsoguHnk+v1w+NpLqTpTC1oH+oop99E9iONDmF/A?=
 =?us-ascii?Q?tyUV0VoKcFxhIuwvS2eUOd9pE3jziFmkuieoizxkuX0XMTWePyZbut/TBoGO?=
 =?us-ascii?Q?tKNYlYTiUrI9aPy01mJXmMw9LCtrTUT8RqxPDS0taMPUnIyWu0p0g2kz9DOq?=
 =?us-ascii?Q?xqLu7uEUpa10wtOa8c4JTB64g22A/E5sN9iRQqxSNQsT/RecshyN+4mxSgcl?=
 =?us-ascii?Q?sowh+LvPWoEgTC1fOQXiKl+OW9vQtwZ0H06gIF9zNXiu0ZWPOZhSxpxOmLBU?=
 =?us-ascii?Q?ir1Q1WTHyFaZJYdgqG06Ux7QNOc1wStFnsom/TN/uUIhm+ikaIeBBoz07ovh?=
 =?us-ascii?Q?/fteUBBE8elq9J1ehFXpxa/XyhyjEIKb+3b7pY7/VQCTjYHQhuUlaPjPTJWw?=
 =?us-ascii?Q?0vFU5IB5FwyZO0n9FEx8+WtiAq48lB1GwNx7uRGM+kCunnWA1N/gd3EsdOJL?=
 =?us-ascii?Q?FPYS491C1/pY2j2tkAnZXMjfBj9sfiu1F/RMYDCKSyw62zvmanrwtgjB3Rji?=
 =?us-ascii?Q?aV2PSJCiCoSG8/dmnc/LsclhqID87H8FscC4DtzZLhqlqCEg02H06GlTXRy3?=
 =?us-ascii?Q?I5FbpS8S6fWePJ/GdJujzft+/kuIhqdul5kXrfxIuq6yY/mT8z0muN6p6xVd?=
 =?us-ascii?Q?lBlfqBx17alBMacmALlbwZgZk1esoI3czs1DDJOE7OmR/t1dP3H70TKM3ewS?=
 =?us-ascii?Q?gWqEp11G6oEiktT3ZZnT3iPc7R+8YDpJcs1CK9m5ntTTuqpzvxX69SZmiTPS?=
 =?us-ascii?Q?j/7ZhjVflx2Fe7CsKLDFMIiAAkgjIglNijYgGiDYD2faZexV3M8Xzpq8GJXP?=
 =?us-ascii?Q?pwdL7yjPWYATJJpts1+z+NuL5dnIkwvbWLDo94a3tjEAt1mwGURxQxRBTYl4?=
 =?us-ascii?Q?GtHFeQ/fH++1G4JmenlCFz3sc6OCZYyuT6NIUZbmRsDExGqk9rt0gB63XlgP?=
 =?us-ascii?Q?q+AAepFvinNezKJbFpEv8v/2CnYyIzDUx1i3b0bCdwvaqVBYLqsnW4ktMm+D?=
 =?us-ascii?Q?oq8JdHyKkboERQgmjV6fwwyT8zFJHSVA5kziglByomEBWVjNBogXiHl200lI?=
 =?us-ascii?Q?Ard67/qZdmxV+Obsi/fzmeSauvcY1PpwKJOmIXZ/SPHq9BLmtrzYCgZSbOl4?=
 =?us-ascii?Q?ZUoaISzYE6nMDLvGaN+eDAlwCK8d/oOrPLse5M6YlPBLoD2zBVBDI7TeCX5N?=
 =?us-ascii?Q?27MaE5P6Uj2x7mvo3CNiiZr75A5RQB3IT0YGrfLcNG6MhxgwMzJ8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983caff2-5e4a-40d1-f827-08df4aee0064
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:16:58.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X/70icODJ/4XuuL8zjXBch73A9MmXl9NsHWZ5/LWQuEqqCML28mm2vxlfzGQXugMupVWUJPsZb+nVrqeBtzF7JAHnGw4z8i3GyFqcpHqYOmwBClGk3aZhRIAY8UecHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456

On Sun, 22 Nov 2026 21:51:13 +0100 Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> The clocks of a domain left on by the bootloader have no user until
> its consumers probe, so they are gated when the unused clocks are
> disabled. On the i.MX8MN, with the LCDIF driver built as a module,
> this stops the pixel clock of the U-Boot splash screen long before
> the DRM driver probes.
> 
> Keep the clocks of these domains enabled until sync_state, i.e. until
> all the consumers of the blk-ctrl have probed.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

Reviewed-by: Peng Fan <peng.fan@nxp.com>
