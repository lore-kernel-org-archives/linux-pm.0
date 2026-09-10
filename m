Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176C3D3339;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022337; cv=none; b=JrIzsxQqnXbHoP5b45yvQsrWTGOWE4prO5aKKtmSjOAulzGQmVpV5Zl5LzU2cwrWVUbdkTFHPbVBV13cfUjJ370PqliEQL9bzU2/pspzfRkKKxE5u91AZ2ftg+iZim9vXr0yc5KUhUm6IS80fbuEsi8P6j+Q+FalJwj3PYZi0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022337; c=relaxed/simple;
	bh=2TU5UtSqlTK5Fx9D95GxY0TfdDPbOgZck8finK/MKtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHEetB6Xz7uYV7BVKZTCJ29hoinqQrpS+g9jBSxj+u2JeArTlVyox7FqGlVM/FjYvl/ZDZrzIzKx5TowKkeT4tODPZn8j11lzOBvYGWfzaU1dpPY/DrFkqzAGpC2hJZYv9zDMTuyTiSxl6gp9nM7eLmSOK5WuwqWY56FGXzJI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFsf7P2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFsf7P2z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91F01C2BCFC;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789022336;
	bh=2TU5UtSqlTK5Fx9D95GxY0TfdDPbOgZck8finK/MKtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BFsf7P2zElLdbO5Q0ymkbWVfDBWZDNXAgIrMIRK7VgkT45En02HXgiunXNP/8/liU
	 K0ZsJw+yQ9hTTs6Rczdyo5vBDeUfi09GJubqI89hesR7U/9nAQld+IBDuBktxlhB6f
	 UBy82UkmbU2S+CVhQFFUpnescSUFVqvTlLhWbwTqg1UGNY7elBr6ix2V+rjiiah6Vv
	 /5D/zXdb0ag5JEbqzW6Tmvmj7YxkHNxfxNnISxtaYwyuPfpf1swlMLlbVHaUYSttMq
	 J6L0kHq0n5E3BcJc6pL9WSwqec+ESpyl67np9ZkcpL6j+X98YCeI3Y5JMQe3bOW6pl
	 In3Fm/sn88A+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFBAC79FB7;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 10 Sep 2026 06:38:52 +0000
Subject: [PATCH v5 1/2] dt-bindings: thermal: amlogic: Add A9 thermal
 bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-a9-thermal-v5-1-892d798723e1@amlogic.com>
References: <20260910-a9-thermal-v5-0-892d798723e1@amlogic.com>
In-Reply-To: <20260910-a9-thermal-v5-0-892d798723e1@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789022333; l=1701;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=z03XxmpaVvRhkUiS0uq3ppP3WR/hzF6qXYwRuBxcXJE=;
 b=e5xlU76hScLnEWkvmwjg2BCWQHDq5iPnOnS9y+eaQqxdcGEpopL6reLgsKb3f/49yx6JkQyuI
 XwTcKScieLXC6weiHMdMNl4dIEW4HOEIJMy6NPXF7rCPMdzsP7AYx+V
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


