Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795031604;
	b=0OlMceBpASBqeRXiE/tBRD3DHFpRvG+Rgf4M5/iBWVa4/RMn+yFB7I+9989r2NhWBWeE
	 mvWJhLU9pcXWitBnfzdYfTXu8Ub4XCNnjLj0JiIK5H9kbszxfBnRMaatAPLl1HP/CGdRd
	 oTy2uJi5wH6AUf0EDZ+lppWI58l+baVCFCIixO9PCfXEeVmWraDEApj2k9mEfaOoNL+ED
	 HfdGVsybo+6lTKjTHML8kqjsO9eA8XaeUqvAL4a5h9lqsVoEuSl4iPXv1Nhnmt8cwHoSh
	 Z9uesn9fHuRpRlqXgPu0PosKPnsBOIT7FALqkeOvTO6edWThKMmxPp5sDxTFrQ5XyJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031604;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0qLvS8HyY33C18uwySXcG4KSwLWIv6i5SrDL0fZ0bpU=;
	b=vcCeFY9ZtCqkQ/UNfgKeDVlNUImkbvB3T1hZF/jrlpAwzV4BXpxw/ikJmpIwjNvpPZ1v
	 aN+4SbieSFXNW7gjHT/7OFdxDSjeQyWWVj8U4X6oez9Un5oaUWA0+kzKRGffG8s9Tb5Sk
	 0STykjSvj2+eHGrVCEF0Q162YstybELt8922GibvCEF9BXYIt2NmrYgD0ix4aEYa76cnE
	 CIy/5BXWwPlxTi+VJFnkT1Fs37euV0OhorFgtjSJGN0GBDU4N/WSvc/CjXONs4zKwO8Yf
	 eKugWjquF6v1q1FrIrTwzCSILV1Fkjh8bchyqa8WXervoSX3uLygHWJV0Yl1/VjNsRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bRlFGNT8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.10
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D217606A334;
	Wed, 18 Nov 2026 19:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D217606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bRlFGNT8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brCyxo/7vDW7cwtb8xQaMmcnaPQB75NvKpCX4ic3MpVt4z1SC8e+IuRhVhWjTuNkPDSGGiAgtccSR0gjh5/M0iVedhj2PblwO4UsZxFwfY7nbqhVAxjUEX5WlO4aEyv/4/OppVd+Sjm7BVZ06hH+Tna+VzYMi0fih0P8uYYBCzTI3dmr+QW4L8vEOlPubt1TxocckDcXpvJIgMjvAvWZSiSQb0U/gMbsHV2oJ7rB3cfsJHXCWlG7RowTS7yiwJBfK0YfAnONUYnCllQFxt9wcvI7Xrowxg7zZA4VqTdd7oW2LM94eNV917TZL/jm7hQvcipPdXMRXqCjAdcW91Hwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qLvS8HyY33C18uwySXcG4KSwLWIv6i5SrDL0fZ0bpU=;
 b=bz3UZxBnNB2zE93c6nh1s7jdq1TfGgxM6CKnne/ox1xR4m+pbnsIT0AevADx2Ln3owTNcxJJ2SyjBpQaMkgP4NCtMx746fdnPigQ5jTdMoB81H0KztkTvO2pCBYsqPsWcRTggGJ433cT8viMg/URXF1Be1WrA7omSl7vngVU9yWRKC1cCaHFD841Iv6rNuE+0/TrcI9lfKhf19NJ5tpdgnkFDqUpvcV/ETQhkDO2iIJwjLoJHQyt4nSI3BIqAvos6ZFoOFDiLDwU5xvcEn43gPaTyiAMlwVK9/aqdRs4zKOeFipYlnsnczEUifC85baxNzPeZ92jwyzubL4Z0A13jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qLvS8HyY33C18uwySXcG4KSwLWIv6i5SrDL0fZ0bpU=;
 b=bRlFGNT8Mf8Pncoy31k2BZ0qOedBB4Gu/vws5elpN69h23Y1axcyoXgAen34/E3tGZSqs/CzdoYsrxDnU+fjAI7Uaxx1dsOZ4kN5fAOElMDIS8a9401t0EyvNn6igCUt7axbfmOwZR61ZeGMNlVfjC4+hWf98dH5EkKPro8OENjHSftKbvu2zdWxlu5iCNFMr+f38TTu6CJwtF/thWciQPAuXvU4S7JKrhLibDAntV8p2y9Kic/8AU2owiYR35rr5zbI6Gtbz3jCuRYNTR6TtK2vflMuBxxWF8PQCDPbWWqho3yQJPG9DrWtTInTRbdDXLCIlpO1tskCodCdS1e87w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB7893.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:53:19 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:53:18 +0000
Date: Wed, 18 Nov 2026 13:53:10 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ste_dma40: Use power domain for LCLA SRAM
Message-ID: <av4CJkri6LQO9FxG@SMW015318>
References: <20261115-ux500-dma40-powerdomain-v1-1-da8b6e1a0376@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-ux500-dma40-powerdomain-v1-1-da8b6e1a0376@kernel.org>
X-ClientProxiedBy: PH7P221CA0035.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d58961-e260-4dc0-8ff7-08df45ad97c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|261022113327099003|261021135927099003|261022075727099003|261021123027099003|10067099003|11063799006|56012099006|261026135527099003|261022115727099003|261021133027099003|261026140227099003|261028144727099003|261021130227099003|261021121427099003|261022105027099003|261026130827099003|261026121527099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Upt9hohSbvUu3yKPFPAAh4MhyCKAeO53LkZpPYu0UT08+g3albE4OH+sfVeP3YQIxBPwwpruqikShpuzisy4CCiFWPYn89+7Pb7SBKWji6+p5VLEr7990/d7My+sr/w2HIJnj9PMlaf0BRTy4wy/btXzPVHv9oyCEZA0Hvyen651JXD1Grg6KmMy95h8JkPjFkLHlv+DizF+VxQZK6ayVagxHwGA2rP6xKNY5L064EdpI4j9TU30bIl6UrMJ/pd/8OsZtpgVIUGuz44RaXmUbLCpXa34oHo55juHjgcBcnHeA//qEvvKE9aQkCGCu2JdLRNtqnZKCL0VKEpsEiRQvi8c8jg99Uezd6EqghA7Lvv/b/UaPZglVT+6hptBwIJDuis54L9sLldNfHWpEl/AvKcwsoLMH0ow6U8gFF/OoxAXbYtDhO69ngvAak2JikMCr2tUlVTQe0DFuyYUZmJU7URPaoBDQ1WE90UyGbhFIGlDDdrW53fI6zHEzaw9OJQCvmTcZWWnqtRCy582Cj3d2uOrrn3oD5mMBtvIFG2cjo+b/KeG8FuYOChKCst9mEhYxKM5DGlDXpsPxdHN4k5tFK4qIsdjke68XVc6I93/OBvD43x554xdwZjzWfXdZ9itT8ySmdpJet9DSRxSSi7iYPLnvAVfGopHB9SWdOIruJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(261022113327099003)(261021135927099003)(261022075727099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261026135527099003)(261022115727099003)(261021133027099003)(261026140227099003)(261028144727099003)(261021130227099003)(261021121427099003)(261022105027099003)(261026130827099003)(261026121527099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p3GBR2L2Epq8nCyYfSWBueSmRkZ0M2R6apPZ4s2Q7nFHhzx/SBHQlgR4SS7j?=
 =?us-ascii?Q?Ffqrsj0bubA+Uc2TT5SdW6KY9mJvJI5t+OYCaYenRhCAX1TGob2N/THKyuAp?=
 =?us-ascii?Q?19ENpQA6qOnaev0FvbABBJ9s7m5UBxn3yl8V571YkotS35w7Ugd8YbOxwz6r?=
 =?us-ascii?Q?EBTIE/29URV4udgzLh3JL0IH8AEY6PE131ihzD4rG7ynhWNIsnd6yJHUExC+?=
 =?us-ascii?Q?QE0yHAj+bSOFJYoslnSfjHrrEkUVD7EXG8SytALlGhax0or2eltMqV5wygtu?=
 =?us-ascii?Q?jL+zxjn7CT0F225dd3V08UQ0B43p1y3fidpBWWFFRc5vaDdQvxgqR/vANiCj?=
 =?us-ascii?Q?D8on5C2SKu5i6v7LSJ3ykl8gViPR7VQW0gEi/n3AOn/MXL40ShJTWJqY5bZh?=
 =?us-ascii?Q?BVVcj+EtOEE9XIlmCoFNejaJ21VNaYRiAlfuSgcI5KO//yxDw/7IC0jYa8Nk?=
 =?us-ascii?Q?E3Wbmd8IZyzeqZXrfBAS3hV1v5a4EYbCRrLZNpz88Kh1ogOEtdCH+LfsUMhV?=
 =?us-ascii?Q?Dz7ErZgVa8Q6b5Hm40Aho1chI39KqQyovblF+wcRVsNH1MvTsWADZ4mp5/Gn?=
 =?us-ascii?Q?32xID6nn81kW4mqIaKyrIBMzg9QsXKxKT7X+fFQFv0apZSVAf6kO6bYlGdS0?=
 =?us-ascii?Q?b3wBO8QYO7F8Ru0AopoWcmQMn/n0smENr+/y9pcXbCNaD/Ig7Ijjv6MV7D4P?=
 =?us-ascii?Q?vbm9zKxhZvf83S3Cwc8asaBId6KNwTEoQvqn5+BjypnfVf3DHhNKl2goj68P?=
 =?us-ascii?Q?1rFgp9TD7a3++zi1YD1y38AuEbhlpmuFZGwzNfmwBXqZtA8w3uS7zJJ2vMPL?=
 =?us-ascii?Q?SyK9lqEaBiZPJtPkC495fKX00NxYkr2fHyza3YwuxbyxrlR3hQwHivXGcedz?=
 =?us-ascii?Q?h+3TUIpjL85rW6qA4e5kCaQio77iomnMlw2FWXlPqr2YtrAOW+oGTPUUWZSb?=
 =?us-ascii?Q?7PfoWRU900CP3K1sTYmmjqyrqv+SDsBzn0Tl+WC8UXCg7O2GAyD8cmqAoR5x?=
 =?us-ascii?Q?Vt3zHyMt25K7VL56rOKnybvgZ8BHs3M38ZKDe5m583VAI+pYA0FjNOFFcKiE?=
 =?us-ascii?Q?AlS7FjUmna+eF3gieWymsgyuVsKUXiCjcMhqeE+No7mvjHAMYfCpTxJ+XFmj?=
 =?us-ascii?Q?OVNEsWkwLve50bxZL077rs+cbZ1KKpXnxEvc3056rOrJAHYwZWttH35Y2FA1?=
 =?us-ascii?Q?4dHePkkrNw4nDylp6TAsbLafufV6ohL0JnlMtdv0cyuY/pJahzL5Yg++qXPG?=
 =?us-ascii?Q?UiPPqu6WhMim/WuWT1YQFwakERcwIsgc605H40j7jMjMtHElubG4XJptv9zZ?=
 =?us-ascii?Q?I+gr8c+6xJL1NPgZMdLepQ+Vaq4lRhWkSSjRSl11UXFRfaGWVjIa8+sC0YhF?=
 =?us-ascii?Q?6OE/xg+c2zaxHRtWBNrDgRMl4VmtCH8QOqrYUsgszB5/xg3z0QRXbnh13/fz?=
 =?us-ascii?Q?AyVHSCqTUWMj2syiQ/5+GE3+0xSIGWTL1Ra31AfSpgxFUFQmeESIKBLNDgHX?=
 =?us-ascii?Q?kCz/+2cO3WojMDF/7iPywcWhzTnNwIcr2AQRyKa7r1RrlM4p6HmCDFXwJ56e?=
 =?us-ascii?Q?ZC0EjZNj8mFo0ot1CfRC+pZGxV10Kyh2PlqO1OZZ2vXn2k/CBj98HExLi/MP?=
 =?us-ascii?Q?QmR+Eb0P12M+fJPk9q6XyZRbdlio0HP2/Kjj/OvhJ4a449qxNZSZjCT9IUHQ?=
 =?us-ascii?Q?AnSkHaZhjomMBZWEasd0jJ2mnVIzvegAyHD3T6xqePjlZcGqvjNa7oQ2yrOI?=
 =?us-ascii?Q?edlrZkt7UC8NSJ7DWOQXY8TeVlEKLa7WHl+uw7Cj2UgX4yMiCZSc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d58961-e260-4dc0-8ff7-08df45ad97c9
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:53:18.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JxwFtAmV6TtdhihrTN2HwZqA/69yus3TuEceLt3dNYSFWUdOq4ZRD67odotjCW78ZHMupM0XDdidiYBa+vbRQybgDc4NQw4nrmy61XS1rl1L5KxzRjkWKgsD0TMqsX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7893

On Sun, Nov 15, 2026 at 10:26:27PM +0100, Linus Walleij wrote:
> Replace the LCLA ESRAM regulator with runtime PM of the SRAM device
> owning the ESRAM34 power domain.
>
> Use the existing LCLA SRAM phandle instead of the never-set
> use_esram_lcla flag and the obsolete named memory resource.
> The bool indicating if we use LCLA SRAM seems pointless, let's just
> check if it's NULL or not. Simpler.
>
> Acquire the SRAM runtime PM reference when allocating a DMA channel,
> before taking its spinlock, and release it when the channel is freed.
> Descriptor preparation can run under a client's spinlock, so it cannot
> synchronously resume the SRAM.
>
> Acquiring a handle to the SRAM can fail and then we defer probe.
>
> Since we can defer probe(), probe() and friends can't be tagged as
> __init anymore, and it's better like this anyway.
>
> Keep a stateless device link for system-sleep ordering without adding
> a runtime PM dependency to the IRQ-safe DMA controller.
>
> Suggested-by: Frank Li <Frank.li@oss.nxp.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> The Ux500 genpd prerequisites have been merged into the powerdomain tree.
> Probably the fix sent earlier should be merged first:
> "dmaengine: ste_dma40: Keep prepared descriptors across termination"
>
> The SRAM driver will be patched separately.
> ---
>  drivers/dma/ste_dma40.c | 253 +++++++++++++++++++++++++++---------------------
>  1 file changed, 142 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index f1cbc719c4f0..eca1ae95fe1c 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -21,8 +21,8 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_platform.h>
>  #include <linux/amba/bus.h>
> -#include <linux/regulator/consumer.h>
>
>  #include "dmaengine.h"
>  #include "ste_dma40.h"
> @@ -41,7 +41,6 @@
>   * certain use cases.
>   * @num_of_soft_lli_chans: The number of channels that needs to be configured
>   * to use SoftLLI.
> - * @use_esram_lcla: flag for mapping the lcla into esram region
>   * @num_of_memcpy_chans: The number of channels reserved for memcpy.
>   * @memcpy_channels: The event lines used for memcpy.
>   * @num_of_phy_chans: The number of physical channels implemented in HW.
> @@ -52,7 +51,6 @@ struct stedma40_platform_data {
>  	int				 disabled_channels[STEDMA40_MAX_PHYS];
>  	int				*soft_lli_chans;
>  	int				 num_of_soft_lli_chans;
> -	bool				 use_esram_lcla;
>  	int				 num_of_memcpy_chans;
>  	u32				 memcpy_channels[D40_MEMCPY_MAX_CHANS];
>  	int				 num_of_phy_chans;
> @@ -301,7 +299,7 @@ struct d40_reg_val {
>  	unsigned int val;
>  };
>
> -static __initdata struct d40_reg_val dma_init_reg_v4a[] = {
> +static struct d40_reg_val dma_init_reg_v4a[] = {
>  	/* Clock every part of the DMA block from start */
>  	{ .reg = D40_DREG_GCC,    .val = D40_DREG_GCC_ENABLE_ALL},
>
> @@ -319,7 +317,8 @@ static __initdata struct d40_reg_val dma_init_reg_v4a[] = {
>  	{ .reg = D40_DREG_LCTIS2, .val = 0xFFFFFFFF},
>  	{ .reg = D40_DREG_LCTIS3, .val = 0xFFFFFFFF}
>  };
> -static __initdata struct d40_reg_val dma_init_reg_v4b[] = {
> +
> +static struct d40_reg_val dma_init_reg_v4b[] = {
>  	/* Clock every part of the DMA block from start */
>  	{ .reg = D40_DREG_GCC,    .val = D40_DREG_GCC_ENABLE_ALL},
>
> @@ -413,6 +412,7 @@ struct d40_desc {
>   * struct d40_lcla_pool - LCLA pool settings and data.
>   *
>   * @base: The virtual address of LCLA. 18 bit aligned.
> + * @esram: I/O mapping when LCLA resides in SRAM instead of system memory.
>   * @dma_addr: DMA address, if mapped
>   * @base_unaligned: The original kmalloc pointer, if kmalloc is used.
>   * This pointer is only there for clean-up on error.
> @@ -423,6 +423,7 @@ struct d40_desc {
>   */
>  struct d40_lcla_pool {
>  	void		*base;
> +	void __iomem	*esram;
>  	dma_addr_t	dma_addr;
>  	void		*base_unaligned;
>  	unsigned int	 alloc_order;
> @@ -578,7 +579,8 @@ struct d40_gen_dmac {
>   * to phy_chans entries.
>   * @plat_data: Pointer to provided platform_data which is the driver
>   * configuration.
> - * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
> + * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
> + * @lcla_link: Device link to keep system PM ordered against LCLA.
>   * @phy_res: Vector containing all physical channels.
>   * @lcla_pool: lcla pool settings and data.
>   * @lcpa_base: The virtual mapped address of LCPA.
> @@ -613,7 +615,8 @@ struct d40_base {
>  	struct d40_chan			**lookup_log_chans;
>  	struct d40_chan			**lookup_phy_chans;
>  	struct stedma40_platform_data	 *plat_data;
> -	struct regulator		 *lcpa_regulator;
> +	struct device			 *lcla_dev;
> +	struct device_link		 *lcla_link;
>  	/* Physical half channels */
>  	struct d40_phy_res		 *phy_res;
>  	struct d40_lcla_pool		  lcla_pool;
> @@ -630,6 +633,25 @@ struct d40_base {
>  	struct d40_chan			 phy_chans[];
>  };
>
> +static int d40_lcla_runtime_get(struct d40_base *base)
> +{
> +	if (!base->lcla_dev)
> +		return 0;
> +
> +	return pm_runtime_resume_and_get(base->lcla_dev);
> +}
> +
> +static void d40_lcla_runtime_put(struct d40_base *base)
> +{
> +	if (base->lcla_dev)
> +		pm_runtime_put(base->lcla_dev);
> +}
> +
> +static void d40_transfer_runtime_put(struct d40_base *base)
> +{
> +	pm_runtime_put_autosuspend(base->dev);
> +}
> +
>  static bool chan_is_physical(struct d40_chan *chan)
>  {
>  	return chan->log_num == D40_PHY_CHAN;
> @@ -859,7 +881,6 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
>  	bool cyclic = desc->cyclic;
>  	int curr_lcla = -EINVAL;
>  	int first_lcla = 0;
> -	bool use_esram_lcla = chan->base->plat_data->use_esram_lcla;
>  	bool linkback;
>
>  	/*
> @@ -912,7 +933,6 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
>  	for (; lli_current < lli_len; lli_current++) {
>  		unsigned int lcla_offset = chan->phy_chan->num * 1024 +
>  					   8 * curr_lcla * 2;
> -		struct d40_log_lli *lcla = pool->base + lcla_offset;
>  		unsigned int flags = 0;
>  		int next_lcla;
>
> @@ -936,16 +956,17 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
>  		 * One unused LCLA in the cyclic case if the very first
>  		 * next_lcla fails...
>  		 */
> -		d40_log_lli_lcla_write(lcla,
> -				       &lli->dst[lli_current],
> -				       &lli->src[lli_current],
> -				       next_lcla, flags);
> -
> -		/*
> -		 * Cache maintenance is not needed if lcla is
> -		 * mapped in esram
> -		 */
> -		if (!use_esram_lcla) {
> +		if (pool->esram) {
> +			/* LCPA and LCLA use the same four-word SRAM layout. */
> +			d40_log_lli_lcpa_write(pool->esram + lcla_offset,
> +					       &lli->dst[lli_current],
> +					       &lli->src[lli_current],
> +					       next_lcla, flags);
> +		} else {
> +			d40_log_lli_lcla_write(pool->base + lcla_offset,
> +					       &lli->dst[lli_current],
> +					       &lli->src[lli_current],
> +					       next_lcla, flags);
>  			dma_sync_single_range_for_device(chan->base->dev,
>  						pool->dma_addr, lcla_offset,
>  						2 * sizeof(struct d40_log_lli),
> @@ -1661,7 +1682,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
>  			d40_desc_done(d40c, d40d);
>  			d40c->pending_tx++;
>  			d40c->busy = false;
> -			pm_runtime_put_autosuspend(d40c->base->dev);
> +			d40_transfer_runtime_put(d40c->base);
>  			tasklet_schedule(&d40c->tasklet);
>  			return ERR_PTR(err);
>  		}
> @@ -1717,7 +1738,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
>  		if (d40_queue_start(d40c) == NULL) {
>  			d40c->busy = false;
>
> -			pm_runtime_put_autosuspend(d40c->base->dev);
> +			d40_transfer_runtime_put(d40c->base);
>  		}
>  	}
>
> @@ -2270,7 +2291,7 @@ static int d40_free_dma(struct d40_chan *d40c)
>  		d40c->base->lookup_phy_chans[phy->num] = NULL;
>
>  	if (d40c->busy)
> -		pm_runtime_put_autosuspend(d40c->base->dev);
> +		d40_transfer_runtime_put(d40c->base);
>
>  	d40c->busy = false;
>  	d40c->phy_chan = NULL;
> @@ -2646,6 +2667,12 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
>  	struct d40_chan *d40c =
>  		container_of(chan, struct d40_chan, chan);
>  	bool is_free_phy;
> +
> +	/* Preparation and submission may run with the client's spinlock held. */
> +	err = d40_lcla_runtime_get(d40c->base);
> +	if (err < 0)
> +		return err;
> +
>  	spin_lock_irqsave(&d40c->lock, flags);
>
>  	dma_cookie_init(chan);
> @@ -2703,6 +2730,8 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
>  	pm_runtime_put_autosuspend(d40c->base->dev);
>   unlock:
>  	spin_unlock_irqrestore(&d40c->lock, flags);
> +	if (err < 0)
> +		d40_lcla_runtime_put(d40c->base);
>  	return err;
>  }
>
> @@ -2725,6 +2754,10 @@ static void d40_free_chan_resources(struct dma_chan *chan)
>  	if (err)
>  		chan_err(d40c, "Failed to free channel\n");
>  	spin_unlock_irqrestore(&d40c->lock, flags);
> +
> +	/* Keep SRAM powered if stopping the channel failed. */
> +	if (!d40c->phy_chan)
> +		d40_lcla_runtime_put(d40c->base);
>  }
>
>  static struct dma_async_tx_descriptor *d40_prep_memcpy(struct dma_chan *chan,
> @@ -2877,7 +2910,7 @@ static int d40_terminate_all(struct dma_chan *chan)
>  	 */
>  	d40_term_all(d40c);
>  	if (d40c->busy)
> -		pm_runtime_put_autosuspend(d40c->base->dev);
> +		d40_transfer_runtime_put(d40c->base);
>  	d40c->busy = false;
>
>  	spin_unlock_irqrestore(&d40c->lock, flags);
> @@ -3047,9 +3080,9 @@ static int d40_set_runtime_config_write(struct dma_chan *chan,
>
>  /* Initialization functions */
>
> -static void __init d40_chan_init(struct d40_base *base, struct dma_device *dma,
> -				 struct d40_chan *chans, int offset,
> -				 int num_chans)
> +static void d40_chan_init(struct d40_base *base, struct dma_device *dma,
> +			  struct d40_chan *chans, int offset,
> +			  int num_chans)
>  {
>  	int i = 0;
>  	struct d40_chan *d40c;
> @@ -3123,8 +3156,8 @@ static void d40_ops_init(struct d40_base *base, struct dma_device *dev)
>  	dev->dev = base->dev;
>  }
>
> -static int __init d40_dmaengine_init(struct d40_base *base,
> -				     int num_reserved_chans)
> +static int d40_dmaengine_init(struct d40_base *base,
> +			      int num_reserved_chans)
>  {
>  	int err ;
>
> @@ -3201,29 +3234,11 @@ static int __init d40_dmaengine_init(struct d40_base *base,
>  #ifdef CONFIG_PM_SLEEP
>  static int dma40_suspend(struct device *dev)
>  {
> -	struct d40_base *base = dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret = pm_runtime_force_suspend(dev);
> -	if (ret)
> -		return ret;
> -
> -	if (base->lcpa_regulator)
> -		ret = regulator_disable(base->lcpa_regulator);
> -	return ret;
> +	return pm_runtime_force_suspend(dev);
>  }
>
>  static int dma40_resume(struct device *dev)
>  {
> -	struct d40_base *base = dev_get_drvdata(dev);
> -	int ret = 0;
> -
> -	if (base->lcpa_regulator) {
> -		ret = regulator_enable(base->lcpa_regulator);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return pm_runtime_force_resume(dev);
>  }
>  #endif
> @@ -3313,7 +3328,7 @@ static const struct dev_pm_ops dma40_pm_ops = {
>
>  /* Initialization functions. */
>
> -static int __init d40_phy_res_init(struct d40_base *base)
> +static int d40_phy_res_init(struct d40_base *base)
>  {
>  	int i;
>  	int num_phy_chans_avail = 0;
> @@ -3405,8 +3420,8 @@ static void d40_drop_kmem_cache_action(void *d)
>  	kmem_cache_destroy(desc_slab);
>  }
>
> -static int __init d40_hw_detect_init(struct platform_device *pdev,
> -				     struct d40_base **retbase)
> +static int d40_hw_detect_init(struct platform_device *pdev,
> +			      struct d40_base **retbase)
>  {
>  	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
>  	struct device *dev = &pdev->dev;
> @@ -3592,7 +3607,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
>  	return 0;
>  }
>
> -static void __init d40_hw_init(struct d40_base *base)
> +static void d40_hw_init(struct d40_base *base)
>  {
>
>  	int i;
> @@ -3640,13 +3655,9 @@ static void __init d40_hw_init(struct d40_base *base)
>
>  	/* Write which interrupt to clear */
>  	writel(pcicr, base->virtbase + base->gen_dmac.interrupt_clear);
> -
> -	/* These are __initdata and cannot be accessed after init */
> -	base->gen_dmac.init_reg = NULL;
> -	base->gen_dmac.init_reg_size = 0;
>  }
>
> -static int __init d40_lcla_allocate(struct d40_base *base)
> +static int d40_lcla_allocate(struct d40_base *base)
>  {
>  	struct d40_lcla_pool *pool = &base->lcla_pool;
>  	size_t lcla_size = SZ_1K * base->num_phy_chans;
> @@ -3728,8 +3739,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
>  	return ret;
>  }
>
> -static int __init d40_of_probe(struct device *dev,
> -			       struct device_node *np)
> +static int d40_of_probe(struct device *dev, struct device_node *np)
>  {
>  	struct stedma40_platform_data *pdata;
>  	int num_phy = 0, num_memcpy = 0, num_disabled = 0;
> @@ -3781,13 +3791,70 @@ static int __init d40_of_probe(struct device *dev,
>  	return 0;
>  }
>
> -static int __init d40_probe(struct platform_device *pdev)
> +static int d40_lcla_sram_setup(struct d40_base *base)
> +{
> +	struct device *dev = base->dev;
> +	struct device_node *np, *parent;
> +	struct platform_device *sram;
> +	struct resource res;
> +	bool ready;
> +	int ret;
> +
> +	np = of_parse_phandle(dev->of_node, "sram", 1);
> +	if (!np)
> +		return 0;
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	parent = of_get_parent(np);
> +	of_node_put(np);
> +	if (ret) {
> +		of_node_put(parent);
> +		return ret;
> +	}
> +	if (!parent)
> +		return -EINVAL;
> +
> +	if (!IS_ALIGNED(res.start, LCLA_ALIGNMENT) ||
> +	    resource_size(&res) < SZ_1K * base->num_phy_chans ||
> +	    res.end > U32_MAX) {
> +		of_node_put(parent);
> +		return dev_err_probe(dev, -EINVAL, "Invalid LCLA SRAM region\n");
> +	}
> +
> +	sram = of_find_device_by_node(parent);
> +	of_node_put(parent);
> +	if (!sram)
> +		return -EPROBE_DEFER;
> +	base->lcla_dev = &sram->dev;
> +
> +	device_lock(base->lcla_dev);
> +	ready = device_is_bound(base->lcla_dev);
> +	device_unlock(base->lcla_dev);
> +	if (!ready)
> +		return -EPROBE_DEFER;
> +
> +	base->lcla_link = device_link_add(dev, base->lcla_dev,
> +					  DL_FLAG_STATELESS);
> +	if (!base->lcla_link)
> +		return -ENOMEM;
> +
> +	/* The SRAM driver owns the containing region. */
> +	base->lcla_pool.esram = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!base->lcla_pool.esram)
> +		return -ENOMEM;
> +
> +	writel(res.start, base->virtbase + D40_DREG_LCLA);
> +	dev_info(dev, "using LCLA SRAM at %pa\n", &res.start);
> +
> +	return 0;
> +}
> +
> +static int d40_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device_node *np_lcpa;
>  	struct d40_base *base;
> -	struct resource *res;
>  	struct resource res_lcpa;
>  	void *dmaenginem_reg_group;
>  	int num_reserved_chans;
> @@ -3844,26 +3911,12 @@ static int __init d40_probe(struct platform_device *pdev)
>  		d40_err(dev, "Failed to ioremap LCPA region\n");
>  		goto report_failure;
>  	}
> -	/* If lcla has to be located in ESRAM we don't need to allocate */
> -	if (base->plat_data->use_esram_lcla) {

Does it break old dts's back compatiblity?

Frank

> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -							"lcla_esram");
> -		if (!res) {
> -			ret = -ENOENT;
> -			d40_err(dev,
> -				"No \"lcla_esram\" memory resource\n");
> -			goto report_failure;
> -		}
> -		base->lcla_pool.base = devm_ioremap(dev, res->start,
> -						    resource_size(res));
> -		if (!base->lcla_pool.base) {
> -			ret = -ENOMEM;
> -			d40_err(dev, "Failed to ioremap LCLA region\n");
> -			goto report_failure;
> -		}
> -		writel(res->start, base->virtbase + D40_DREG_LCLA);
> -
> -	} else {
> +	ret = d40_lcla_sram_setup(base);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to set up LCLA SRAM\n");
> +		goto destroy_cache;
> +	}
> +	if (!base->lcla_pool.esram) {
>  		ret = d40_lcla_allocate(base);
>  		if (ret) {
>  			d40_err(dev, "Failed to allocate LCLA area\n");
> @@ -3879,26 +3932,6 @@ static int __init d40_probe(struct platform_device *pdev)
>  		goto destroy_cache;
>  	}
>
> -	if (base->plat_data->use_esram_lcla) {
> -
> -		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
> -		if (IS_ERR(base->lcpa_regulator)) {
> -			d40_err(dev, "Failed to get lcpa_regulator\n");
> -			ret = PTR_ERR(base->lcpa_regulator);
> -			base->lcpa_regulator = NULL;
> -			goto destroy_cache;
> -		}
> -
> -		ret = regulator_enable(base->lcpa_regulator);
> -		if (ret) {
> -			d40_err(dev,
> -				"Failed to enable lcpa_regulator\n");
> -			regulator_put(base->lcpa_regulator);
> -			base->lcpa_regulator = NULL;
> -			goto destroy_cache;
> -		}
> -	}
> -
>  	writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
>
>  	pm_runtime_irq_safe(base->dev);
> @@ -3954,22 +3987,18 @@ static int __init d40_probe(struct platform_device *pdev)
>  		dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
>  				 SZ_1K * base->num_phy_chans,
>  				 DMA_TO_DEVICE);
> -
> -	if (!base->plat_data->use_esram_lcla &&
> -	    !base->lcla_pool.base_unaligned && base->lcla_pool.base)
> +	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
>  		free_pages((unsigned long)base->lcla_pool.base,
>  			   base->lcla_pool.alloc_order);
>
>  	kfree(base->lcla_pool.base_unaligned);
> -
> -	if (base->lcpa_regulator) {
> -		regulator_disable(base->lcpa_regulator);
> -		regulator_put(base->lcpa_regulator);
> -	}
> +	if (base->lcla_link)
> +		device_link_del(base->lcla_link);
> +	if (base->lcla_dev)
> +		put_device(base->lcla_dev);
>
>   report_failure:
> -	d40_err(dev, "probe failed\n");
> -	return ret;
> +	return dev_err_probe(dev, ret, "probe failed\n");
>  }
>
>  static const struct of_device_id d40_match[] = {
> @@ -3978,15 +4007,17 @@ static const struct of_device_id d40_match[] = {
>  };
>
>  static struct platform_driver d40_driver = {
> +	.probe = d40_probe,
>  	.driver = {
>  		.name  = D40_NAME,
>  		.pm = &dma40_pm_ops,
>  		.of_match_table = d40_match,
> +		.suppress_bind_attrs = true,
>  	},
>  };
>
>  static int __init stedma40_init(void)
>  {
> -	return platform_driver_probe(&d40_driver, d40_probe);
> +	return platform_driver_register(&d40_driver);
>  }
>  subsys_initcall(stedma40_init);
>
> ---
> base-commit: becfc375b0ee95818c531ed43ecda26c90f7617a
> change-id: 20261115-ux500-dma40-powerdomain-135a566b03ff
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>
