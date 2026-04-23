Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3A361660;
	Thu, 23 Apr 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960491; cv=none; b=Izqeudf2RYfrhxtu0nbvqpP9SXAAsiO+KK7Faq+V/8VWAvF6UUXtpEKMt/UXy4rl10gCIFOmWO8046BVnCkIyZ/pUlaYRwJ8SLOGtR8s2TdSiOj+0f+ZB4XMOnUfC0uOWTQhHGhOq7mac/7/Woa20wiq/XRXqCuehJgaj8NLrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960491; c=relaxed/simple;
	bh=wXjL0/ZjPWYklzHHsG/fnHIawjJ0r03LA6jLikwVGTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6sc5ZW6/7SVkeF3UCnGXmPXxIY6yKdVtnrEjNWJc9iF9OCYuS+05M/fmsI7JC2ZVVTW65owfTyduyLCnjPJk6Lk0Ixe/4E3KTuYRjtDdh0pRrEME1EqSOYoibs4yeoFD1o7/Kfn3fBI+THZT75parQxNxYOPHWKYN0B+ev93Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBbau/8J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBbau/8J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD790C2BCB4;
	Thu, 23 Apr 2026 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776960490;
	bh=wXjL0/ZjPWYklzHHsG/fnHIawjJ0r03LA6jLikwVGTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lBbau/8JGaGZrZ70Dg6tqGCO2fPy08Hyc/EKUc7+dqaadWU/UjzV21H//95ovUI5p
	 w9tbFg9Ll9KLRwsRkD6wNEQ4OG0G7RKOSyzyUd5/W+KmgmSSZR29tXdBSmJJUpCZKM
	 0BDzu6pbsmMcgKedernpAgH6we1YkEBeTngcDRv6X05vBP0ywwhwkeufmXvhKC4h6r
	 pfUl1HVsWwMpOohiBauqGQDbtbWQ7pkVizkoW2cRbK0umNKdBEUsa28wUfOUT5+VVl
	 gsHKQFiXggeKVbewT073vP4A7dSUoXsYYDtyz5muKFWKLJoTc2rMQFI9u5T8hc8vVd
	 ND3ftKfj3IxCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB144FC0360;
	Thu, 23 Apr 2026 16:08:10 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 23 Apr 2026 18:07:16 +0200
Subject: [PATCH v4 1/8] dt-bindings: thermal: amlogic: Add support for T7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-thermal-t7-vim4-v4-1-d4c1528d5044@aliel.fr>
References: <20260423-add-thermal-t7-vim4-v4-0-d4c1528d5044@aliel.fr>
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-0-d4c1528d5044@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2861;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=42FjYfnK8gHAQIf5ZxFekEMwi0ysWDknaNuX/++vGok=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+Yr5/vzP+b9+GgtcciWXWbJXJbJL69L3k19eftz+rG2/
 /4H6xIXdZSyMIhxMciKKbL0z7U88e7y0TNf96inwMxhZQIZwsDFKQATEV3AyHAka+k6gdXRidnJ
 /l63ij6ITDL9OFWN15v598fA/b+nLLVm+O/1Wmirw717DW8Nbiru+8x9YX+gasTH5kndy/k5WSs
 Nb/MDAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add the amlogic,t7-thermal compatible for the Amlogic T7 thermal sensor.

Unlike existing variants which use a phandle to the ao-secure syscon,
the T7 relies on a secure monitor interface described by a phandle and
a sensor index argument.

The T7 integrates multiple thermal sensors, all accessed through the
same SMC call. The sensor index argument is required to identify which
sensor's calibration data the secure monitor should return, as a single
SM_THERMAL_CALIB_READ command serves all of them.

Introduce the amlogic,secure-monitor property as a phandle-array and
make amlogic,ao-secure or amlogic,secure-monitor conditionally required
depending on the compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 37 ++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 70b273271754b..e28612510d679 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -21,7 +21,9 @@ properties:
               - amlogic,g12a-cpu-thermal
               - amlogic,g12a-ddr-thermal
           - const: amlogic,g12a-thermal
-      - const: amlogic,a1-cpu-thermal
+      - enum:
+          - amlogic,a1-cpu-thermal
+          - amlogic,t7-thermal
 
   reg:
     maxItems: 1
@@ -42,12 +44,34 @@ properties:
   '#thermal-sensor-cells':
     const: 0
 
+  amlogic,secure-monitor:
+    description: phandle to the secure monitor
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the secure monitor
+          - description: sensor index to get specific calibration data
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
-  - amlogic,ao-secure
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,a1-cpu-thermal
+              - amlogic,g12a-thermal
+    then:
+      required:
+        - amlogic,ao-secure
+    else:
+      required:
+        - amlogic,secure-monitor
 
 unevaluatedProperties: false
 
@@ -62,4 +86,13 @@ examples:
         #thermal-sensor-cells = <0>;
         amlogic,ao-secure = <&sec_AO>;
     };
+  - |
+    temperature-sensor@20000 {
+        compatible = "amlogic,t7-thermal";
+        reg = <0x0 0x20000 0x0 0x50>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc_periphs CLKID_TS>;
+        #thermal-sensor-cells = <0>;
+        amlogic,secure-monitor = <&sm 1>;
+    };
 ...

-- 
2.49.0


