Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31A38736E;
	Tue, 21 Apr 2026 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757228; cv=fail; b=K2GZyGrWpWe4n12f0OL1NUjPhKxhPZzuoQRJge40NBQLPpGsRyMk4CBl4NaLYWxggRIdheeXURcZZai+sIGLPkgCnWITe1kYyt1UK5Wn8xUsjooA0/vkYGMevpBVl6tWItAECTvzOZIEp2K8999BTSqmEo1OW1YtaqRiQusZzWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757228; c=relaxed/simple;
	bh=C2z9d/qxNtaax2vGBA5YXXwyfbDGkbmPDxbbfo35dGY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pNIdJCCzdHz1Zwi501/2+62IsoiGfn3VgonWeijsC+kROyTtogtzVnYva0VN12p0qcBuNa+/nekwI48jI9Kq9+nznuhfehIXepQwAuD2BPzMCYQ5CG+mnc0xyX+KT8mEJIM5RBYobVH3fG6X9Xl2fffXmGxP476s0TZ1kIGweqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QbQXMLWL; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QbQXMLWL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDI+qGpihC2wJAjxgcQVR2XSv6UIk31pPXBnGz1Dfqrf3XHs1KDPAFPBuQYS4HAu3M4uOQ6DJzZjVCiKKezZf22jmNd79ybzXD84UPi6beji6/VV99dXLJ0/F4bB0eIjj4WXZsBttOiaQ0AIyqP1maDQlSmgmNT6nD4td3klmiitsDgJm9st0n/VMxjWA5U445VOZutb2bjWvycn3SSDrdyMkxi8/hFJbaEyZUG8YreTs3JtonJgCOQWEstN7SB/YQ0UXfFj2kW/b7jceLpu0J3Zi160hGuRQpjgAkkj1vkhZMEfyba+3VCH93SFk+hdVD2UjT+mUm+r2GogRs7kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MY1ubkQCOQpj75z8j2uhE4RtZd9hN4RqCIp9ia0fkA=;
 b=pe90T6Xxg57R7jArHGJjvmMzz+PsZf9lQtvr45jLgj2/S1oaDdEYu52bo5zuIoVUW3DRpjcHdjFHl3GeU6KYvabZuB39EymoyI8RdyNrBH5O97/X6ngMB7QFOguTX3kYCZ9pe4nWxMKQOCzWS+PTn1cAgh0MorAgs7jnnkKw6liIF6nzr7FdrpxMcBeK9rw7fAOdimdjac6E9D869g43aA/VMEfngzO2imx47hrCxenfBSG1UUBHhkPyQmEDz5z6Cb/ppxuy3EQOnEGr5njEyOajJqlRe6bqRCaIvkVxmckGJyevYYrB32oeJZFqtMBeuGaBl7Qk3MUAk6qjAzDk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MY1ubkQCOQpj75z8j2uhE4RtZd9hN4RqCIp9ia0fkA=;
 b=QbQXMLWLHVG35cz4f1mXtekpv+bGgXndHC4wKwjdn7Vklm7XAzihAs9JaKmj+61VMkfS4JFaThDAJfrAYkndZE/8mOGa6tJ/tXj1uZTVuM9FqZ35h6NXnTvzFtcGAqpDKyk/JC+nCG10U0xQ+u5GqmWNd6SlxRP2pl9kYykxI0Mtx19Ram8d/BGvYsl7qCtCbaKLYsEiRv23TiJsZ0Op5D/HMwxXUqeyLLgGRMySivqQ8g8rkT8o996cCOhVLhdWhRink/8GQv4joIts6RGpmzxMZ+eQQS3U+k+n4m/szE4ENYnKkUwprR2aDP/D9U2v+WetBbZZbk9C7YpqRfTn7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:40:23 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 07:40:23 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Tue, 21 Apr 2026 15:42:25 +0800
Subject: [PATCH v5 4/4] arm64: dts: imx93: update the tmu compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx93_tmu-v5-4-05ea1969bb9f@nxp.com>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
In-Reply-To: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776757357; l=1014;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=C2z9d/qxNtaax2vGBA5YXXwyfbDGkbmPDxbbfo35dGY=;
 b=yYZsJj/6jNV+97bAx7Zb/my3K9hwkBEVedWNN2fG7MSemmQWIYBTTr5p149euKezge7zxZDcR
 qrH+f5W90ZTDk+/GPUI19HOvcrc5oBUY+jzqpRAS9+Xo1Ydq1Y6IH5g
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: d16dd714-8905-4701-cc8e-08de9f793e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|38350700014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7DJYhOROpAcfsDP2Wzo/tUJonloI3l0YYW+bbv17oyIIhG5MVPNPf7r5wD3mR9d1BdrED5P/Thr3Hv83OTa1wJdejPZgir+joEpXXIjL6nOvzYxCMNUkPcShqbHCtoF/f7c9YGWRR7h5xXQQ3meag4QW8thARJA/UfVDUJExAi0lUoIYKNNiaVg7fbUm5o4s4BVWplmd5HGVaNospY59qMpxBF2eP6ze06h9QkIxA8H1PlFXEtORlPcA+E0HqezIPBhWU5T3Xv+bHiIL9xKRJoeniNVeyyRi+I4R3g1OwhMuHGZ/CoAFsY0nWbpN9QjOP2qX11WrRGVher+eK1N6zznEg/h6EXCDgGU/61+zNEy63fo9s/nb4ftGCeI0r70qLktC5V75YyKxQH91pWARn+Q3gVq6wSu3oA+7ydEsb+KVcj3tKQ6B7U/ahlugoQqHLRb5Bth8Fox/lpPRI30rYYLWX20st6KDK09f9vQsV5IdfeMJaLFe52UNsXieaD69cSVJFsgi8EFe1GDQHVT5SOMQOwtK9EVG/+t6HqD5fGdhHQDL7bd6Wy2xoKjzlaRD6fDYXE3E+rKddiTvyPZkx13QwaB9psRT/oSN0xNwOqd7Tdqn73b2amkPdjZl+JWvHEKnsRkaHb6ICcEGKUJ6ClGU7sQL9vKnsN2Ykd9ZJ31Eg5FUESX8IVnDWqwHH3uTLZi6j1I849AmFLU+4yeRsSlTPiKfIRcOu9mgVAV+QfXhW5DOereapZYFO5g6lsGAyIGNZ5UmE1ni23NkcqcP9wzRcO+Jylm48c8jzRI4BVOrYgSMqIr08IqlJwbR/dJd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(38350700014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3VybmQ0d0R6TEkza0cvYm1MRWtWUDgyWldNVndZY2JpOXR4d1RXOVZxamIw?=
 =?utf-8?B?L3N4cEluZVR2VnRHNlNWbWErckxkbitUZGx6YUhNaUtIM2NMaGdLMnZyWDVm?=
 =?utf-8?B?T2VTSXpRYlVUS2FNSFpPcmsrT0Q1VUR0blBCY1hnbVFYZjM1cy9kSjk5T1dJ?=
 =?utf-8?B?QkptQVNBMnNuZC9rcVNKc1NyeGhld3ZZR010cEZjWStvakRpKzArOElEdzZT?=
 =?utf-8?B?UzNIb1E0QWtyOTdBbWtNTXUwVkxaWWRjdnN4VzFOZGp0eE9FNlhES0taUjBU?=
 =?utf-8?B?YlBKcmFKMS9CWmdMTlFIeWFTaEhLTmI4NlBIbUlxd29wUXJ3Ukg1N1ZSRXhH?=
 =?utf-8?B?b29UOU81dmNORGxhZkZkZ0pEdWNKYmtEbnJnVzQ3SzRZVTlEbjRtaUZNMFpO?=
 =?utf-8?B?MnJNQ2FrNmZyMitrL3IwTTBWVGdLNGlsK01HVWRlZzVBVXNybS9jWW1SNjFW?=
 =?utf-8?B?NmVOSStSQnZFYnV3dGxsZGI3REZiMHIwNXNsdXVDK2JldERFcEdVei9ua05q?=
 =?utf-8?B?WWNJaUR4MElvbUt5VWVscGh4OWxjaTJsN3M3eVRjNVpnYmFBZHpsREc0NXZ2?=
 =?utf-8?B?TlJkV05GbnJZZEFBeXh5TXhlR25zY05MSXZhU3JaTm5NNEcyek0wZGo3T2lw?=
 =?utf-8?B?cmtCcENVM0plZHhIK0tjMlpGc1I5RXNhV0k4MmQvTU84YjdCOXpEeXRxZ0FN?=
 =?utf-8?B?S0tEOGwyRnA1cmxKbW9Id29XTUJERk53aWhIQlhaaHZXaDZRYkI3QkZvQ05p?=
 =?utf-8?B?MndUdUY3YkxyQXFoVGhXU3NXWkl3d3lvRDluZEQ2UklTYzB2RElsTFdQd294?=
 =?utf-8?B?dVE3bWZ0S0pDYmtoNXUybDFBS3pyK2lYSEtkelY5VjhLZ3BhQUhmV1RRS2Mv?=
 =?utf-8?B?cCt6d0xjaVFjOERzNFAxekJGMnFQMkNYVTZKNnFJMkw1Y1liMmNwTi95Tit5?=
 =?utf-8?B?OVdZRkFQbklEb2xiUXRneFhSenYwTFJmd1dqZUNXWFdMWXNPOHhkQ0g5bytr?=
 =?utf-8?B?Q25ET1RRMVcrYVREeG1xTE1zVVV5Zmt2eEFnSVZjeVJSTjF3WWp4aG4zbkM3?=
 =?utf-8?B?UWRHRU1OdnpwL1pFcGJ3OFMzUXZrV1YwRjBjcHMwU2hEZ3h6SXhhRXVqWXYy?=
 =?utf-8?B?RzJ0dUpwVEZ6TC9Wbkw5cm9EcGl5dm9hVXlIaW9Ca3UxVTlmMGVCNGNQNWUz?=
 =?utf-8?B?dkx5dXUzcFp5SVF5S2hBVE04ZHpFOStUWlBYK3VoWExiUW9vK2pLVWE0MVA0?=
 =?utf-8?B?UmpKM3RIZFBVVXlJN2lUNzBvZmtZaUFUU05TYUhLeXlJTWtjMDhjcWsvTHlM?=
 =?utf-8?B?cXpoaFp4TFVzWlFKREdxKytCQmVkbFh4dlRnV3kzWEdCQWVqTDhZZHpQT2Vw?=
 =?utf-8?B?WEhaTnc4YUVRZmdQdEFQT0puaDRuYVdpSG5NODZHR0duUEw3cStaZ1hxTnJY?=
 =?utf-8?B?c1l1TkRWZlR0a05LbW1TaFJBM3A4RWgxdTZXS05oZFExU0svd2xEVGNLYS85?=
 =?utf-8?B?R3hzOFcvUnpodDhkN0syRmdXclRlZHg2TGVjVzRNamE4aWxnNHFLbDY3bkRI?=
 =?utf-8?B?VXBzOEl6VWVJbU1scElNdzIrc3BQR08xOElZQkxLNGg3QUgvdWdoMTlqQ0R6?=
 =?utf-8?B?VldHOU52VlM4RVZhdjlyNlFHNituZmdLaWlFc3FwUjJ5bFNHWlJjVGhUaUMv?=
 =?utf-8?B?LzFhdnRhclVLN1luSEVBWXZaOWwweXN0MzJXM2Y1Slg1eitCTGhEL0RNdENH?=
 =?utf-8?B?b3lyVUFtMjlGalRvUGtudUpaa1dtMkQ2ODdVRXRpNmh2MC9PNlRNMTJGYzAw?=
 =?utf-8?B?VXZhQzk2ejMxY3A4KzYrQVZDa0M3YmtpckVKSW9TUEJ3emE2YzBubzNzMFcw?=
 =?utf-8?B?WHZrV2tmSHI4ajNsc1l4aWt4RUNmR1J5WjlBOHFZTEgra1N5Ylh0L2pCclNq?=
 =?utf-8?B?eTVPc05YalhBVm1LUzJFVkwyUGEzZUIrMmViWGFhWXRGajhneWtrcXNQaWlZ?=
 =?utf-8?B?T3d5Snp0RncwRm1aaCtRUENmb280b28vL3hjVjVtbUd0emdDWituZGd6ZzAz?=
 =?utf-8?B?UGIreVYrb09KZVdxT203bmZFYVhSTkpYQUtLRUZNVjk5K1NnQysycDcyNStJ?=
 =?utf-8?B?L3BHTFl5QjNBQ1VuRitqR2xocS85aFVzdmQ4cDFlWjFTeVJkOFpKZVF4c3F4?=
 =?utf-8?B?cjVpRUo0VHdWZVpac3lhZE9Qa0R0UDBlT2kyWW5EMEZMWWd2eEZ5dHhGcXFS?=
 =?utf-8?B?NW9RVFQraFg2VXV5d0Z1Lzl6Rk1LT054V1oyb21FNFFxNjJ0djlkbmJSeWQ4?=
 =?utf-8?Q?Kh2IcoAy401GIl3n0s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16dd714-8905-4701-cc8e-08de9f793e26
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:40:23.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM3phqidrHGef+sM/oZtOGPvx21nrwYXQ1j5+sh0n6/F7VORKu2SsIf7+O/y9BioR4hWP1f8aOYF+R9fvfW7Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476

The i.MX93 TMU node compatible need to be updated to apply the SoC
specific configuration and TMU errata workaround.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v5 changes:
  - no

 - v4 changes:
  - no

 - v3 changes:
  - drop the qoriq compatible

 - v2 changes:
  - no
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index b9abe143cb567e722277960ff677d460154dfc8a..06443d52a4290f9525c320f8bcf5fba1a8435d11 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -80,7 +80,7 @@ mu1: mailbox@44230000 {
 	};
 
 	tmu: tmu@44482000 {
-		compatible = "fsl,qoriq-tmu";
+		compatible = "fsl,imx93-tmu";
 		reg = <0x44482000 0x1000>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clk IMX93_CLK_TMC_GATE>;

-- 
2.34.1

