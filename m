Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC1439328
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438788; cv=none; b=pGvJdC1JfQ+R0phag8iEzFUfZnxeMCMYIQh4iYmOv2WtvNEL9MkkoPukedyMXBVTW/PNvWuRaU/hUkk5TTnT82VbTfgvOD29xq/cOUq+c48mxQ8B/Pq4cI5PaFY2vxtMOauSeww3/Ur+PHKZm3taKtVHxL2gYLqvqGqnKgdI5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438788; c=relaxed/simple;
	bh=0EkKu3bgHBdwhJcVVD367LVQ8oTp4uI3kUU7TeCOItE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JvHqRYIDkyTPuEEun30XXPpAgjHbPkfIoDd/UG6eMIK3idcnaXkHenlPYAEkUCCd5jPVqK2oRW/Q9rhhsBPdnguhIAH58DbqbPwDkFODwSDzDae2lLcb5j6835MXvhHgKyADHh/h1JJMe5KwXBdO1BgwnScW/++D5EBR2gGdRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENtAZbeE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENtAZbeE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-384422b05b5so29703a91.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785438784; x=1786043584; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9AeVjnVShATQYoTkD7E2msQdb1oMjsrKsyiSSAcEkmw=;
        b=ENtAZbeEOuFHaCJmI8WO0p1II0Ipkzw6rUvuMQuR+yoaEsFMDeZbN7nv1EDZ+W+yrY
         0xd0EmgoOlbJq0l2vLsYp+CQL5a0blAKYOpSiAUt+APzNH/mdEDgTNnpmLlLevvlxBPN
         DMtTUFpzgVaq5HAmK2BQV19rMw8K0UNHLwE1vA4r+vNNArxv4mGGWBBte8X8J4PEhKif
         BtxXxWqJizWylLg9Xiaie1SI8ZtwgXp0bMAEA5QeSvc5NzLAhAliISB40NZt8F83R+x9
         7KoBLa7R1hCJosTQF5Pnt+FjH0xS06ev7LaBhYZPE6yVbPTzqg9MEZQnFkGGfe9ubVTf
         LoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438784; x=1786043584;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9AeVjnVShATQYoTkD7E2msQdb1oMjsrKsyiSSAcEkmw=;
        b=kXDmcYF+Szj7HbNLw05Dhuc0UnzRzG6l3hibzLS8xffXoL8K8ZtgsTbRxoEAMS6Qss
         SKzJzq+Uy5ZJo7EfP0B9WhILQ60ACNfNhIee4vrdDb23a3iT1gn5lN7gU0HFzqo9jt0z
         2m1FFKeahC9duIerPBBXwiu9cyX8X4JFaAkKz3TihMbfkkO63dEXLrzB6fyno/Md2XVa
         OJo0PIL+AeIa9Q3dgXIh+qhTnVJS0VDNMOxRbvHBtRcR0rBdvpa4X1lcxWQick5Hbn0i
         pw9SYFqIvahXujjB9lTT7qaLaC0oGf4cPr98etHn+5QcMpWNwQRFPFUWd0NjC3nTAEw4
         JHEw==
X-Gm-Message-State: AOJu0YyNsfLS3kdj9Zyh+CcNtDUMpobpcTOHZjOrpcHnVXeOvaKIYJX1
	3DXH2pHen4/XAgmTL4ZeI9v91SkdCHsduXuJjS0OmLpeJdTJFKgJdnZN
X-Gm-Gg: AR+sD13PCc93oHQF5T9z9O8Wvf9QApMQIpS/xY2XHSkansl/jh9DeH3NK1wBkzefpF2
	GTwbYLGbooVtVu06etBZyiZlUyeFAyhpLdX5nM8Q6+sghPw4yo9ITKSocmHJ7633CxW3yfMCz90
	JeANNCDVwAkV5oLWmSkK4gjT82Otex/Fq0WIxKOdw+79DLzfabWv03TV1UdYmIMemgI9Xu6wXcx
	K72f2BU6tOZlJJ4YKE7KJXm39rFx1ZyIYLP1D5TlOviWnxvpxMr8visHPngvbt4CX/1J5XvFylv
	vTHAWzram2ifq6JpOZMC1GST/1C/oiTjFQxciKidcrxF59ajldl8FflPlI3ByZtxXDmmjrYaA60
	I7fdNizNR0YLu/bmbFTNDk7pthmfFwOl+uP2a9TtSq5Z93Z9my2RmRbcIp/Kz5tGrP9jkhq2zkJ
	kp0FdwglxSetDkvPMaP9APFoNg/Wf+4pmYliMmnOWr4JBOm5H6qLUVtScNN7m3KAirC3D6O+xz
X-Received: by 2002:a17:90b:4a85:b0:38d:90c1:2400 with SMTP id 98e67ed59e1d1-38fa809536cmr1304967a91.2.1785438783737;
        Thu, 30 Jul 2026 12:13:03 -0700 (PDT)
Received: from [10.179.125.252] ([2409:40c2:500f:59d:8e80:806b:4f70:e9d6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b67063sm25773578eec.9.2026.07.30.12.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:13:03 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 31 Jul 2026 00:42:38 +0530
Subject: [PATCH] dt-bindings: thermal: ti,omap-bandgap: Convert to DT
 schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ti-bandgap-v1-1-aeee6a658520@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avErBOsQKGrRIvRRpsWJloRRHfPa
 vkW/1+QKTFl6KsLEh2ceQ0FTV2BnTF4EjwVQytbJXUnxcbCYJg8RuG06azS6BQqKEFM5Pj8ZsP
 4O+9mIbu9B7jvB/pf8ZBuAAAA
X-Change-ID: 20260730-ti-bandgap-f7b3c67af6a6
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785438770; l=9175;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=0EkKu3bgHBdwhJcVVD367LVQ8oTp4uI3kUU7TeCOItE=;
 b=1642rZAF9UGHmejIql/M1pwKwFFaib1JPKoEvsp9+ZemqH9oOxorO9/l7ZCe8gc+SFVkYc3YH
 ETbTV8+izYZAdddmJtbS6SaQPvHOIqO7Pmkc3mtQKKVLJPuDMRQJVBZ
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert Texas Instruments OMAP SCM bandgap from legacy text to DT schema

Add "ti,dra752-bandgap" to compatible which was missing in text binding
but used and matched by same driver.

Document the "#thermal-sensor-cells" property, which was missing from
the original text binding but is required in practice by all in-tree
users via the common thermal-sensor.yaml binding.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../bindings/thermal/ti,omap-bandgap.yaml          | 227 +++++++++++++++++++++
 .../devicetree/bindings/thermal/ti_soc_thermal.txt |  88 --------
 2 files changed, 227 insertions(+), 88 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml b/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
new file mode 100644
index 000000000000..5afd10a84f70
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
@@ -0,0 +1,227 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/ti,omap-bandgap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OMAP SCM bandgap
+
+maintainers:
+  - Eduardo Valentin <edubezval@gmail.com>
+
+description:
+  In the System Control Module, OMAP supplies a voltage reference and a
+  temperature sensor feature that are gathered in the band gap voltage and
+  temperature sensor (VBGAPTS) module. The band gap provides current and
+  voltage reference for its internal circuits and other analog IP blocks. The
+  analog-to-digital converter (ADC) produces an output value that is
+  proportional to the silicon temperature.
+
+properties:
+  compatible:
+    enum:
+      - ti,omap34xx-bandgap
+      - ti,omap36xx-bandgap
+      - ti,omap4430-bandgap
+      - ti,omap4460-bandgap
+      - ti,omap4470-bandgap
+      - ti,omap5430-bandgap
+      - ti,dra752-bandgap
+
+  reg:
+    minItems: 1
+    maxItems: 6
+
+  interrupts:
+    maxItems: 1
+
+  gpios:
+    maxItems: 1
+    description:
+      used to inform which GPIO line the tshut signal is routed to. The
+      informed GPIO will be treated as an IRQ;
+
+  "#thermal-sensor-cells":
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,omap34xx-bandgap
+              - ti,omap36xx-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+
+        interrupts: false
+
+        gpios: false
+
+        "#thermal-sensor-cells":
+          const: 0
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,omap4430-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        interrupts: false
+
+        "#thermal-sensor-cells":
+          const: 0
+
+      required:
+        - gpios
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,omap4460-bandgap
+              - ti,omap4470-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+
+        interrupts:
+          maxItems: 1
+
+        "#thermal-sensor-cells":
+          const: 0
+
+      required:
+        - interrupts
+        - gpios
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,omap5430-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+
+        interrupts:
+          maxItems: 1
+
+        gpios: false
+
+        "#thermal-sensor-cells":
+          const: 1
+
+      required:
+        - interrupts
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,dra752-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 6
+          maxItems: 6
+
+        interrupts:
+          maxItems: 1
+
+        gpios: false
+
+        "#thermal-sensor-cells":
+          const: 1
+
+      required:
+        - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bandgap@48002524 {
+        compatible = "ti,omap34xx-bandgap";
+        reg = <0x48002524 0x4>;
+        #thermal-sensor-cells = <0>;
+    };
+
+  - |
+    bandgap@48002524 {
+        compatible = "ti,omap36xx-bandgap";
+        reg = <0x48002524 0x4>;
+        #thermal-sensor-cells = <0>;
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    bandgap@4a002260 {
+        compatible = "ti,omap4430-bandgap";
+        reg = <0x4a002260 0x4>, <0x4a00232c 0x4>;
+        gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>; /* tshut */
+        #thermal-sensor-cells = <0>;
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bandgap@4a002260 {
+        compatible = "ti,omap4460-bandgap";
+        reg = <0x4a002260 0x4>, <0x4a00232c 0x4>, <0x4a002378 0x18>;
+        interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
+        gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>; /* tshut */
+        #thermal-sensor-cells = <0>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bandgap@4a0021e0 {
+        compatible = "ti,omap5430-bandgap";
+        reg = <0x4a0021e0 0xc>, <0x4a00232c 0xc>,
+              <0x4a002380 0x2c>, <0x4a0023c0 0x3c>;
+        interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
+        #thermal-sensor-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bandgap@4a0021e0 {
+        compatible = "ti,dra752-bandgap";
+        reg = <0x4a0021e0 0xc>, <0x4a00232c 0xc>,
+              <0x4a002380 0x2c>, <0x4a0023c0 0x3c>,
+              <0x4a002564 0x8>, <0x4a002574 0x50>;
+        interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>; /* talert */
+        #thermal-sensor-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
deleted file mode 100644
index 6299dd8de339..000000000000
--- a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-* Texas Instrument OMAP SCM bandgap bindings
-
-In the System Control Module, OMAP supplies a voltage reference
-and a temperature sensor feature that are gathered in the band
-gap voltage and temperature sensor (VBGAPTS) module. The band
-gap provides current and voltage reference for its internal
-circuits and other analog IP blocks. The analog-to-digital
-converter (ADC) produces an output value that is proportional
-to the silicon temperature.
-
-Required properties:
-- compatible : Should be:
-  - "ti,omap34xx-bandgap" : for OMAP34xx bandgap
-  - "ti,omap36xx-bandgap" : for OMAP36xx bandgap
-  - "ti,omap4430-bandgap" : for OMAP4430 bandgap
-  - "ti,omap4460-bandgap" : for OMAP4460 bandgap
-  - "ti,omap4470-bandgap" : for OMAP4470 bandgap
-  - "ti,omap5430-bandgap" : for OMAP5430 bandgap
-- interrupts : this entry should indicate which interrupt line
-the talert signal is routed to;
-Specific:
-- gpios : this entry should be used to inform which GPIO
-line the tshut signal is routed to. The informed GPIO will
-be treated as an IRQ;
-- regs : this entry must also be specified and it is specific
-to each bandgap version, because the mapping may change from
-soc to soc, apart of depending on available features.
-
-Example:
-OMAP34xx:
-bandgap {
-	reg = <0x48002524 0x4>;
-	compatible = "ti,omap34xx-bandgap";
-};
-
-OMAP36xx:
-bandgap {
-	reg = <0x48002524 0x4>;
-	compatible = "ti,omap36xx-bandgap";
-};
-
-OMAP4430:
-bandgap {
-	reg = <0x4a002260 0x4 0x4a00232C 0x4>;
-	compatible = "ti,omap4430-bandgap";
-};
-
-OMAP4460:
-bandgap {
-	reg = <0x4a002260 0x4
-		0x4a00232C 0x4
-		0x4a002378 0x18>;
-	compatible = "ti,omap4460-bandgap";
-	interrupts = <0 126 4>; /* talert */
-	gpios = <&gpio3 22 0>; /* tshut */
-};
-
-OMAP4470:
-bandgap {
-	reg = <0x4a002260 0x4
-		0x4a00232C 0x4
-		0x4a002378 0x18>;
-	compatible = "ti,omap4470-bandgap";
-	interrupts = <0 126 4>; /* talert */
-	gpios = <&gpio3 22 0>; /* tshut */
-};
-
-OMAP5430:
-bandgap {
-	reg = <0x4a0021e0 0xc
-		0x4a00232c 0xc
-		0x4a002380 0x2c
-		0x4a0023C0 0x3c>;
-	compatible = "ti,omap5430-bandgap";
-	interrupts = <0 126 4>; /* talert */
-};
-
-DRA752:
-bandgap {
-	reg = <0x4a0021e0 0xc
-		0x4a00232c 0xc
-		0x4a002380 0x2c
-		0x4a0023C0 0x3c
-		0x4a002564 0x8
-		0x4a002574 0x50>;
-	compatible = "ti,dra752-bandgap";
-	interrupts = <0 126 4>; /* talert */
-};

---
base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8
change-id: 20260730-ti-bandgap-f7b3c67af6a6

Best regards,
-- 
Bhargav

