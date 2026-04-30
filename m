Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D9332EAC;
	Thu, 30 Apr 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517484; cv=fail; b=BcMvGPLH4GB+dtbLGN+74gcXJvXJD89nTNs3xfHVwGpMnxfmMT9zFLYVll7B4Eu5UijZGDgu6mLcmIqz+TL3/G5FpuV2PEnYiW0c2Z4NEnHvEdds165vK9a+9A68SwtjWP1eiIke0qjK8fvDvzaSQoVMqyTEJOkEPQDLCOU534A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517484; c=relaxed/simple;
	bh=dg3mdns1os5pheR4NAu6V1BJMET9Yls6MRT0e6kqdEo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YjwksPtEyyff48gBNDFjNAhgb88q+dIyrBpOjfarrGtOatHruPFk6I3m3VoQHsxMRHS+evYj9JpVaRwb9HdivFsBqX7T2Qmf1pa5U4+Q+yYN81MMsLGKUHspTyhI+Q4IpDvkcKc2ppTKGZwowaiyY7uJ9pb5odYcf5Z+cAjf70o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T/BquhjA; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/BquhjA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujljTAxk9tF9PvGw6z0wxHUF9ydGBp0BvT48D0xlpsu/HWtLd0Feomv+8aVceH7pkK0W9Qe0Y6NpRHhYRfvBtIu4zlLndJGRVMq4NUY/ANcDwAwsoKS9R87HzPsoVIdBEw7x4YqM3BMtzvKwVbt9wSYQajqCv1Fjfjy9fWQk3FHoBkhTsMtLX/T49NMcQTS4lUxevWntvC+qtoV2WedPx9N9egPc5r0/fX3qCBVa+KqPCl6/qoA3lDqBtYW+dm2E+JotA6wTqpMnyr5eGnGCJ7mXfF+vSOqQGw3ucSGft7Pw2Qqst8peUSQ4lIAoz/UPIS7bFAT3kfV3tUwiwTOLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdIBNZGg2VPUfM5vnwY6ek8L5Pv4pNYvpBfv5NAJFX0=;
 b=wqooJyRm6GMyFC6/ElkuDZ9lWnDN0XZkwbmrJXfwgL6l6LYOs2XeLSnt0FMC34LmiluoSMCNldxGzaVDj88yDr28Sa8qDqbdxo+lRDvX6XAWfySMuOE9GnqMySAw2ssWGPFCUViim+eVWGhwsnHonWBcvpHlQsY4MVmMzMbcxbLwpV0/7GRWoUpQNe1QEShAH6q307fd2DiHtR8OFd/Chahn74csBzu5A37zjQK5r6aj/foo74Q8+92s2E/VaUnMD75NlML+KpIhuog5UQ3ysCEEaHfyDvW0zdQTJQtmzB8VGRoQ9fVc8jiiTcBGb7xjXuoB6ZGfV8k2K/PxX4jXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdIBNZGg2VPUfM5vnwY6ek8L5Pv4pNYvpBfv5NAJFX0=;
 b=T/BquhjA1MwXLbtoHfYxyVhanXrkEHK8xTUz1dXaZwCF9SpPFGGPQF9NtOSa0ws4CE0HuxXnIFxBGKuMHGa1EPVBb+b5ZiJ207VHTyWUeMdhn/aouXzf8w8NlOOXJoPdJ5sMMnp9kFrHKPN9z212RPdV3bm24mS9/zL8UsEab/y5mOmkFsza6CNGTUATaiyrNURzm5LYHxuD0EQ8KMwJ1Ct/E09ZXFhTgE6oi0skMANt3sGG3/C84wgjG/7UPE1mfkBeGkrdz/9D3qAReLCJ+dWORr6uHmkJ2DU9dbpK4uBFlL8ppDdzV56ew6etrbZNvoV2QNkyshgE1j4QIFlYtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:51:20 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:51:20 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 30 Apr 2026 10:53:33 +0800
Subject: [PATCH v6 4/4] arm64: dts: imx93: update the tmu compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-imx93_tmu-v6-4-485459d7b54f@nxp.com>
References: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
In-Reply-To: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777517621; l=965;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=dg3mdns1os5pheR4NAu6V1BJMET9Yls6MRT0e6kqdEo=;
 b=QfArIwZrj3f2ofbLbws30nm/r2fAMbZpOiddOusf6igQTMGjQM3Se9SzqqeGw41B5n2hBkoSQ
 tdDloqPnsbJD7ofTgEtSbqnAnaR9NVVABfzgffx9k0hQ0RxHPoAM4iY
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: e40adb9f-3547-4e1a-519d-08dea6635bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	bU0hJkevE1VolsTO7qBEIme1DNTlM+RNc/Dl5GUuVe08mcM5uNWCgPdGTV3kLt8stLO3n+Ygg/wfxAaf+5cCk3zfnbsQGpuHmIl2s9a6XzYKQlMo/0j9y6AHGN0byW91Oqm/GVQz6GR7s9uedDZGYSwRuSqWkVXEV4c4DokNiUMudg1h6tspKxVBp/jJA3/BTMIG/5nRpUVeK42leZzGOaD5StAYnpb6Hg4LvdeGxrAawsyGJqLVc4jImHitUumktzdrmf3WnJjjI2uLaLkGq02TcUfVFADkLwlglEBfgUc7Ult2QIofIiVqzQEyuhwLUVWqI3Q2eGb1z2SDUhlpeeGiZI9yw2O/SuIOQ2CXXc5lGv6ZzS/CEFvoisMAeUpxfvfylBJSfnEZv3ZhV0ZeYL8j+yOqwpGo0q07yWAxULZ7/VnRuStIN7AroTiU/pY5VFcmgFJEfAxNG0P9obM79MuJQyBAX+JDCOAlGgfKiwNYcDwqFjAaOrC/3mYFRfMT0GH9mNNXfL/uvKD4pj9DqGzlisjH02ixp2TkMAJES5DZsQpj/1lIE0UVoIn2J0UOTZVJXB7uuzRaNMNgdg7+tEouSOPIa7Wkcfx8e3HWcquqe3A9IBpPCD0nv2tbBRr9ZkOQWYcf6cRbcin1Gq2RM4+IXbBfKMFdbgS88oAQ9nF8/ljI1huKAM9cHntjYU33R+3dJsyvaUCZQqqLi6SfY8Zvf9QcABhMDZQ+oGwSIUuaS/hoVk3NDowZJbWHfbks8b9oMn7e99+VBf5vn3jTnCXtJS4rBEVopmlEgN41cWf0Dv+nrSd8yx/tNPfynjX9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5MT0RYbzI0MTJ4Q1ZMQ0I5N01seU9KVm1Eb0lEanVuQzVvVGFJQ200amI0?=
 =?utf-8?B?UW9YcHNNSDk5ZlIzeXpLZEpmeEVkcm1wQk1uMmY5dlNWMWRud3hBTDRNUVcz?=
 =?utf-8?B?TTZPdnZKTEt4SU00V2QzZTI1VFJQVlVyNUJqbVFkWWhONjFPM0M4NEtDdTkw?=
 =?utf-8?B?NkxTQUxjcFhXeDFtam4yS1RPeDdXaUx0bjcxcnRYTmdtSkVJRC9JQWxnK2t3?=
 =?utf-8?B?TVRQSDFHQitNZk9Rd1d2NEYzbm5qZHl3a3FZMXJjZXBnT29EYkJxY21DZnZF?=
 =?utf-8?B?aGdoWWlENkIyK2ZEUjBsMngwZWVQRTl6aUtuM2NiWkQrUHJqZXE1S2pRdXQ4?=
 =?utf-8?B?OWtwcGNjNSt6L2RXQ0ZUUHNmMkNPSEFhcE90S28rbkJsdnNHcmtOQXJIT3Jj?=
 =?utf-8?B?dHdGMWV1MU1UNDZqY2E5bTlZdmQyRTkycnJ6aGkwc09XK3h0WndYUHVnTnNn?=
 =?utf-8?B?RSsxcUF3VjVGRE1zRVRtN2FkRFh1N3JJYkZYTXFNMmdIRGpxQjVGUWxaSWZ5?=
 =?utf-8?B?S25lMzNvSVVJTG5oNENJbnREWGsxTlAwT1F5OEJnemtTTnNtc1huVG9qSkRw?=
 =?utf-8?B?bm9XT3dWZE84M1lmOFhvRGlET3hLK0xOU1JORVp5UTdNY05JRUpvdUpycGQr?=
 =?utf-8?B?bkhtanBWRjF0NEp6ZXNPWFBkOE4wU2xpeVBheSsrU0xXNFJQeWpqVWRNOGJS?=
 =?utf-8?B?NG9KSStPOGVwMW1HSmJvNDIycHI3cXVsSHpZRTNiWXhzRlFBZVZ3cVhNbzVI?=
 =?utf-8?B?K3VlamVlNmF6Wnh5RXJuU3k0c2t5RUNvVzZ6bHBLT2xvcFJzM3UxMHhyUTN6?=
 =?utf-8?B?U0NaOWV5bEZvcjhxeWphZVJlUXVqMEJ1MDdjQU5OU3V1bnQ0ZFM2V0JpazVG?=
 =?utf-8?B?MWc1UUZNVCt6N0xCY2J4NlYxbHh2NkMwWlBFWnM1VXB4bk5rUi9FL3MzYmxu?=
 =?utf-8?B?amdLd2ZVY0RjOThoVHJmUktWMGx2RFZlcm5ob1NqVGlNdnlMZTBpb1N2NHVS?=
 =?utf-8?B?TUw5OTlIYUViMlV3NzQzNWNMekFtRzIzWG5jV2x3ZHV6N1JUaS9TNkpoMGg2?=
 =?utf-8?B?MWVFR1BvLzVWZGYrSVNINXBNamZVenE2V3pKMFZGWWl4eTBNb0V3c0xBWHAy?=
 =?utf-8?B?MFpIZTl1VGJGcjVsc0Yra0hEQ3RCYzJmcEwvSGIrWGtFWk5lcVBaUTFLZjgy?=
 =?utf-8?B?R2V5aEtIZ0tOQlh6NlYveStqaElRYVN4VmdhV2NHUnFtTEF1TXBuZEZHa0Jx?=
 =?utf-8?B?WHZWL21md2NVNjRCdkp2VzVYMmFtc3REcFZLbW9SS05xU0dQWWpqa0JnUUsx?=
 =?utf-8?B?T3V3c01janlRZHNwNUlyQ1p0cGp4NVcyOGN1eEIzWVZuZ1c3RjN3b3NCdTY5?=
 =?utf-8?B?U2JKTVl3Zi9SdHBkdjB6SjIzak5hTnNHTVhhMUwxcW0xWE94Tlp3dkpZeTBr?=
 =?utf-8?B?clh4QnV5bk5SL2JWSVpIWHlmYVJuVGFpVzBjYzJmYTI5NlM4NExlQ053UlpH?=
 =?utf-8?B?ai9ha3dvY1ltL1RuWWgyUlZ6cW1DY0kwSWdINVRJcGM0UUo2RVY3RVowQ0pk?=
 =?utf-8?B?U1ZzcVhEZHVyM1J2QWhyMWhFd1ArbVBVYXNiR0RFeWJDMUlodEFZVUdrYVYv?=
 =?utf-8?B?Sm1JUy82K1Zla0lEVDNXTU53aHR3Mzl6dnRMZDJucnhIS285eFdUaHpJWmg5?=
 =?utf-8?B?L0MxdnVuNWh1Rko1TjRHUVFKYW8rcktobzNaWHFyT1d6YnNTK2N2SnM0R09U?=
 =?utf-8?B?a0o5MFV3Qm1hWk1vN0g1T1pJaXV6VDEzb05oME9vdGh6aFY0dSthd3BzNE4y?=
 =?utf-8?B?c21EUm9Va2l3aFhKbWgzNEVETXdRMGdRM0NGYkM4Mi9xV2I1dVBiUFUxaVRH?=
 =?utf-8?B?WGFhS1QzUk04bnBKaVNTVDN6T0kvejJRVnR0d3RpTWtRbHNRaVY0UkgvelM0?=
 =?utf-8?B?aFB2akd3NndLT3NxME9VdkUvQWJCd2dTVHZRN0ZVMFZLOC8xQ2dwMzJ0QTI4?=
 =?utf-8?B?MWVkNGMxMFRCYXUrTkYvY0JQcmoxbldVWHFXbUgxNkVHZjJwT2VucEVhU1l5?=
 =?utf-8?B?emVrdER5Q2k5SUhXS1Y5VyswRXFIMnAwYTRuNVlyWXpTY3B2ZHI1QmsxMWlY?=
 =?utf-8?B?VWJkN0JVZC9TWitrSzZLay9lYTZ5SDlpWVA5V1pYNnZCZXU1R1M5M2VJUnFy?=
 =?utf-8?B?QkZOL1Jxc2xoL3cxdWxFUTBZU3ZkazlIMGo4WXYydkNmcE5CMHFZSG5hMTE1?=
 =?utf-8?B?U3RieW5kNVNXTVpRem1zeXpjT0FQQmV3WFNMdFkvNlVzY1ZhKzlsTmhYTHNk?=
 =?utf-8?B?UHZGMU9RejJZK2ppNEJqa1RlMzNlL0FxU3ZramtqOGVyamhQZnkxQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40adb9f-3547-4e1a-519d-08dea6635bc4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:51:20.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rtkvbm3uGXUXJIIAwNFpao3ju5yviIoBvZex+eo1rXtJIix6naFVgFO4CHqzWrAgF8AiX62i1+avMbP0T1lGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

The i.MX93 TMU node compatible need to be updated to apply the SoC
specific configuration and TMU errata workaround.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v6 changes:
  - no

 - v5 changes:
  - no

 - v4 changes:
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

