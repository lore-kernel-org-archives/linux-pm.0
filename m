Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE4332EBD;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045656; cv=none; b=ibaVWhIfF/42yEcI8sj7r9py5Gg0KoyHnyLx+/iRgZUZPabHIy3PAtEVQKqcuvKlyAOuNuPRPl7ga5k8LNnvItdArp8JhdMXZQmRgM7qF9+D9lgQx5twww+ivrtIojx8cfkyaWYlU9WWNQbMH5+QbpO0SxsT2JKxi0vozqbjIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045656; c=relaxed/simple;
	bh=wXjL0/ZjPWYklzHHsG/fnHIawjJ0r03LA6jLikwVGTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgzBzfxdWRRbC+RTlxb3m9aTU3YiqivvJUvP3fntuGHSjYg+R6V6t2Pi0YGkLXCQg8nHVJavQb2ECx4wpHGA5X+8jEw6c5dGDOfto0a/kt8sRNy6MBU0KfCfKRAv1mdd0UlqigAA9svF540UyG9xEvYUtCJTbCeKKHtYuagt7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2uqHI6g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2uqHI6g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0606C2BCB2;
	Fri, 24 Apr 2026 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045656;
	bh=wXjL0/ZjPWYklzHHsG/fnHIawjJ0r03LA6jLikwVGTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N2uqHI6g2nccCrhKt4U1q2AWsmt/Q/pSpOadWj8Sj0WRLETWGzqzmGv18LwQzklub
	 HGJg+fq2jO2+XflrFnuqk5x1xz7QMC/E64aBP3wFZQ6Uy/KQb+Sa+uXWAxaGRb5MFb
	 4F7IyjDp0jvn3LkZLfG9ZzHZg/bIiIuB2zW652CxL0cEVf56s2t73qM4t6IMw1KOfN
	 9nM2Mb2Q4h8OgXEVMZvJrWhLXLW9RbjUrhA3F3EOQN2BL1BHQBnY995gLYQJNDK44J
	 fS9EKrCbeFuz58cVtoONNlhIDQ0fQgHixakie71JGMLHOmN60EIy6txu+fZIcxPSPO
	 zEl4XdhXadEnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF5BFED3E6;
	Fri, 24 Apr 2026 15:47:35 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 24 Apr 2026 17:45:09 +0200
Subject: [PATCH v5 1/8] dt-bindings: thermal: amlogic: Add support for T7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-add-thermal-t7-vim4-v5-1-9040ca36afe2@aliel.fr>
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
In-Reply-To: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+brCZ0S+09pl0+8nh7FM3H7wwkN88P058d8uWsZ8Uy23
 mDtd7GyjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAicr8ZGd5/+cPbqaz9WXj6
 q6Sc/LNi7/6+LrQMuL7bctbWUyfO3FjCyLDi+tenLzxMl3DO2eRnPk/bfZH4P36vX5ycM2OenHm
 0mJsTAA==
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


