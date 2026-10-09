Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F823345EB1;
	Fri,  9 Oct 2026 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518458; cv=fail; b=EXk8PTPKrIAvk1URplHdF4qAvCoMYnr2bpaxZS5/y3vJx4maiY+IaLcy/HVHFFGArzqO9c8VBFuzekus1OqCPjlx44UNsMdVRnVwHlY6tJ5vutdihV7k1T8h+kDKRUnrXVcd6k0x//hyoLyo2xiNHWKOghREmuri4MKVR7iFqUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518458; c=relaxed/simple;
	bh=ZlQ/M8VkehKjmzYBRRd7EBMW6Zlh9Ul9e49ZRKTBzis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ccRoBhS4m/uuV6ymTeZ6YjtrsSr4eX891opzezK1rmsAPrn++f9b0lAR94+CP7+CCau7kfafe2B7PfulPo7YiLC5XFxcPK2slwMR92uxSQ5ILOJr/cH7gNh6ffAVIpyQg3dcyxWjiDVHBqR6/l5LvldTWsz+SreI/nEM6JAyi9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e1mFEn93; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e1mFEn93"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywOnPY6Tez/BU33/VuADO75+2Y+POHCblH6g4HfDta591XfPJFZaQl0BCvdL67jP/A/GmwwtAK1FakyTBgNUOksBlJy1W0d3E0dQ83sLmCL3nK25MkEWdrUiu94N7k3ExcG55d7GFw+kqFuAd+y3+95nvG5ZRsgQ40tLdZ/7ylJUO4UXSUho6j5FtNpuX3LYD1tiXsAdZ+QBCw8z6xbpPT8ABD0bZyS4sE2+56gll7sPf/uWtz471rsbL21GZ4ZMBUkwjAD6oVEopcsNDuH7UUd2imHJrUdrXgj+0464+DF8BhiUC+jjvbi9FQiJlNs/YEOhdU+R3tHsd09/1jJZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBXZZo2eOxu5tQTqahnYI/bZqeIbYxGkJ7GQCLVsvAA=;
 b=q+HISIXVEiG9OJ001Pm1sbON0G9II168Hth45LZ2dAA+hRxqPVdvmb5zAtGzREqWk1D3rrRZ+9bLjEfT1VYMfHLkbxqd2Er/jl88oZ8rwtATGfnXXydhxLOWJ4A6J5a71Fp21gkK10H0IgJ7lRxUTeikfBl2BxHEX7vdUxrWQP2LqRmZx4aMCYxi+EBRKCQZ78wNf2bb00qds56zMqP9pzFtzWTQE43BQu5hoOeKDYS34GIIBhjWtR/gY0fgq6l9gnWms4iYHUl48FFu0ckLMzhtTWZvNLYb0y9s7qvDfX6ChUN1skwiYc0Hdg0pAEm7Q0x1SABPudXKQggna5aFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBXZZo2eOxu5tQTqahnYI/bZqeIbYxGkJ7GQCLVsvAA=;
 b=e1mFEn93Ln6c6hLOfC+rnVMixRg5qwr2rBCTaLvuCovBucrN4CdIKjoAxM1mDLHAdzzdf9PaLGucRBdzwdNhnj93ZS2A50plxHvs3N6thxVXJ+6TUDxbG4ICuFCSLSUtXtmOOLgJ4XDJxRQUiL80EBRlML0VqjDETcPOCUaSjWw=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 04:00:42 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8f) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 04:00:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 04:00:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:35 -0500
Received: from xhdnaggolla50x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 23:00:30 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
Date: Fri, 9 Oct 2026 09:30:13 +0530
Subject: [PATCH v4 4/6] dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net
 compatible support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-adma-pm-fix-and-per-channel-reset-v4-4-55f5fe409c55@amd.com>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Michal
 Simek" <michal.simek@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Tretter <m.tretter@pengutronix.de>, "Harini
 Katakam" <harini.katakam@amd.com>, Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <git@amd.com>, Golla Nagendra
	<nagendra.golla@amd.com>, Jay Buddhabhatti <jay.buddhabhatti@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791518416; l=3525;
 i=nagendra.golla@amd.com; s=20261008; h=from:subject:message-id;
 bh=Z9ToMMII92EeHPPE/FgeDYbKYorazaJoXx0vUSqT1eQ=;
 b=IhITFVA4gjTnWeYubYfa6d7sq9u7r0PRqMX6+G0JLXhD5oIHTBJSDIIpBrFlKElCUXDze9fX5
 CxCMZPeqvm8AQvLv6tSyqlxpsNPdkl3X/VA8GBEvVyo5tBMQq6RNi2q
X-Developer-Key: i=nagendra.golla@amd.com; a=ed25519;
 pk=pCRGj/0mb0C3aDMpVVZeyBqOIQZUKGJjCKL4QZTu7nQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dec288e-ecf3-494b-745b-08df25b9e38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|7416014|18002099003|22082099003|921020|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	lkUcNAWzBzsUqQ+lxD3nmYZkVxfSswff9Wc66tbZB05+TgH4B0teTSlrE8GJ8o+ugEBf4QNl1bL7ZFp3cfvSWNAggYAKqXdrx4yvBFzWzQzm4lRMG5mbbN9TGm1ZgAQ2S3ADyenh3K7PY0dIUTIIFBg8ecui0vMbjbtJp7ehqo59pfYDtIyLgLHTHWs8yQQRFZ+DDRHXGaMyPIGPvBulqPgwjKFaXX+zeTXJSFSKbJ33IFbBChhT4QIF8lb1PVg45yM8kYJXEzy89CqzbSn2EygAzLwhOF5XMzmHZzassBTf35AFmnz1kQVdIxTcUqbnf6RLr/6gjz1P0gt7IP9jb/U5IJ1bNXvaEZ7wWHKAxa2zfophGZd2+OJs/5jciJffbGgjagACRpXv+ADsvPRjT6R090G/B1d0JxjTzeN5heTrVR7CLbv7tkWEpsFYH7PhpcCJazA6uz05I32pFLLuHmBETyZP9eX4VV0yFZvWOVE4h6nv1/xfeurO5kv1dmtoTGwQgMQkxNPFZs3FW5gn5NUKU0nzvU5EhftNj/xrOXu6dSJpIzFr+ZsTrKlVPl+jqtAggoCSemITYHKCLzUnYyw56JHJrxLipRRA8SD9vPLqN3QWH2rwyqRE9pce3Ds8U54FpC7ZA+0fmG0H8Hd9+rRaM/8OcvNtwjVzAjKv+58IvBfM9nPBYwq/K7q47xfjCpsZO+h82TvEUgrDrKavl4GfuJzVWYvG/8lrcJmAZovvh1OsQruOmTD7zpLO1F2G
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(921020)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AcxW+USjWMe/L9k8yAlFKYJllyW4aMo6Us1TLt7EUd/G+9ENvGGVm5zxv4cYz+ZX1voNL5yIbFTghwsQmfJG5pQP4kiqUHIv8jiexs1F0cwnWjoPpvMZi/tjXwpLrU4d/WHrr7ifDf7ku4HKHHSv+Nk7EBFYW4sucsDtpNZ6zCg8/Iv+3woRYVoPlDh9Vw/eXIh2naibyX9WpK4fv/wOah1ZzRvS7oYeWhNnFm1E4GGO/1dUuzeWAKc9H6HD85V+sXfRDv47x/zfIEoR8Z6610/I+LZvmxE9tzBM6nZVJZOUyLw1IqeYp+O5cIIcLxUJSCg57iTvawH1GC/swdIRnsElEgQbqzvOGk2vHfvOZpTN90oMfd6faMF01VGUDgH/EgD8Djx79D9VrBlEDfo1fwkkpPLoDy773PMYpKiBeqFA6FC0p2el1Y9tGafjx4mr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:00:42.6196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dec288e-ecf3-494b-745b-08df25b9e38f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>

Introduce a new compatible string amd,versal-net-dma-1.0 for Versal Net
ZDMA. The new compatible requires xlnx,zynqmp-dma-1.0 as a fallback.

Add a reset property to describe the per-channel reset line exposed
on Versal Gen2 and Versal Net. Mark the resets property as required
for both Versal Gen2 and Versal Net, and not applicable for other
platforms.

Note that making resets required for Versal Gen2 and Versal Net results
in an ABI break, but this is unavoidable. While the driver works in many
scenarios when no other firmware has used the DMA prior to Linux boot,
there is no guarantee the channel is left in a clean state. In observed
error scenarios, a reset is necessary before Linux can reconfigure the IP
after previous use by other firmware components. Due to configuration
differences or the DMA being left in a bad state, DMA functionality fails
when sequential software components use the channel (e.g., firmware before
Linux boot). The channel can only be cleanly re-configured after a
per-channel reset, making it essential. This ABI break is only applied
to Versal Gen2 and Versal Net where the per-channel reset capability is
available.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Co-developed-by: Golla Nagendra <nagendra.golla@amd.com>
Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   | 34 +++++++++++++++++-----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index 2da86037ad79..ff8c9a0e5559 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -16,17 +16,17 @@ maintainers:
   - Harini Katakam <harini.katakam@amd.com>
   - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
-allOf:
-  - $ref: ../dma-controller.yaml#
-
 properties:
   "#dma-cells":
     const: 1
 
   compatible:
-    enum:
-      - amd,versal2-dma-1.0
-      - xlnx,zynqmp-dma-1.0
+    oneOf:
+      - const: amd,versal2-dma-1.0
+      - const: xlnx,zynqmp-dma-1.0
+      - items:
+          - const: amd,versal-net-dma-1.0
+          - const: xlnx,zynqmp-dma-1.0
 
   reg:
     description: memory map for gdma/adma module access
@@ -59,6 +59,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   dma-coherent: true
 
 required:
@@ -70,13 +73,29 @@ required:
   - clock-names
   - xlnx,bus-width
 
+allOf:
+  - $ref: ../dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amd,versal2-dma-1.0
+              - amd,versal-net-dma-1.0
+    then:
+      required:
+        - resets
+    else:
+      properties:
+        resets: false
+
 additionalProperties: false
 
 examples:
   - |
 
     fpd_dma_chan1: dma-controller@fd500000 {
-      compatible = "xlnx,zynqmp-dma-1.0";
+      compatible = "amd,versal-net-dma-1.0", "xlnx,zynqmp-dma-1.0";
       reg = <0xfd500000 0x1000>;
       interrupt-parent = <&gic>;
       interrupts = <0 117 0x4>;
@@ -84,5 +103,6 @@ examples:
       clock-names = "clk_main", "clk_apb";
       clocks = <&zynqmp_clk 19>, <&zynqmp_clk 31>;
       xlnx,bus-width = <128>;
+      resets = <&reset 0>;
       dma-coherent;
     };

-- 
2.43.7

