From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH 4/5] thermal: introduce the Power Allocator governor
Date: Tue,  6 May 2014 13:06:37 +0100
Message-ID: <1399377998-14870-5-git-send-email-javi.merino@arm.com>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35597 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934775AbaEFMHw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 08:07:52 -0400
In-Reply-To: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>

The power allocator governor is a thermal governor that controls system
and device power allocation to control temperature.  Conceptually, the
implementation takes a system view of heat dissipation by managing
multiple heat sources.

This governor relies on power-aware cooling devices (power actors) to
operate.  That is, cooling devices whose thermal_cooling_device_ops
accept THERMAL_UNIT_POWER.

It uses a Proportional Integral (PI) controller driven by the
temperature of the thermal zone.  This budget is then allocated to
each cooling device that can have bearing on the temperature we are
trying to control.  It decides how much power to give each cooling
device based on the performance they are requesting.  The PI
controller ensures that the total power budget does not exceed the
control temperature.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/Kconfig           |   14 ++
 drivers/thermal/Makefile          |    1 +
 drivers/thermal/power_allocator.c |  403 +++++++++++++++++++++++++++++++++=
++++
 drivers/thermal/thermal_core.c    |    7 +-
 drivers/thermal/thermal_core.h    |    8 +
 include/linux/thermal.h           |    5 +
 6 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/power_allocator.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d51912a6e40..f5e6b693fc19 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -71,6 +71,14 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 =09  Select this if you want to let the user space manage the
 =09  platform thermals.
=20
+config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
+=09bool "power_allocator"
+=09select THERMAL_GOV_POWER_ALLOCATOR
+=09help
+=09  Select this if you want to control temperature based on
+=09  system and device power allocation. This governor relies on
+=09  power-aware cooling devices (power actors) to operate.
+
 endchoice
=20
 config THERMAL_GOV_FAIR_SHARE
@@ -89,6 +97,12 @@ config THERMAL_GOV_USER_SPACE
 =09help
 =09  Enable this to let the user space manage the platform thermals.
=20
+config THERMAL_GOV_POWER_ALLOCATOR
+=09bool "Power allocator thermal governor"
+=09help
+=09  Enable this to manage platform thermals by dynamically
+=09  allocating and limiting power to devices.
+
 config CPU_THERMAL
 =09bool "generic cpu cooling support"
 =09depends on CPU_FREQ
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 54e4ec9eb5df..1cb7d5fec8dc 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_OF)=09=09+=3D of-thermal.o
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)=09+=3D fair_share.o
 thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)=09+=3D step_wise.o
 thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)=09+=3D user_space.o
+thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)=09+=3D power_allocator.o
=20
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_THERMAL)=09+=3D cpu_cooling.o
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allo=
cator.c
new file mode 100644
index 000000000000..39c425abf10a
--- /dev/null
+++ b/drivers/thermal/power_allocator.c
@@ -0,0 +1,403 @@
+/*
+ * A power allocator to manage temperature
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "Power allocator: " fmt
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define MAX_NUM_ACTORS 8
+
+#define FRAC_BITS 8
+#define int_to_frac(x) ((x) << FRAC_BITS)
+#define frac_to_int(x) ((x) >> FRAC_BITS)
+
+/**
+ * mul_frac - multiply two fixed-point numbers
+ * @x:=09first multiplicand
+ * @y:=09second multiplicand
+ *
+ * Returns the result of multiplying two fixed-point numbers.  The
+ * result is also a fixed-point number.
+ */
+static inline s64 mul_frac(s64 x, s64 y)
+{
+=09return (x * y) >> FRAC_BITS;
+}
+
+enum power_allocator_trip_levels {
+=09TRIP_SWITCH_ON =3D 0,=09/* Switch on PI controller */
+=09TRIP_MAX_DESIRED_TEMPERATURE, /* Temperature we are controlling for */
+};
+
+/**
+ * struct power_allocator_params - parameters for the power allocator gove=
rnor
+ * @k_po:=09P parameter of the PI controller when overshooting (i.e., when
+ *=09=09temperature is below the target)
+ * @k_pi:=09P parameter of the PI controller when undershooting
+ * @k_i:=09I parameter of the PI controller
+ * @integral_cutoff:=09threshold below which the error is no longer accumu=
lated
+=09=09=09in the PI controller
+ * @err_integral:=09Accumulated error in the PI controller.
+ */
+struct power_allocator_params {
+=09s32 k_po;
+=09s32 k_pu;
+=09s32 k_i;
+=09s32 integral_cutoff;
+=09s32 err_integral;
+};
+
+/**
+ * pi_controller() - PI controller
+ * @tz:=09thermal zone we are operating in
+ * @control_temp:=09The target temperature
+ * @max_allocatable_power:=09maximum allocatable power for this thermal zo=
ne
+ *
+ * This PI controller increases the available power budget so that the
+ * temperature of the thermal zone gets as close as possible to
+ * @control_temp and limits the power if it exceeds it.  k_po is the
+ * proportional term when we are overshooting, k_pu is the
+ * proportional term when we are undershooting.  integral_cutoff is a
+ * threshold below which we stop accumulating the error.  The
+ * accumulated error is only valid if the requested power will make
+ * the system warmer.  If the system is mostly idle, there's no point
+ * in accumulating positive error.
+ *
+ * It returns the power budget for the next period.
+ */
+static u32 pi_controller(struct thermal_zone_device *tz,
+=09=09=09unsigned long current_temp, unsigned long control_temp,
+=09=09=09unsigned long max_allocatable_power)
+{
+=09s64 p, i, power_range;
+=09s32 err;
+=09struct power_allocator_params *params =3D tz->governor_data;
+
+=09err =3D ((s32)control_temp - (s32)current_temp) / 1000;
+=09err =3D int_to_frac(err);
+
+=09/* Calculate the proportional term */
+=09p =3D mul_frac(err < 0 ? params->k_po : params->k_pu, err);
+
+=09/*
+=09 * Calculate the integral term
+=09 *
+=09 * if the error s less than cut off allow integration (but
+=09 * the integral is limited to max power)
+=09 */
+=09i =3D mul_frac(params->k_i, params->err_integral);
+
+=09if (err < int_to_frac(params->integral_cutoff)) {
+=09=09s64 tmpi =3D mul_frac(params->k_i, err);
+=09=09tmpi +=3D i;
+=09=09if (tmpi <=3D int_to_frac(max_allocatable_power)) {
+=09=09=09i =3D tmpi;
+=09=09=09params->err_integral +=3D err;
+=09=09}
+=09}
+
+=09power_range =3D p + i;
+
+=09/* feed-forward the known maximum dissipatable power */
+=09power_range =3D tz->tzp->max_dissipatable_power +
+=09=09frac_to_int(power_range);
+
+=09/* output should not exceed max power */
+=09if (power_range > max_allocatable_power)
+=09=09power_range =3D max_allocatable_power;
+
+=09return power_range >=3D 0 ? power_range : 0;
+}
+
+static void divvy_up_power(struct thermal_zone_device *tz,
+=09=09=09unsigned long req_power[MAX_NUM_ACTORS],
+=09=09=09unsigned long max_power[MAX_NUM_ACTORS],
+=09=09=09int num_actors, unsigned long total_req_power,
+=09=09=09u32 power_range,
+=09=09=09unsigned long granted_power[MAX_NUM_ACTORS])
+{
+=09unsigned long extra_power, capped_extra_power;
+=09unsigned long extra_actor_power[MAX_NUM_ACTORS];
+=09int i;
+
+=09if (!total_req_power) {
+=09=09/*
+=09=09 * Nobody requested anything, so just give everybody
+=09=09 * the maximum power
+=09=09 */
+=09=09for (i =3D 0; i < num_actors; i++)
+=09=09=09granted_power[i] =3D max_power[i];
+
+=09=09return;
+=09}
+
+=09capped_extra_power =3D 0;
+=09extra_power =3D 0;
+=09for (i =3D 0; i < num_actors; i++) {
+=09=09u64 req_range =3D req_power[i] * power_range;
+
+=09=09granted_power[i] =3D div_u64(req_range, total_req_power);
+
+=09=09if (granted_power[i] > max_power[i]) {
+=09=09=09extra_power +=3D granted_power[i] - max_power[i];
+=09=09=09granted_power[i] =3D max_power[i];
+=09=09}
+
+=09=09extra_actor_power[i] =3D max_power[i] - granted_power[i];
+=09=09capped_extra_power +=3D extra_actor_power[i];
+=09}
+
+=09if (!extra_power)
+=09=09return;
+
+=09/*
+=09 * Re-divvy the reclaimed extra among actors based on
+=09 * how far they are from the max
+=09 */
+=09extra_power =3D min(extra_power, capped_extra_power);
+=09if (capped_extra_power > 0)
+=09=09for (i =3D 0; i < num_actors; i++)
+=09=09=09granted_power[i] +=3D (extra_actor_power[i] *
+=09=09=09=09=09extra_power) / capped_extra_power;
+}
+
+static int allocate_power(struct thermal_zone_device *tz,
+=09=09=09unsigned long current_temp, unsigned long control_temp)
+{
+=09struct thermal_instance *instance;
+=09unsigned long req_power[MAX_NUM_ACTORS], max_power[MAX_NUM_ACTORS];
+=09unsigned long granted_power[MAX_NUM_ACTORS];
+=09unsigned long total_req_power, max_allocatable_power;
+=09u32 power_range;
+=09int i, num_actors, ret =3D 0;
+
+=09i =3D 0;
+=09total_req_power =3D 0;
+=09max_allocatable_power =3D 0;
+
+=09mutex_lock(&tz->lock);
+
+=09list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+=09=09struct thermal_cooling_device *cdev =3D instance->cdev;
+
+=09=09if (instance->trip !=3D TRIP_MAX_DESIRED_TEMPERATURE)
+=09=09=09continue;
+
+=09=09if (i >=3D MAX_NUM_ACTORS) {
+=09=09=09pr_warn("Too many actors (%d) for this governor\n", i);
+=09=09=09ret =3D -EINVAL;
+=09=09=09goto unlock;
+=09=09}
+
+=09=09ret =3D cdev->ops->get_cur(cdev, &req_power[i],
+=09=09=09=09=09THERMAL_UNIT_POWER);
+=09=09if (ret) {
+=09=09=09pr_warn_once("Couldn't get current power for %s: %d\n",
+=09=09=09=09cdev->type, ret);
+=09=09=09goto unlock;
+=09=09}
+
+=09=09total_req_power +=3D req_power[i];
+
+=09=09cdev->ops->get_max(cdev, &max_power[i], THERMAL_UNIT_POWER);
+=09=09max_allocatable_power +=3D max_power[i];
+
+=09=09i++;
+=09}
+=09num_actors =3D i;
+
+=09power_range =3D pi_controller(tz, current_temp, control_temp,
+=09=09=09=09max_allocatable_power);
+
+=09divvy_up_power(tz, req_power, max_power, num_actors, total_req_power,
+=09=09power_range, granted_power);
+
+=09i =3D 0;
+=09list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+=09=09struct thermal_cooling_device *cdev =3D instance->cdev;
+
+=09=09if (instance->trip !=3D TRIP_MAX_DESIRED_TEMPERATURE)
+=09=09=09continue;
+
+=09=09cdev->ops->set_cur(cdev, granted_power[i], THERMAL_UNIT_POWER);
+=09=09i++;
+=09}
+
+unlock:
+=09mutex_unlock(&tz->lock);
+
+=09return ret;
+}
+
+static int check_trips(struct thermal_zone_device *tz)
+{
+=09int ret;
+=09enum thermal_trip_type type;
+
+=09if (tz->trips < 2)
+=09=09return -EINVAL;
+
+=09ret =3D tz->ops->get_trip_type(tz, TRIP_SWITCH_ON, &type);
+=09if (ret)
+=09=09return ret;
+
+=09if ((type !=3D THERMAL_TRIP_PASSIVE) && (type !=3D THERMAL_TRIP_ACTIVE)=
)
+=09=09return -EINVAL;
+
+=09ret =3D tz->ops->get_trip_type(tz, TRIP_MAX_DESIRED_TEMPERATURE, &type)=
;
+=09if (ret)
+=09=09return ret;
+
+=09if ((type !=3D THERMAL_TRIP_PASSIVE) && (type !=3D THERMAL_TRIP_ACTIVE)=
)
+=09=09return -EINVAL;
+
+=09return ret;
+}
+
+static void reset_pi_controller(struct power_allocator_params *params)
+{
+=09params->err_integral =3D 0;
+}
+
+/**
+ * power_allocator_bind - bind the power_allocator governor to a thermal z=
one
+ * @tz:=09thermal zone to bind it to
+ *
+ * Check that the thermal zone is valid for this governor: has two
+ * thermal trips.  If so, initialize the PI controller parameters and
+ * bind it to the thermal zone.
+ *
+ * Returns 0 on success, -EINVAL if the trips were invalid or -ENOMEM
+ * if we ran out of memory.
+ */
+static int power_allocator_bind(struct thermal_zone_device *tz)
+{
+=09int ret;
+=09struct power_allocator_params *params;
+=09unsigned long switch_on_temp, control_temp;
+=09u32 temperature_threshold;
+
+=09ret =3D check_trips(tz);
+=09if (ret) {
+=09=09pr_err("thermal zone %s has the wrong number of trips for this gover=
nor\n",
+=09=09=09tz->type);
+=09=09return ret;
+=09}
+
+=09if (!tz->tzp || !tz->tzp->max_dissipatable_power) {
+=09=09pr_err("Trying to bind the power_allocator governor to a thermal zon=
e without the max_dissipatable_power parameter\n");
+=09=09return -EINVAL;
+=09}
+
+=09params =3D kzalloc(sizeof(*params), GFP_KERNEL);
+=09if (!params)
+=09=09return -ENOMEM;
+
+=09ret =3D tz->ops->get_trip_temp(tz, TRIP_SWITCH_ON, &switch_on_temp);
+=09if (ret)
+=09=09goto free;
+
+=09ret =3D tz->ops->get_trip_temp(tz, TRIP_MAX_DESIRED_TEMPERATURE,
+=09=09=09=09&control_temp);
+=09if (ret)
+=09=09goto free;
+
+=09temperature_threshold =3D (control_temp - switch_on_temp) / 1000;
+
+=09params->k_po =3D int_to_frac(tz->tzp->max_dissipatable_power) /
+=09=09temperature_threshold;
+=09params->k_pu =3D int_to_frac(2 * tz->tzp->max_dissipatable_power) /
+=09=09temperature_threshold;
+=09params->k_i =3D int_to_frac(1);
+=09params->integral_cutoff =3D 0;
+
+=09reset_pi_controller(params);
+
+=09tz->governor_data =3D params;
+=09return 0;
+
+free:
+=09kfree(params);
+=09return ret;
+}
+
+static void power_allocator_unbind(struct thermal_zone_device *tz)
+{
+=09pr_debug("Unbinding from thermal zone %d\n", tz->id);
+=09kfree(tz->governor_data);
+=09tz->governor_data =3D NULL;
+}
+
+static int power_allocator_throttle(struct thermal_zone_device *tz, int tr=
ip)
+{
+=09int ret;
+=09unsigned long switch_on_temp, control_temp, current_temp;
+=09struct power_allocator_params *params =3D tz->governor_data;
+
+=09/*
+=09 * We get called for every trip point but we only need to do
+=09 * our calculations once
+=09 */
+=09if (trip !=3D TRIP_MAX_DESIRED_TEMPERATURE)
+=09=09return 0;
+
+=09ret =3D thermal_zone_get_temp(tz, &current_temp);
+=09if (ret) {
+=09=09pr_warn("Failed to get temperature: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D tz->ops->get_trip_temp(tz, TRIP_SWITCH_ON, &switch_on_temp);
+=09if (ret) {
+=09=09pr_warn("Failed to get switch on temperature: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09if (current_temp < switch_on_temp) {
+=09=09reset_pi_controller(params);
+=09=09return 0;
+=09}
+
+=09ret =3D tz->ops->get_trip_temp(tz, TRIP_MAX_DESIRED_TEMPERATURE,
+=09=09=09=09&control_temp);
+=09if (ret) {
+=09=09pr_warn("Failed to get the maximum desired temperature: %d\n",
+=09=09=09ret);
+=09=09return ret;
+=09}
+
+=09return allocate_power(tz, current_temp, control_temp);
+}
+
+static struct thermal_governor thermal_gov_power_allocator =3D {
+=09.name=09=09=3D "power_allocator",
+=09.bind_to_tz=09=3D power_allocator_bind,
+=09.unbind_from_tz=09=3D power_allocator_unbind,
+=09.throttle=09=3D power_allocator_throttle,
+};
+
+int thermal_gov_power_allocator_register(void)
+{
+=09return thermal_register_governor(&thermal_gov_power_allocator);
+}
+
+void thermal_gov_power_allocator_unregister(void)
+{
+=09thermal_unregister_governor(&thermal_gov_power_allocator);
+}
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 1efaadf436fa..bed3d2ef8ef3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1840,7 +1840,11 @@ static int __init thermal_register_governors(void)
 =09if (result)
 =09=09return result;
=20
-=09return thermal_gov_user_space_register();
+=09result =3D thermal_gov_user_space_register();
+=09if (result)
+=09=09return result;
+
+=09return thermal_gov_power_allocator_register();
 }
=20
 static void thermal_unregister_governors(void)
@@ -1848,6 +1852,7 @@ static void thermal_unregister_governors(void)
 =09thermal_gov_step_wise_unregister();
 =09thermal_gov_fair_share_unregister();
 =09thermal_gov_user_space_unregister();
+=09thermal_gov_power_allocator_unregister();
 }
=20
 static int __init thermal_init(void)
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.=
h
index 3db339fb636f..b24cde2c71cc 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -77,6 +77,14 @@ static inline int thermal_gov_user_space_register(void) =
{ return 0; }
 static inline void thermal_gov_user_space_unregister(void) {}
 #endif /* CONFIG_THERMAL_GOV_USER_SPACE */
=20
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
+int thermal_gov_power_allocator_register(void);
+void thermal_gov_power_allocator_unregister(void);
+#else
+static inline int thermal_gov_power_allocator_register(void) { return 0; }
+static inline void thermal_gov_power_allocator_unregister(void) {}
+#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
+
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
 int of_parse_thermal_zones(void);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5986f546ca98..3861cb443520 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -57,6 +57,8 @@
 #define DEFAULT_THERMAL_GOVERNOR       "fair_share"
 #elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
 #define DEFAULT_THERMAL_GOVERNOR       "user_space"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
+#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
 #endif
=20
 extern struct list_head thermal_cdev_list;
@@ -250,6 +252,9 @@ struct thermal_zone_params {
=20
 =09int num_tbps;=09/* Number of tbp entries */
 =09struct thermal_bind_params *tbp;
+
+=09/* Maximum power (heat) that this thermal zone can dissipate in mW */
+=09u32 max_dissipatable_power;
 };
=20
 struct thermal_genl_event {
--=20
1.7.9.5


