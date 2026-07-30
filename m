Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0233B1EC8;
	Thu, 30 Jul 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400501; cv=none; b=jWb7AlCD7ZAxpjzxLsNKiJiID3n0N6YYYUxt/Yf1CTGkfiJIdVTRHHLYGWMI3u3dcMhO9siLC2S+UJgq5eGM8QAxCiQhOElxMN/dhalrer7u+GQVcRFEghRMVK2r5+XmTexhY5ZMV/B6TyYitvuYxxgpWr7VMkgfKdyNYDMO9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400501; c=relaxed/simple;
	bh=kZutcbweUt6v7QjWlxQA00/uuYFO/XJNm3iPcBOuyYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHmnOpNYMn2NWyUUoRmfvnQR1e3hgT7sF5FiaFEqxiN5evK4dSF4cn7608CaUbuU+W8NAHUj2Gf0BqF3AsMgW1RpVZmsCjJpHQ0Uj8vKY80fqiit2rhXOQkyLOuUzBhAfTfaOXwIuHDdk/YFia4oe8ADHuvTWFON3g7jOiUV9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3hax5Y6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3hax5Y6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB496C2BCB3;
	Thu, 30 Jul 2026 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785400500;
	bh=kZutcbweUt6v7QjWlxQA00/uuYFO/XJNm3iPcBOuyYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s3hax5Y6WxHdP9oxPs+cSmWhD/YShxIPr3/pHVFgdm8LsRwnLM4SSvA2sYrrUj7Zz
	 StRAPzUQCLYGJC98lS7Oe71PKm7/yrOP6yEn9ke6H6py6Uyk3J7HnXIBNADdPZ8GfV
	 bfKlZRPIXCf+do43mcfBzqxBg4ak6H2RCx/EX7pb4PQ6IZyIEz2DiiXazqsWip0qPc
	 QCG1NJb99vz4/PCRot3icd5DOzXDppcDUTKJJb5R0zqS2+ZDYVlTN8KYiolCa7eNig
	 XuypgiY9LoMMYNqkw3Cbd+2e57t3zDrpjNOm2aN/qiwufeH7Z3K6GP0j5BC2Gr9CkU
	 caUALnEJaUSeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B009C55162;
	Thu, 30 Jul 2026 08:35:00 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 30 Jul 2026 08:34:37 +0000
Subject: [PATCH 1/2] dt-bindings: thermal: amlogic: Add A9 thermal bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-a9-thermal-v1-1-d786d37cba58@amlogic.com>
References: <20260730-a9-thermal-v1-0-d786d37cba58@amlogic.com>
In-Reply-To: <20260730-a9-thermal-v1-0-d786d37cba58@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785400497; l=2032;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=a2jDBBmn4Im07LAaY1RPp+SwGvK+6Pv6kYhWR+NQIKY=;
 b=5JXLh377xnZAYCkjTOkmo9Amu8ZrBVMLJbqzx0+yVYyODdrh310hP4MJiZA6/Ks+DkT8G86mf
 wL62TLUnu/VCPLkhvreP6/c9OrkpDKkpBmp/r5KBke+mJFpgegMJe9D
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the thermal controller compatibles for the Amlogic A9 SoC.

Describe the required "core" and "plck" clocks, add the optional
"amlogic,hw-reset-temp" property, and update the schema constraints for
A9-specific thermal controllers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 8cfa44dcda58..5f5dc6f12851 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -23,6 +23,7 @@ properties:
           - const: amlogic,g12a-thermal
       - enum:
           - amlogic,a1-cpu-thermal
+          - amlogic,a9-thermal
           - amlogic,t7-thermal
 
   reg:
@@ -32,7 +33,13 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: pclk
 
   power-domains:
     maxItems: 1
@@ -52,6 +59,10 @@ properties:
           - description: phandle to the secure monitor
           - description: sensor index to get specific calibration data
 
+  amlogic,hw-reset-temp:
+    description: The hardware-controlled reset temperature value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
   - reg
@@ -73,6 +84,22 @@ allOf:
       required:
         - amlogic,secure-monitor
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,a9-thermal
+    then:
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clocks-names: false
+        amlogic,hw-reset-temp: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.52.0


