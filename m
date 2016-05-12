From: kernel@martin.sperl.org
Subject: [PATCH 3/4] ARM: bcm2835: add thermal node to device-tree of bcm283x
Date: Thu, 12 May 2016 14:35:37 +0000
Message-ID: <1463063738-11506-4-git-send-email-kernel@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.dynamic.surfer.at ([212.186.180.163]:54401 "EHLO
	cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbcELOfw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 10:35:52 -0400
In-Reply-To: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

From: Martin Sperl <kernel@martin.sperl.org>

Add the node for the thermal sensor of the bcm2835-soc
to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9db9d97..525f1f2 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -159,6 +159,12 @@
 			status = "disabled";
 		};
 
+		thermal: thermal@0x7e212000 {
+			compatible = "brcm,bcm2835-thermal";
+			reg = <0x7e212000 0x8>;
+			clocks = <&clocks BCM2835_CLOCK_TSENS>;
+		};
+
 		aux: aux@0x7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
-- 
2.1.4

