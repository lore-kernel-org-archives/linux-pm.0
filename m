Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D84195A4;
	Fri, 10 Jul 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697609; cv=fail; b=Edj3XqMXDpMSF2VOAgPXE5tMY1Pk0Ti4+RjQsy4/nKt9Trjnb704My0mv1BUKMn60HrXiJALp0wqUZUv4/Of20EvklR46OCuCYKoK18AUCoM468aQjVkkexGrNmqErnBjE0ooWL1mo3fyXgVQwGAVKcq5yirWrXKas/lOMo8i/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697609; c=relaxed/simple;
	bh=/X0MAezw84uq2zQnTkC2k4ETk9RgWnb/UTNX8SnDIY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yfffk2MS9ZA+IAtntfA7KY36Qrt7eD7jUGf/8G/RxM+cittCkrckwNYbhajgh1lPHNwhzoz7l714ZJBcF2/V0RDR4Pw/DO7PnQ+8H63SvTyJjS2rWSG78avkgXaCRh3mYuHmJNSAJtUwfoskWO077OSZ5BW13S10dPZOL+Y9zZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AzsUuQ6K; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AzsUuQ6K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ4kcy2nuLfpXZ6q0YMPcUav4J83EJOAWBdg3p01dGaYTsKaHX13ck3E3kfpDmt39A3JWipTItpkoI75zHlbVe7AmAUXRpOeO0yLjq43NSSh7AuwteQ2/xzOjvT0AtmcoZ8l6lc67CCpPxxo6kCPpNBMaPCujOtprgTFUC2N/JtraE0CfMa40pAWMTXqGy6M48cWfGqTd3Ju+GbwEGK4Odmba0bwnJPPlpu+FvhhemoCKo+Jz0CFkyIc7QJSyWpRcO/aeCrKePQqZPyoARWGSA74Afx2eHwGZaQPdCy5A1x8X90UszwuuyfY+taEsdS+tlwmLLK19HNpnWeUp/AJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IonECwjoPteSKiFmF0BYBXGcGB39kgEoKPbOHCoLHCE=;
 b=tc+P1cjRYdkoMDFPHMvrJW0vZyPkXmWJ9IU1iQbKFJ0u3O8eJ0d78yVoONq7/z8BkFwfvqO7fxh8uM3lTCdjPJT8OabuGiRVSn3nadxjtC8EGS1SADH3gsaoY8Q106NY5Cub0tRRhU7vxtuWvACjwjPaxz4xTLxqyEPleNNfP6Os2fSRiU1HBvUprQ/5cSmW/Oal53N00Uk6nfkM7fjW8lUKe70DICmeeuUYVeTXGKfB1QCGKvAengDphKp9m048q/Rd9TP2W1J1dNrLqxSTIJj7P/DQAp0oFNo086E8hLhbc28RNv3Kzmq7zoFQ9tY0EZQ5ZxdKgyGhyOG8GhcKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IonECwjoPteSKiFmF0BYBXGcGB39kgEoKPbOHCoLHCE=;
 b=AzsUuQ6K5sQ4CaDOnCQ1+81AIuYDtAGrjEt88fCuZl3GaIqxppPdKxcFZxG23Pc2wk0QM6JfWpd2dABuB81TSqhJdqNVolvLY/lCR3+NNlZxI2bagaOP4hU+kZlttojyLhCl+k2b1cNKiBkl1Aq55K7thZ00stSZpPNLgmwARd6xlQd0V9wSL23vmmen9LSkRFeuYGIFdq/IBIyQnCDZ9eWV/208QSb0vKeHQKYttjNRcrCKLTfXSwIdK5EGoHGlY0lWy0TdbZZ9p6j53t4U9Enigvhp7D6HkKpWTjWOwuFsFdRhrMUC2+b+fW4U3p6Yqh3K4+Id61jTsvcIBxbiMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 15:33:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 15:33:24 +0000
Date: Fri, 10 Jul 2026 10:33:13 -0500
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
Subject: Re: [PATCH v4 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Message-ID: <alEQuVaYjNeWEStP@SMW015318>
References: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-0-1fef97d1c750@cn.bosch.com>
 <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-1-1fef97d1c750@cn.bosch.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-1-1fef97d1c750@cn.bosch.com>
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7987de85-7a1c-4f85-a961-08dede989484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|366016|1800799024|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bl8OELV+sk0+YS/5N2Ll1Bm2OdRtpqXHsbxOB+yRBiy+qE6HIVROFtIpajCwEijnr+4sZGDtoqrQLvZzeyoo2ZSPI9jLxPKVSmIv6hQH4WqZC5TwFuNKh2dz0KPhl3p3fI6HMvarlVTH+NotOPL/6+Hz8aDOAU6x8eERiNyXbIfe0MXjLwwg+RnkJFwsQmJi+iDWmI8JAQrvW/HqEfNyAMy246b70MaarbHivZdO2NTSx1LHbeUD9YSGb4b09ERpWT0S3m46jxgV9TTs8P3/50iTuReA/kjQRaPgQ3CPe3PkJYOKhVLVBHHQOe7p79IGOm1G+4f/gYUcR31nP3mzjb4UreemMGWwTEebWhQ1MeSR8SwNj9wXxgBk7IdeXlWP9T7AQig9JtIFbRl0xfJlX6Hw60XCmZ399vaqF0lfFj32RLm0WdIFnhYA0NXkXlFlWmLAoYdIFWR5Qnak2OnK2D/L3QGLdEub3R8uqUvkAdTSZVAvsxAn2icKnJU0A4FtjTdOBhe2v/AizvW2SdTrUZTYNdf55w8JDMkE5A4RkjoXTbiq6uaGoNK+49eRPtvQyVRjPYllRmV2f1y/DpXX1hVYwLjCe7N5dfxn7gdMAVVJYltcKAUaAjtkoY7O8QAFr9ycLGpqVpJCADb1QNSk9Uwu7jzkG0Jpo0xeT7iYxvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(366016)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWaachUWtJZ9utchUGyjQEpCvlGgDSOyCr91p6f8OfbHGmB6VP1kp0G8T3Fh?=
 =?us-ascii?Q?ZJr8EtIekK3U5U/D9vjllvSH9aba502LdnnI7FPvTuPPWpMawxvQxhAd+PxH?=
 =?us-ascii?Q?oADudgnWEETof17EZM7cxrMBcH/oc2g/HKk9KR4kChMQiAYlQis23iM5/mk1?=
 =?us-ascii?Q?8HKFTTOk0JbijOD3cXJjW7I561IU2n7NuAznexoEsC0iN9aytWMkcJ5STTgw?=
 =?us-ascii?Q?+5qjmzhkyW7mHlTrjSCwH24NgwSmUNtBP6G+gEjtKhbErxYDRjlnCO0EoEgK?=
 =?us-ascii?Q?UjJ/wOJw68VeiFPYsBWiidZF6e0Y4uhYlSe0STWCIjPemzbg2YcsKJ4Xqa5l?=
 =?us-ascii?Q?OhMMrzlvfJkiPsOnVd6WfXe3wa+ntrXVLioa3R92a9mgrxLNZ71r1mzUHE2B?=
 =?us-ascii?Q?fx59dtGVAXXwrjTeVtcfjV5y6pDw6g8ktWFs43NvFKhCosVcIHSEKGa1tPOw?=
 =?us-ascii?Q?Ysr+HwKhH3KmU/tAsWtJjPyiz+vewTul7gZbhZ9TxJiPuOZjScWhxF5kcxrM?=
 =?us-ascii?Q?RlplkVTygaDkU7GG/+TObRw18C73hwz4gXzuXIf+H4hJrMGuK9qVpVxy0Kp2?=
 =?us-ascii?Q?dVC8HDqNdsE8FU49luSznX0nEB4ZqaBPd6XOj/C4ydwmzSid12hCTiZFfHQY?=
 =?us-ascii?Q?AW1gEwPhLvHRIwtCDphBTDCklA1ra10iL+Pxzui2nshYBbJs3zS527S5lGnG?=
 =?us-ascii?Q?hATldofynloa9ZBQsXbCvLc+nM+IGtvn+kOqkBL4WytNp7dOZRCISevjUYds?=
 =?us-ascii?Q?fl/52zry6hMWKYnGlycUUI/KH6fl6Of40hH+FAf2GYXdWGW396ReKwC9fCqE?=
 =?us-ascii?Q?C+WjecO3NoTYg6quvGMyPmI9rmHAdbHxAuRMIFPp7vtFdRrbffANtK6Q2Jch?=
 =?us-ascii?Q?bx7wak/3sfXA99cUo6pNbp78VhKqM/nhfgTVC0cyIrkFf0V1ubbscIcAc47A?=
 =?us-ascii?Q?BubAxcRL53is0VMXCxWpHH0TfsQ5atWOXUJxUraFzSO20AXwrLQhIEj29NLl?=
 =?us-ascii?Q?+uxy+dRIU5sAig5iQP9qUQX1dk/2VJD0zUMaXOPZdoZRPgXDjaaQDaIXsNSV?=
 =?us-ascii?Q?IkaIrJyCm1sQdUAkxt5VeCLwONKjt8B7exW6C/j++1G6R6DnQwlzHvNB8d30?=
 =?us-ascii?Q?VFYr2V5yHQWiYC8Sm+v91V3npXYRlwq/fuDp+tD4G1UjCuRXmKLxN2fX+7AA?=
 =?us-ascii?Q?CGfIrDm/MLzpE3eC6u1M2qK/9GaM9Bl/FM01jBWwPa8EVUoz2vx6vnFX2srY?=
 =?us-ascii?Q?slN1v6E9AfVB1BV9AYFAa8s/0luJi4FWEPI/g5KnanCZ223MHymtHu0Z/kzf?=
 =?us-ascii?Q?tVwTbpk3YupnHkSEGamRGEEEw3oU7yEEj0wASrTn1SwN2o+9Z+AMW/ocIsBA?=
 =?us-ascii?Q?YZKkav3JePadfhiy2gHZrOboiSBtdt7PR9H4hD4wlEe/2IfKnOetiFlYtUKZ?=
 =?us-ascii?Q?WrY7xCiAhbzP8tSOJZeZoPZm9c7Bb2zfu+AL37JWYuG/zE6KxebPpi6cjzK+?=
 =?us-ascii?Q?xY+nArDc5veZTWHiYQFgpgL1QBO83RThmFbmRA/AMPSiBtWeomOVCIkpFlBX?=
 =?us-ascii?Q?qAaJCGSa3UpPXbXB4c2J/E/n0qaptMeCImSrEzu1w4fdljcFXFXxRuhNyeTF?=
 =?us-ascii?Q?gwEGNeKET1z4UvrxxaU+jVZhDiiMGfJ7+UPblN8XsniignnBLL04bIIEmEtt?=
 =?us-ascii?Q?+/TeEUpMghPVeBRhdVJbA8ucke3/pH3mkJTZmzuLOUb1fT23dsRSp1pZBN7P?=
 =?us-ascii?Q?xqXj9otaXmDF2emwvIZWmSpWupvrfyXgiHiHQz5MjGAmsjjswUTi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7987de85-7a1c-4f85-a961-08dede989484
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:33:24.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah9KsibzWQh8lIbK/LJ/xbZ0HOWw/rSXwXk8y0eQR6FVrnCyOMday2k76oLDdKIF9vReq8zJrIRrmRjRPB5NGv+NT3WgPYX9T3AyPhzy/c8yYxpMivHdVbk3ALW4xI1K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

On Fri, Jul 10, 2026 at 11:03:36AM +0800, HaoNing Cheng via B4 Relay wrote:
> [You don't often get email from devnull+haoning.cheng.cn.bosch.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
>
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements.

Thanks you for patch, but you have not answer my previous question yet.

"why board difference cause such offset, I suppose it is cause by SoC
variance. The offset may difference if you change to another chip. another
words, if you have 1000 boards, Is this offset the same?"

Or did you tune this value for each boards?

Frank

>
> Document the optional fsl,temp-calibration-offset-millicelsius property,
> a signed offset in millicelsius that is added to the calculated sensor
> temperature. The property is optional and the existing behaviour is kept
> when it is omitted.
>
> Update the binding example to show its usage.
>
> Signed-off-by: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
> ---
>  Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> index 949b154856c5..b9afffd98f84 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> @@ -59,6 +59,14 @@ properties:
>    clocks:
>      maxItems: 1
>
> +  fsl,temp-calibration-offset-millicelsius:
> +    minimum: -28580
> +    maximum: 28580
> +    description:
> +      A signed calibration offset, in millicelsius, added to the calculated
> +      sensor temperature to compensate for board-level measurement
> +      differences. When absent, no offset is applied.
> +
>    "#thermal-sensor-cells":
>      const: 0
>
> @@ -109,6 +117,7 @@ examples:
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
