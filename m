From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
Date: Mon, 14 Sep 2015 14:00:14 +0100
Message-ID: <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442235619-4029-1-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The System Control Processor (SCP) provides access to SoC sensors via
the System Control and Power Interface (SCPI) Message Protocol. Add
bindings to allow probing of these sensors. Also support referencing
of the sensors for setting up thermal zones via the thermal DT
bindings.

Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index f002460..af66f7f 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -72,8 +72,18 @@ Required sub-node properties:
 - compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
 	       shared memory on Juno platforms
 
+Sensor bindings for the sensors based on SCPI Message Protocol
+--------------------------------------------------------------
+SCPI provides an API to access the various sensors on the SoC.
+
+Required properties:
+- compatible : should be "arm,scpi-sensors".
+- #thermal-sensor-cells: should be set to 1. This property follows the
+			 thermal device tree bindings[2].
+
 [0] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/thermal/thermal.txt
 
 Example:
 
@@ -122,6 +132,11 @@ scpi_protocol: scpi@2e000000 {
 			clock-output-names = "pxlclk0", "pxlclk1";
 		};
 	};
+
+	scpi_sensors0: sensors {
+		compatible = "arm,scpi-sensors";
+		#thermal-sensor-cells = <1>;
+	};
 };
 
 cpu@0 {
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
