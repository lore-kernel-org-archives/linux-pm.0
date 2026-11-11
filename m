Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394862;
	b=q0YAdeOQZj95qJo9vJroY9wL+nX6cNFo7qITd0nqbOMxul6JWs0BTa5X3hhUCjk9mmJM
	 WmouAx7tqF4QVaOdMPV5muQpziz9Gc6eUwV8mdBbs719fVzrFV7TnFcv9jANQgXK8gmjo
	 wIOyfODJ6/LXvCRbMK42WkT/yuGcO3Me0EWTVaiqDd1AH8zTsq5GfgqMGBo2Xo5iXujlE
	 K3jfxAOQlkuOoeXA0/xFpZj0aV87BGOMmIQz5zY9b9UeKqlsLYZPsQt5754TveDAwZmom
	 WIpji/s6j4FdhWedxM7NkS52Qpf8cPkGe0h5WfnFdy/Pd9Sgq54V4EIDL0xDk2fhupg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394862;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=QOkydq0cYYGGH7GG7wSCcbFytlG6lfG522uEzWQ+MSI=;
	b=vTcjZoc72o3+fxJGpWi0ha9kvu4PHOF/Bd86myNZt5lswtusaxzy8992cSHyPXXPy0kN
	 Eo+rV9VRo4VH/IH0FxEQbeBv92dwGKYXbdIZ3TJYEVZ8Bsn5r0T0+0/tspI9TRiIrkeyt
	 JQljRnERxyLdgx4Pd3LtBCSIX4uDOXxyvkrHNVJy13uN464S0v+L37IVNJS7mU8C6PTMa
	 Yv8abZRanJns2qwAbNVcc94v3arlpJrlvQRTEJHDTXDEBxi0TB7OdDJ5iNOUvBDyIm/Eb
	 RjRWfCN5gv7Tj7RjCO1NjYBP4q4PK+Bv+vePUr4So1gGxpIUpaLn3bhU6XLr5JHKK3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8KZwsi9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F6606A31C;
	Wed, 11 Nov 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8KZwsi9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64771F00A0A;
	Wed, 11 Nov 2026 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394862;
	bh=QOkydq0cYYGGH7GG7wSCcbFytlG6lfG522uEzWQ+MSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W8KZwsi9Hcbt9TSZX6V5UL5nYaEUloPI0gxTYW4DfFh8F4JSK7uZnFHPjrXxecBqk
	 ji41dAwrpmcKougQiJomEXkvOERXIVdKDkSscYsuF3nyoEVUspYHHXAvl+gs/QV7mQ
	 QD9nU9IrhNFeL3tEWt/r+BEu7u7SNw5H3SokXWdOdSmo9c6ycJAozdIMYox+xJS1Pt
	 V0/OPFjvefxcGni5v0VnEzGvv8/mqVoklMS07ru9LtdFWJMS3DDkkowDIhmYiIpL+9
	 Z30wOfTJZxSoalehQGvfAucYO+t6mDmyyjCfLGv7iGZ9fC29CnYgr6bjxewArWh5i5
	 oXyLROZfhyjkw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Nov 2026 12:00:43 +0100
Subject: [PATCH v4 2/7] dt-bindings: mfd: Describe the BCM6846 PMC complex
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
Message-Id: <20261111-xg6846b-bcmbca-xrdp-reset-v4-2-17035a5e8ad2@kernel.org>
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

The third generation Power Management Controller (PMC3) has
different subdevices.

Identify the parent with the BCM6846-specific "brcm,bcm6846-pmc"
compatible.

Describe the complex as a simple-mfd with a PMB bus child owning its
register resource. Include the PMB power, clock and reset controllers and
PVTMON, with its acquisition clock and reset resources.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  | 87 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
new file mode 100644
index 000000000000..6082e30d37ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
@@ -0,0 +1,87 @@
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
+    $ref: /schemas/soc/bcm/brcm,bcm6846-pmb.yaml#
+    description: PMB configuration, keyhole and address mapping registers
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
index e9112393e56b..e11fc5064dc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5449,6 +5449,7 @@ M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.yaml
 F:	Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml
+F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
 F:	Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
 F:	Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
 F:	Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml

-- 
2.56.0

