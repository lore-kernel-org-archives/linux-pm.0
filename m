Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18342D97A6;
	Tue, 11 Aug 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466492; cv=fail; b=G5rugVMlY7/n9/Iz6/zvpMt8Hxkcbt7kX3Vxa9PFiUBENzs2ivY/SLYzJDQy195+cRel6G9iElnDVaW0S3aWIAyduiUWcZK+Vf/7/eRu34sEGvmTX6Bq+p1K9L7JydThyoDr/pYXnDn8Tl67sVVF1XlyCTFHn+EW8a+K2+DKEMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466492; c=relaxed/simple;
	bh=HQpMDZN5uS6D/9itdZO6x07tfGSamo1QqJmDNBU9PB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PkzjZUfCZfytRtOhrBedjWm7lFJnP7b+bdTV1GdAe5p5nvnLH7b8w19M897DysH8PoHhDlFWfeYk77MfRSdnpug1GRErowEhLA8WKq2reTGDxpA99IevI/W0N5grHDCAFs1rdUsX7DnPhnycAN9psYQWpsg3X7WFYtZhH2Jxkws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uP5GjrHg; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uP5GjrHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNpv1o8R1wJvulI33pcQJFczTICjfzdVV+PQtA16g0rvWfpOz51lFKWgOU8ayakxeMqKOeDxuUYl/OKoIo2S9p1D4KKcMCByU429lawuHft1thKUAzyb8FZNohFcoQOynNVxui4/+j/VjxRRGxqjVmdvEilkRmjvUB60kYjck3mXkYWmi+s2okpgCxKJqK8WFgo2EtzDfOR2/wfuihcoiZ5n7S2hFgv71k1P5GawhDu9dXvlfrynRPOB/cZpXp08hym230r+qVaNHHFTdN0roYlSERvGiy63tEgIyrkNYCAo9icydIIzYFeFppvAsMgItbLgkziZyJQtUowtzfEZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i48chlIC8MGrNcplBgNHWogpwtPx0OgX1Egpa9AI+FE=;
 b=mfjneMj+XOYQJq5cQZixCMP4+bF3F8VRpOvTyJIye4vN0xQ7RjPwqnv1sKsUrMyHvD521myXxdycFJE0TEGrrzAP+10BdMI946A4kHppfuN1F2h45IPPa6bGx1v8otv+VxLl0c/zD+O4OYPcJ3UjdypJaey8A0D9KeAD2Jl9XYLn0ZgA/VneQVLROwH6ApZt42agWpz+NtE8CBNZNpIV/sv7m3M6XZOY2Qmy+JcTMXC81Q0JgTljoxPYn8omsmsJ3vKcw+pi473EbCo14dTQ079jfY5iXa+W8eog5e1LqLLl+YXdUI92F/acXVe0e7mczihOd6LbRP+FUFcIHrr7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i48chlIC8MGrNcplBgNHWogpwtPx0OgX1Egpa9AI+FE=;
 b=uP5GjrHgm+lggjh95V+ULIDZy75kpFWrzbQeu37qcArA9UPESDbT8glPvoGDBcoG/hQb1WaDHp4mcG6pUieTS3fj+ve7ugbyBgW/f9I02/Rxzsk0Imwk4PMxihEQpeAIbf8Uy13ouN5qlFTDat3vB3EKcksDS10mV6H0vLiFHNJ+NC8dFVKFRvejKBLqzxXf79Vw/ZOsWZplwm6mRDFc2UmpvRUB7Y3vvej54U9ZxV6t5J8IDWJM0CfwGnyT0MX1w4fVeCmGGhyMM7iHK5/xODwvT/twa4G3YIOQ8/0IJYwnQxRLNo7OYoXAkAbMCzQbgJ1iHXxaW6LVepYSeg1Bfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10928.eurprd04.prod.outlook.com (2603:10a6:800:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 16:41:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 16:41:27 +0000
Date: Tue, 11 Aug 2026 11:41:15 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, git@amd.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 4/6] dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net
 compatible support
Message-ID: <antQqyT-slTnY2e1@SMW015318>
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-5-nagendra.golla@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810100452.426320-5-nagendra.golla@amd.com>
X-ClientProxiedBy: PH0PR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:510:e::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10928:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df7a7e4-b2f2-437e-0cdb-08def7c7635d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NV+8nMl7f1To4QsYrp+hPctxfIOOlTLDlQjd7whpFeTiztJlyxJHNrfBEN5pXg0qDWf2I53xudEuB1701HfeBBggQo11ZYkFjezkk5SId0GLOsdhfWxlTcGADCYxMK4MgPFl9dYwRLtZ9P1mSME5wAgWyokTjCiuUrUtdNsQj7Wq2aPng1Kufx850iNUFp+FFpdChWOUI88aK+r1gjlVBTla4Weh1KVRLdBtS8LG2AXWzCj1BSLFtHVF1NyoXX5EQZBROENUwkJXJghHaMdteQGlfR1WA5a9/cFGR3mtC24WJYluF13IDlvlOnHgWwN4nUSpuk0JiClU4zwJKZeSXNR7wp6W1wepQC0zVXaWcltOBQAqbR6MxRIVvtliS8H+7m+jpMmuqTdP+d1OSa0c6bWV7zfRvSUOeAhgyBnfWTEdKm4OjRfjJNy8M95LbVxvUS5mTgsofVa0hy3UE/RKQ5AEZvi5wpFXljg/7rW7G3dZcEFwIKyzt/nE65OHsjs44R5dFbhktDcwowciimwHBnshWCn2VL0+jRyPoeNt4F2T+EVWGS2geir1l/HItKv9bJqIzmhGZSTl8jw/UziPteXMCsaoZ9FmhsSRxAHSFAAJLK8sv2/9CrMrI8efhjayuQC7obnP8Br/JECbdF8ElSpZaM2KCOfEjWywn1VTjoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUX5YPx7At1dJhj9SWxeisrYWax7s+isVZfgkwkLzYUGc3ZqorqtzrJnVDs2?=
 =?us-ascii?Q?RA1Sw4EMnB8B+kMqdpEc//3P5uf+5mtPI7dc42YIwYllIgvRnugzem9R7Qzh?=
 =?us-ascii?Q?57VeLGb/+7hkR2K/9faRNeSgcTazZek6p5F+XBO1V0wEpV3CvngFmnleTpxw?=
 =?us-ascii?Q?UuDyO+H6rSW9XDSXuBaFkqK4rKEt54fBtehc9GLZyg5ac5vWbgINNPIdeznG?=
 =?us-ascii?Q?DR7iAOWaSc4juEfK1+usU7nTAf3ofkIUnJ2/wMfdv68sniezS2D59vYaoaSz?=
 =?us-ascii?Q?9xG2YfnqLKUahP3MY7j13gpHwuYyW3iGgE+RzFDc6Ol+vtpRT6N5Y1hD4NU/?=
 =?us-ascii?Q?7bNrqhl1HJlvWIyemJpw0HQQp1SUBFEYYRFyV94hdiqaMtiG7N0B2E+gsi4W?=
 =?us-ascii?Q?HEnEpjuM35aQHEb60QaGKcYxHeIWy8IF4yWz/Bh3W3PSEqcfeevxb89wnSDH?=
 =?us-ascii?Q?Op/4Vkgk8akEYDg6VpoOP3I4+lOcVRrQ1YlZiLkD+3xiGi4ubMlIvZ6SOTxf?=
 =?us-ascii?Q?BwI/jtNELulWbJsa8RmiThVl5kYynulkOSPkYVVr++ZfGvS14CEbW0CFZRTp?=
 =?us-ascii?Q?OqBYJxxCFpzAghyIg2uVm4aVO2gOpZmYXyGHYsj+1Hm0sR3mJSW7ClnUH8vP?=
 =?us-ascii?Q?WXhReLlGYf7oioEkqjQ7L69VQYEQ3da9k+KDUhauNP+VaCWRNYGkPeK4VhkW?=
 =?us-ascii?Q?83rcUa3ahkOQBp6bl/+QC7zvu4ReQnkWCQskFZyt1veQXaV9mL7byf2cyWeo?=
 =?us-ascii?Q?CCFRz8IppCmaz7T3WqmqI3mu3UvTwYNrxKj8EVUS13wdx5tHP0fxecoZMJrc?=
 =?us-ascii?Q?xXYA4y8h0lpQS0fkxY73Ag+TygA+GpytBZHO/uqamH7bniOS/FgJD37+CMWS?=
 =?us-ascii?Q?+cPs8mie/sApzbJ23aWd1PaJxu5M9xLF/D8HGqE3vqb21JhdT5XamVEX+Aum?=
 =?us-ascii?Q?KOcK7WpWkieNcG9FRwsBvMPxs04kzRPIS0wwMcAyQdifLd6stpiHkM+MZJr/?=
 =?us-ascii?Q?74KhivFidFXAH2JaUvCu5OsDOYhbWu6dPYUgscTcty7yqgJUiv7jet2pdBWr?=
 =?us-ascii?Q?RmnTM7xPCnS5QpOXBgQAe6Fxm0iDmv0ZT6i6JXKAIUrz2+8k3RnWm1tVM4Yp?=
 =?us-ascii?Q?hy0mbp+Y1rf6lpEOnQuK57C45/vKD6+zXTYESiBd6S1bJZc/F4QSnXyFjlI5?=
 =?us-ascii?Q?qPrFP2tmVkqlnD6e3I7AnjKh/xarR7naXVieCYKQ6VFGxFHVkEnx4lemwUAM?=
 =?us-ascii?Q?XFoo+NqK5OtwtHlU+KTnVF+iGdU9BliWSDXxuNbXBhTih+R+URFD/07PwIRf?=
 =?us-ascii?Q?BlN6/DihoKw9eHcKr9E0uipS25MK+7PCGyo6rgsfxuQBlL5lYnGUSFVTFcUi?=
 =?us-ascii?Q?irV0cWcIKmDVQ4g7jBclczqJ5xG5nfKTL7EYaREI97p+3dnrO3fumtCG9jWZ?=
 =?us-ascii?Q?fiBWcIgwnIWV/cfjLIj+30wg7w1E+ac0NVlfHZB4THL/ue5wWFzK7Q/eix82?=
 =?us-ascii?Q?rtxHSCTvU2hk/9i6RI3WFO7WpcXEYnsw7rjCwDnYSgvYrDd8iSVkLuvfU4/p?=
 =?us-ascii?Q?kCKhHT9UpB3JSIopri0Y0DKqowmoIFZ6PPp1nCzG0BHNfmxhE0NNAtrluR46?=
 =?us-ascii?Q?0BcufIFkP9QubIAHoQx2w5NMg75J1QPURWsn3ICog2/3No/mtk1Ak5vbgb5s?=
 =?us-ascii?Q?dbwuu/iapJVJ+05XM2XnfhtTZR9JVf0kCn9sZ/1qjUnV9w+KijhdBYPBzezp?=
 =?us-ascii?Q?a43apgVmiGhkWXEEYNTvHvPGr9ZOORvgMhHpTbJiceStXRSN6svb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df7a7e4-b2f2-437e-0cdb-08def7c7635d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:41:27.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fo4S1kql9zW5W+Eff5odSNWPv6OLL1qHRjn6fEqiDgi+tf1TPhpxjqAXiC2jpS4mNY8RCzTusOaBWNEYleoGsx/L0IloiFCbr5hEh6Tr8HmHwTcBkqFdU/3gHEjAeGG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10928

On Mon, Aug 10, 2026 at 03:34:50PM +0530, Golla Nagendra wrote:
> From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>
> Introduce a new compatible string amd,versal-net-dma-1.0 for
> Versal Net ZDMA.The new compatible requires xlnx,zynqmp-dma-1.0 as a
> fallback.
>
> Add a reset property to describe the per-channel reset line exposed
> on Versal Gen2 and Versal Net.

why only one reset if per-channel reset line?

> Mark the resets property as required
> for both Versal Gen2 and Versal Net, and not applicable for other
> platforms.
>
> Note that making resets required for Versal Gen2 results in an ABI
> break but this is unavoidable. When DMA is used by two software components
> back to back (e.g., firmware before Linux boot), DMA functionality fails
> due to configuration differences or the DMA being left in a bad state by
> the previous user. The channel can only be cleanly re-configured after
> a DMA channel reset,making it essential.
>
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> Co-developed-by: Golla Nagendra <nagendra.golla@amd.com>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
> Changes in V3:
> - Use allOf:if:then: to restrict the resets property per-compatible,
>   making it required for amd,versal2-dma-1.0 and amd,versal-net-dma-1.0
>   and explicitly setting resets: false for all other platforms
> - Add amd,versal-net-dma-1.0 compatible string with xlnx,zynqmp-dma-1.0
>   as fallback
> - Switch compatible from enum to oneOf to accommodate the new multi-item
>   entry for Versal Net
> - Add ABI break justification
> ---
>  .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 25 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> index 2da86037ad79..87c65aef5c7d 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> @@ -18,15 +18,31 @@ maintainers:
>
>  allOf:
>    - $ref: ../dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,versal2-dma-1.0
> +              - amd,versal-net-dma-1.0
> +    then:
> +      required:
> +        - resets
> +    else:
> +      properties:
> +        resets: false
>
>  properties:
>    "#dma-cells":
>      const: 1
>
>    compatible:
> -    enum:
> -      - amd,versal2-dma-1.0
> -      - xlnx,zynqmp-dma-1.0
> +    oneOf:
> +      - const: amd,versal2-dma-1.0
> +      - const: xlnx,zynqmp-dma-1.0

         use enum
	 - enum
             - amd,versal2-dma-1.0
             - xlnx,zynqmp-dma-1.0

> +      - items:
> +          - const: amd,versal-net-dma-1.0
> +          - const: xlnx,zynqmp-dma-1.0
>
>    reg:
>      description: memory map for gdma/adma module access
> @@ -59,6 +75,9 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  resets:
> +    maxItems: 1
> +
>    dma-coherent: true
>
>  required:
> --
> 2.43.7
>
