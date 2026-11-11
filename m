Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394856;
	b=m7rrSHAHLWiNhNCZE/PuDKevwU4FofTo22BueJUCpQVFqvfFGsFVXYvs8unKixNssiLb
	 NWhERoxStcFmiu9qhsOpd66ckTORyNAxqi27zOuu2b5wdqd0efScWGj9bdcEBTKfsURlG
	 f4d/T7T2iBL4PP5HeqctVCZAKLHNfkimhk5Nh1aBjdrybVQfahLyk0nYvGSc9fxqSP7sm
	 hP1dw0+0oFsp+r/Ayw7q+tODLCfd887EkDNCPxrjX8DoiXMryOgKvPFh5hQ6JZvxCKnYZ
	 V3OV+h08z1Av4ri41erAul9rL1NSZVdTR6FYhWUGw4odVIHBKUhwwOYKkliTcwV0Jgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394856;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Vmk4aWqWXSrffB+jBif12gqK694P9ADaIcfkC9ZLp9E=;
	b=OC+46zqBEVDBcus0ABMC4ytr9EpO8nk+0pdOEL7bCSuHxrrQFif2AkubfoLaMuS6n2O4
	 l+HHTYuxqCGJBISmhwWwSdUBWP0vUQcXk0aBYSjYCNpwIIlqu3T6kiNVczV8lLzL+0u2T
	 AMJ14fUv5rYszNvHeq9WLUB08olGC7MYB/eHbmkuL+3g44jeco0i5h34ruA8DBBc1iiLa
	 XS+GmJQJruYoy82EMHc9jfCoP/jhoIaNGEgcA9sD7Ji+rmdldBJJctOIoGRdrgcgz+ekW
	 fbtzoJfMPI6V/8XI1S5azFPPyhxxqwmRzyyJ466MskciiESXisflWFwtPV1Sw+0WZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxJYuyKX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB156606A31C;
	Wed, 11 Nov 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxJYuyKX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCA51F00A05;
	Wed, 11 Nov 2026 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394856;
	bh=Vmk4aWqWXSrffB+jBif12gqK694P9ADaIcfkC9ZLp9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lxJYuyKXZeTMfhuM6galnSE0+gTmU1ZRua5/E6O/YKH0oh11qNZoR6dYPLHHXddj+
	 jafP5R8xAFyZGXsVdlpOmKNbOUc3s+idGeEKPp6SyUvVBEWrc4LKV5dHIWtXMQDsCx
	 RqN6rLeD9awDxHQJe1ewfi8uWIDZUaUbuZrHpLO4vWUt64/cdx6b4VEMk4p5uaenyt
	 864Qkp6t00T1Vamt8NvBlF4PmJumSkzYT324Pig1lk2vevSWdb57hlyxVcWqf61UO3
	 mVVNkxIkqTz2Q6BLZZfmItvYjMNfdCSgjjmPj+1crAeGdpGRfsMRW0cErJojBNm4QH
	 mr/J078/wJFRw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Nov 2026 12:00:42 +0100
Subject: [PATCH v4 1/7] dt-bindings: soc: Describe the BCM6846 Power
 Management Bus
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
Message-Id: <20261111-xg6846b-bcmbca-xrdp-reset-v4-1-17035a5e8ad2@kernel.org>
References: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
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

The third generation Power Management Controller (PMC3) accesses SoC
block control and reset registers through the Power Management Bus
(PMB). Describe the BCM6846 PMB and its child controllers.

Add bindings for the power, clock, reset and PVTMON child controllers,
and headers defining their clock, reset and power-domain IDs. Include
the combined XRDP, Runner and WAN power domain and the zero-cell PVTMON
thermal sensor.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
I considered even just using the PMB but the PMC has more stuff and
it seems natural to let it live in a simple-mfd node.
---
 .../bindings/clock/brcm,bcm6846-pmb-clock.yaml     | 39 ++++++++++
 .../bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml    | 42 ++++++++++
 .../bindings/power/brcm,bcm6846-pmb-power.yaml     | 44 +++++++++++
 .../bindings/reset/brcm,bcm6846-pmb-reset.yaml     | 31 ++++++++
 .../bindings/soc/bcm/brcm,bcm6846-pmb.yaml         | 90 ++++++++++++++++++++++
 MAINTAINERS                                        | 12 +++
 include/dt-bindings/clock/brcm,bcm6846-pmb.h       | 42 ++++++++++
 include/dt-bindings/power/brcm,bcm6846-pmb.h       | 12 +++
 include/dt-bindings/reset/brcm,bcm6846-pmb.h       | 11 +++
 9 files changed, 323 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.yaml
new file mode 100644
index 000000000000..406125622f7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/brcm,bcm6846-pmb-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6846 PMB clocks
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description:
+  The Power Management Bus (PMB) provides access to the RDP and BIU PLL
+  outputs, the Runner clock, the crystal output, the PVTMON acquisition
+  clock and the clock gates in block power-control zones. Clock indices
+  are defined in dt-bindings/clock/brcm,bcm6846-pmb.h.
+  The PLLs and crystal output use a 50 MHz reference clock.
+  Zone clocks require their associated blocks to be powered.
+
+properties:
+  compatible:
+    const: brcm,bcm6846-pmb-clock
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ref
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml b/Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml
new file mode 100644
index 000000000000..2fc4f7ef5148
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/brcm,bcm6846-pmb-pvtmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6846 PMB process, voltage and temperature monitor
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description:
+  The process, voltage and temperature monitor (PVTMON) is a child of
+  the Power Management Bus (PMB) controller and uses its indirect
+  register interface. It measures die temperature and seven voltages,
+  including a diagnostic test input.
+
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm6846-pmb-pvtmon
+
+  clocks:
+    maxItems: 1
+    description: PVTMON acquisition clock
+
+  resets:
+    maxItems: 1
+    description: PVTMON analog-acquisition reset
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - resets
+  - '#thermal-sensor-cells'
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml b/Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
new file mode 100644
index 000000000000..686049bc2032
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/brcm,bcm6846-pmb-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6846 Power Management Bus power controller
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description: |
+  The power controller is a child of the Power Management Bus (PMB)
+  controller and accesses BPCM power zones through the parent regmap.
+  A domain includes all power zones of a block. The XRDP domain groups
+  XRDP, its three Runner cores and WAN, matching the vendor power sequence.
+
+  Domain IDs are defined in dt-bindings/power/brcm,bcm6846-pmb.h:
+    BCM6846_PD_PERIPH: peripheral block (bus 0, device 0, four zones)
+    BCM6846_PD_MEMC: memory controller (bus 1, device 8, one zone)
+    BCM6846_PD_USB20: USB 2.0 (bus 1, device 10, four zones)
+    BCM6846_PD_XRDP: XRDP (bus 1, device 12, three zones), Runner cores
+      (bus 1, devices 14, 15 and 16, one zone each) and WAN
+      (bus 1, device 11, three zones)
+    BCM6846_PD_PCIE0: PCIe 0 (bus 0, device 18, one zone)
+    BCM6846_PD_PCIE1: PCIe 1 (bus 0, device 19, one zone)
+
+  Peripheral and memory domains remain powered because they provide
+  resources required for system operation. CPU and PLL blocks use different
+  register layouts and are outside the scope of this provider.
+
+properties:
+  compatible:
+    const: brcm,bcm6846-pmb-power
+
+  '#power-domain-cells':
+    const: 1
+    description: Power domain ID from dt-bindings/power/brcm,bcm6846-pmb.h
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
new file mode 100644
index 000000000000..a70149d078cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/brcm,bcm6846-pmb-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6846 Power Management Bus reset controller
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description:
+  The reset controller is a child of the Power Management Bus (PMB)
+  controller and uses its indirect register interface.
+
+  Each reset specifier identifies a logical reset group, which may span
+  several blocks that must be reset together.
+
+properties:
+  compatible:
+    const: brcm,bcm6846-pmb-reset
+
+  '#reset-cells':
+    const: 1
+    description: Reset group ID from dt-bindings/reset/brcm,bcm6846-pmb.h
+
+required:
+  - compatible
+  - '#reset-cells'
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
new file mode 100644
index 000000000000..9782a27ff075
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm6846-pmb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6846 Power Management Bus
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description:
+  The Power Management Bus (PMB) connects the third generation Power
+  Management Controller (PMC3) to the control registers of miscellaneous
+  independent hardware blocks.
+
+  The controller provides configuration, arbitration and four keyhole
+  interfaces for indirect register access.
+
+  Child nodes describe independent hardware blocks accessed over the PMB.
+  These provide global resources and even resources for each other.
+
+properties:
+  compatible:
+    const: brcm,bcm6846-pmb
+
+  reg:
+    maxItems: 1
+    description: PMB configuration, keyhole and address mapping registers
+
+  power-controller:
+    type: object
+    $ref: /schemas/power/brcm,bcm6846-pmb-power.yaml#
+
+  clock-controller:
+    type: object
+    $ref: /schemas/clock/brcm,bcm6846-pmb-clock.yaml#
+
+  reset-controller:
+    type: object
+    $ref: /schemas/reset/brcm,bcm6846-pmb-reset.yaml#
+
+  hwmon:
+    type: object
+    $ref: /schemas/hwmon/brcm,bcm6846-pmb-pvtmon.yaml#
+
+required:
+  - compatible
+  - reg
+  - power-controller
+  - clock-controller
+  - reset-controller
+  - hwmon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/brcm,bcm6846-pmb.h>
+    #include <dt-bindings/reset/brcm,bcm6846-pmb.h>
+
+    /* Power Management Bus */
+    bus@ffb20100 {
+        compatible = "brcm,bcm6846-pmb";
+        reg = <0xffb20100 0x200>;
+
+        pmb_clk: clock-controller {
+            compatible = "brcm,bcm6846-pmb-clock";
+            clocks = <&osc50m>;
+            clock-names = "ref";
+            #clock-cells = <1>;
+        };
+
+        hwmon {
+            compatible = "brcm,bcm6846-pmb-pvtmon";
+            clocks = <&pmb_clk BCM6846_CLK_PVTMON>;
+            resets = <&pmb_reset BCM6846_RESET_PVTMON>;
+            #thermal-sensor-cells = <0>;
+        };
+
+        power-controller {
+            compatible = "brcm,bcm6846-pmb-power";
+            #power-domain-cells = <1>;
+        };
+
+        pmb_reset: reset-controller {
+            compatible = "brcm,bcm6846-pmb-reset";
+            #reset-cells = <1>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..e9112393e56b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5444,6 +5444,18 @@ N:	bcm[9]?6856
 N:	bcm[9]?6858
 N:	bcm[9]?6878
 
+BROADCOM BCMBCA PMC3 PMB DRIVER
+M:	Linus Walleij <linusw@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.yaml
+F:	Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml
+F:	Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
+F:	Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
+F:	Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
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
2.56.0

