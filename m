From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 7/7] arm: dts: add thermal zones info on tmp102 for DRA7-EVM
Date: Mon, 6 Jan 2014 08:36:51 -0400
Message-ID: <1389011811-13004-8-git-send-email-eduardo.valentin@ti.com>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40402 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbaAFMkv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2014 07:40:51 -0500
In-Reply-To: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

Add simple thermal zone on tmp102.

Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-ev=
m.dts
index 36e2c9e..1ea9c3d 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -95,6 +95,21 @@
 	};
 };
=20
+&thermal_zones {
+	pcb_thermal: pcb_thermal {
+		polling-delay-passive =3D <250>; /* milliseconds */
+		polling-delay =3D <1000>; /* milliseconds */
+		thermal-sensors =3D <&tmp102>;
+		trips {
+			crit@80000 {
+			temperature =3D <80000>;
+				hysteresis =3D <1000>;
+				type =3D "critical";
+			};
+		};
+	};
+};
+
 &i2c1 {
 	status =3D "okay";
 	pinctrl-names =3D "default";
--=20
1.8.2.1.342.gfa7285d

