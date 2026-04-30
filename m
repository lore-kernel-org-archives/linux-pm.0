Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0C30100E;
	Thu, 30 Apr 2026 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517469; cv=fail; b=lVLtcxFrYoYWMWUyLsHTuWR7O9UzC0t5P7GLHEAzCTuEb+jjWpWASMrJ5R7gA8AtgZNsmyvhWxSvOfN8izO31WnSC0Pz63oIszF1owz+Yl7uQDoIii6nqxOjC0ksWKzYYJVzfEtHBNQa6e6L+TdgKgmbNyipdsGVUrriZCojFFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517469; c=relaxed/simple;
	bh=o02hMUQEJMgyn6fOsaRdX5Qg9T19Try8ZpS1pBAW+8E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=at8bvo2vEUqIiDVMSkO6M0YTAxuOzC0ZTbOllEwOx8EZPxeUp/Rl7K504pWL7Bq24VY/mXDGQRKIy7iA+hghuQum4/Ydz6hEKUBTrOsxPvylQPyxcKTho8ICMGaey5x3kGEYy+SooXI8icxIXZNclV+zBb+Bj4pSHKGT9lsqfcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AIMznMTM; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AIMznMTM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtiE102mT10zZGy7yM0KhyArPIKXUINI0F16JkiG3oc+g8MOlxmZSYeJPrjfT1+xd0UtAS+UI62V39PySFEV4mPe4wY9Sy3L5m+o7yLuur0eNTRQH/seKg+R3/ibkwfRAMr9STN/lIneuX4FADOskBjLuinPYudxDQvwQOrLcTA2wWcyjtVqC59F6AjP3/SccBtzOetOq61rKKesNY0WSaRL2wVhLHT+omKlLoPf7A9t3ys5KELIL1h0PCB4xCrslKosqvXogfN9IvA6u/CmPEnWwaly1wYBn/CA0tgrTWpMTPdV/mqS/4UjvBxziwU39mK6rotbUaHGrlBA0EdP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNvSZpBxqCh55qM0bnYTD166cTPHaoI3boWc6ThvzR0=;
 b=oTcndLm/+8bgUTrFfeq4WJjgApZZqZkW0JoG8CTAC62rZgdiI9S45qYariTGfXKfspwwJxV8tTSfDUOmCQVaKVijdniOH46cy4bh82VIoOhHwKus3jsTCV5ZX02gbZRLQHLqb73L3rdYwjIyR3ycuKCu2LofLZlTRiUPbraVAESAhbB/9Pj43wdvbxyC3pPCONJ/U0rYJRiV5OKC23NbWhtOxWV2RC7RU72Tgkakwykt8Cakwxm4TZpREk/se5MEEixZqv+E9pvOskwqEeCSiN2QPUPDQrmS0dsvr+mabwh1m2zKAZvENeA7NfowzuVbM8qkCt3M+AxrYPTBqTdWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNvSZpBxqCh55qM0bnYTD166cTPHaoI3boWc6ThvzR0=;
 b=AIMznMTMEBWs6S5DFBUfQjJdbu6yJ9k12zgPxkR+gYbpUZNcRusPmRN3nJDDNwht1o6mjZvmC9GN6krfwQEyqqDRtKWZQoM3TDyM3aFkPdB0j6ysrDnPIjCBu/ldBb6jePVgJNo7z/BocVLXVv+nbYxr+VvU+sufWqSK4o6CLiIyG76XYwuO5oY7qGZURv0WPPoPMNlQAcv3RY3mWHiIAV4bmFt/bQX76LR0jyenljg0HQzm/wbiQDNtaEHBeD/W26rgIuQ2eiha6+QnJhk8j7AGYZRVu7IsYXKP6BzMgG7u0gVhznwSxQSsRU3K9c+sBggHQrtAi5CnZTB+rH8lsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:51:05 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:51:05 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 30 Apr 2026 10:53:30 +0800
Subject: [PATCH v6 1/4] dt-bindings: thermal: qoriq: Add compatible string
 for imx93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-imx93_tmu-v6-1-485459d7b54f@nxp.com>
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
 Jacky Bai <ping.bai@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777517621; l=1038;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=o02hMUQEJMgyn6fOsaRdX5Qg9T19Try8ZpS1pBAW+8E=;
 b=XYjpZGX3VR9QZXu6B7WIlS8cJl2/bgev4LdZDrCxw+B4oJqPCOoG2a+Me6AFbG2JcdSXsWAlL
 Yuj6W0qt+htDet8KDw6eRB02Qj6cjlqaE9mrR/iS74TZPN9ORynCp47
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
X-MS-Office365-Filtering-Correlation-Id: e23032cd-a0f1-40c6-4320-08dea6635248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	kLf9LcX04W/MQeIVDUvWFQ8QRtmMzIfz7eK5T83uTAmxHyZkaW9lKDPFZggv2JL9e+Ai87l2GQg4u5OVqDo1/X2Tz1LS2MnEauxJYo8/Z+54UVl7tdCUn1DBAUfVF6DbwHP1+90DYGrOKfrWqqSOxLbrRLbhDqLhe5VaDWhBbofaw/exlAHO6khSKWOMTDVLWjSK01/9QpAVwhFSJ3HGDGGLojQV2xsYhUW1+hGv41kfHGCN+HMRFSRZ1Kijk2BU3UwIl3HQxNbcK7PPhbzadP3TdtFX2iul/YAnBWyGs3bjAddPxYjN/HrufU/e3JE+YOJ0V1mD/vKsOO/L5aJ5HX6myt5qxtDg57OYI1ovYfVDhCzgKeWt1NFZYS0iP7BW2Sd4ErYPBgIuqsIfJWBZwDmAYSLjAQACFr/+/JRFlbm7f3oHiktoyad7La17zTkmRO9e6kumxrhlaQPoCvR15D/ByudWL7izK9rJplfMdr5sCZNchXBGv0aleXAmxiPy2n5TxIgUH/m49fWIvdtpGux+QQrzkGumVKcJLhPONamvxCAox3zMnVa53ZfpnUQStHKUOHHywg96wbKql6CZ9qNlYD66RF1mAXySNu23YcYjhmMjTTYNJH+ni+oShOhW9chypcYKwYMoWsWg0jvAGEGHwzRMUNJtT7FK1l8J8AeKf5TByt7xjtCB8/K1JFc/qUz7JomovrJi4A8+wEO9x49OKK49F/d/QPSuVnoEULQxWNvRaBP9DP/5KAQzchaKHeH6o0rlX6SHo4qkj750vNGADbDVK/Ai6Nk51SKRCx0bZv91hbWv8Puc4qLQuDWG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnNIYnRaa0NlMmxienkzdnNnc2xGTHBzYkpuN05aQldXTlh4dXBXK1lyRlJH?=
 =?utf-8?B?ZGdBWWV6SzNvTTdPYVBwZWQ5RDJjaktqOFFsVHNEc0xzWC81eGVSd3d3SDBr?=
 =?utf-8?B?bGpMSU5XMSt5UzlLMHpvRTQwMlM3OHhnV2VoSDJ1Vm5TMjN4Q0svcEo2Yzht?=
 =?utf-8?B?alpDUjM4N0ZrSXFKRDY4Q0x6SXBvbzN6VE5aZDhlaEQ2ZGUwYStLY1M1NnYr?=
 =?utf-8?B?bThrRmZ6YU5XenA0VjVrUTlXYkpqcStsT1FOakxnYmVqYjA1b3phaUpTTXJN?=
 =?utf-8?B?c1ppSkJJQlV0d1J4aWJDaGtjbEtqaEFpbnkyb0tqcmhQRDBnNy9hZlVTdHdX?=
 =?utf-8?B?cnRkaitlUGpielBLU1M5WGdxVWYvUW9jUHB5NzZuMHIvdm9lT3ZtUzlLY0tx?=
 =?utf-8?B?M3Q0MENoRWhYTGhueE40RW9PUjlSSUVyMlpqemoycWJ6dUtVNkhTYmNIRE9O?=
 =?utf-8?B?cWo4MmtCc0NCTER3OHRZMXl3N1kxYzk2UVhieEFGK0c2anFlMC9pd0YyMDFZ?=
 =?utf-8?B?RFZ4K1hDSEN5TUZLTFBGZUd0bWY5Vkl2ZUg0cVl4Vm1ZYnhvT1BVU2liNUZu?=
 =?utf-8?B?Rm9OVTNxVjZqNjY5UXAwWC9YN08wMnVyamh4ZExLREpjaHlaS3dTMXcxYXZi?=
 =?utf-8?B?UGYvYml0OWN6eUVnejc4Z25qK1ZydERvZHo4TW5QMmxydzN2bTFHK3oyRWRD?=
 =?utf-8?B?V3ZtZWRvOEN2bE9nV2htMDlGU0h1YjdVaUR5TDNsbXo2aTMvbHlFUkM0bkJL?=
 =?utf-8?B?L0FHYkVvWWJmNkNPS2htUUM2RGRoc25mTDRMaEFuc25oVk9NUVVRL0pvTGpr?=
 =?utf-8?B?WUl2MzRBTFZqOVRGZEdVa2xIOWNhZWcyQlZ5VmNZVmlZWmFGODNYQ3NPS21T?=
 =?utf-8?B?ZmJUd2I2ZG5jSWhHTnpuMnZMZmZRbzBIb3JKM3dnQXJqbVNnaVArNWd1cklr?=
 =?utf-8?B?OXhFNW9LUjFWSWRiODltM2xoQVM2QUZwTnc3MWQzbWRHQTBLMUVmNHpNc2NZ?=
 =?utf-8?B?aWxwWTBicTVDU0FJSnVlWGFRZ1A1M2ZDQ2VQVFEvTmxsUXJsa3kvLzRlSU40?=
 =?utf-8?B?SjlldjRXbmN5TDQya3l2cHdQRUtqNGNFdUVQcWlFYmE2d0szdzRGTG9Mb2VG?=
 =?utf-8?B?c2VTZm1zQm80RkdQSG5xeHg0QzVySGtVZkt2UzlkVlJEa1NLVm1ZaURQK1RX?=
 =?utf-8?B?em5pUldLclZyUzN5dDdiT3RwYituRVArRzIyZVA3aitiMVFZM3RQRjlrODcr?=
 =?utf-8?B?QVNJc2MyamhTaHVBcTZxTzdMMWJJcTBPUG9FZUQyUlJzZlZPVjQ5eHd0dHpJ?=
 =?utf-8?B?am8xaG51SDVsdE56R3YzTVJTM3BqbUtzaDV1WWNVNVM3YmgvVG5xem9QOG9W?=
 =?utf-8?B?ZEVPZlV6Njd4eko5VDFFR0t2Y0Zwd3lvTUp5dmU1U0E2eE1rVEVDdHlVUzlz?=
 =?utf-8?B?dGVYSXgraldvTk5UMkY5L3U0UXpDaERkOWYwaWNoSHJSUWY4OWNBeDA4OFgz?=
 =?utf-8?B?YmM2WExTRU9EbEFocnhzd1VuYWJzMnRLY3lPS25DRURROXhiaGhRR1NWeHUr?=
 =?utf-8?B?a1NuM2M4RnovQi9MeWh2cEYzTHAxclhxd0F0cjV3MFpzWWx0WXlacXN0dkdh?=
 =?utf-8?B?Z3RCSHo1SFNiOGJGQnQ1aHpmdzcyZWl0dFpMUWhvd21FZitXQzVBVUwraDRG?=
 =?utf-8?B?WW50dWNmVnZZTGM1dXRHWHdTTkNGVEwyaVpLMzVjd3dpYnpHS2xmbkhreVNt?=
 =?utf-8?B?SzFjMmV6SzU5SGo1OVcwZmQxcmdSUnkyOEpob1dieHNsb0hFT3hsbTNKZUZr?=
 =?utf-8?B?UERKVU44K012bVQ3Qm9zUzF3TVR1MWZIb0VlRXc5ZUxnMTNEbkFrUXBXOWl6?=
 =?utf-8?B?R3daNlRMN0pCMUJNTkNjbzV5a0VpWGgvNXdsQXcyMmRMNEtDWXlWSTZiOHAw?=
 =?utf-8?B?L2pEbUJ1NWlMWGJIMHMxSkNSYWlZRUgzS1ZkckR0Z1ZHZ0EzVWNac1NkTHFY?=
 =?utf-8?B?Yk5iY3IxVnlteS92VEFzMHQ0Z1NJR1ppVklQWHA1cHlBVTBSWUVDWFVFM0d3?=
 =?utf-8?B?RlZwa1NyVVJUb1VyVllBamxUM1BEYVVKaTZCUm80SjdGWmkzdFo0Uk9YYUFn?=
 =?utf-8?B?VXVSUmU3Nm40Rzg4V2RXekhPY25WdCszVUVGN01mcmVDSDJodi90U2NMT0h0?=
 =?utf-8?B?MDlTdHRvSzhOYXRlSi9CNU1pL3hHRGdDL09jSDBMdkR2RmJHck9zQ2o4QVJk?=
 =?utf-8?B?Z0tKSUVPRG92RWg2Umh6MHd5OUFRQXFDeGJZN3hNSFFCdGtCZHhkWEQ3aThY?=
 =?utf-8?B?MWk5dkZXL3FxUUMvMlNxY01tUXIremdEdDhOdFppT2JaUkVsTVkxQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23032cd-a0f1-40c6-4320-08dea6635248
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:51:04.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXiZWhVd/YlzkosiqBXR1caRJjrBDvh0MIckjxN0TIrO7148OUL6u/h/q5mKBK9CZAAZXmsRllQ3ERcDODlLKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

Add i.MX93 compatible string 'fsl,imx93-tmu' because Thermal monitor
unit(TMU) on i.MX93 has differences with QorIQ platform and not fully
compatible with existing Platform, such as fsl,qoriq-tmu.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v6 changes:
  - no

 - v5 changes:
  - no
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index aa756dae512a2c6e3f0b6bb1ab4a65c01e373ea7..f3b136f5e1cba1fff7e90678d7e3d7ec3ddd25c1 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -25,6 +25,7 @@ properties:
     enum:
       - fsl,qoriq-tmu
       - fsl,imx8mq-tmu
+      - fsl,imx93-tmu
 
   reg:
     maxItems: 1

-- 
2.34.1

