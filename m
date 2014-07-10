From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v5 08/10] thermal: introduce the Power Allocator governor
Date: Thu, 10 Jul 2014 15:18:46 +0100
Message-ID: <1405001928-12697-9-git-send-email-javi.merino@arm.com>
References: <1405001928-12697-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405001928-12697-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

The power allocator governor is a thermal governor that controls system
and device power allocation to control temperature.  Conceptually, the
implementation divides the sustainable power of a thermal zone among
all the heat sources in that zone.

This governor relies on "power actors", entities that represent heat
sources.  They can report current and maximum power consumption and
can set a given maximum power consumption, usually via a cooling
device.

The governor uses a Proportional Integral Derivative (PID) controller
driven by the temperature of the thermal zone.  The output of the
controller is a power budget that is then allocated to each power
actor that can have bearing on the temperature we are trying to
control.  It decides how much power to give each cooling device based
on the performance they are requesting.  The PID controller ensures
that the total power budget does not exceed the control temperature.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/power_allocator.txt |  61 ++++
 drivers/thermal/Kconfig                   |  15 +
 drivers/thermal/Makefile                  |   1 +
 drivers/thermal/power_allocator.c         | 467 ++++++++++++++++++++++++++=
++++
 drivers/thermal/thermal_core.c            |   7 +-
 drivers/thermal/thermal_core.h            |   8 +
 include/linux/thermal.h                   |   8 +
 7 files changed, 566 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/thermal/power_allocator.txt
 create mode 100644 drivers/thermal/power_allocator.c

diff --git a/Documentation/thermal/power_allocator.txt b/Documentation/ther=
mal/power_allocator.txt
new file mode 100644
index 000000000000..1859074dadcb
--- /dev/null
+++ b/Documentation/thermal/power_allocator.txt
@@ -0,0 +1,61 @@
+Integration of the power_allocator governor in a platform
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+Registering thermal_zone_device
+-------------------------------
+
+An estimate of the sustainable dissipatable power (in mW) should be
+provided while registering the thermal zone.  This is the maximum
+sustained power for allocation at the desired maximum temperature.
+This number can vary for different conditions, but the closed-loop of
+the controller should take care of those variations, the
+`sustainable_power` should be an estimation of it.  Register your
+thermal zone with `thermal_zone_params` that have a
+`sustainable_power`.  If you weren't passing any
+`thermal_zone_params`, then something like this will do:
+
+=09static const struct thermal_zone_params tz_params =3D {
+=09=09.sustainable_power =3D 3500,
+=09};
+
+and then pass `tz_params` as the 5th parameter to
+`thermal_zone_device_register()`
+
+Trip points
+-----------
+
+The governor requires the following two trip points:
+
+1.  "switch on" trip point: temperature above which the governor
+    control loop starts operating
+2.  "desired temperature" trip point: it should be higher than the
+    "switch on" trip point. It is the target temperature the governor
+    is controlling for.
+
+The trip points can be either active or passive.
+
+Power actors
+------------
+
+Devices controlled by this governor must be registered with the power
+actor API.  Read `power_actor.txt` for more information about them.
+
+Limitations of the power allocator governor
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The power allocator governor can't work with cooling devices directly.
+A power actor can be created to interface between the governor and the
+cooling device (see cpu_actor.c for an example).  Otherwise, if you
+have power actors and cooling devices that are next to the same
+thermal sensor create two thermal zones, one for each type.  Use the
+power allocator governor for the power actor thermal zone with the
+power actors and any other governor for the one with cooling devices.
+
+The power allocator governor's PID controller is highly dependent on a
+periodic tick.  If you have a driver that calls
+`thermal_zone_device_update()` (or anything that ends up calling the
+governor's `throttle()` function) repetitively, the governor response
+won't be very good.  Note that this is not particular to this
+governor, step-wise will also misbehave if you call its throttle()
+faster than the normal thermal framework tick (due to interrupts for
+example) as it will overreact.
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 249b196deffd..0e76c0dab5f3 100644
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
+=09  power actors to operate.
+
 endchoice
=20
 config THERMAL_GOV_FAIR_SHARE
@@ -89,6 +97,13 @@ config THERMAL_GOV_USER_SPACE
 =09help
 =09  Enable this to let the user space manage the platform thermals.
=20
+config THERMAL_GOV_POWER_ALLOCATOR
+=09bool "Power allocator thermal governor"
+=09select THERMAL_POWER_ACTOR
+=09help
+=09  Enable this to manage platform thermals by dynamically
+=09  allocating and limiting power to devices.
+
 config THERMAL_POWER_ACTOR
 =09bool
=20
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 74f97c90a46c..e74d57d0fe61 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_OF)=09=09+=3D of-thermal.o
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)=09+=3D fair_share.o
 thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)=09+=3D step_wise.o
 thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)=09+=3D user_space.o
+thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)=09+=3D power_allocator.o
=20
 # power actors
 obj-$(CONFIG_THERMAL_POWER_ACTOR) +=3D power_actor.o
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allo=
cator.c
new file mode 100644
index 000000000000..eb1797cd859b
--- /dev/null
+++ b/drivers/thermal/power_allocator.c
@@ -0,0 +1,467 @@
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
+#include <linux/power_actor.h>
+#include <linux/rculist.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define FRAC_BITS 8
+#define int_to_frac(x) ((x) << FRAC_BITS)
+#define frac_to_int(x) ((x) >> FRAC_BITS)
+
+/**
+ * mul_frac() - multiply two fixed-point numbers
+ * @x:=09first multiplicand
+ * @y:=09second multiplicand
+ *
+ * Return: the result of multiplying two fixed-point numbers.  The
+ * result is also a fixed-point number.
+ */
+static inline s64 mul_frac(s64 x, s64 y)
+{
+=09return (x * y) >> FRAC_BITS;
+}
+
+enum power_allocator_trip_levels {
+=09TRIP_SWITCH_ON =3D 0,=09/* Switch on PID controller */
+=09TRIP_MAX_DESIRED_TEMPERATURE, /* Temperature we are controlling for */
+};
+
+/**
+ * struct power_allocator_params - parameters for the power allocator gove=
rnor
+ * @k_po:=09Proportional parameter of the PID controller when overshooting
+ *=09=09(i.e., when temperature is below the target)
+ * @k_pi:=09Proportional parameter of the PID controller when undershootin=
g
+ * @k_i:=09Integral parameter of the PID controller
+ * @k_d:=09Derivative parameter of the PID controller
+ * @integral_cutoff:=09threshold below which the error is no longer accumu=
lated
+=09=09=09in the PID controller
+ * @err_integral:=09accumulated error in the PID controller.
+ * @prev_err:=09error in the previous iteration of the PID controller.
+ *=09=09Used to calculate the derivative term.
+ */
+struct power_allocator_params {
+=09s32 k_po;
+=09s32 k_pu;
+=09s32 k_i;
+=09s32 k_d;
+=09s32 integral_cutoff;
+=09s32 err_integral;
+=09s32 prev_err;
+};
+
+/**
+ * pid_controller() - PID controller
+ * @tz:=09thermal zone we are operating in
+ * @current_temp:=09the current temperature
+ * @control_temp:=09the target temperature
+ * @max_allocatable_power:=09maximum allocatable power for this thermal zo=
ne
+ *
+ * This PID controller increases the available power budget so that the
+ * temperature of the thermal zone gets as close as possible to
+ * @control_temp and limits the power if it exceeds it.  k_po is the
+ * proportional term when we are overshooting, k_pu is the
+ * proportional term when we are undershooting.  integral_cutoff is a
+ * threshold below which we stop accumulating the error.  The
+ * accumulated error is only valid if the requested power will make
+ * the system warmer.  If the system is mostly idle, there's no point
+ * in accumulating positive error.
+ *
+ * Return: The power budget for the next period.
+ */
+static u32 pid_controller(struct thermal_zone_device *tz,
+=09=09=09unsigned long current_temp, unsigned long control_temp,
+=09=09=09u32 max_allocatable_power)
+{
+=09s64 p, i, d, power_range;
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
+
+=09=09tmpi +=3D i;
+=09=09if (tmpi <=3D int_to_frac(max_allocatable_power)) {
+=09=09=09i =3D tmpi;
+=09=09=09params->err_integral +=3D err;
+=09=09}
+=09}
+
+=09/*
+=09 * Calculate the derivative term
+=09 *
+=09 * We do err - prev_err, so with a positive k_d, a decreasing
+=09 * error (i.e. driving closer to the line) results in less
+=09 * power being applied, slowing down the controller)
+=09 */
+=09d =3D mul_frac(params->k_d, err - params->prev_err);
+=09params->prev_err =3D err;
+
+=09power_range =3D p + i + d;
+
+=09/* feed-forward the known sustainable dissipatable power */
+=09power_range =3D tz->tzp->sustainable_power + frac_to_int(power_range);
+
+=09return clamp(power_range, (s64)0, (s64)max_allocatable_power);
+}
+
+/**
+ * divvy_up_power() - divvy the allocated power between the actors
+ * @req_power:=09each actor's requested power
+ * @max_power:=09each actor's maximum available power
+ * @num_actors:=09size of the @req_power, @max_power and @granted_power's =
array
+ * @total_req_power: sum of @req_power
+ * @power_range:=09total allocated power
+ * @granted_power:=09ouput array: each actor's granted power
+ *
+ * This function divides the total allocated power (@power_range)
+ * fairly between the actors.  It first tries to give each actor a
+ * share of the @power_range according to how much power it requested
+ * compared to the rest of the actors.  For example, if only one actor
+ * requests power, then it receives all the @power_range.  If
+ * three actors each requests 1mW, each receives a third of the
+ * @power_range.
+ *
+ * If any actor received more than their maximum power, then that
+ * surplus is re-divvied among the actors based on how far they are
+ * from their respective maximums.
+ *
+ * Granted power for each actor is written to @granted_power, which
+ * should've been allocated by the calling function.
+ */
+static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
+=09=09=09u32 total_req_power, u32 power_range,
+=09=09=09u32 *granted_power)
+{
+=09u32 extra_power, capped_extra_power, extra_actor_power[num_actors];
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
+=09struct power_actor *actor;
+=09u32 *req_power, *max_power, *granted_power;
+=09u32 total_req_power, max_allocatable_power;
+=09u32 power_range;
+=09int i, num_actors, ret =3D 0;
+
+=09mutex_lock(&tz->lock);
+=09rcu_read_lock();
+
+=09num_actors =3D 0;
+=09list_for_each_entry_rcu(actor, &actor_list, actor_node)
+=09=09num_actors++;
+
+=09req_power =3D devm_kcalloc(&tz->device, num_actors, sizeof(*req_power),
+=09=09=09=09GFP_KERNEL);
+=09if (!req_power) {
+=09=09ret =3D -ENOMEM;
+=09=09goto unlock;
+=09}
+
+=09max_power =3D devm_kcalloc(&tz->device, num_actors, sizeof(*max_power),
+=09=09=09=09GFP_KERNEL);
+=09if (!max_power) {
+=09=09ret =3D -ENOMEM;
+=09=09goto free_req_power;
+=09}
+
+=09granted_power =3D devm_kcalloc(&tz->device, num_actors,
+=09=09=09=09sizeof(*granted_power), GFP_KERNEL);
+=09if (!granted_power) {
+=09=09ret =3D -ENOMEM;
+=09=09goto free_max_power;
+=09}
+
+=09i =3D 0;
+=09total_req_power =3D 0;
+=09max_allocatable_power =3D 0;
+
+=09list_for_each_entry_rcu(actor, &actor_list, actor_node) {
+=09=09req_power[i] =3D actor->ops->get_req_power(actor, tz);
+=09=09total_req_power +=3D req_power[i];
+
+=09=09max_power[i] =3D actor->ops->get_max_power(actor, tz);
+=09=09max_allocatable_power +=3D max_power[i];
+
+=09=09i++;
+=09}
+
+=09power_range =3D pid_controller(tz, current_temp, control_temp,
+=09=09=09=09max_allocatable_power);
+
+=09divvy_up_power(req_power, max_power, num_actors, total_req_power,
+=09=09power_range, granted_power);
+
+=09i =3D 0;
+=09list_for_each_entry_rcu(actor, &actor_list, actor_node) {
+=09=09actor->ops->set_power(actor, tz, granted_power[i]);
+=09=09i++;
+=09}
+
+=09devm_kfree(&tz->device, granted_power);
+free_max_power:
+=09devm_kfree(&tz->device, max_power);
+free_req_power:
+=09devm_kfree(&tz->device, req_power);
+unlock:
+=09rcu_read_unlock();
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
+static void reset_pid_controller(struct power_allocator_params *params)
+{
+=09params->err_integral =3D 0;
+=09params->prev_err =3D 0;
+}
+
+static void allow_maximum_power(struct thermal_zone_device *tz)
+{
+=09struct power_actor *actor;
+
+=09rcu_read_lock();
+
+=09list_for_each_entry_rcu(actor, &actor_list, actor_node) {
+=09=09u32 max_power =3D actor->ops->get_max_power(actor, tz);
+
+=09=09actor->ops->set_power(actor, tz, max_power);
+=09}
+
+=09rcu_read_unlock();
+}
+
+/**
+ * power_allocator_bind() - bind the power_allocator governor to a thermal=
 zone
+ * @tz:=09thermal zone to bind it to
+ *
+ * Check that the thermal zone is valid for this governor, that is, it
+ * has two thermal trips.  If so, initialize the PID controller
+ * parameters and bind it to the thermal zone.
+ *
+ * Return: 0 on success, -EINVAL if the trips were invalid or -ENOMEM
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
+=09=09dev_err(&tz->device,
+=09=09=09"thermal zone %s has the wrong number of trips for this governor\=
n",
+=09=09=09tz->type);
+=09=09return ret;
+=09}
+
+=09if (!tz->tzp || !tz->tzp->sustainable_power) {
+=09=09dev_err(&tz->device,
+=09=09=09"power_allocator: missing sustainable_power\n");
+=09=09return -EINVAL;
+=09}
+
+=09params =3D devm_kzalloc(&tz->device, sizeof(*params), GFP_KERNEL);
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
+=09params->k_po =3D int_to_frac(tz->tzp->sustainable_power) /
+=09=09temperature_threshold;
+=09params->k_pu =3D int_to_frac(2 * tz->tzp->sustainable_power) /
+=09=09temperature_threshold;
+=09params->k_i =3D int_to_frac(1);
+=09params->k_d =3D int_to_frac(0);
+=09params->integral_cutoff =3D 0;
+
+=09reset_pid_controller(params);
+
+=09tz->governor_data =3D params;
+
+=09return 0;
+
+free:
+=09devm_kfree(&tz->device, params);
+=09return ret;
+}
+
+static void power_allocator_unbind(struct thermal_zone_device *tz)
+{
+=09dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
+=09devm_kfree(&tz->device, tz->governor_data);
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
+=09=09dev_warn(&tz->device, "Failed to get temperature: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D tz->ops->get_trip_temp(tz, TRIP_SWITCH_ON, &switch_on_temp);
+=09if (ret) {
+=09=09dev_warn(&tz->device,
+=09=09=09"Failed to get switch on temperature: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09if (current_temp < switch_on_temp) {
+=09=09tz->passive =3D 0;
+=09=09reset_pid_controller(params);
+=09=09allow_maximum_power(tz);
+=09=09return 0;
+=09}
+
+=09tz->passive =3D 1;
+
+=09ret =3D tz->ops->get_trip_temp(tz, TRIP_MAX_DESIRED_TEMPERATURE,
+=09=09=09=09&control_temp);
+=09if (ret) {
+=09=09dev_warn(&tz->device,
+=09=09=09"Failed to get the maximum desired temperature: %d\n",
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
index 3da99dd80ad5..1415d3d8a9eb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1857,7 +1857,11 @@ static int __init thermal_register_governors(void)
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
@@ -1865,6 +1869,7 @@ static void thermal_unregister_governors(void)
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
index 1124b7a9358a..e01141261756 100644
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
 struct thermal_zone_device;
@@ -287,6 +289,12 @@ struct thermal_zone_params {
=20
 =09int num_tbps;=09/* Number of tbp entries */
 =09struct thermal_bind_params *tbp;
+
+=09/*
+=09 * Sustainable power (heat) that this thermal zone can dissipate in
+=09 * mW
+=09 */
+=09u32 sustainable_power;
 };
=20
 struct thermal_genl_event {
--=20
1.9.1
