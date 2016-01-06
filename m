From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/4] thermal: power_allocator: rework proportional parameter
Date: Wed,  6 Jan 2016 16:53:45 +0800
Message-ID: <1452070428-2567-2-git-send-email-leo.yan@linaro.org>
References: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

k_po/k_pu are two proportional term constants and essentially they have
fixed ratio compared with sustainable power. In current implementation,
k_po and k_pu are absolute value after calculation and cannot represent
the ratio relationship with sustainable power; as a result, when change
sustainable power we cannot smoothly change proportional term constant.

So this patch introduces variants k_po_ratio and k_pu_ratio, which
represent the ratio value compared against sustainable power, so smaller
ratio will result in thermal slower ramp. The formulas finally are as
below:

k_pu = k_pu_ratio * sustainable_power /
		(desired_temperature - switch_on_temp)

k_po = k_po_ratio * sustainable_power /
		(desired_temperature - switch_on_temp)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/power_allocator.c | 18 ++++++++++++------
 include/linux/thermal.h           |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 1246aa6..76d2b47 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -155,13 +155,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	if (!temperature_threshold)
 		return;
 
-	if (!tz->tzp->k_po || force)
-		tz->tzp->k_po = int_to_frac(sustainable_power) /
-			temperature_threshold;
+	if (!tz->tzp->k_po_ratio || force)
+		tz->tzp->k_po_ratio = 1;
 
-	if (!tz->tzp->k_pu || force)
-		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
-			temperature_threshold;
+	if (!tz->tzp->k_pu_ratio || force)
+		tz->tzp->k_pu_ratio = 2;
 
 	if (!tz->tzp->k_i || force)
 		tz->tzp->k_i = int_to_frac(10) / 1000;
@@ -169,6 +167,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	 * The default for k_d and integral_cutoff is 0, so we can
 	 * leave them as they are.
 	 */
+
+	tz->tzp->k_po = int_to_frac(tz->tzp->k_po_ratio * sustainable_power) /
+				temperature_threshold;
+	tz->tzp->k_pu = int_to_frac(tz->tzp->k_pu_ratio * sustainable_power) /
+				temperature_threshold;
 }
 
 /**
@@ -202,6 +205,9 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 
 	if (tz->tzp->sustainable_power) {
 		sustainable_power = tz->tzp->sustainable_power;
+		estimate_pid_constants(tz, sustainable_power,
+				       params->trip_switch_on, control_temp,
+				       false);
 	} else {
 		sustainable_power = estimate_sustainable_power(tz);
 		estimate_pid_constants(tz, sustainable_power,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 613c29b..2638f0b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -284,13 +284,13 @@ struct thermal_zone_params {
 	 * Proportional parameter of the PID controller when
 	 * overshooting (i.e., when temperature is below the target)
 	 */
-	s32 k_po;
+	s32 k_po, k_po_ratio;
 
 	/*
 	 * Proportional parameter of the PID controller when
 	 * undershooting
 	 */
-	s32 k_pu;
+	s32 k_pu, k_pu_ratio;
 
 	/* Integral parameter of the PID controller */
 	s32 k_i;
-- 
1.9.1
