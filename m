From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH v2 2/2] dt-bindings: power: add amlogic meson power domain bindings
Date: Sat, 28 Oct 2017 18:40:17 +0200
Message-ID: <1509208817-30632-3-git-send-email-narmstrong@baylibre.com>
References: <1509208817-30632-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52599 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdJ1Qk0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Oct 2017 12:40:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id t139so8804026wmt.1
        for <linux-pm@vger.kernel.org>; Sat, 28 Oct 2017 09:40:25 -0700 (PDT)
In-Reply-To: <1509208817-30632-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@baylibre.com, carlo@caione.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/power/amlogic,meson-gx-pwrc.txt       | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
new file mode 100644
index 0000000..95ec49a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
@@ -0,0 +1,61 @@
+Amlogic Meson Power Controller
+==============================
+
+The Amlogic Meson SoCs embeds an internal Power domain controller.
+
+VPU Power Domain
+----------------
+
+The Video Processing Unit power domain is controlled by this power controller,
+but the domain requires some external resources to meet the correct power
+sequences.
+The bindings must respect the power domain bindings as described in the file
+power_domain.txt
+
+Device Tree Bindings:
+---------------------
+
+Required properties:
+- compatible: should be "amlogic,meson-gx-pwrc-vpu" for the Meson GX SoCs
+- #power-domain-cells: should be 0
+- amlogic,hhi-sysctrl: phandle to the HHI sysctrl node
+- resets: phandles to the reset lines needed for this power demain sequence
+	as described in ../reset/reset.txt
+- clocks: from common clock binding: handle to VPU and VAPB clocks
+- clock-names: from common clock binding: must contain "vpu", "vapb"
+	corresponding to entry in the clocks property.
+
+Parent node should have the following properties :
+- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
+- reg: base address and size of the AO system control register space.
+
+Example:
+-------
+
+ao_sysctrl: sys-ctrl@0 {
+	compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
+	reg =  <0x0 0x0 0x0 0x100>;
+
+	pwrc_vpu: power-controller-vpu {
+		compatible = "amlogic,meson-gx-pwrc-vpu";
+		#power-domain-cells = <0>;
+		amlogic,hhi-sysctrl = <&sysctrl>;
+		resets = <&reset RESET_VIU>,
+			 <&reset RESET_VENC>,
+			 <&reset RESET_VCBUS>,
+			 <&reset RESET_BT656>,
+			 <&reset RESET_DVIN_RESET>,
+			 <&reset RESET_RDMA>,
+			 <&reset RESET_VENCI>,
+			 <&reset RESET_VENCP>,
+		 	 <&reset RESET_VDAC>,
+		 	 <&reset RESET_VDI6>,
+		 	 <&reset RESET_VENCL>,
+			 <&reset RESET_VID_LOCK>;
+		clocks = <&clkc CLKID_VPU>,
+			 <&clkc CLKID_VAPB>;
+		clock-names = "vpu", "vapb";
+	};
+};
+
+
-- 
2.7.4
