From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 8/9] arm64: dts: Add sensor node to Juno dt
Date: Wed, 22 Jul 2015 15:02:42 +0100
Message-ID: <1437573763-6525-9-git-send-email-punit.agrawal@arm.com>
References: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

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
