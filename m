Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6233BED38;
	Sat, 10 Oct 2026 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601179; cv=fail; b=UfIf+OzC3FlgBUdRE24kKBCGD/rkPsoRzae1IvwpBFE8DfCzVi5R7dLjtB4Qz97cB1gHnsaEWdihZvhbWykMYoOUEgQCsoYEavqEW3PqbJRUlO+wZBCWxTpJqCUktTPtdrEzdOALwYmxsPynG6PAeX5OgOc9o0D1HoEeyW5Fv3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601179; c=relaxed/simple;
	bh=WbVDOVwlEJoiSv+ypm+bqdUTMKPTAXIJfyYm0RXlDHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IAaQLSr5LmUXRG4VPsHGxUYwxJl1xhWVLjvOox737l15MJ/pXl/JrVB1CGIGmGi3FK3b4jiR+U+zoYb19vhm16R6mbddYUj/B3NP5sz4pOtfveALgHWbwfkVhgVB1OPtN9pvAKlE4Ym9XIwX/d8Bwl0L6DcTl4LFg6nXEUPOc3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ggkLd3AN; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ggkLd3AN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhzwgHXd2uPvos5UYC3x+VusSNVUxNOlYDicBQi4z1FLRUzYnhCueN4L4b8ii1tKAsfmfWLmrqkLMmKbo8DJBje1wVGkkgrbk0NpJOS0zZ5o2d27WzMZG2MmmcAmYmc7DpxVgAqVyGBlXb2w1pNxckJvoWcIIRXFQNHoueM/HbzLJ61CXCbLLlKs2i6I61d4vMPZlbjD80FGyGGpn92cVgq29tcTD/9uQf+qpxCXVb+XrTSv2ysM9h15vFZZmUhWH7QXHMN3ZcyxWvDG21FvFqtPfl2mk30nHWqKia6m/QIXGARARS0A+z8QXyF4PkdPfnPb7GYVzUyqudmxnZtccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXZja9cuk12L1sDydVzu6DvWOKXRc8LiwMliOvZQxPc=;
 b=Zp5rBAP267oB5iEcu5HCPAPl92CbDu2GgkDQ9/LWNIYGno0Wq4HdzBMeIbh2iFGk8aHCmRPMUJLe5S9lV+uQa6IeeVXAxb9ghr5yJc/f775WFJKY3znPq2JKR6udZagBR0RuHxKnPWRTSo0pN7m0XkP3Wk/Xz5LZhuutON8Qv5IvgzgDde0ZdZGQ4VOoiOvnQCuAf3Pz1AfvmMp1phV+AeXF/nLTuhzK5KlufYJEcSu2kdYaSUfu0tQciP+pISQnt5NLMgquLjrepf3D2C4KNuitiZQOtWDM5KiIglxKGFuvcL3WryusUXXm4Q1cI9kcd/E3AuRQZEHaeSlR0I0RHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXZja9cuk12L1sDydVzu6DvWOKXRc8LiwMliOvZQxPc=;
 b=ggkLd3ANveitZTHpZ8N6hI4o6ErmW0ew0IeTIy85EtAsN80NFto418G7/GpVQc1XYy79Jx5ZkcMO5y9Hq+Rs3XmUYDzTVItn7RDphvOrz+lVO8QFsZBmQZ6cQWdh4jnHFKXzH+GJAdpmD9S4y+WoqFJCxY/Ax1yjk29qexUu5u3GpKvpHQC9ufeJwA3ax5P4wEH5WupIQLrihvSI7WeE5LcOiHv72WcgkQJMQ4zisVxhS4wN5RTE6UXKUNLGZs7paA4yB38M9kZHGmgzhPg+YrmO4MGfhKGcn+2m6N8k2rEsS4fxM2I4NDD2mb1mjBf9sMf/xRZ0ILBmjSG2bSk7Vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12630.eurprd04.prod.outlook.com (2603:10a6:150:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:59:35 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:59:35 +0000
Date: Fri, 9 Oct 2026 21:59:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Harini Katakam <harini.katakam@amd.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v4 3/6] dmaengine: zynqmp_dma: Guard IRQ handler against
 spurious interrupts
Message-ID: <asmqDOHWq9ZPXh6J@SMW015318>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-3-55f5fe409c55@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-3-55f5fe409c55@amd.com>
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12630:EE_
X-MS-Office365-Filtering-Correlation-Id: c8efdac0-0ff2-4806-8419-08df267a83bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|7416014|18002099003|261009223027099003|11063799006|4143699003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	SEsHL19DoqVhf9NLzFu7k9pbNM6Flb/mGi+GDuhqOdtitKo1zi8yt4sNKpuivgRE6XXqT7QHJjAmHd8iTYguSMzLrd4UZmUxaEGPArGU9I9ubJ7/jEdy90XyQoB+iPoGLlkF86z4ptzLfM/dL+RltkGSEzDommTN7X/TPlopmZFZMu/pqMxFZIngeNIX70/gX3VMqIiuV3DqfcKuWUdR/NkE3dOeUxGuGsc/Hu8Km57k8P8g8Zwzjq6mn77u6wtqnJoosCazCsqmHcYGdOH4NcyfdCL/bABj1TzKvwbtHyCfS1zcIBdCy2Ijucv8BEiHuKnobjS1CH2J9KiraHvjgiYXRdFAxruHkRfNc0vRkmkkPYFvEED42yT7mB/PODRoKyBSjyUIaEey8rLGP/Pt0Ayn30faUzYx+fuBUObtTtnA30w+fGhPps3Y3BBNnPIamyZA2zHA/0+0k0BWhAuekSqDEVgCvEtGfgMPSoiG/3zkWwAHr4HuCAUwwWQ+J9mmmTbJiSYfhHEly1HTw2pVwcQZfjR9S9uxjOPaP/4Sdyv1AYDsrlw0kD/x0aVyUif1YtoptDhlxFIzlnZHjb2cC7Q7Tefxf7F5pteiLrSS6KHeV/OCUIyk+tTAT68c7IzqtFgx0+1LtJbza/TXtEIQ3CUgRzxvvqwkO/AgqKYQkQA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(7416014)(18002099003)(261009223027099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?swpZep+Qi+0ELJrjufSQVIL4pamHXOYik7zQbZv375mp8NVbAT/xQzIUGFpi?=
 =?us-ascii?Q?t2Ed6J2xg+u2x6s4yNbYg9mhc9jB+H5XkuengNeSBbmQUDVOdXOgWENygxIK?=
 =?us-ascii?Q?mAnBDodgoes331m7RLehTIE91gh+3s2iwOD91VpeoClNhLfU/JizhDoPUewe?=
 =?us-ascii?Q?62ivthdt3uwWvkOo+cqgsT0DQkZErPHnmil5mFFwznDj9usUWDYzPyUZUewE?=
 =?us-ascii?Q?Ywc33B/O7NZbfsGKJGXDFgen+fjlWxlS86jLxx9/I4iWpDKa6bhH+raWxZXz?=
 =?us-ascii?Q?/7nSfsz6os/cAaPcdcdW5+HypBTclcIGniPDULXUKzxsmVY1rEPCXUVATh4L?=
 =?us-ascii?Q?+TjzYfpXTZYgk5GFQkFFK6X4pU6jdlxFyOCxu6ZXqFbfSPton1ANiTeVhbvM?=
 =?us-ascii?Q?Hta8Uvvgh6O3Yfh1jwFA2ZO2g950JaR3flhzjWFJ/E2OSzhJ1hbGEi52ieBB?=
 =?us-ascii?Q?64oQHXe9zQ+eChIF1Z4NaR7XYr0MWyhao0pH6+wiGufgvI2+QU0wxxD5ntYX?=
 =?us-ascii?Q?lqmG9Ri5LFSt7+ckqx/VEhzOTEm7OUyPgA1Gw6zWsSSeNFQggWK9EIMRxxtM?=
 =?us-ascii?Q?aYyB+t3W9YMhB0n1tAv8fgBDfSIOi2jqzOKaYFQOtRki0b6ZlvG3AvReNRad?=
 =?us-ascii?Q?i3RUvNbJuVkeNqGBCGT26TtBnf0yFvQpV7sQYXxaB+Iut498N9zdm8aSJK3D?=
 =?us-ascii?Q?5aE374pFvIxEpQFxjEWpMpp9KkXCEWMRUE3OCqlyLI7nTuWNVUU8g1I1Jpal?=
 =?us-ascii?Q?xYdUebCk5cjF6IuiZFVhcQvjQJ4KN1OIuftFAtosSt9jt09604WVXCcHA7T5?=
 =?us-ascii?Q?NzIFObS/Sz2eyvOH6UkdUZmdG+v9Hu2i29z0IoTsa8OYscuVQGPhO10EIOqV?=
 =?us-ascii?Q?e3ySa44pzljNjZF32ZxpM/2yevCJGl01I390AjlxD+lWnktTSV0fSJLUmoMy?=
 =?us-ascii?Q?Nme1f+cl9HjHAqVA4noghVTtGr7r8UOlm2FJED/GseVnIFEUmmJlyq3KHvec?=
 =?us-ascii?Q?QH+A7Ny6DfQBkvLO5iwkIafMFi290W5DCvZl/A4S5rgtRu17bzpDTxGnMGvH?=
 =?us-ascii?Q?qasqQ65Gb6iWhVGrF0BGCtUZt1jwkTwQXH8IhAqq6dIfIJI4GdIlYI0PHprI?=
 =?us-ascii?Q?gCgHznnuSCIDvfvngeB3VADrVg2ktyXb8sxZ/LZ8zJoAcMLbYmRxWV5crxUN?=
 =?us-ascii?Q?rOhumUpX3QustMwc+Ssn65w+zsmtFWCrnrYc88jCeaz30TGNxRg+E7Ya29v6?=
 =?us-ascii?Q?VyYpsqb6DMwiPr12BxZxB/CnPjm5M/hnz/Mb5qnnuD7bO7GU2sMi17nW/TuB?=
 =?us-ascii?Q?s3rmlljDTWE6WQOU817WWacRn3zeBnQGKxqQtR8vIOyqD7IJF9zMtWX47ARi?=
 =?us-ascii?Q?d9fm1tIO85Sa2F0DebLSOBhajgc6mAElZ99Ag0WrM8reFGhGNZoKsv8EMZdS?=
 =?us-ascii?Q?mvgemrwM/Ux42ELxYisA08KbxrRaZPKVUuemfEEz2zT8g5CWnNqGvStpm5fL?=
 =?us-ascii?Q?Ms5koeZIn4M5dx4nP4Z2HpHBdwTxUEmS/BsDpKc1h/iVMgdR60VaYoqkiGiS?=
 =?us-ascii?Q?SjwlWwBYIqYjmJRZBcKVfy0drINvyPmT97sh/6WJOSrgkpT6uDt6Vd7tP93M?=
 =?us-ascii?Q?rAp8LqB2xBcCVI1A7rJd4x6EJ+WZZ8RPUWgXlO+JqufSQJfvEjC9yjgUtn4W?=
 =?us-ascii?Q?3LYitJ2t06rxvvinOpQ9XRgKGa7QgZHt76+LmJ/KYNTzyYRm6OSyeWd1UgSf?=
 =?us-ascii?Q?PkzkW9F+nGxJR9cZy52yYb7RwjH67ns5TRQnJdBJYRMx0XIS7PvE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8efdac0-0ff2-4806-8419-08df267a83bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:59:34.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmIX013ufYXgOCBtpUKl/Ty4emTqXb4kk8YcOez4x3SmhRC5yCCfgE2TCT5tf2fm1YNfYI6do9iuty6beu88S6fl8m5hAmLTfjsCQ/YaQNvD2Xsxmh6TthzoVK2UQxnH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12630

On Fri, Oct 09, 2026 at 09:30:12AM +0530, Golla Nagendra wrote:
> Use the PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard in
> zynqmp_dma_irq_handler() to safely handle spurious interrupts that may
> arrive while the device is runtime-suspended.
>
> The guard acquires a runtime PM reference only if the device is active,
> returning IRQ_NONE when the device is genuinely runtime-suspended. When
> runtime PM is disabled for the device (probe fallback path), the handler
> falls through to normal processing since the hardware is still powered.
> The reference is released automatically on function exit via the cleanup
> infrastructure.
>
> Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/xilinx/zynqmp_dma.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index a48106e404e7..b5a5e93e42d5 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -738,6 +738,10 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
>  	u32 isr, imr, status;
>  	irqreturn_t ret = IRQ_NONE;
>
> +	PM_RUNTIME_ACQUIRE_IF_ACTIVE(chan->dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return IRQ_NONE;
> +
>  	isr = readl(chan->regs + ZYNQMP_DMA_ISR);
>  	imr = readl(chan->regs + ZYNQMP_DMA_IMR);
>  	status = isr & ~imr;
>
> --
> 2.43.7
>
