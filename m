Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FA4BFE72;
	Mon, 21 Sep 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007029; cv=fail; b=uIZjpanEdfGL1rOWPg/rTty7GFfQmn22F6DRgdmSJMAVJN3I5dfwoneU0Bpwdu1MZEA6w65QYQvSb3QdFqlKVmbU6dW+7V67/0TgXIJjd1Vb6W2xLTF5yjtoa3FNOsk4TV3cr31Vnp00EEqjX21LXw6cFx7Czv1MU1b3AaU+OtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007029; c=relaxed/simple;
	bh=8H3ivygizFuKFpQy8n6N0N/zUfqREvdozIP5AIW6Y9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iJX+xLLgLOmTbciQS7rU7M9wUZpYmuOYrJvvZL9Cl6TzfHV6Y8SP2gd5BrEM9woGLHvrCnrKmgwxYTU7BrGz7ZAsN4mA8TM8rewiY1XaDEX+WOsran4NptcDcj3hXLorhMkMzwXUYaK7Ii6gSpdJPyOWVwfpgHNzTgwqrBb+p7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=coM4ejlZ; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="coM4ejlZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtCU9VONJLJOBbXnKz1GAyx8PveXUmO9Sevjt6Rn3bs6RmBcIvXleXak/hpQhNIggk3WlGUb3QWpFPJRaOXQYdyUKBLsxXbevTAd9jeYEVE5JvFt4vdwruKA3OJ0cAGxLS24EkQ33XdZndfHKK+gtFio74vneMfDZuGbMW5zZt0K6Gj2DVXPIjAOfuaHsyneyG+9BPShkBjMsgTFz37Oy9Cl00XKahKr4ihx7iVko25pKKkakePPs50Byto8wBAW1eGWgQbQoSLL1UPJGPfRWYzwKbe/itppgIe1cFi3pDtzVheWoZKxGlb9WlvTCWVt7+l5Jq7b3RcfYoYiMTYfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H3ivygizFuKFpQy8n6N0N/zUfqREvdozIP5AIW6Y9o=;
 b=dBBDs6fGLdOwhdVoeY/21BKpXag1uQkzb64ofyK4Wi+uX7ZPjm3WBwbQkogaqR4gjPQ07EfW5TixnND6a4uvGsPlbkST5If5mHy+IOflVS/mpLdYj/RSfPpNIU7Q5X8BUrb5jbC68UDZJNgdXOzVFYYPF8mKjZDv3mnRMyCJXky7jyvbE0/6SfGy9S8kP2mz7EOSyC8Z1rx5HP/oB+nYIlitSxNnSazlY/XSDzINTmPclahGQpHUiGwB4tklMP2mU5LUczEaTJIsKYivfG8Vlj8gfMisgM7cDnx4ieohKXQ0OCqaY6BTlyY2Mqfes86Jr2Dy35g2041mpl9XtoLnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H3ivygizFuKFpQy8n6N0N/zUfqREvdozIP5AIW6Y9o=;
 b=coM4ejlZFgmQZF9AhfPdSVS91MrA8invSsKWeq5C4k4huX5NRGh7Y1lBjNyFifXkP1DwS6/CzFzLR7VtRf3LAmNdNpn+Lgf//w149pm8TMH6m4UUm/ILaGz4DG2VzpfY05ymSywYVSSIAh6IqOqdnBY09jY/UDaqlyv84d5JfS6SPNgPoY+FsV9lIhFC2PXg6pWWWcPEgYWTP+EgedzkpW6JhgEQeI3tDaHOloCWk1aT8wPAoFX2g0eIgsEw90T+UltLH0LFpeg4V8w7DEAjYSNZKMD5zlm7sIyglbiy0m1CP+eKEaW7yI9IjCXeCS/QOe3kUNZpDpQx3U2Qw3kB2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7580.eurprd04.prod.outlook.com (2603:10a6:10:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:10:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:10:22 +0000
Date: Mon, 21 Sep 2026 11:10:12 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Ming Qian <ming.qian@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Zhou Peng <eagle.zhou@nxp.com>, Xiahong Bao <xiahong.bao@nxp.com>,
	Ming Zhou <ming.zhou@nxp.com>
Subject: Re: [PATCH v3] pmdomain: imx8m-blk-ctrl: Serialize power on/off
 across sibling domains
Message-ID: <arFW5FryhHsf48Nu@SMW015318>
References: <20260921-imx8mp-blk-ctrl-v3-1-c86b0a9d4781@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-imx8mp-blk-ctrl-v3-1-c86b0a9d4781@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b9750d-4c12-47f9-78d1-08df17fad68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|19092799006|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V9RNEeqfBVgKaLgE2doOuksPLdYTofjQCoxHjj05ydY0Gv0PkSHQSLh4qS4YPKvg0BinN+WnkkZhpP59j7No43whssZc9/DriE4NCXbmOCXVbqNqCBpcQiw6RC18iMEMujjYsuQpXeLm9zD0U/zM7ITMlEuvniEStzIb7ZsXpsS7a+eUrjSBrdL2NXNGNjVpfBQm4i+fTTkdbnTXVuCTsWj1+QjDsnsR7ON5uTWbDA/ptEhds/H3x7rKM89AmAeBfwtNubLcAs8QeSVRldyZhjt6ZqldWFUNRiwginLuQ37BneOInmaDPG5EfNOuZ/lHpJJKwubBu6+N8xpVoqlIMQbOdkVfRvLqtLfTbdw9rRJCs7AwZkzsV7jzLmRvxU9F/OFJiys1sQ34hkLVwtoxeFF2i4a2IlgwiSkdu9CKZ2XxHG0JNTfuxTVYBTGTxoUvE+CjSygq6nZeUODYIAJ5N9qlXMcnn+6782dasxS0ubZGc0F4IQD7l/Oqeqg7BWbfJ+eph0E/mLY5pCXtaUDQ/DHvF04KVVTIoQPE+cr4qoXXlzxk2hNFHvbiyXQ5wW4rYh1gcQOAkp9WzdlOyllOE9f8b27w/gC5nLs6k0puzAYC05ePdqRAQ4kqvELQOovgxKpL2yWEZWJzPSiAsbB11gi4oTistNZtg+XNWra7zro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(19092799006)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XEaVX2ACAB8ogfhIEUsVqhqlIHwz9x8p6dBuejKWUZ9HHXPgctPB/XwmkK9a?=
 =?us-ascii?Q?pA8APsoviKTeLJtQR0Q+uKjv3fn/wiEiJelR85bAoB0/wI8B29RqbW/VZKdd?=
 =?us-ascii?Q?f0neezsOO3FtDVY20aBr7D7JFYJaa9xGHIGyRy1XQNsPdAiY6lpJ/Hk1T3P9?=
 =?us-ascii?Q?lsxRixYFGoqRetSm9dcpPlvaGRjNY2GRg6fh1RJ+s4QX4bM0cqFUXk/mee+O?=
 =?us-ascii?Q?yEl7bpA1G9e5zKsryQola/NDhCvQSjMEddJmp/PhgyqhPM2HGdzItnxVMEYu?=
 =?us-ascii?Q?guS5CVgC211o3RAupJQ7cIEidoLZtLZ8mgVd/cEGfJw4wZ/PV3yqQGol+Fyh?=
 =?us-ascii?Q?jDHZrk1yd5G+NSnKxAKEjMV4VjVrRhIRE9f1FXvoEYL9IHdwOyZMNGZCMOsU?=
 =?us-ascii?Q?6df35+40ZENzBT3s2YrIVxSBGNK37nbgpDbXLHl7hIYaitSEbzlFgmZGxFyq?=
 =?us-ascii?Q?LqZg/+N3UDfiYTAR+Q85BaXjXSNcCepJ7bYsZBTeeacr53kKu9RcPo4+zdXR?=
 =?us-ascii?Q?3adIhu+njK3lXX1LEBp+ipb1SlPk4MnzHgm3PCCQ3PdlZ2X7D2xmI0bq2Jp+?=
 =?us-ascii?Q?xhtiSWBiTOmZqza30FyD+4mBZw/j9T8guPLkgtrEAcgaNjnc97VJy4M26YIa?=
 =?us-ascii?Q?qE8JxC+LoP6a+peNDDfedhrospJ1kDY/pFBu5WcQ+7oAlbllQR6kZwDknkCn?=
 =?us-ascii?Q?2OK2SRi4OFR/TcQIeU0X/NKy6pu9JihupRdoAS2ckgdNLF9Nndej6Ic8fh43?=
 =?us-ascii?Q?OmP0E4aezxnHrn9yPmOxXtKsQoF8IT3EAUXvlaRCS1VrStE8lWVRq5ThrB7t?=
 =?us-ascii?Q?ak3efk5UWdRaaZ+n0H8M0n2RDjSjRR6VrsAtrX4O7xYWnZCUhAJ0V21EpzM+?=
 =?us-ascii?Q?tQ415sD4G2lK1e76sxe8jx0H4Q8ippSzuwu+7zVimbE5/GalG82EKiVwrqe4?=
 =?us-ascii?Q?ZwooxweT7YZnpvdPssyaYMSc69AiFLH+uCzZwJv3KnhU6kgrC0qGszzz8sOA?=
 =?us-ascii?Q?J2NWM5i5AQyA4RFJ354p71rgJ9N8vOd0lN33J30M3CNMSohuXhByQqRnGadf?=
 =?us-ascii?Q?4cstTqc4iMDa5GMEaVyW3XoKdxMCOVJ9kdCheDv37rjraXMU8pcbo5WMA06l?=
 =?us-ascii?Q?GZU39s+U1Gn6SB37ELBPc68jLpOiJ28HJs2qtl4dYKB6XlSOZyq3BoZ9br7g?=
 =?us-ascii?Q?/nwpVN3afyh8Q7uOu3RBfZKrM8x4sYjel1x+ShuCoW0fWHzO44IXKdzkXrc+?=
 =?us-ascii?Q?dbmnID/ugFPjd+4KEif6M4vqU+rM+5ItVW1ig0UaXS7A+sEUL7wj9fLL+Lrj?=
 =?us-ascii?Q?xL05wGOR2jtLOQEqKBWhGRP93nDBv5Pu2pJj9Cz6WDUWxHf8AwK6X4SDUipB?=
 =?us-ascii?Q?OQnnfuOpOXzSC7RxGXlIqaaI5bdx0PJ5O0f2bUzdh7g4z1YJnmo6etcxI74/?=
 =?us-ascii?Q?khr0YG1VOcaTQlBnfXU0Yhl0tggNjALlFdlJ1wePZBzvQ87Ik0CJAS7vaQdh?=
 =?us-ascii?Q?EOMTjdslJLbz8sUmNXZ0gj2lPE27GEZyYEQ2xCBVGJY3ptTGO9CoJb/DrUUx?=
 =?us-ascii?Q?NYqNKPuqQD0xyGfI+6PJMOEXHmIIBayelEQw/DQMnzS6GSWQITfH1gsnvT2o?=
 =?us-ascii?Q?8f1TIP4AzRTdYeJfmUfa2q5PIoiBYPZRd1oBAzEwdaGdKvffjDIlf9zLJg/l?=
 =?us-ascii?Q?NJc5bqdzA2cw4PoTNZvQNatUI6BBysw1vcRGq+3EIvhxeCQiU9rrIkGwo3H9?=
 =?us-ascii?Q?M2crnXD8bRBBoHR1knIBete66DsX/1g9xppv+90hkYdeGPe7Pa1n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b9750d-4c12-47f9-78d1-08df17fad68b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:10:22.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsLrfds1DfcOkmdMbcSwGxY7WZLgJ8XSLTTmdOs9Dd47Lqze3jPv9DCf+fluUAXqkLiwq9s9rqgEUGsLBNSEJP61Qn7WU+n1x1EyGQ6/cR9K5bOAanuD6XH51KCDSK5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7580

On Mon, Sep 21, 2026 at 07:03:34PM +0900, Ming Qian wrote:
> On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
> genpds, each serialized only by its own genpd lock, so their power_on and
> power_off callbacks can run concurrently on SMP.
>
> The sequences are not independent: they share the VPUMIX bus domain, the
> VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
> the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
> clk-en bit - so it just waits a fixed delay instead of polling hskack. A
> sibling transition landing inside another domain's reset window disturbs
> that shared clock and handshake timing, the victim's reset does not take
> effect, and its block registers read back all zeros: the decoder times
> out or the encoder fails its format check.
>
> Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
> driver deliberately avoids a genpd hierarchy, so the genpd core gives no
> cross-sibling serialization.
>
> Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
> Problem:
> On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> concurrently rarely and non-deterministically leaves a VPU stuck in
> reset: its block registers read back all zeros. A decoder then times out
> or the encoder fails its format check.
>
> Root cause:
> The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
> serialized only by the per-genpd lock, so on SMP their power_on/power_off
> callbacks can run concurrently. The sequences share the VPUMIX bus
> domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
> not ack-verify the ADB400 handshake - the ack only completes once
> blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
> sibling transition landing inside another domain's reset window disturbs
> that shared clock and handshake timing, the victim's reset fails to take
> effect, and its block is left in reset with registers reading zero.
>
> Fix:
> Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
> sibling domain cannot run its sequence while another is inside its reset
> window. The driver deliberately avoids a genpd hierarchy, so the genpd
> core provides no cross-sibling serialization.
>
> Test:
> i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
> this patch the failure reproduces within one to two hours. With it the
> same test ran overnight, over 14 hours, without a single occurrence.
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
