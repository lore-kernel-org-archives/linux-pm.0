From: kernel@martin.sperl.org
Subject: [PATCH-V2 1/5] dt: bindings: add thermal device driver for bcm2835
Date: Fri, 13 May 2016 13:13:02 +0000
Message-ID: <1463145186-12906-2-git-send-email-kernel@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.dynamic.surfer.at ([212.186.180.163]:54635 "EHLO
	cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcEMNNP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 09:13:15 -0400
In-Reply-To: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

From: Martin Sperl <kernel@martin.sperl.org>

Add documentation for bcm2835 SOC thermal sensor.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Acked-by: Eric Anholt <eric@anholt.net>

Changelog:
 V1 -> V2: renamed file to follow naming conventions
---
 .../bindings/thermal/brcm,bcm2835-thermal.txt           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
new file mode 100644
index 0000000..09de164
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
@@ -0,0 +1,17 @@
+Binding for Thermal Sensor driver for BCM2835 SoCs.
+
+Required parameters:
+-------------------
+
+compatible: 	should be one of: "brcm,bcm2835-thermal",
+		"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
+reg:		Address range of the thermal registers.
+clocks: 	Phandle of the clock used by the thermal sensor.
+
+Example:
+
+thermal: thermal@0x7e212000 {
+	compatible = "brcm,bcm2835-thermal";
+	reg = <0x7e212000 0x8>;
+	clocks = <&clocks BCM2835_CLOCK_TSENS>;
+};
--
2.1.4
