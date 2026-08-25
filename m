Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62B3C3C0E;
	Tue, 25 Aug 2026 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639314; cv=none; b=X1L1Rm//E+/Ht0yBJAQEf2whwI0guHGHGtwd3ZNhk/tEyCj6d0r/Fv1Eatx7rx1yfwh+Hn4FHD8+xDjazw7+2HfwW+FJzNMYb9eIg0Fyo7Yg6kHHdsrhu9/i2lDRi8p8TymK2FZ7TJvYzKhSLNzss+fesmQl1OuV4S3FJNL42yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639314; c=relaxed/simple;
	bh=2TU5UtSqlTK5Fx9D95GxY0TfdDPbOgZck8finK/MKtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiaSKtFJ54kOweX3fKtUdxebt5VRFe+TMtgfJKKGX9qCdmONQ5hke8mn2USyVmaMMayL28YescTxbo4CfXxxwoyFhhZelbMDsgi5UVK/R3ZJEH5VF8O4S6e/IeJ5XQ7VpmthxiI8cXe3uOfzmgBIc9QqTUHsCbgKWYtCZ3GqAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwqEGci2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwqEGci2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D6C6C2BCF6;
	Tue, 25 Aug 2026 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787639314;
	bh=2TU5UtSqlTK5Fx9D95GxY0TfdDPbOgZck8finK/MKtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HwqEGci2IieJ0DgW5CB/7HVRGN7RykD4quUqNH+gTq38Aj9yu0a2NzhqbNoaLbRAK
	 gIOBOWtTa27Pxs6foXlollH1F5vAGG4m6w31deG5rX42kbtJmPMvTVWiGlqOQ1pN7d
	 ME/JDTNHs5PZEjjP+AksDVH7gXQzgwdbty9Z6bc7KKu26cnihkQb8GqLtnrUoPqngN
	 YoQgfyBWiYE2PB+2HdkkS4x6vs0C3l6W59fRFT24/NejugJMLXz670VUVEQU458rC/
	 d+ZmlpqBQTxUz4L3g0KRjF0xAY3Q0eBDs62rENV6tBkBhCkpwzFYOtyfoYGbH2UTEe
	 DTB/s6Piu5kJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD5C61CE3;
	Tue, 25 Aug 2026 06:28:34 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 25 Aug 2026 06:28:29 +0000
Subject: [PATCH v4 1/2] dt-bindings: thermal: amlogic: Add A9 thermal
 bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-a9-thermal-v4-1-d8fc9859cf22@amlogic.com>
References: <20260825-a9-thermal-v4-0-d8fc9859cf22@amlogic.com>
In-Reply-To: <20260825-a9-thermal-v4-0-d8fc9859cf22@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787639310; l=1701;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=z03XxmpaVvRhkUiS0uq3ppP3WR/hzF6qXYwRuBxcXJE=;
 b=4ecCzrDqMsskePU+vwx0rj+vxH6zsH2Qc+c3HyewSXxo2Jp51pPujjQvYl8vIzXaMPnmLPAbT
 OkCiwm9I48EAYVfH3irVJUWOpcsH0doxK78fJQiYVtZCdhSfESh84E/
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the thermal controller compatibles for the Amlogic A9 SoC.

Describe the required "core" and "pclk" clocks, and update the schema
constraints for A9-specific thermal controllers.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 8cfa44dcda58..1b02404d67d5 100644
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
@@ -73,6 +80,24 @@ allOf:
       required:
         - amlogic,secure-monitor
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,a9-thermal
+    then:
+      properties:
+        clocks:
+          minItems: 2
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.52.0


