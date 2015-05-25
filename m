From: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] Documentation: devicetree: Add Richtek RT9455 bindings
Date: Mon, 25 May 2015 13:22:22 +0300
Message-ID: <1432549343-5756-3-git-send-email-anda-maria.nicolae@intel.com>
References: <1432549343-5756-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432549343-5756-1-git-send-email-anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/power/rt9455_charger.txt   |   46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.txt

diff --git a/Documentation/devicetree/bindings/power/rt9455_charger.txt b/Documentation/devicetree/bindings/power/rt9455_charger.txt
new file mode 100644
index 0000000..bb46842
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rt9455_charger.txt
@@ -0,0 +1,46 @@
+Binding for Richtek rt9455 battery charger
+
+Required properties:
+- compatible: Should contain one of the following:
+ * "richtek,rt9455"
+
+- reg:					integer, i2c address of the device.
+- richtek,output-charge-current:	integer, output current in uA, from the
+					charger to the battery.
+- richtek,end-of-charge-percentage:	integer, percent of the output charge current.
+					When the current in constant-voltage phase drops
+					below output_charge_current x end-of-charge-percentage,
+					charge is terminated.
+- richtek,battery-regulation-voltage:	integer, maximum battery voltage in uV.
+- richtek,boost-output-voltage:		integer, maximum voltage in uV, provided to consumer
+					devices, when the charger is in boost mode.
+
+Optional properties:
+- richtek,min-input-voltage-regulation: integer, input voltage threshold in uA, used to
+					determine when to decrease voltage level when
+					the over current of the input power source occurs.
+					This prevents input voltage drop due to insufficient
+					current provided by the power source.
+- richtek,avg-input-current-regulation: integer, input current in uA, the charger should
+					drain from the power source.
+
+Example:
+
+rt9455@22 {
+	compatible = "richtek,rt9455";
+	reg = <0x22>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <0 1>;
+
+	interrupt-gpio = <&gpio1 0 1>;
+	reset-gpio = <&gpio1 1 1>;
+
+	richtek,output-charge-current	    = <500000>;
+	richtek,end-of-charge-percentage    = <10>;
+	richtek,battery-regulation-voltage  = <4200000>;
+	richtek,boost-output-voltage	    = <5050000>;
+
+	richtek,min-input-voltage-regulation = <4500000>;
+	richtek,avg-input-current-regulation = <500000>;
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
