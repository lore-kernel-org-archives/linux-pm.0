Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B332F3C13;
	Thu,  9 Jul 2026 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609658; cv=fail; b=fJL8FatW0sGVpQMtaqDE9YQ+XsT+21AZHuGYUzX72EYQBKIcImMiU549rlEyZIbyCtvxQ3rQoTiOCtUkYFnDJwB27phB9CJ0mf6gYDOsbyFF6kkxLikEuJ4nDUQZwHnjwq/6OMl7XjXXYlXwEYeAKNPsABgSCvaOMX9z+7noVQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609658; c=relaxed/simple;
	bh=xVSXWoHxUQmoQ3LqS2vKsly3SUhX83TSF7WCf7j0MD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UcUwwTuiigwIMFlWA9pxSRBWOy+z4uLJRVpNBi0w9QGvEgDi4W669DGTkPZ5Sagoou9WvwMexSbAoUiRnDMiBSYvXIYfLAMgSzg2VoANZlNalFc0FsZrDr4jthd9nMIzQLlBB2yvGpidtgS7F1uR7Fiy5JifSlCE7zS/X9EaMUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=i0GlN0X7; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i0GlN0X7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sR8d+0TEF6/wQWYQrestdobcNy41cOJxqvfb27cGCB2TaIdLC044sD6AqLzKAzAicPT+cSY0ed07Et1DKJTTfVJQhTwBYD1WSTy7nF+PXUNLzSlKDbJO8c9IxbWTej08HmJvtdlr7UhOGC5/AUcXc24OXk02TtvWCFeLG5e7cD4vF9StosqrA69IngOL7R6VxlZh0bd5/qqKPxiu93/fwDcmul4+WhWzkG5qqnn5xM1vTgSeWjZvZqfyugXlVjX5Huvs8XJR2AvH+B66KQF2esjj1CPQEgDFmie3iGF3mxB3PTw5w5iQJ7hVafmnp+BoBEpnlwEs30EzYtbhwot7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWIjba/tlXRMEiBrgsOvE8OqewTbNijE7rghrumqevc=;
 b=L6XkRZcZaV9YXjxf8Mm6xfJmvK49lJWZwSivcS0TxL3Zb2W0P3Ndukd/LQ8oULY0AmbvgTqVnOO29i2bKIiJmYUo6AaoqVH/Kr58EcpNVSt9xQdjGo0NGqtDpB0uL10dZwVM5BXE3ORtJPS+zFs0actrdktBGCkx4AXylXziQLZxcfSqim1akkbUv2CIFA3M+u1KktsY4ABI6WoTobBqZQsjDmS7viRRoKmtw8whYLxVmL1CeuCPE3HszDuQWXVdkF2XL6xc+KEaHWybOcDFbo9KPlOHuFtHtyuFj05RDxoczcDRBwwISt6uFrQSgPxyvIIcllNbvNzEeIi/G/XCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWIjba/tlXRMEiBrgsOvE8OqewTbNijE7rghrumqevc=;
 b=i0GlN0X7EZgSJ69IplTEcfUCWFhiFdySUNgdeIWukYz7RVovknGWEPS4TuC0bbqQZPvP2ggPnCorl56hlmxGn7nxVFNFTRSP05uF8rC4IRR0CCjhyFlsjc/n0gN8dYjLeDQndx1FcoA7Eype4nPxETwLs4TanMQ2Z8NjgdMV19P45c3pvNwUhRLgTqpkOv6g4Bq2N5Zcer6Ye65nfbe2G9SDEaHbqeGNzZ92STu0i6WjZTihWqnJlGTAI+CeWj4YOuo7GxeXxSPLpbEdxFCQPlGu/RtoQtUoJY0hMeWp2katnyQrZnyMvZaQ7/mj1/h7Uh+5ihraoahawYM4wGBnZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10768.eurprd04.prod.outlook.com (2603:10a6:10:585::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:07:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:07:32 +0000
Date: Thu, 9 Jul 2026 10:07:21 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Haoning.CHENG@cn.bosch.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Message-ID: <ak-5KdXFUldV2eTP@SMW015318>
References: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-0-00ff72495e24@cn.bosch.com>
 <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-1-00ff72495e24@cn.bosch.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-1-00ff72495e24@cn.bosch.com>
X-ClientProxiedBy: SN7PR04CA0238.namprd04.prod.outlook.com
 (2603:10b6:806:127::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0ddae6-8e08-4894-1c60-08deddcbccdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|19092799006|1800799024|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IPdo3pYqLt9Xm2KD9xddg2pAIUspIqa6qfHxZGY4J39g/Kh8KP17r0RVOWJ2W6AqgoHTGrY469h2+A8OVqhaOSFi8rhS+NAXHK/aI1xUoTuL0FSmkq8s82X07T7jRWZV93H/cl2CJgcJTLDcnOGWAqwoDiRDg8JZjLoqQ1qDl+sNeR9VJO+TyU10lMaD688qobuINBwSgGq+k+94mPsk75JFUxBBPfCJCdgx8BcWn8T6gaZK/THjjK+IlOGt+PXqT8dsfDPwEmBV8q/pqSS/7y3ul4XWMhVu/FQNUGHvaXBcJo2hHsjREjGR5WiUNiZ6wgMr8tWYU5+WV8f0gs4/Hi4pnZA7Toh+G8CR8T0Y+HvI3Z7bTbsx4wA5x0klQlVZKUUbgux+2NQJPpxd2cu4uEYzcfUy1KMuwI9UnsxGsyPf2fx76ERo7xC/bXbDxPtkQ/Lzlh200NctyIsWdFc52UAOXxBw3uS7Pb0esJskmOeD2LhEBeFKi8y3odhqhXXPPHwF85KTu+Roh1nRe7EILF08rnHXtQluLXfKIssnQb73gEcKRuYkCv0yWQugtqeO/+7z9/VQEg3p7+Gu6Velh3O8TUDi1ex6PYTqPY+SvpqRVmVF5h+OAXCjEBpl8XZiRNruXoNGHONgJjNuczAcBD0YdiyVcLaVqmPUmZFWdDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ygzEedx5qJ700db6omnvJivpBYQ8m+ykKT60/h6qAsANlejJwNHYZdjwaj4i?=
 =?us-ascii?Q?jt5MkHDsDPXaxB1qEWR2wuBgYA1lD1UzxP3B1zSSJDSRSber5QnMNQ4+gMwm?=
 =?us-ascii?Q?FSE+UEyyLpPpzRlP3l+OKvwKrCVO3a+7Kql9OTscBm/zJAA+B0rdBOUoTfT2?=
 =?us-ascii?Q?t29Gu0yN2rTmuInrmbOGIePCgOGa7tgsDVYObA5hLDYss+xqQbXo2xu6Y20C?=
 =?us-ascii?Q?tXP5ymGfxQlYeC2hkxsoZlJ4O+lSkWY6j5rHzNaAQ28j92U3RP1mYWhuNiqf?=
 =?us-ascii?Q?NhhOoysx6YIZkWUKtIyEosHIftohCwiIr6zB8fyYmk3gPrI0cb7HWgiNypBQ?=
 =?us-ascii?Q?hngpms7VbFgqGVQ0sCFctKme37fFWpujv9hwUXUxtbJnA57sJfAkxh1YCkqi?=
 =?us-ascii?Q?Rk9PbY+Ytlyspti2m766Ipmzaf6145yuO4KiG3YSmx3SjDk/UBW5zEvRaicK?=
 =?us-ascii?Q?wraiaceC7oCYhdiUOvNaY9bjkXxfETwVDJ80UYKgzeVtUxAxfYGOk4emE0Dg?=
 =?us-ascii?Q?Tp8ZpuH0R9E3A7PLbcp3VxDGXW4NEofLz3m/ZMFjGhF5GtCyzzeWh982FZ7N?=
 =?us-ascii?Q?hYQTrZTvZd4IQOW/gymie4cXoncY1091ndVcMFB8+1LX2BdYiWQ9vpaq3seO?=
 =?us-ascii?Q?xMI59swXJPwLfERd6lqu553vqVQvMxrCRyRtgF3gjk9foYVxqbcij0a6sMYG?=
 =?us-ascii?Q?4YdiN3cAUn1Oo+83vx7+GHJnPMKgma6fHsMcgYchnzrvN81TI+eDOpC2wbx2?=
 =?us-ascii?Q?H8DhIxEMxGQtFyLJRa1hQ8rkB41UKk0Ge7FV1K/P0dSeQDUNHJcmrieQyhUI?=
 =?us-ascii?Q?+EpDG2ux6CP0XJ86+aP0KRHrrRfvjxUmRezCUInjFsrrGwdUoqNIOGAJAzRg?=
 =?us-ascii?Q?Z9+/ATVTFTTTTzX7QVoCcBMYAPdmEwh1oE7z7rsBn6y8nPpJooPmICLuqeI4?=
 =?us-ascii?Q?bvRRePWz7+sjVpQFV6sZNRWu7mOqlepqjQVxMSc4DphmBC5oWByttA9oL4TJ?=
 =?us-ascii?Q?J82TJNnd/YzAO998gNK9qjJDa4lBstyz+BZFff1+xEdzBHrO3n1jWQiSPxYi?=
 =?us-ascii?Q?9kJKlreLDLUNv2DOiljRe42BJ++YQlnzCLfT9/HbDalO2/e5kRI4qQ7iyGcK?=
 =?us-ascii?Q?bdy+DvwXx9GNikQdb1obutGOU1Ec3XGq4gxjnCroecF+a3dTBirGjQ1Fyt55?=
 =?us-ascii?Q?7LrY9fdLqkX2e0oCIce/+M8o1OtAVPyqKZ8xSb6TfcHMUMQkXUPCLEue7agG?=
 =?us-ascii?Q?kcOI7o7QjkX1oaZxQVJ7J30US3D+sYPD6S/yZiwFOMKmpSI1wSDexP/zCT3h?=
 =?us-ascii?Q?bnLomltW6nE3i6ezL+H7KIUzE1ROhaOtDuG2Wdt4rXN9L78t5OTZi9RqR1Ai?=
 =?us-ascii?Q?Qj8omXK+vMB9xn/2accEjiwYU4fibED4oWZcef5nnm8pLThqS3KP5WMsO3kj?=
 =?us-ascii?Q?oWEz8b4J+y6j8YSG9+It56HWsI4c/6YrjhSVfiOB7PBeBMZlv5C9qjEpTWWF?=
 =?us-ascii?Q?lb4vHaeaTG7O/TFVCBhVjM9c/5s6sPBAbXm0NdopELqOBj3OlBSCc23v/Bc/?=
 =?us-ascii?Q?/P8RHbaBwFy4ip+hr3F7FmExxJzY6dXr2ZDvlbAg63Cj/8HojxarXZ9256Hn?=
 =?us-ascii?Q?quqa+61n0ZTobfI16qPeGjn6biexA6SCErGzNbQRy+bckhCG5uezNTHNhPaI?=
 =?us-ascii?Q?hVhNacEDg3gtytyDYBnpdXZLAIuTDZxBbW1w5laXFdsUgousTxr7iNIFnzdW?=
 =?us-ascii?Q?4VCM1372V44hDs3qDAEI+GkJAe4hQXqb7tEK+Qv2e6Xj9MTvTsfN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0ddae6-8e08-4894-1c60-08deddcbccdb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:07:32.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R2bt1DpVaCstnWd2gtci8K9HOYaUkaVtGm86uyREwjELYOR8CB+4Vka9g3J+jn0rET7i2I/99W2o44rcVKBQBp25Ki3fsK+WkwUtkLypVr485lWCcegwL9e7JwnQoW9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10768

On Thu, Jul 09, 2026 at 04:10:21PM +0800, HaoNing Cheng via B4 Relay wrote:
> [You don't often get email from devnull+haoning.cheng.cn.bosch.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
>
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements.
>
> Document the optional fsl,temp-calibration-offset-millicelsius property,
> a signed offset in millicelsius that is added to the calculated sensor
> temperature.

why board difference cause such offset, I suppose it is cause by SoC
variance. The offset may difference if you change to another chip. another
words, if you have 1000 boards, Is this offset the same?


> The property is optional and the existing behaviour is kept
> when it is omitted.
>
> Update the binding example to show its usage.
>
> Signed-off-by: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
> ---
>  Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> index 949b154856c5..eb7243a7ebaf 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> @@ -59,6 +59,13 @@ properties:
>    clocks:
>      maxItems: 1
>
> +  fsl,temp-calibration-offset-millicelsius:
> +    maxItems: 1

suppose it int32, why need maxItems here?

Frank

> +    description:
> +      A signed calibration offset, in millicelsius, added to the calculated
> +      sensor temperature to compensate for board-level measurement
> +      differences. When absent, no offset is applied.
> +
>    "#thermal-sensor-cells":
>      const: 0
>
> @@ -109,6 +116,7 @@ examples:
>              nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
>              nvmem-cell-names = "calib", "temp_grade";
>              clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> +            fsl,temp-calibration-offset-millicelsius = <(-6400)>;
>              #thermal-sensor-cells = <0>;
>          };
>      };
>
> --
> 2.43.0
>
>
>
