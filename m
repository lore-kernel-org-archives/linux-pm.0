From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Tue, 3 Feb 2015 00:31:03 -0400
Message-ID: <20150203043102.GG17425@developer.hsd1.ca.comcast.net>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
 <20150202235120.GC4855@linaro.org>
 <20150203130336.GA2896@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64666 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbbBCPaO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 10:30:14 -0500
Content-Disposition: inline
In-Reply-To: <20150203130336.GA2896@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 01:03:37PM +0000, Javi Merino wrote:
> On Mon, Feb 02, 2015 at 11:51:20PM +0000, Lina Iyer wrote:
> > On Wed, Jan 28 2015 at 14:42 -0700, Javi Merino wrote:
> > >The power allocator governor is a thermal governor that controls system
> > >and device power allocation to control temperature.  Conceptually, the
> > >implementation divides the sustainable power of a thermal zone among
> > >all the heat sources in that zone.
> > >
> > >This governor relies on "power actors", entities that represent heat
> > >sources.  They can report current and maximum power consumption and
> > >can set a given maximum power consumption, usually via a cooling
> > >device.
> > >
> > >The governor uses a Proportional Integral Derivative (PID) controller
> > >driven by the temperature of the thermal zone.  The output of the
> > >controller is a power budget that is then allocated to each power
> > >actor that can have bearing on the temperature we are trying to
> > >control.  It decides how much power to give each cooling device based
> > >on the performance they are requesting.  The PID controller ensures
> > >that the total power budget does not exceed the control temperature.
> > >
> > >Cc: Zhang Rui <rui.zhang@intel.com>
> > >Cc: Eduardo Valentin <edubezval@gmail.com>
> > >Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > >Signed-off-by: Javi Merino <javi.merino@arm.com>
> > >---
> > > Documentation/thermal/power_allocator.txt | 241 +++++++++++++++
> > > drivers/thermal/Kconfig                   |  15 +
> > > drivers/thermal/Makefile                  |   1 +
> > > drivers/thermal/power_allocator.c         | 478 +++++++++++++++++++++=
+++++++++
> > > drivers/thermal/thermal_core.c            |   9 +-
> > > drivers/thermal/thermal_core.h            |   8 +
> > > include/linux/thermal.h                   |  37 ++-
> > > 7 files changed, 782 insertions(+), 7 deletions(-)
> > > create mode 100644 Documentation/thermal/power_allocator.txt
> > > create mode 100644 drivers/thermal/power_allocator.c
> > >
> [...]
> > >diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power=
_allocator.c
> > >new file mode 100644
> > >index 000000000000..c929143aee67
> > >--- /dev/null
> > >+++ b/drivers/thermal/power_allocator.c
> > >@@ -0,0 +1,478 @@
> > >+/*
> > >+ * A power allocator to manage temperature
> > >+ *
> > >+ * Copyright (C) 2014 ARM Ltd.
> > >+ *
> > >+ * This program is free software; you can redistribute it and/or modi=
fy
> > >+ * it under the terms of the GNU General Public License version 2 as
> > >+ * published by the Free Software Foundation.
> > >+ *
> > >+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > >+ * kind, whether express or implied; without even the implied warranty
> > >+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > >+ * GNU General Public License for more details.
> > >+ */
> > >+
> > >+#define pr_fmt(fmt) "Power allocator: " fmt
> > >+
> > >+#include <linux/rculist.h>
> > >+#include <linux/slab.h>
> > >+#include <linux/thermal.h>
> > >+
> > >+#include "thermal_core.h"
> > >+
> > >+#define FRAC_BITS 10
> > >+#define int_to_frac(x) ((x) << FRAC_BITS)
> > >+#define frac_to_int(x) ((x) >> FRAC_BITS)
> > >+
> > >+/**
> > >+ * mul_frac() - multiply two fixed-point numbers
> > >+ * @x:        first multiplicand
> > >+ * @y:        second multiplicand
> > >+ *
> > >+ * Return: the result of multiplying two fixed-point numbers.  The
> > >+ * result is also a fixed-point number.
> > >+ */
> > >+static inline s64 mul_frac(s64 x, s64 y)
> > >+{
> > >+      return (x * y) >> FRAC_BITS;
> > >+}
> > >+
> > >+enum power_allocator_trip_levels {
> > >+      TRIP_SWITCH_ON =3D 0,     /* Switch on PID controller */
> > >+      TRIP_MAX_DESIRED_TEMPERATURE, /* Temperature we are controlling=
 for */
> > >+
> > >+      THERMAL_TRIP_NUM,
> > >+};
> >=20
> > This has to be exported for tz's to respond to the request. See below.
> >=20
> > >+
> > >+/**
> > >+ * struct power_allocator_params - parameters for the power allocator=
 governor
> > >+ * @err_integral:     accumulated error in the PID controller.
> > >+ * @prev_err: error in the previous iteration of the PID controller.
> > >+ *            Used to calculate the derivative term.
> > >+ */
> > >+struct power_allocator_params {
> > >+      s64 err_integral;
> > >+      s32 prev_err;
> > >+};
> > >+
> > >+/**
> > >+ * pid_controller() - PID controller
> > >+ * @tz:       thermal zone we are operating in
> > >+ * @current_temp:     the current temperature in millicelsius
> > >+ * @control_temp:     the target temperature in millicelsius
> > >+ * @max_allocatable_power:    maximum allocatable power for this ther=
mal zone
> > >+ *
> > >+ * This PID controller increases the available power budget so that t=
he
> > >+ * temperature of the thermal zone gets as close as possible to
> > >+ * @control_temp and limits the power if it exceeds it.  k_po is the
> > >+ * proportional term when we are overshooting, k_pu is the
> > >+ * proportional term when we are undershooting.  integral_cutoff is a
> > >+ * threshold below which we stop accumulating the error.  The
> > >+ * accumulated error is only valid if the requested power will make
> > >+ * the system warmer.  If the system is mostly idle, there's no point
> > >+ * in accumulating positive error.
> > >+ *
> > >+ * Return: The power budget for the next period.
> > >+ */
> > >+static u32 pid_controller(struct thermal_zone_device *tz,
> > >+                        unsigned long current_temp,
> > >+                        unsigned long control_temp,
> > >+                        u32 max_allocatable_power)
> > >+{
> > >+      s64 p, i, d, power_range;
> > >+      s32 err, max_power_frac;
> > >+      struct power_allocator_params *params =3D tz->governor_data;
> > >+
> > >+      max_power_frac =3D int_to_frac(max_allocatable_power);
> > >+
> > >+      err =3D ((s32)control_temp - (s32)current_temp);
> > >+      err =3D int_to_frac(err);
> > >+
> > >+      /* Calculate the proportional term */
> > >+      p =3D mul_frac(err < 0 ? tz->tzp->k_po : tz->tzp->k_pu, err);
> > >+
> > >+      /*
> > >+       * Calculate the integral term
> > >+       *
> > >+       * if the error is less than cut off allow integration (but
> > >+       * the integral is limited to max power)
> > >+       */
> > >+      i =3D mul_frac(tz->tzp->k_i, params->err_integral);
> > >+
> > >+      if (err < int_to_frac(tz->tzp->integral_cutoff)) {
> > >+              s64 i_next =3D i + mul_frac(tz->tzp->k_i, err);
> > >+
> > >+              if (abs64(i_next) < max_power_frac) {
> > >+                      i =3D i_next;
> > >+                      params->err_integral +=3D err;
> > >+              }
> > >+      }
> > >+
> > >+      /*
> > >+       * Calculate the derivative term
> > >+       *
> > >+       * We do err - prev_err, so with a positive k_d, a decreasing
> > >+       * error (i.e. driving closer to the line) results in less
> > >+       * power being applied, slowing down the controller)
> > >+       */
> > >+      d =3D mul_frac(tz->tzp->k_d, err - params->prev_err);
> > >+      params->prev_err =3D err;
> > >+
> > >+      power_range =3D p + i + d;
> > >+
> > >+      /* feed-forward the known sustainable dissipatable power */
> > >+      power_range =3D tz->tzp->sustainable_power + frac_to_int(power_=
range);
> > >+
> > >+      return clamp(power_range, (s64)0, (s64)max_allocatable_power);
> > >+}
> > >+
> > >+/**
> > >+ * divvy_up_power() - divvy the allocated power between the actors
> > >+ * @req_power:        each actor's requested power
> > >+ * @max_power:        each actor's maximum available power
> > >+ * @num_actors:       size of the @req_power, @max_power and @granted=
_power's array
> > >+ * @total_req_power: sum of @req_power
> > >+ * @power_range:      total allocated power
> > >+ * @granted_power:    output array: each actor's granted power
> > >+ *
> > >+ * This function divides the total allocated power (@power_range)
> > >+ * fairly between the actors.  It first tries to give each actor a
> > >+ * share of the @power_range according to how much power it requested
> > >+ * compared to the rest of the actors.  For example, if only one actor
> > >+ * requests power, then it receives all the @power_range.  If
> > >+ * three actors each requests 1mW, each receives a third of the
> > >+ * @power_range.
> > >+ *
> > >+ * If any actor received more than their maximum power, then that
> > >+ * surplus is re-divvied among the actors based on how far they are
> > >+ * from their respective maximums.
> > >+ *
> > >+ * Granted power for each actor is written to @granted_power, which
> > >+ * should've been allocated by the calling function.
> > >+ */
> > >+static void divvy_up_power(u32 *req_power, u32 *max_power, int num_ac=
tors,
> > >+                         u32 total_req_power, u32 power_range,
> > >+                         u32 *granted_power)
> > >+{
> > >+      u32 extra_power, capped_extra_power, extra_actor_power[num_acto=
rs];
> > >+      int i;
> > >+
> > >+      /*
> > >+       * Prevent division by 0 if none of the actors request power.
> > >+       */
> > >+      if (!total_req_power)
> > >+              total_req_power =3D 1;
> > >+
> > >+      capped_extra_power =3D 0;
> > >+      extra_power =3D 0;
> > >+      for (i =3D 0; i < num_actors; i++) {
> > >+              u64 req_range =3D req_power[i] * power_range;
> > >+
> > >+              granted_power[i] =3D div_u64(req_range, total_req_power=
);
> > >+
> > >+              if (granted_power[i] > max_power[i]) {
> > >+                      extra_power +=3D granted_power[i] - max_power[i=
];
> > >+                      granted_power[i] =3D max_power[i];
> > >+              }
> > >+
> > >+              extra_actor_power[i] =3D max_power[i] - granted_power[i=
];
> > >+              capped_extra_power +=3D extra_actor_power[i];
> > >+      }
> > >+
> > >+      if (!extra_power)
> > >+              return;
> > >+
> > >+      /*
> > >+       * Re-divvy the reclaimed extra among actors based on
> > >+       * how far they are from the max
> > >+       */
> > >+      extra_power =3D min(extra_power, capped_extra_power);
> > >+      if (capped_extra_power > 0)
> > >+              for (i =3D 0; i < num_actors; i++)
> > >+                      granted_power[i] +=3D (extra_actor_power[i] *
> > >+                                      extra_power) / capped_extra_pow=
er;
> > >+}
> > >+
> > >+static int allocate_power(struct thermal_zone_device *tz,
> > >+                        unsigned long current_temp,
> > >+                        unsigned long control_temp)
> > >+{
> > >+      struct thermal_instance *instance;
> > >+      u32 *req_power, *max_power, *granted_power;
> > >+      u32 total_req_power, max_allocatable_power;
> > >+      u32 power_range;
> > >+      int i, num_actors, ret =3D 0;
> > >+
> > >+      mutex_lock(&tz->lock);
> > >+
> > >+      num_actors =3D 0;
> > >+      list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> > >+              if ((instance->trip =3D=3D TRIP_MAX_DESIRED_TEMPERATURE=
) &&
> > >+                  cdev_is_power_actor(instance->cdev))
> > >+                      num_actors++;
> > >+
> > >+      req_power =3D devm_kcalloc(&tz->device, num_actors, sizeof(*req=
_power),
> > >+                               GFP_KERNEL);
> > >+      if (!req_power) {
> > >+              ret =3D -ENOMEM;
> > >+              goto unlock;
> > >+      }
> > >+
> > >+      max_power =3D devm_kcalloc(&tz->device, num_actors, sizeof(*max=
_power),
> > >+                               GFP_KERNEL);
> > >+      if (!max_power) {
> > >+              ret =3D -ENOMEM;
> > >+              goto free_req_power;
> > >+      }
> > >+
> > >+      granted_power =3D devm_kcalloc(&tz->device, num_actors,
> > >+                                   sizeof(*granted_power), GFP_KERNEL=
);
> > >+      if (!granted_power) {
> > >+              ret =3D -ENOMEM;
> > >+              goto free_max_power;
> > >+      }
> >=20
> > You could optimize this allocation by allocating them together and then
> > using an offset to get max_power and granted_power from req_power.
>=20
> Makes sense, I've changed it to:=20
>=20
> 	/*
> 	 * We need to allocate three arrays of the same size:
> 	 * req_power, max_power and granted_power.  They are going to
> 	 * be needed until this function returns.  Allocate them all
> 	 * in one go to simplify the allocation and deallocation
> 	 * logic.
> 	 */
> 	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*max_power));
> 	BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*granted_power));
> 	req_power =3D devm_kcalloc(&tz->device, num_actors * 3,
> 				 sizeof(*req_power), GFP_KERNEL);
> 	if (!req_power) {
> 		ret =3D -ENOMEM;
> 		goto unlock;
> 	}
>=20
> 	max_power =3D &req_power[num_actors];
> 	granted_power =3D &req_power[2 * num_actors];
>=20
> > >+
> > >+      i =3D 0;
> > >+      total_req_power =3D 0;
> > >+      max_allocatable_power =3D 0;
> > >+
> > >+      list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > >+              struct thermal_cooling_device *cdev =3D instance->cdev;
> > >+
> > >+              if (instance->trip !=3D TRIP_MAX_DESIRED_TEMPERATURE)
> > >+                      continue;
> > >+
> > >+              if (!cdev_is_power_actor(cdev))
> > >+                      continue;
> > >+
> > >+              if (cdev->ops->get_requested_power(cdev, tz, &req_power=
[i]))
> > >+                      continue;
> > >+
> > >+              req_power[i] =3D frac_to_int(instance->weight * req_pow=
er[i]);
> > >+
> > >+              if (power_actor_get_max_power(cdev, tz, &max_power[i]))
> > >+                      continue;
> > >+
> > >+              total_req_power +=3D req_power[i];
> > >+              max_allocatable_power +=3D max_power[i];
> > >+
> > >+              i++;
> > >+      }
> > >+
> > >+      power_range =3D pid_controller(tz, current_temp, control_temp,
> > >+                                   max_allocatable_power);
> > >+
> > >+      divvy_up_power(req_power, max_power, num_actors, total_req_powe=
r,
> > >+                     power_range, granted_power);
> > >+
> > >+      i =3D 0;
> > >+      list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > >+              if (instance->trip !=3D TRIP_MAX_DESIRED_TEMPERATURE)
> > >+                      continue;
> > >+
> > >+              if (!cdev_is_power_actor(instance->cdev))
> > >+                      continue;
> > >+
> > >+              power_actor_set_power(instance->cdev, instance,
> > >+                                    granted_power[i]);
> > >+
> > >+              i++;
> > >+      }
> > >+
> > >+      devm_kfree(&tz->device, granted_power);
> > >+free_max_power:
> > >+      devm_kfree(&tz->device, max_power);
> > >+free_req_power:
> > >+      devm_kfree(&tz->device, req_power);
> > >+unlock:
> > >+      mutex_unlock(&tz->lock);
> > >+
> > >+      return ret;
> > >+}
> > >+
> > >+static int check_trips(struct thermal_zone_device *tz)
> > >+{
> > >+      int ret;
> > >+      enum thermal_trip_type type;
> > >+
> > >+      if (tz->trips < THERMAL_TRIP_NUM)
> > >+              return -EINVAL;
> > >+
> > >+      ret =3D tz->ops->get_trip_type(tz, TRIP_SWITCH_ON, &type);
> > >+      if (ret)
> > >+              return ret;
> >=20
> > TZ should be able to correctly enumerate the value of this definition in
> > their driver.
>=20
> Right, drivers can use this enum so it should be in a header that they
> can include.  I've moved the "enum power_allocator_trip_levels"
> definition to thermal.h .  I considered drivers/thermal/thermal_core.h
> but no drivers include that so it's probably not the right place
> (others can correct me if I'm wrong).

Well, I am not convinced drivers really need to be aware of these trip
types. Which kind of drivers are we talking? Thermal zone drivers?
cooling device drivers?

Lina, do you have an existing driver (it can be yet to be posted) that
would required using these types? To my understanding, these are simply
for the governor internal control, drivers do not really need to understand
the difference from one to another.

The purpose of the .bind_to_tz callback is exactly to verify if the
driver has added the required info into the thermal zone. Including the
trip setup.

Besides, the existing exposed trip types are sufficient, given that this
series is in a working state. Unless we have a valid use case to change
/ add trip types and expose them to driver, I would prefer to keep this
simple.

Side note, drivers/thermal/thermal_core.h has symbols that are not
exported. As drivers can be built as separated modules from thermal
core, I would not recommend include things in that header. The symbols
that are EXPORT_SYMBOL'ed are in thermal.h under include directory.

>=20
> Cheers,
> Javi
>=20
> > I dont think anymore, this should be a enum thermal_trip_type, but it h=
as to be
> > generic across governors.
> >=20
> >=20
> > Thanks,
> > Lina

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU0E72AAoJEMLUO4d9pOJWGPMH/3FnmLQW5d8aUO7yFXs3xXDT
/xQ2+FzWf14/x3AlpFS3eavJOeDqUmGSlDamyZwDatgFZUtHaF96IfVEWF/W2K2P
co1oltT244e3mFAzIZ7AMODEqSdb1gJiDN/VVpLn6my3tW5ToNGmJaIyy8LccHFY
V83w1zaGGDxBNP5+uo+8i4dte04KTRMuLNSnJEsNF6ibo2+VtN+w/ZdZGzpmH7jS
+VJ6BKmklUhe5OLqCNbsMdwKUx9b+e37yL/e4vkeP6dZ+NolqkYUh/1gORM/I5ko
w0UnYraL8Z7g5z3Ivq7vhpBmvGwJvPOl0XfFhP+VFkhQ27n/sL5OorAO1az1VmE=
=9v8R
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
