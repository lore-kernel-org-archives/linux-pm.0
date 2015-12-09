From: Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
Date: Wed, 9 Dec 2015 22:29:35 +0000
Message-ID: <5668AB4F.7030100@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:52860 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbbLIW3r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 17:29:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kevin Cernekee <cernekee@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, MIPS Mailing List <linux-mips@linux-mips.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>

The BCM6358 contains power domains controlled with a register. Power
domains are indexed by bits in the register. Power domain bits can be
interleaved with other status bits and clocks in the same register.

Newer SoCs with dedicated power domain registers are active low.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 .../power/brcm,bcm6358-power-controller.txt        | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt

diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
new file mode 100644
index 0000000..556c323
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
@@ -0,0 +1,53 @@
+Broadcom BCM6358 Power domain controller
+
+This binding uses the power domain bindings:
+        Documentation/devicetree/bindings/power/power_domain.txt
+
+The BCM6358 contains power domains controlled with a register. Power
+domains are indexed by bits in the register. Power domain bits can be
+interleaved with other status bits and clocks in the same register.
+
+Newer SoCs with dedicated power domain registers are active low.
+
+Required properties:
+- compatible:           Should be "brcm,bcm<soc>-power-controller", "brcm,bcm6358-power-controller"
+- #power-domain-cells:  Should be <1>.
+- regmap:               The register map phandle
+- offset:               Offset in the register map for the power domain register (in bytes)
+- power-domain-indices: The bits in the register used for power domains.
+- power-domain-names:   Should be a list of strings of power domain names
+                        indexed by the power domain indices.
+
+Optional properties:
+- active-low:           Specify that the bits are active low.
+
+Example:
+
+misc_iddq_ctrl: power-controller {
+	compatible = "brcm,bcm63168-power-controller", "brcm,bcm6358-power-controller";
+	regmap = <&misc>;
+	offset = <0x4c>;
+
+	#power-domain-cells = <1>;
+	power-domain-indices =
+	                <0>,         <1>,      <2>,    <3>,         <4>,
+	                <5>,         <6>,      <7>,    <8>,         <9>,
+	                <10>,        <11>,     <12>,   <13>,        <17>,
+	                <18>;
+	power-domain-names =
+	                "sar",       "ipsec",  "mips", "dect",      "usbh",
+	                "usbd",      "robosw", "pcm",  "periph",    "vdsl_phy",
+	                "vdsl_mips", "fap",    "pcie", "wlan_pads", "gphy",
+	                "gmac";
+	active-low;
+};
+
+periph_iddq: power-controller {
+	compatible = "brcm,bcm6368-power-controller", "brcm,bcm6358-power-controller";
+	regmap = <&periph_cntl>;
+	offset = <0x4>;
+
+	#power-domain-cells = <1>;
+	power-domain-indices = <19>;
+	power-domain-names = "usbh";
+};
-- 
2.1.4

-- 
Simon Arlott
