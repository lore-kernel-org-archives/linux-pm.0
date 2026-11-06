Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953620;
	b=aDKzywFTWcmJbau5Vd5OdkQKVERSu8e5ojQCYiDNe6YmXA+8qOqQw6n3TMpj6zcJXl1z
	 qmMnEZachJOncCGWXaXaKQqQSpkb6udbOisq+l1rl9+alj4kKQMf+5vCWta86ZStHsntV
	 VJz2yXEqsqqL8drJxTovqocxXYXuFsCvhoAC45ECk+Xi9RAnL8aEk03svDDF001f3nPTJ
	 bfZS4kQWKsLoksKrVHdBFY40BLZlclki0+m8FJOIrsmAbeE03IdNiqDEiU927uICFRXkN
	 pTtQMhvxAYOZ778M4SFfkvLSLja+QMnooct7OLOQ5LCFx7WPg3DiNFxsubwyYxJxy6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953620;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=3qvxcnEjBI1kj/zcfIZc9ahcj/biklczCPaLrWvv44g=;
	b=oRFQZt3nI8yUyzikJ78Bl3GWaGiRCqfLmWXNbn+VmT7NCf6VosPWpXMPluaKdvtFYHNo
	 8rGICCqr8il4la2dc9boGBdFhx4bUHtTc+hWIWIs/Pdl/ezCL9m0dCJrcc5vlmvJdHLdJ
	 bl14FrXxmSEFv+h5XnrbBZ8F262mGeeny8Ko1iPoyIiwR45YR+sV5CZkd0gk9hJRKaXbJ
	 CjEy6bet8OfMnA61P+YV2snERHYyo2JNJcaf2/30HvCGbRNBH2bMAis3xUvJ4DVYLZ1v+
	 MxyW8BH16mL7K2W+BzRWdRJ1RvhtlZMDnmPUTZxEC1Clq7hUSu58M80xcw18Q1fAMfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3tjwoeB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ACB606A334;
	Fri,  6 Nov 2026 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3tjwoeB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377011F008A1;
	Fri,  6 Nov 2026 08:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953619;
	bh=3qvxcnEjBI1kj/zcfIZc9ahcj/biklczCPaLrWvv44g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l3tjwoeBqHptp67N06p05D3l5YJBmhSDelUnStUxA66bo6AXM/2woSOwMP5ekeMuQ
	 gCrj6jKzIonIakyLdp96vTF4tWNgKJRBJqYu2/AeuVmlVMvSYhd0AwogqSTna4QN7G
	 5ThenhGlBigsmHTnJBXokbMWXTZwdduqXhx2LGbQR69ydLtX13x0moblYFKymcsbvL
	 WuZ1ljadPoKSKtlUPH4VsuCg9uGG32nvVBU2VMX9pSczSpxqPtK6SyOodk1384sncE
	 uparGpMidiJ9zhrdEnF5F+9In5/KR2IGsLg0wDvdWJGt/xdOg6oBnArkpGTA2zFV3U
	 bFpizPB5BP3gw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 06 Nov 2026 09:26:44 +0100
Subject: [PATCH v3 1/7] dt-bindings: mfd: Describe the BCM6846 PMC complex
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
Message-Id: <20261106-xg6846b-bcmbca-xrdp-reset-v3-1-d6adeb71afc9@kernel.org>
References: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org>
In-Reply-To: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org>
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
register resource. Include the PMB clock and reset controllers and
PVTMON, with its acquisition clock and reset resources.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
new file mode 100644
index 000000000000..d4c927cabb3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
@@ -0,0 +1,82 @@
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
+  register banks. This binding describes the Processor Monitor Bus (PMB)
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
+        /* Processor Monitor Bus */
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
+            pmb_reset: reset-controller {
+                compatible = "brcm,bcm6846-pmb-reset";
+                #reset-cells = <1>;
+            };
+
+            hwmon {
+                compatible = "brcm,bcm6846-pmb-pvtmon";
+                clocks = <&pmb_clk BCM6846_CLK_PVTMON>;
+                resets = <&pmb_reset BCM6846_RESET_PVTMON>;
+                #thermal-sensor-cells = <0>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..f14f9910911c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5444,6 +5444,11 @@ N:	bcm[9]?6856
 N:	bcm[9]?6858
 N:	bcm[9]?6878
 
+BROADCOM BCMBCA PMC3 PMB DRIVER
+M:	Linus Walleij <linusw@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
+
 BROADCOM BDC DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
 M:	Al Cooper <alcooperx@gmail.com>

-- 
2.56.0

