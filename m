From: Tyler Hall <tylerwhall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Tue, 10 Feb 2015 17:50:15 -0500
Message-ID: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tyler Hall <tylerwhall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The current register being used to read the temperature returns a noisy value
that is prone to variance and occasional outliers. The value in the thermal
manager control and status register appears to have the same scale but much
less variability.

Add a "marvell,armadaxp-filtered-thermal" config which is set up to read from
the Thermal Manager Control and Status Register at 0x184c4 rather than the
Thermal Sensor Status Register at 0x182b0. The only difference is the
temperature value shift. The original "marvell,armadaxp-thermal" is retained
for device tree compatibility.

This also fixes Armada XP clearing the disable bit in the wrong register. Bit 0
of the sensor register was being cleared but that bit is read-only. The disable
bit doesn't seem to have an effect on the temperature sensor value, however, so
this doesn't make a material difference.

This problem was detected when running with the watchdog(8) daemon polling the
thermal value. In one instance I observed a single read of over 200 degrees C
which caused a spurious watchdog-initiated reboot. I have since observed
individual outliers of ~20 degrees C. With this change and the corresponding
device tree update, the temperature is much more stable.

Signed-off-by: Tyler Hall <tylerwhall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

If there's a better way to handle this than a separate binding, I'm open to
suggestions.

My conclusions about these registers are based on experimental data. The
documentation is very sparse, but the Thermal Manager Control and Status
Register looks like the preferred register given the way it is laid out in the
public spec.

I have the small corresponding patch to the dts which I can submit separately.

Thanks
Tyler

 .../devicetree/bindings/thermal/armada-thermal.txt          |  8 ++++++++
 drivers/thermal/armada_thermal.c                            | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index 4698e0e..0d6a3f1 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -7,6 +7,14 @@ Required properties:
 		marvell,armada375-thermal
 		marvell,armada380-thermal
 		marvell,armadaxp-thermal
+		marvell,armadaxp-filtered-thermal
+
+		Note: "marvell,armadaxp-filtered-thermal" is adjusted to read
+		the hardware-filtered value in the thermal manager
+		control/status register rather than the raw sensor value in the
+		thermal sensor status register. "marvell,armadaxp-thermal"
+		remains for backward compatibility. The sensor reg address must
+		also point to the appropriate register.
 
 - reg:		Device's register space.
 		Two entries are expected, see the examples below.
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2556cf..d3c2ad3 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -196,6 +196,15 @@ static const struct armada_thermal_data armadaxp_data = {
 	.coef_div = 13825,
 };
 
+static const struct armada_thermal_data armadaxp_filt_data = {
+	.init_sensor = armadaxp_init_sensor,
+	.temp_shift = 1,
+	.temp_mask = 0x1ff,
+	.coef_b = 3153000000UL,
+	.coef_m = 10000000UL,
+	.coef_div = 13825,
+};
+
 static const struct armada_thermal_data armada370_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada370_init_sensor,
@@ -236,6 +245,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.data       = &armadaxp_data,
 	},
 	{
+		.compatible = "marvell,armadaxp-filtered-thermal",
+		.data       = &armadaxp_filt_data,
+	},
+	{
 		.compatible = "marvell,armada370-thermal",
 		.data       = &armada370_data,
 	},
-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
