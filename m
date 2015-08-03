From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v2 09/10] arm64: dts: Add sensor node to Juno dt
Date: Mon,  3 Aug 2015 16:22:57 +0100
Message-ID: <1438615378-14241-10-git-send-email-punit.agrawal@arm.com>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:28785 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754065AbbHCPYY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 11:24:24 -0400
In-Reply-To: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>

The SCP firmware on Juno provides access to SoC sensors via the
SCPI. Add the sensor nodes to the device tree to enable this support.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index c624208..dd5158e 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -96,6 +96,11 @@
 				clock-output-names = "pxlclk0", "pxlclk1";
 			};
 		};
+
+		scpi_sensors0: sensors {
+			compatible = "arm,scpi-sensors";
+			#thermal-sensor-cells = <1>;
+		};
 	};
 
 	/include/ "juno-clocks.dtsi"
-- 
2.1.4

