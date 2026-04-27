Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF73806AA;
	Mon, 27 Apr 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272788; cv=none; b=epbx9xsBHoukJPl4SU9IyYkKKb3Z0iVpLAZU9gngeKJu4tmql2aviFhFNcbaIQrbKWqpKGXW0NevPmHZ7UCCdgvBXRvygmH115yHOGAqvzReENylxI0bAwpmMXUw5LnkYZxMh5Vtlz5ffORBdwaxS5AtssJPOa9rgs1dCQwmJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272788; c=relaxed/simple;
	bh=89hHDqbexTyMlPyPP2yOVYeZDBludThuf4hJ81dY12g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fCRhhls7a+Z49o/iPGEY16klDB4dt5cfXRawLp18OCQOxj94zzLFvGgP9pslLCdHmuS8UCYG0Pe7W3BHjO/O9tsiWwEYymbQKcypevJ0hwBF1xf2xrK9CwsPgJW6IhhKYSpsv0C9c0xFHSH6jJ05grz+HXAaDORuzqhoDV8NYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=awhpednU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="awhpednU"
X-UUID: b9ec45c0420511f19a16598d5ca7f8ec-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ss2cj82M0/89oGj9sC/6bQnm3td5UO2hvLaBpDMWa60=;
	b=awhpednUdviT4JTNQMf2bSgBpOkE3bktTP9Exc/eIowf5YPWHgEQDZ6m9uxwsQMIsPM85VpPV7PWSlfP07zgT5xi6Zicb0vXOWgeO2FBAzzz/IIKdAwrlB4RfrlLk4g+Ii1NXnmZGMw3boyOFoFRwLzDH5jKjX/IXrud7Hmlnn0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c0283e32-f901-4a08-a5f4-983d2f97041c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1387a764-469e-4eb6-aeb8-4b21454b0f32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9ec45c0420511f19a16598d5ca7f8ec-20260427
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <kuanfu.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1144651653; Mon, 27 Apr 2026 14:52:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 14:52:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 14:52:57 +0800
From: mtk36707 <kuanfu.lu@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Balsam
 CHIHI <bchihi@baylibre.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <jarried.lin@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <justin.yeh@mediatek.com>, Kuanfu Lu
	<kuanfu.lu@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: thermal: mediatek: Add MT8189 LVTS bindings
Date: Mon, 27 Apr 2026 14:48:29 +0800
Message-ID: <20260427065236.1685057-1-kuanfu.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Kuanfu Lu <kuanfu.lu@mediatek.com>

Add support for the MediaTek MT8189 LVTS thermal controller to
the device tree bindings. This includes new compatible strings
and required properties for MT8189.

Signed-off-by: Kuanfu Lu <kuanfu.lu@mediatek.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        | 27 +++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           | 20 ++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 975235130670..64fc6b5385de 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -23,6 +23,8 @@ properties:
       - mediatek,mt8186-lvts
       - mediatek,mt8188-lvts-ap
       - mediatek,mt8188-lvts-mcu
+      - mediatek,mt8189-lvts-ap
+      - mediatek,mt8189-lvts-mcu
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
@@ -61,6 +63,21 @@ properties:
 allOf:
   - $ref: thermal-sensor.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8189-lvts-ap
+              - mediatek,mt8189-lvts-mcu
+    then:
+      properties:
+        nvmem-cells:
+          minItems: 2
+
+        nvmem-cell-names:
+          minItems: 2
+
   - if:
       properties:
         compatible:
@@ -78,6 +95,10 @@ allOf:
         nvmem-cell-names:
           maxItems: 1
 
+      required:
+          - clocks
+          - resets
+
   - if:
       properties:
         compatible:
@@ -94,12 +115,14 @@ allOf:
         nvmem-cell-names:
           minItems: 2
 
+      required:
+          - clocks
+          - resets
+
 required:
   - compatible
   - reg
   - interrupts
-  - clocks
-  - resets
   - nvmem-cells
   - nvmem-cell-names
 
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 350f98178b26..3f493d7f13b3 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -45,6 +45,26 @@
 #define MT8188_AP_CAM1		6
 #define MT8188_AP_CAM2		7
 
+#define MT8189_MCU_BIG_CPU1     0
+#define MT8189_MCU_BIG_CPU2     1
+#define MT8189_MCU_BIG_CPU3     2
+#define MT8189_MCU_BIG_CPU4     3
+#define MT8189_MCU_LITTLE_CPU1  4
+#define MT8189_MCU_LITTLE_CPU2  5
+#define MT8189_MCU_LITTLE_CPU3  6
+#define MT8189_MCU_LITTLE_CPU4  7
+#define MT8189_MCU_LITTLE_CPU5  8
+#define MT8189_MCU_LITTLE_CPU6  9
+#define MT8189_MCU_LITTLE_CPU7  10
+#define MT8189_MCU_LITTLE_CPU8  11
+
+#define MT8189_AP_SOC1          12
+#define MT8189_AP_SOC2          13
+#define MT8189_AP_SOC3          14
+#define MT8189_AP_APU           15
+#define MT8189_AP_GPU1          16
+#define MT8189_AP_GPU2          17
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
-- 
2.45.2

