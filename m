From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 2/2] dt-bindings: thermal: add binding doc for i.MX system
 controller thermal driver
Date: Tue, 27 Nov 2018 06:01:27 +0000
Message-ID: <1543298147-8155-2-git-send-email-Anson.Huang@nxp.com>
References: <1543298147-8155-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543298147-8155-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/thermal/imx-sc-thermal.txt | 33 ++++++++++++++++++=
++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-sc-therma=
l.txt

diff --git a/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt b=
/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt
new file mode 100644
index 0000000..2f5b0a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt
@@ -0,0 +1,33 @@
+* Temperature Monitor (TEMPMON) on NXP i.MX SoCs with System Controller
+
+Required properties:
+- compatible : Must be "nxp,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description=
.
+
+Example:
+tsens: thermal-sensor {
+	compatible =3D "nxp,imx8qxp-sc-thermal";
+	tsens-num =3D <1>;
+	#thermal-sensor-cells =3D <1>;
+};
+
+thermal_zones: thermal-zones {
+	cpu-thermal0 {
+		polling-delay-passive =3D <250>;
+		polling-delay =3D <2000>;
+		thermal-sensors =3D <&tsens 355>;
+		trips {
+			cpu_alert0: trip0 {
+				temperature =3D <107000>;
+				hysteresis =3D <2000>;
+				type =3D "passive";
+			};
+			cpu_crit0: trip1 {
+				temperature =3D <127000>;
+				hysteresis =3D <2000>;
+				type =3D "critical";
+			};
+		};
+	};
+};
--=20
2.7.4
