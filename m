Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872888;
	b=j/wNvFKw3pVSsmoSec1rAAZXJXEItRdNGkZ8XBWKNgF6o5XvcrJyaW2AvzicRJMxkkKS
	 j3e3nl9geM5+E+2+o+pFx1YTkZTemjNyg/UpGBXl3G9Nc2GRVqmGCmjqhILM4a+aNZsQT
	 mV8mU/s6Mjf6Hf+qfK4uepDBL4vdgrDIPzeSaWu8o8UJAHO/N9wSrx+TqEaXPFZ3MLpbf
	 jesaKUyng9jkHo/UKJDfRs/1ycs3xofZeN7eKscFiStMVztyVJkSL31u2E764sGF2unNv
	 Lwdcpg0EXgH69tXwyeJYyUMfuLYn2accKkscwjrINYIx4qUr0XShoo1U30xgjDeVmXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872888;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=tVyAta9m6t+mbgMS/k0M+khdGxqpaVYfkYl31ln14zc=;
	b=EdFdltNtjpCoz4uE0S69aZsuofgPvIM4hJdSALbM0/ZqHGb9YyLMro4N13gLJFyYx+Eq
	 2DCyHew49gqMvTxKgZEJ6eEUOcN4AP1GMuqaEe0yAwe7MRB8jz/G0t6qvDmSA45GGlCXR
	 0PdXyWp2EkntnPFJJ2/LfuhOa0bsBeFQlDdcLODh/dcpQzK+xVCNm4E39kliepy8OA0D5
	 pbVt2JAcIeBAvBHWQTTFiqYAmrBD4CAmU9sVBhXCfNun/N7o/40EghBSrncfIRul/hE35
	 hLqZd7EVuWBaGU5nncU5DJA7G7B8PYz3Un1a+BHLf5IzMQOaP6ZBPWhaox7lBNQ4CmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zqc6N45G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA0606A31C;
	Mon, 16 Nov 2026 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zqc6N45G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9921F000C4;
	Mon, 16 Nov 2026 23:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872888;
	bh=tVyAta9m6t+mbgMS/k0M+khdGxqpaVYfkYl31ln14zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zqc6N45GKKNrpR+i30qzGjo8S+oTxo49o7Jk9nfjhrPg+hukuxUrQHmrnkTJSvzSx
	 3AuTBV1K2Qxj6pne7NfWTiGnZeSDA1XTxDaX+6CBem/PZTSredayBBbnsVHy6qi8qE
	 Ad4blHC4ekPrOUhwrhppJfFXkrLmynIi4HzEB61Xuf1Wyj3tQK0b/PSPkK2KTfR5a5
	 xzagztznmMn5S3RcCC5osCpDHCtjJ6Le/flO8ndfwk4J1h3IL5weyFzqJaTv8eEtox
	 TM6QlaYZluuQs6stJidbYOeZON82vxnaPnlC+8JdrtbTs4PeWNNY/ZXvp7usy/NnjG
	 JP9/+xIq2r67g==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 00:47:53 +0100
Subject: [PATCH v5 1/6] dt-bindings: mfd: Describe the BCM6846 PMC complex
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-xg6846b-bcmbca-xrdp-reset-v5-1-f584e8b8e696@kernel.org>
References: <20261117-xg6846b-bcmbca-xrdp-reset-v5-0-f584e8b8e696@kernel.org>
In-Reply-To: <20261117-xg6846b-bcmbca-xrdp-reset-v5-0-f584e8b8e696@kernel.org>
To: Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0

Describe the BCM6846 Power Management Controller complex and its Power
Management Bus, including the power-domain, clock, reset and PVTMON
providers. Define the clock, reset and power-domain IDs used by consumers.

Keep the complete hierarchy in one schema so each child is validated
once through the PMC binding. Include the combined XRDP, Runner and WAN
power domain and the zero-cell PVTMON thermal sensor.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  | 238 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +
 include/dt-bindings/clock/brcm,bcm6846-pmb.h       |  42 ++++
 include/dt-bindings/power/brcm,bcm6846-pmb.h       |  12 ++
 include/dt-bindings/reset/brcm,bcm6846-pmb.h       |  11 +
 5 files changed, 311 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
new file mode 100644
index 000000000000..eb01797f8262
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
@@ -0,0 +1,238 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/brcm,bcm6846-pmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6846 Power Management Controller
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description:
+  The third generation Power Management Controller (PMC3) contains several
+  register banks. This binding describes the Power Management Bus (PMB)
+  interface within Procmon. The PMB child owns its register bank. The parent
+  provides address translation and does not own a register bank.
+
+properties:
+  compatible:
+    items:
+      - const: brcm,bcm6846-pmc
+      - const: simple-mfd
+
+  ranges:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  '^bus@[0-9a-f]+$':
+    type: object
+    description:
+      The Power Management Bus (PMB) connects the third generation Power
+      Management Controller (PMC3) to the control registers of miscellaneous
+      independent hardware blocks.
+
+      The controller provides configuration, arbitration and four keyhole
+      interfaces for indirect register access.
+
+      Child nodes describe independent hardware blocks accessed over the PMB.
+      These provide global resources and even resources for each other.
+
+    properties:
+      compatible:
+        const: brcm,bcm6846-pmb
+
+      reg:
+        maxItems: 1
+        description: PMB configuration, keyhole and address mapping registers
+
+      power-controller:
+        type: object
+        description: |
+          The power controller is a child of the Power Management Bus (PMB)
+          controller and accesses BPCM power zones through the parent regmap.
+          A domain includes all power zones of a block. The XRDP domain groups
+          XRDP, its three Runner cores and WAN, matching the vendor power sequence.
+
+          Domain IDs are defined in dt-bindings/power/brcm,bcm6846-pmb.h:
+            BCM6846_PD_PERIPH: peripheral block (bus 0, device 0, four zones)
+            BCM6846_PD_MEMC: memory controller (bus 1, device 8, one zone)
+            BCM6846_PD_USB20: USB 2.0 (bus 1, device 10, four zones)
+            BCM6846_PD_XRDP: XRDP (bus 1, device 12, three zones), Runner cores
+              (bus 1, devices 14, 15 and 16, one zone each) and WAN
+              (bus 1, device 11, three zones)
+            BCM6846_PD_PCIE0: PCIe 0 (bus 0, device 18, one zone)
+            BCM6846_PD_PCIE1: PCIe 1 (bus 0, device 19, one zone)
+
+          Peripheral and memory domains remain powered because they provide
+          resources required for system operation. CPU and PLL blocks use different
+          register layouts and are outside the scope of this provider.
+
+        properties:
+          compatible:
+            const: brcm,bcm6846-pmb-power
+
+          '#power-domain-cells':
+            const: 1
+            description: Power domain ID from dt-bindings/power/brcm,bcm6846-pmb.h
+
+        required:
+          - compatible
+          - '#power-domain-cells'
+
+        additionalProperties: false
+
+      clock-controller:
+        type: object
+        description:
+          The Power Management Bus (PMB) provides access to the RDP and BIU PLL
+          outputs, the Runner clock, the crystal output, the PVTMON acquisition
+          clock and the clock gates in block power-control zones. Clock indices
+          are defined in dt-bindings/clock/brcm,bcm6846-pmb.h.
+          The PLLs and crystal output use a 50 MHz reference clock.
+          Zone clocks require their associated blocks to be powered.
+
+        properties:
+          compatible:
+            const: brcm,bcm6846-pmb-clock
+
+          clocks:
+            maxItems: 1
+
+          clock-names:
+            const: ref
+
+          '#clock-cells':
+            const: 1
+
+        required:
+          - compatible
+          - clocks
+          - clock-names
+          - '#clock-cells'
+
+        additionalProperties: false
+
+      reset-controller:
+        type: object
+        description:
+          The reset controller is a child of the Power Management Bus (PMB)
+          controller and uses its indirect register interface.
+
+          Each reset specifier identifies a logical reset group, which may span
+          several blocks that must be reset together.
+
+        properties:
+          compatible:
+            const: brcm,bcm6846-pmb-reset
+
+          '#reset-cells':
+            const: 1
+            description: Reset group ID from dt-bindings/reset/brcm,bcm6846-pmb.h
+
+        required:
+          - compatible
+          - '#reset-cells'
+
+        additionalProperties: false
+
+      hwmon:
+        type: object
+        description:
+          The process, voltage and temperature monitor (PVTMON) is a child of
+          the Power Management Bus (PMB) controller and uses its indirect
+          register interface. It measures die temperature and seven voltages,
+          including a diagnostic test input.
+
+        allOf:
+          - $ref: /schemas/thermal/thermal-sensor.yaml#
+
+        properties:
+          compatible:
+            const: brcm,bcm6846-pmb-pvtmon
+
+          clocks:
+            maxItems: 1
+            description: PVTMON acquisition clock
+
+          resets:
+            maxItems: 1
+            description: PVTMON analog-acquisition reset
+
+          '#thermal-sensor-cells':
+            const: 0
+
+        required:
+          - compatible
+          - clocks
+          - resets
+          - '#thermal-sensor-cells'
+
+        unevaluatedProperties: false
+
+    required:
+      - compatible
+      - reg
+      - power-controller
+      - clock-controller
+      - reset-controller
+      - hwmon
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/brcm,bcm6846-pmb.h>
+    #include <dt-bindings/reset/brcm,bcm6846-pmb.h>
+
+    system-controller@ffb00000 {
+        /* Broadcom BCM6846 Power Management Controller complex */
+        compatible = "brcm,bcm6846-pmc", "simple-mfd";
+        ranges = <0x0 0xffb00000 0x21000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        /* Power Management Bus */
+        bus@20100 {
+            compatible = "brcm,bcm6846-pmb";
+            reg = <0x20100 0x200>;
+
+            pmb_clk: clock-controller {
+                compatible = "brcm,bcm6846-pmb-clock";
+                clocks = <&osc50m>;
+                clock-names = "ref";
+                #clock-cells = <1>;
+            };
+
+            hwmon {
+                compatible = "brcm,bcm6846-pmb-pvtmon";
+                clocks = <&pmb_clk BCM6846_CLK_PVTMON>;
+                resets = <&pmb_reset BCM6846_RESET_PVTMON>;
+                #thermal-sensor-cells = <0>;
+            };
+
+            power-controller {
+                compatible = "brcm,bcm6846-pmb-power";
+                #power-domain-cells = <1>;
+            };
+
+            pmb_reset: reset-controller {
+                compatible = "brcm,bcm6846-pmb-reset";
+                #reset-cells = <1>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..67642e2a4ab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5444,6 +5444,14 @@ N:	bcm[9]?6856
 N:	bcm[9]?6858
 N:	bcm[9]?6878
 
+BROADCOM BCMBCA PMC3 PMB DRIVER
+M:	Linus Walleij <linusw@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
+F:	include/dt-bindings/clock/brcm,bcm6846-pmb.h
+F:	include/dt-bindings/power/brcm,bcm6846-pmb.h
+F:	include/dt-bindings/reset/brcm,bcm6846-pmb.h
+
 BROADCOM BDC DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
 M:	Al Cooper <alcooperx@gmail.com>
diff --git a/include/dt-bindings/clock/brcm,bcm6846-pmb.h b/include/dt-bindings/clock/brcm,bcm6846-pmb.h
new file mode 100644
index 000000000000..548a18ed7959
--- /dev/null
+++ b/include/dt-bindings/clock/brcm,bcm6846-pmb.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_CLOCK_BRCM_BCM6846_PMB_H
+#define _DT_BINDINGS_CLOCK_BRCM_BCM6846_PMB_H
+
+#define BCM6846_CLK_RDPPLL_CH0	0
+#define BCM6846_CLK_RDPPLL_CH1	1
+#define BCM6846_CLK_RDPPLL_CH2	2
+#define BCM6846_CLK_RDPPLL_CH3	3
+#define BCM6846_CLK_RDPPLL_CH4	4
+#define BCM6846_CLK_RDPPLL_CH5	5
+#define BCM6846_CLK_BIUPLL_CH0	6
+#define BCM6846_CLK_BIUPLL_CH1	7
+#define BCM6846_CLK_BIUPLL_CH2	8
+#define BCM6846_CLK_BIUPLL_CH3	9
+#define BCM6846_CLK_BIUPLL_CH4	10
+#define BCM6846_CLK_BIUPLL_CH5	11
+#define BCM6846_CLK_RUNNER	12
+#define BCM6846_CLK_XTAL_OUT	13
+#define BCM6846_CLK_PVTMON	14
+#define BCM6846_CLK_PERIPH_ZONE0	15
+#define BCM6846_CLK_PERIPH_ZONE1	16
+#define BCM6846_CLK_PERIPH_ZONE2	17
+#define BCM6846_CLK_PERIPH_ZONE3	18
+#define BCM6846_CLK_MEMC		19
+#define BCM6846_CLK_USB_ZONE0	20
+#define BCM6846_CLK_USB_ZONE1	21
+#define BCM6846_CLK_USB_ZONE2	22
+#define BCM6846_CLK_USB_ZONE3	23
+#define BCM6846_CLK_WAN_ZONE0	24
+#define BCM6846_CLK_WAN_ZONE1	25
+#define BCM6846_CLK_WAN_ZONE2	26
+#define BCM6846_CLK_XRDP_ZONE0	27
+#define BCM6846_CLK_XRDP_ZONE1	28
+#define BCM6846_CLK_XRDP_ZONE2	29
+#define BCM6846_CLK_RUNNER0	30
+#define BCM6846_CLK_RUNNER1	31
+#define BCM6846_CLK_RUNNER2	32
+#define BCM6846_CLK_PCIE0		33
+#define BCM6846_CLK_PCIE1		34
+#define BCM6846_CLK_BIU		35
+
+#endif
diff --git a/include/dt-bindings/power/brcm,bcm6846-pmb.h b/include/dt-bindings/power/brcm,bcm6846-pmb.h
new file mode 100644
index 000000000000..abdd01c94bc5
--- /dev/null
+++ b/include/dt-bindings/power/brcm,bcm6846-pmb.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_POWER_BCM6846_PMB_H
+#define _DT_BINDINGS_POWER_BCM6846_PMB_H
+
+#define BCM6846_PD_PERIPH	0
+#define BCM6846_PD_MEMC		1
+#define BCM6846_PD_USB20		2
+#define BCM6846_PD_XRDP		3
+#define BCM6846_PD_PCIE0		4
+#define BCM6846_PD_PCIE1		5
+
+#endif
diff --git a/include/dt-bindings/reset/brcm,bcm6846-pmb.h b/include/dt-bindings/reset/brcm,bcm6846-pmb.h
new file mode 100644
index 000000000000..ce68adb10108
--- /dev/null
+++ b/include/dt-bindings/reset/brcm,bcm6846-pmb.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_RESET_BRCM_BCM6846_PMB_H
+#define _DT_BINDINGS_RESET_BRCM_BCM6846_PMB_H
+
+/* XRDP packet engine and its three Runner cores. */
+#define BCM6846_RESET_XRDP	0
+
+/* Process, voltage and temperature monitor analog acquisition reset. */
+#define BCM6846_RESET_PVTMON	1
+
+#endif

-- 
2.56.1

