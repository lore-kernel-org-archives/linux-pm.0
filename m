From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Tue, 3 Feb 2015 13:03:37 +0000
Message-ID: <20150203130336.GA2896@e104805>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
 <20150202235120.GC4855@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40850 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbbBCNED (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 08:04:03 -0500
Content-Disposition: inline
In-Reply-To: <20150202235120.GC4855@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, Feb 02, 2015 at 11:51:20PM +0000, Lina Iyer wrote:
> On Wed, Jan 28 2015 at 14:42 -0700, Javi Merino wrote:
> >The power allocator governor is a thermal governor that controls system
> >and device power allocation to control temperature.  Conceptually, the
> >implementation divides the sustainable power of a thermal zone among
> >all the heat sources in that zone.
> >
> >This governor relies on "power actors", entities that represent heat
> >sources.  They can report current and maximum power consumption and
> >can set a given maximum power consumption, usually via a cooling
> >device.
> >
> >The governor uses a Proportional Integral Derivative (PID) controller
> >driven by the temperature of the thermal zone.  The output of the
> >controller is a power budget that is then allocated to each power
> >actor that can have bearing on the temperature we are trying to
> >control.  It decides how much power to give each cooling device based
> >on the performance they are requesting.  The PID controller ensures
> >that the total power budget does not exceed the control temperature.
> >
> >Cc: Zhang Rui <rui.zhang@intel.com>
> >Cc: Eduardo Valentin <edubezval@gmail.com>
> >Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >Signed-off-by: Javi Merino <javi.merino@arm.com>
> >---
> > Documentation/thermal/power_allocator.txt | 241 +++++++++++++++
> > drivers/thermal/Kconfig                   |  15 +
> > drivers/thermal/Makefile                  |   1 +
> > drivers/thermal/power_allocator.c         | 478 ++++++++++++++++++++++++++++++
> > drivers/thermal/thermal_core.c            |   9 +-
> > drivers/thermal/thermal_core.h            |   8 +
> > include/linux/thermal.h                   |  37 ++-
> > 7 files changed, 782 insertions(+), 7 deletions(-)
> > create mode 100644 Documentation/thermal/power_allocator.txt
> > create mode 100644 drivers/thermal/power_allocator.c
> >
[...]
> >diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> >new file mode 100644
> >index 000000000000..c929143aee67
> >--- /dev/null
> >+++ b/drivers/thermal/power_allocator.c
> >@@ -0,0 +1,478 @@
> >+/*
> >+ * A power allocator to manage temperature
> >+ *
> >+ * Copyright (C) 2014 ARM Ltd.
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License version 2 as
> >+ * published by the Free Software Foundation.
> >+ *
> >+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> >+ * kind, whether express or implied; without even the implied warranty
> >+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >+ * GNU General Public License for more details.
> >+ */
> >+
> >+#define pr_fmt(fmt) "Power allocator: " fmt
> >+
> >+#include <linux/rculist.h>
> >+#include <linux/slab.h>
> >+#include <linux/thermal.h>
> >+
> >+#include "thermal_core.h"
> >+
> >+#define FRAC_BITS 10
> >+#define int_to_frac(x) ((x) << FRAC_BITS)
> >+#define frac_to_int(x) ((x) >> FRAC_BITS)
> >+
> >+/**
> >+ * mul_frac() - multiply two fixed-point numbers
> >+ * @x:        first multiplicand
> >+ * @y:        second multiplicand
> >+ *
> >+ * Return: the result of multiplying two fixed-point numbers.  The
> >+ * result is also a fixed-point number.
> >+ */
> >+static inline s64 mul_frac(s64 x, s64 y)
> >+{
> >+      return (x * y) >> FRAC_BITS;
> >+}
> >+
> >+enum power_allocator_trip_levels {
> >+      TRIP_SWITCH_ON = 0,     /* Switch on PID controller */
> >+      TRIP_MAX_DESIRED_TEMPERATURE, /* Temperature we are controlling for */
> >+
> >+      THERMAL_TRIP_NUM,
> >+};
> 
> This has to be exported for tz's to respond to the request. See below.
> 
> >+
> >+/**
> >+ * struct power_allocator_params - parameters for the power allocator governor
> >+ * @err_integral:     accumulated error in the PID controller.
> >+ * @prev_err: error in the previous iteration of the PID controller.
> >+ *            Used to calculate the derivative term.
> >+ */
> >+struct power_allocator_params {
> >+      s64 err_integral;
> >+      s32 prev_err;
> >+};
> >+
> >+/**
> >+ * pid_controller() - PID controller
> >+ * @tz:       thermal zone we are operating in
> >+ * @current_temp:     the current temperature in millicelsius
> >+ * @control_temp:     the target temperature in millicelsius
> >+ * @max_allocatable_power:    maximum allocatable power for this thermal zone
> >+ *
> >+ * This PID controller increases the available power budget so that the
> >+ * temperature of the thermal zone gets as close as possible to
> >+ * @control_temp and limits the power if it exceeds it.  k_po is the
> >+ * proportional term when we are overshooting, k_pu is the
> >+ * proportional term when we are undershooting.  integral_cutoff is a
> >+ * threshold below which we stop accumulating the error.  The
> >+ * accumulated error is only valid if the requested power will make
> >+ * the system warmer.  If the system is mostly idle, there's no point
> >+ * in accumulating positive error.
> >+ *
> >+ * Return: The power budget for the next period.
> >+ */
> >+static u32 pid_controller(struct thermal_zone_device *tz,
> >+                        unsigned long current_temp,
> >+                        unsigned long control_temp,
> >+                        u32 max_allocatable_power)
> >+{
> >+      s64 p, i, d, power_range;
> >+      s32 err, max_power_frac;
> >+      struct power_allocator_params *params = tz->governor_data;
> >+
> >+      max_power_frac = int_to_frac(max_allocatable_power);
> >+
> >+      err = ((s32)control_temp - (s32)current_temp);
> >+      err = int_to_frac(err);
> >+
> >+      /* Calculate the proportional term */
> >+      p = mul_frac(err < 0 ? tz->tzp->k_po : tz->tzp->k_pu, err);
> >+
> >+      /*
> >+       * Calculate the integral term
> >+       *
> >+       * if the error is less than cut off allow integration (but
> >+       * the integral is limited to max power)
> >+       */
> >+      i = mul_frac(tz->tzp->k_i, params->err_integral);
> >+
> >+      if (err < int_to_frac(tz->tzp->integral_cutoff)) {
> >+              s64 i_next = i + mul_frac(tz->tzp->k_i, err);
> >+
> >+              if (abs64(i_next) < max_power_frac) {
> >+                      i = i_next;
> >+                      params->err_integral += err;
> >+              }
> >+      }
> >+
> >+      /*
> >+       * Calculate the derivative term
> >+       *
> >+       * We do err - prev_err, so with a positive k_d, a decreasing
> >+       * error (i.e. driving closer to the line) results in less
> >+       * power being applied, slowing down the controller)
> >+       */
> >+      d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> >+      params->prev_err = err;
> >+
> >+      power_range = p + i + d;
> >+
> >+      /* feed-forward the known sustainable dissipatable power */
> >+      power_range = tz->tzp->sustainable_power + frac_to_int(power_range);
> >+
> >+      return clamp(power_range, (s64)0, (s64)max_allocatable_power);
> >+}
> >+
> >+/**
> >+ * divvy_up_power() - divvy the allocated power between the actors
> >+ * @req_power:        each actor's requested power
> >+ * @max_power:        each actor's maximum available power
> >+ * @num_actors:       size of the @req_power, @max_power and @granted_power's array
> >+ * @total_req_power: sum of @req_power
> >+ * @power_range:      total allocated power
> >+ * @granted_power:    output array: each actor's granted power
> >+ *
> >+ * This function divides the total allocated power (@power_range)
> >+ * fairly between the actors.  It first tries to give each actor a
> >+ * share of the @power_range according to how much power it requested
> >+ * compared to the rest of the actors.  For example, if only one actor
> >+ * requests power, then it receives all the @power_range.  If
> >+ * three actors each requests 1mW, each receives a third of the
> >+ * @power_range.
> >+ *
> >+ * If any actor received more than their maximum power, then that
> >+ * surplus is re-divvied among the actors based on how far they are
> >+ * from their respective maximums.
> >+ *
> >+ * Granted power for each actor is written to @granted_power, which
> >+ * should've been allocated by the calling function.
> >+ */
> >+static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
> >+                         u32 total_req_power, u32 power_range,
> >+                         u32 *granted_power)
> >+{
> >+      u32 extra_power, capped_extra_power, extra_actor_power[num_actors];
> >+      int i;
> >+
> >+      /*
> >+       * Prevent division by 0 if none of the actors request power.
> >+       */
> >+      if (!total_req_power)
> >+              total_req_power = 1;
> >+
> >+      capped_extra_power = 0;
> >+      extra_power = 0;
> >+      for (i = 0; i < num_actors; i++) {
> >+              u64 req_range = req_power[i] * power_range;
> >+
> >+              granted_power[i] = div_u64(req_range, total_req_power);
> >+
> >+              if (granted_power[i] > max_power[i]) {
> >+                      extra_power += granted_power[i] - max_power[i];
> >+                      granted_power[i] = max_power[i];
> >+              }
> >+
> >+              extra_actor_power[i] = max_power[i] - granted_power[i];
> >+              capped_extra_power += extra_actor_power[i];
> >+      }
> >+
> >+      if (!extra_power)
> >+              return;
> >+
> >+      /*
> >+       * Re-divvy the reclaimed extra among actors based on
> >+       * how far they are from the max
> >+       */
> >+      extra_power = min(extra_power, capped_extra_power);
> >+      if (capped_extra_power > 0)
> >+              for (i = 0; i < num_actors; i++)
> >+                      granted_power[i] += (extra_actor_power[i] *
> >+                                      extra_power) / capped_extra_power;
> >+}
> >+
> >+static int allocate_power(struct thermal_zone_device *tz,
> >+                        unsigned long current_temp,
> >+                        unsigned long control_temp)
> >+{
> >+      struct thermal_instance *instance;
> >+      u32 *req_power, *max_power, *granted_power;
> >+      u32 total_req_power, max_allocatable_power;
> >+      u32 power_range;
> >+      int i, num_actors, ret = 0;
> >+
> >+      mutex_lock(&tz->lock);
> >+
> >+      num_actors = 0;
> >+      list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> >+              if ((instance->trip == TRIP_MAX_DESIRED_TEMPERATURE) &&
> >+                  cdev_is_power_actor(instance->cdev))
> >+                      num_actors++;
> >+
> >+      req_power = devm_kcalloc(&tz->device, num_actors, sizeof(*req_power),
> >+                               GFP_KERNEL);
> >+      if (!req_power) {
> >+              ret = -ENOMEM;
> >+              goto unlock;
> >+      }
> >+
> >+      max_power = devm_kcalloc(&tz->device, num_actors, sizeof(*max_power),
> >+                               GFP_KERNEL);
> >+      if (!max_power) {
> >+              ret = -ENOMEM;
> >+              goto free_req_power;
> >+      }
> >+
> >+      granted_power = devm_kcalloc(&tz->device, num_actors,
> >+                                   sizeof(*granted_power), GFP_KERNEL);
> >+      if (!granted_power) {
> >+              ret = -ENOMEM;
> >+              goto free_max_power;
> >+      }
> 
> You could optimize this allocation by allocating them together and then
> using an offset to get max_power and granted_power from req_power.

Makes sense, I've changed it to: 

	/*
	 * We need to allocate three arrays of the same size:
	 * req_power, max_power and granted_power.  They are going to
	 * be needed until this function returns.  Allocate them all
	 * in one go to simplify the allocation and deallocation
	 * logic.
	 */
	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*max_power));
	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*granted_power));
	req_power = devm_kcalloc(&tz->device, num_actors * 3,
				 sizeof(*req_power), GFP_KERNEL);
	if (!req_power) {
		ret = -ENOMEM;
		goto unlock;
	}

	max_power = &req_power[num_actors];
	granted_power = &req_power[2 * num_actors];

> >+
> >+      i = 0;
> >+      total_req_power = 0;
> >+      max_allocatable_power = 0;
> >+
> >+      list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> >+              struct thermal_cooling_device *cdev = instance->cdev;
> >+
> >+              if (instance->trip != TRIP_MAX_DESIRED_TEMPERATURE)
> >+                      continue;
> >+
> >+              if (!cdev_is_power_actor(cdev))
> >+                      continue;
> >+
> >+              if (cdev->ops->get_requested_power(cdev, tz, &req_power[i]))
> >+                      continue;
> >+
> >+              req_power[i] = frac_to_int(instance->weight * req_power[i]);
> >+
> >+              if (power_actor_get_max_power(cdev, tz, &max_power[i]))
> >+                      continue;
> >+
> >+              total_req_power += req_power[i];
> >+              max_allocatable_power += max_power[i];
> >+
> >+              i++;
> >+      }
> >+
> >+      power_range = pid_controller(tz, current_temp, control_temp,
> >+                                   max_allocatable_power);
> >+
> >+      divvy_up_power(req_power, max_power, num_actors, total_req_power,
> >+                     power_range, granted_power);
> >+
> >+      i = 0;
> >+      list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> >+              if (instance->trip != TRIP_MAX_DESIRED_TEMPERATURE)
> >+                      continue;
> >+
> >+              if (!cdev_is_power_actor(instance->cdev))
> >+                      continue;
> >+
> >+              power_actor_set_power(instance->cdev, instance,
> >+                                    granted_power[i]);
> >+
> >+              i++;
> >+      }
> >+
> >+      devm_kfree(&tz->device, granted_power);
> >+free_max_power:
> >+      devm_kfree(&tz->device, max_power);
> >+free_req_power:
> >+      devm_kfree(&tz->device, req_power);
> >+unlock:
> >+      mutex_unlock(&tz->lock);
> >+
> >+      return ret;
> >+}
> >+
> >+static int check_trips(struct thermal_zone_device *tz)
> >+{
> >+      int ret;
> >+      enum thermal_trip_type type;
> >+
> >+      if (tz->trips < THERMAL_TRIP_NUM)
> >+              return -EINVAL;
> >+
> >+      ret = tz->ops->get_trip_type(tz, TRIP_SWITCH_ON, &type);
> >+      if (ret)
> >+              return ret;
> 
> TZ should be able to correctly enumerate the value of this definition in
> their driver.

Right, drivers can use this enum so it should be in a header that they
can include.  I've moved the "enum power_allocator_trip_levels"
definition to thermal.h .  I considered drivers/thermal/thermal_core.h
but no drivers include that so it's probably not the right place
(others can correct me if I'm wrong).

Cheers,
Javi

> I dont think anymore, this should be a enum thermal_trip_type, but it has to be
> generic across governors.
> 
> 
> Thanks,
> Lina
