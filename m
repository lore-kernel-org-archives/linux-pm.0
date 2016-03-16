From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V8 08/14] of: add notes of critical trips for soctherm
Date: Wed, 16 Mar 2016 16:58:05 +0800
Message-ID: <1458118685-29907-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The "critical" type trip in thermal zone can be
set to SOC_THERM hardware, it can trigger shut down
or reset event from hardware.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
index 6b68cd150405..351a7376baa8 100644
--- a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
@@ -26,6 +26,10 @@ Required properties :
     of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
     list of valid values when referring to thermal sensors.
 
+Note:
+- the "critical" type trip points will be set to SOC_THERM hardware as the
+shut down temperature. Once the temperature of this thermal zone is higher
+than it, the system will be shutdown or reset by hardware.
 
 Example :
 
@@ -51,5 +55,13 @@ Example: referring to thermal sensors :
 
                         thermal-sensors =
                                 <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+
+			trips {
+				cpu_shutdown_trip: shutdown-trip {
+					temperature = <102500>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
                 };
 	};
-- 
1.9.1
