Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9432D45B;
	Thu, 30 Apr 2026 02:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517474; cv=fail; b=DF47sJk7hTGyGdCBwhba5LVWO4Vo3NpeMlWEd0v1WiBLPdYfgPb6TdNEVVWu7F95xa4UtnhBVuYFp9H9umeMW0Kb35hVifg2quAbVwcVlqbl7wgCsXVP2qpZFldzN3cXX8Blt64wNRF9tsfKGus4gAIo0US092wUrdklmXf7UKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517474; c=relaxed/simple;
	bh=7iYyO7S6YsvXpf3WazgF7bvit5j52efltA07l7L1AWo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y3i38kwOAnW+HL7Lok+Dpv1qIOFVRlw34H+n2i3OEY/PPhp7uwQDodecm4mSlV+rinQphaJNxdb7Ie9JMzQ6uDzcSZgg45gQw8GpJ8bjvcxNjcSYdvrqQQAd2+gn6DKunBtr/3Lio12ROeI7RhxCSdQn1dBp8nXXrr9OIgE5ISM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZw+2gnc; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZw+2gnc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS5h9tzIJ6w08ZnLEZlvbPFzwAGIGsgehsPtfFGUdO9dHvyfMAEKvB4w+nFU/ntZEyhG8CrXpwyr727ZxNBRAIgG0Y7EzvQONkaW6DunPYEWuHx4MBa6wXfBhz+N5CgiqPffloWMuiY8Yi85xOSoBRNlwI7NyrFSUDqNRhbbYOU7rUjpjig/aqP8aQ4bJ65dWrKVce/sUEQwPIqKgVlzwxvys4Zc2rmWEMM7VkUTyzCEyPp5BMpZbh+0dmBbsXoZ7NznuSHKvAMbS0F3+duckgp+54hJT0QGArQc2rHkSLIFHBebo1t2p/TUVF15Xo3TfjSHndCS3wgJ4TAQ96etqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iiipCqgXqeEjlY9reJ79dDHSr7j0Y0iZ5HRO/jb4KA=;
 b=sf1HonfVotCGvlYJUkvEQyBOQXLGIsJZ+vNcfpXowrS2Fl01OwLfXFK3OMuSBEDqFp5LyHfwe9JrbDn5ZGlmKYNmdeCc+XqrSpkdFQt67w7Tqt8HTNxpkt+RyPonHzOK9W4IuqD1YL4ro87gzV4tnaepwxgVPRRjLxtSPb1sHLgy5HPxAo9do6KdKCSRabAtDSWTw0MR+p7agWIHm80ps71vrZhGIZzW7Jr9cd4v5m63a2qNmIUQ0K9+TdGcvsSsaX8zu2eeBOS9AmE/zzFzivEPCkXe+HvCKgGQJqYyiqCq7dreRkrDV7oIDSifKuFaUrXjtqNuiJ05WmC7Dd7EpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iiipCqgXqeEjlY9reJ79dDHSr7j0Y0iZ5HRO/jb4KA=;
 b=VZw+2gnczgtK2sD/sIm1eqFJUFYCNRXU4Nic7n2bnE9mjbhWNQwMEbB55nB6kmIXfShj+aiFwihZbB65u2r3/gbYe0/4Mf+v6+VHdB0WCOsqbSMVnq6qXP6EzY2oOaj4MlnAlz/+qGEU3l0p8AvQTlDxRDJE5syb7QcDivspXfm/f6VM5pjY3BwI70hj9i+0WdxvPSPclojh5pvw8KeoTU2NKIkbq2/dHKGnOG5aOvSPlySQfrOrx9gMNa3H2bI9K3NINK+HrGf6vtBpW/tG+xqMBjKSu4fvo0f86hy2ME9H8h6SDLlEOg3hdySgec30W8V4nKuNp97bYuAwya34DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:51:10 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:51:10 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 30 Apr 2026 10:53:31 +0800
Subject: [PATCH v6 2/4] thermal: qoriq: add i.MX93 tmu support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-imx93_tmu-v6-2-485459d7b54f@nxp.com>
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
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777517621; l=3395;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=7iYyO7S6YsvXpf3WazgF7bvit5j52efltA07l7L1AWo=;
 b=umrx9WWn1VDeBbChvrdf0/SXo+TkH7H4GyfkkeVg8VCONEZXQnIJ9PjJw9K7OAz+vHrwNZZq+
 rBleQ66CHsBCHZwCSCa8rLkFcPWb5+mosbGWD14A6+ihRv4dlbJ7huO
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
X-MS-Office365-Filtering-Correlation-Id: 70c2cd98-c307-4c1a-1170-08dea66355b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	HmQXt+8VMI0dn0s5NI1TC4Wg2grlmOMOPYTq13zu3GLLpv69tljZXfopGMduU38fJGb0r0WXgSFDWPbFxpLvDqbeQybvaA9wrwYq6R3wSSBI4k/9sgUtamzOGmtyy1NDBhimNcsjOMGbdWbKy6VCzJNByKpD2GjS5yYpjtTZvsab+vCA3L1lUuweZDn6abYvRAydzWcaC0pt9e27pbTfzEZL5P+Lb8i2trDTgRnpSNOPiCXtphXvas9aA7rT1VjChf57RDbdUni99CcWPCG/NE7+PrgKq2PIeb+lug0oMaffi+0Gmt4AeHAFdn0gsdqs1ge9BjgMDorE70cgDMJdcZ98eqqNhtNxYxKlZ5HvY//yQ3trTkNbuVCyK5IlfR0cljmQPoiS0nQLbWGD7etFK+KkWd/8BXDcN/RdxX2dExfJENWBwPYVEviwnfnbMtscYZwCzWb7rYW7RYG4FArv3BWR81Tuf2KvDDTKP41SvyDBLS4wDCVum19r229lisK9B6nqY11FyCQJJLxJm8bYZYXthQQ9YiAq3sZepMs2u4AEmhuwaA+Em+6xdZjOKCKHMmU0/cMxla9kT2bp99eHhmr9bQznuriWb2B7CvJy5Fv4bWLVnWLoIc+Ab4aNNbMAW2lmaZIXjml8YoDBI4iQ2PAXVPSuIR4E9ZcZPXkQGEX1+Fl82d94NlKCSEmeALK0L9g+vqzVcAUzBaC/Ba5Yv2D3+Oubuw2XoXmZaYk3xTyCA21WFMuHbzUgTWe1AkP2fAVdfb4g6jC0HkPtK37KYA12oCvhJbDCxxsUqh/hGldSJw9hACNaIljxrCMK8/yE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFoajBSNzNxUjBCWUY5TlBKMDdKdmVVZXpSSnVCaTlEcERCNFJra3BybHBo?=
 =?utf-8?B?WUtxaVZ1Vm16VHNydUcrZkgxTURVb2J1dUlEeWVFbkFsLy8zS2V2VkxMdm1m?=
 =?utf-8?B?R0RvaUtzbGxRQm9PWFJxQWoxdGQvemIwZ2I4OFhRSGMrOEV5M3gxZHdOeEFG?=
 =?utf-8?B?czB0Y0VvUTEveFVWNSttWHBZNEVPUVR5TXhnTTZqWDFESWZDT3BHS3JVQTJi?=
 =?utf-8?B?dGl3T3lFcHRQcFgzVk56cDdwY2hDM2U0T1cvWGo0TzJxaDR3eFduNzN2Znll?=
 =?utf-8?B?NUR6cUYvOUhNcEJvR1BsVCtpcmN2U0hESjBheVI3MUhlR1hLaDVCVHN4M3F2?=
 =?utf-8?B?NkNVdHVRWmd6Z244UGk1TGdsOHkzQnE5MWU3bEZXVStHanNnR0xadHFXd3BX?=
 =?utf-8?B?clBCOVdFMXBKdWhCbDlFOU8xL3JKUndGb2VRKyt0RThnWHBlOUs5WGgvZDVR?=
 =?utf-8?B?RDFMWHdnU2R0b2Y3a2U4Z3YvQTNvV0FmZEJMWEJ4bHowMUwvTjhtNFB1Skx4?=
 =?utf-8?B?UUV0OUQrSjkrV2M2Um1XOUZxaGZNQVgrRmhOSHRGclJaemNRMm1CODJlQlRj?=
 =?utf-8?B?bjJMU0lOa2ZscW9iYm9xbHlTM3pOcXEwVjFxWDJvZGJsVlVHakR0cEdZYm1p?=
 =?utf-8?B?U1lHd3JRZS9KQzU3WVBVR0JzMDRHclJWemM2Qld4V3liKzNndEcvRUtRYkd2?=
 =?utf-8?B?U2hDemI5NVhuODZ1SFdyV0Y3cXc1YUt0MERkQko5TjFFOFBUK2xPQ1JhemMz?=
 =?utf-8?B?VWw4SGhXWGg4ZjFwUjhpSFZiV0tNazJoY1NwMVZrcTR4WkNtZWdaN2RHUHRy?=
 =?utf-8?B?TGpLMVJ2NmtjV3E4M1FPV0V4ZTNwbHl6UXEvNlBTZmJCMk5vakdDekZkYXRK?=
 =?utf-8?B?bGFETUxIOXZWVG1PNER3YSs3Rk9DQktLeDV3eFA5blZoZVprSG84S2xPTkYv?=
 =?utf-8?B?eXRhM3RhVU5Tc3Y2bG1HS0tlWDhrdXE2U1hRbFZIQ0pBbVJqTEtIQlZpMktO?=
 =?utf-8?B?WFRsZmF6YWtNamsycXNYdCs1WDcyM2NJSUxjRHdDY1NHczRkYVk3cEU5eVJD?=
 =?utf-8?B?a0NCaUYraTZ4VkkyZ2dUZjJVWTlNMVo2NGhwcjNlelIvWE9yTjhkb3RXUzg0?=
 =?utf-8?B?L1g2R1V5QXIyNkpYem1VU2RHRy9zRmpUbGFWckpnVXFkdnYwRFM1ZUVpT1NF?=
 =?utf-8?B?VmhWc2RnMzhzQlh5ZWgvM3J5WmNMeTNaSUdFS0tPTnFUUnBZbUJkbm1CVlRs?=
 =?utf-8?B?RHhHVkdJejEzQ24zNzZCMFRBTExWQnRvL2FkaHFLMUpwQUNlbVJ0Y3Ryc3py?=
 =?utf-8?B?bnNEbjZmMFE2WjZLMnJKcnlFb1F5WkMxTmN0aTdxNnZCOE1QQW5TUjdSSy9T?=
 =?utf-8?B?b2pwalV0TGIzT3NDYUZqcEhHWU1Xc2tRRmNtRDVUUTc4MGZlSjhYTEc1SFVt?=
 =?utf-8?B?cGZZdE5BOG5sNFRYVDdkN2tMMVRiQi9FZnhvdkFtQ0tyUUwzMXpSdlY2UFFx?=
 =?utf-8?B?dGpHYUF3bmxBZFZMTmduMCtaaGh3bVRmd2FNWTZFVTdGeXNqZGkrS1hCTTZx?=
 =?utf-8?B?RHh1aVJKYlhDQnRKU3YxVUdZU1lZWW8vVlV2N3RuKzdMQzQrLytWSkRwdDc1?=
 =?utf-8?B?ajBPdCtpUzBCNGc3S2RVWTc2OGUxWWE1dldpMXIxNnV0ZHVjWThFNlN2TXk3?=
 =?utf-8?B?Wm1WT2hLN0M4ODNHbENxN2FDNXpnY0w1akx6QUt0eTNwcnY1ZXA0eEtXVjRH?=
 =?utf-8?B?aW1zWEhvcEJwSHJOeVpydGJiTEM2NXdzOHJabjg4WDBGK2ZEMVBicmlFOThP?=
 =?utf-8?B?VlpVQ3lmQW96cElvcXpTWHFSN05EWHN6dVRmR2ZOTEVHd0tDN2ZsWS9qV3NB?=
 =?utf-8?B?SzlGeDJlUlVmdExRUkFTWFdaK0xFNVJMZ3BIUnRINVo3L1dQMXJjR2U5amtx?=
 =?utf-8?B?S2VxT1loRGttTDZ0b1RaaWhzSFVlTTMvZ1lIQlFMYTBsOVBRSUpTM0pBMXll?=
 =?utf-8?B?Znl4ZXc5MTdLNEdMc0pNc0NQeTJVMms4VWtQWWpJSlBSNGlDN3JFb1dJUm5m?=
 =?utf-8?B?UDZLTVEwTTZCd0pzbmYrQytmdWp4YkxVVVF2L01oaG5GbTNkMFhsRVRHRkx1?=
 =?utf-8?B?VjFHZzJuNHd2S2F5NjlWL2dtYmltMlR5UWlBTzRERm0rdm1EdWpHVFoxa3Rj?=
 =?utf-8?B?TlZTWTI2TXlZdG1HTUhQR3JMNzNCelRkWnlkSzI4SkJ2OUU3UUxxUUEwcjZ2?=
 =?utf-8?B?QlFMeFc1Yzd2bVJ4TThSZlJLazl3TGttZlhxRy9UUGlGRHA3Sk5wZGE5Vld5?=
 =?utf-8?B?R2RJY2t2c0JSNkVRRFduc2duQ1VwcXI1TE4zRXdQMXp3azFtVFRsZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c2cd98-c307-4c1a-1170-08dea66355b7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:51:10.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVt4/jz80YZ6sfQAORdhDwvQIitoqt1NC8UAp1YEvNstVINZsptxsqmwhCVFcTzNgQgNKFk44IYi3In2XwVPcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
from the ID register is the same the one used on some of the QorIQ
platform, but the config has some slight differance. Add i.MX93 compatible
string and corresponding code for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v6 changes:
  - drop the unnecessary local teumr0_val variable

 - v5 changes:
  - drop the unnecessary GET_TEUMR0 helper macro
  - add drvdata for each of the platforms

 - v4 changes:
  - no
---
 drivers/thermal/qoriq_thermal.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..e4b61d531e44f6927b74e79a81f1e63dda7f9aca 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2025 NXP
 
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -24,6 +25,7 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TEUMR0_V21		0x55000c00
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
@@ -73,12 +75,17 @@ struct qoriq_sensor {
 	int				id;
 };
 
+struct tmu_drvdata {
+	u32 teumr0;
+};
+
 struct qoriq_tmu_data {
 	int ver;
 	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
+	const struct tmu_drvdata *drvdata;
 };
 
 static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
@@ -234,7 +241,8 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
-		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
+		regmap_write(data->regmap, REGS_V2_TEUMR(0),
+			     data->drvdata->teumr0);
 	}
 
 	/* Disable monitoring */
@@ -319,6 +327,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->ver = (ver >> 8) & 0xff;
 
+	data->drvdata = of_device_get_match_data(&pdev->dev);
+	if (!data->drvdata)
+		return dev_err_probe(dev, -EINVAL, "Failed to get match data\n");
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
@@ -376,9 +388,22 @@ static int qoriq_tmu_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 				qoriq_tmu_suspend, qoriq_tmu_resume);
 
+static const struct tmu_drvdata qoriq_tmu_data = {
+	.teumr0 = TEUMR0_V2,
+};
+
+static const struct tmu_drvdata imx8mq_tmu_data = {
+	.teumr0 = TEUMR0_V2,
+};
+
+static const struct tmu_drvdata imx93_data = {
+	.teumr0 = TEUMR0_V21,
+};
+
 static const struct of_device_id qoriq_tmu_match[] = {
-	{ .compatible = "fsl,qoriq-tmu", },
-	{ .compatible = "fsl,imx8mq-tmu", },
+	{ .compatible = "fsl,qoriq-tmu", .data = &qoriq_tmu_data },
+	{ .compatible = "fsl,imx8mq-tmu", .data = &imx8mq_tmu_data },
+	{ .compatible = "fsl,imx93-tmu", .data = &imx93_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);

-- 
2.34.1

