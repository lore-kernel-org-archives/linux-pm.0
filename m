From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 3/5] thermal: Add devfreq cooling
Date: Thu, 20 Aug 2015 15:32:02 -0700
Message-ID: <20150820223200.GB6708@localhost.localdomain>
References: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
 <1439575020-3447-4-git-send-email-javi.merino@arm.com>
 <20150817183910.GH2762@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35559 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbHTWcH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 18:32:07 -0400
Content-Disposition: inline
In-Reply-To: <20150817183910.GH2762@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "rufus.hamade@imgtec.com" <rufus.hamade@imgtec.com>, =?iso-8859-1?Q?=D8rjan?= Eide <Orjan.Eide@arm.com>, Zhang Rui <rui.zhang@intel.com>

On Mon, Aug 17, 2015 at 07:39:10PM +0100, Javi Merino wrote:
> Replying to myself, there are two issues that will be fixed in the
> next version:

Assuming that this is a design copy of cpu cooling,
Please have a look also in the fix from RMK about
AB-BA lock dep problem.


>=20
> On Fri, Aug 14, 2015 at 06:56:58PM +0100, Javi Merino wrote:
> > From: =D8rjan Eide <orjan.eide@arm.com>
> >=20
> > Add a generic thermal cooling device for devfreq, that is similar t=
o
> > cpu_cooling.
> >=20
> > The device must use devfreq.  In order to use the power extension o=
f the
> > cooling device, it must have registered its OPPs using the OPP libr=
ary.
> >=20
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > Signed-off-by: =D8rjan Eide <orjan.eide@arm.com>
> > ---
> >  drivers/thermal/Kconfig           |  10 +
> >  drivers/thermal/Makefile          |   3 +
> >  drivers/thermal/devfreq_cooling.c | 541 ++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/devfreq_cooling.h   |  72 +++++
> >  4 files changed, 626 insertions(+)
> >  create mode 100644 drivers/thermal/devfreq_cooling.c
> >  create mode 100644 include/linux/devfreq_cooling.h
> >=20
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 118938ee8552..da339ff7c3c9 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -147,6 +147,16 @@ config CLOCK_THERMAL
> >           device that is configured to use this cooling mechanism w=
ill be
> >           controlled to reduce clock frequency whenever temperature=
 is high.
> >=20
> > +config DEVFREQ_THERMAL
> > +       bool "Generic device cooling support"
> > +       depends on PM_DEVFREQ
> > +       help
> > +         This implements the generic devfreq cooling mechanism thr=
ough
> > +         frequency reduction for devices using devfreq.
> > +
> > +         This will throttle the device by limiting the maximum all=
owed DVFS
> > +         frequency corresponding to the cooling level.
> > +
> >           If you want this support, you should say Y here.
> >=20
> >  config THERMAL_EMULATION
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 535dfee1496f..45f26978ff74 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -22,6 +22,9 @@ thermal_sys-$(CONFIG_CPU_THERMAL)     +=3D cpu_co=
oling.o
> >  # clock cooling
> >  thermal_sys-$(CONFIG_CLOCK_THERMAL)    +=3D clock_cooling.o
> >=20
> > +# devfreq cooling
> > +thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_cooling.o
> > +
> >  # platform thermal drivers
> >  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)     +=3D qcom-spmi-temp-alarm.o
> >  obj-$(CONFIG_SPEAR_THERMAL)    +=3D spear_thermal.o
> > diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/de=
vfreq_cooling.c
> > new file mode 100644
> > index 000000000000..ca2e212ce7ef
> > --- /dev/null
> > +++ b/drivers/thermal/devfreq_cooling.c
> > @@ -0,0 +1,541 @@
> > +/*
> > + * devfreq_cooling: Thermal cooling device implementation for devi=
ces using
> > + *                  devfreq
> > + *
> > + * Copyright (C) 2014-2015 ARM Limited
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warr=
anty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
> > + * GNU General Public License for more details.
> > + *
> > + * TODO:
> > + *    - If OPPs are added or removed after devfreq cooling has
> > + *      registered, the devfreq cooling won't react to it.
> > + */
> > +
> > +#include <linux/devfreq.h>
> > +#include <linux/devfreq_cooling.h>
> > +#include <linux/export.h>
> > +#include <linux/slab.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/thermal.h>
> > +
> > +static DEFINE_MUTEX(devfreq_lock);
> > +static DEFINE_IDR(devfreq_idr);
> > +
> > +/**
> > + * struct devfreq_cooling_device - Devfreq cooling device
> > + * @id:                unique integer value corresponding to each
> > + *             devfreq_cooling_device registered.
> > + * @cdev:      Pointer to associated thermal cooling device.
> > + * @devfreq:   Pointer to associated devfreq device.
> > + * @cooling_state:     Current cooling state.
> > + * @power_table:       Pointer to table with maximum power draw fo=
r each
> > + *                     cooling state. State is the index into the =
table, and
> > + *                     the power is in mW.
> > + * @freq_table:        Pointer to a table with the frequencies sor=
ted in descending
> > + *             order.  You can index the table by cooling device s=
tate
> > + * @freq_table_size:   size of the @freq_table and @power_table
> > + * @power_ops: Pointer to power operations, used to generate @powe=
r_table.
> > + */
> > +struct devfreq_cooling_device {
> > +       int id;
> > +       struct thermal_cooling_device *cdev;
> > +       struct devfreq *devfreq;
> > +       unsigned long cooling_state;
> > +       u32 *power_table;
> > +       u32 *freq_table;
> > +       size_t freq_table_size;
> > +       struct devfreq_cooling_ops *power_ops;
> > +};
> > +
> > +/**
> > + * get_idr - function to get a unique id.
> > + * @idr: struct idr * handle used to create a id.
> > + * @id: int * value generated by this function.
> > + *
> > + * This function will populate @id with an unique
> > + * id, using the idr API.
> > + *
> > + * Return: 0 on success, an error code on failure.
> > + */
> > +static int get_idr(struct idr *idr, int *id)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&devfreq_lock);
> > +       ret =3D idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
> > +       mutex_unlock(&devfreq_lock);
> > +       if (unlikely(ret < 0))
> > +               return ret;
> > +       *id =3D ret;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * release_idr - function to free the unique id.
> > + * @idr: struct idr * handle used for creating the id.
> > + * @id: int value representing the unique id.
> > + */
> > +static void release_idr(struct idr *idr, int id)
> > +{
> > +       mutex_lock(&devfreq_lock);
> > +       idr_remove(idr, id);
> > +       mutex_unlock(&devfreq_lock);
> > +}
> > +
> > +/**
> > + * enable_disable_opps() - disable all opps above a given state
> > + * @dfc:       Pointer to devfreq we are operating on
> > + * @cdev_state:        cooling device state we're setting
> > + *
> > + * Go through the OPPs of the device, enabling all OPPs until
> > + * @cdev_state and disabling those frequencies above it.
> > + */
> > +static int enable_disable_opps(struct devfreq_cooling_device *dfc,
> > +                              unsigned long cdev_state)
> > +{
> > +       int i;
> > +       struct device *dev =3D dfc->devfreq->dev.parent;
> > +
> > +       rcu_read_lock();
> > +
> > +       for (i =3D 0; i < dfc->freq_table_size; i++) {
> > +               struct dev_pm_opp *opp;
> > +               unsigned int freq =3D dfc->freq_table[i];
> > +               bool want_enable =3D i >=3D cdev_state ? true : fal=
se;
> > +
> > +               opp =3D dev_pm_opp_find_freq_exact(dev, freq, !want=
_enable);
> > +
> > +               if (PTR_ERR(opp) =3D=3D -ERANGE) {
> > +                       continue;
> > +               } else if (IS_ERR(opp)) {
> > +                       rcu_read_unlock();
> > +                       return PTR_ERR(opp);
> > +               }
> > +
> > +               if (want_enable)
> > +                       dev_pm_opp_enable(dev, freq);
> > +               else
> > +                       dev_pm_opp_disable(dev, freq);
>=20
> dev_pm_opp_enable/disable can't be called while holding rcu.  The
> rcu_read_lock() should only be held for the call to
> dev_pm_opp_find_freq_exact()
>=20
> > +       }
> > +
> > +       rcu_read_unlock();
> > +
> > +       return 0;
> > +}
> > +
> > +static int devfreq_cooling_get_max_state(struct thermal_cooling_de=
vice *cdev,
> > +                                        unsigned long *state)
> > +{
> > +       struct devfreq_cooling_device *dfc =3D cdev->devdata;
> > +
> > +       *state =3D dfc->freq_table_size - 1;
> > +
> > +       return 0;
> > +}
> > +
> > +static int devfreq_cooling_get_cur_state(struct thermal_cooling_de=
vice *cdev,
> > +                                        unsigned long *state)
> > +{
> > +       struct devfreq_cooling_device *dfc =3D cdev->devdata;
> > +
> > +       *state =3D dfc->cooling_state;
> > +
> > +       return 0;
> > +}
> > +
> > +static int devfreq_cooling_set_cur_state(struct thermal_cooling_de=
vice *cdev,
> > +                                        unsigned long state)
> > +{
> > +       struct devfreq_cooling_device *dfc =3D cdev->devdata;
> > +       struct devfreq *df =3D dfc->devfreq;
> > +       struct device *dev =3D df->dev.parent;
> > +       int ret;
> > +
> > +       if (state =3D=3D dfc->cooling_state)
> > +               return 0;
> > +
> > +       dev_dbg(dev, "Setting cooling state %lu\n", state);
> > +
> > +       if (state >=3D dfc->freq_table_size)
> > +               return -EINVAL;
> > +
> > +       ret =3D enable_disable_opps(dfc, state);
> > +       if (ret)
> > +               return ret;
> > +
> > +       dfc->cooling_state =3D state;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * freq_get_state() - get the cooling state corresponding to a fre=
quency
> > + * @dfc:       Pointer to devfreq cooling device
> > + * @freq:      frequency in Hz
> > + *
> > + * Return: the cooling state associated with the @freq, or
> > + * THERMAL_CSTATE_INVALID if it wasn't found.
> > + */
> > +static unsigned long
> > +freq_get_state(struct devfreq_cooling_device *dfc, unsigned long f=
req)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < dfc->freq_table_size; i++) {
> > +               if (dfc->freq_table[i] =3D=3D freq)
> > +                       return i;
> > +       }
> > +
> > +       return THERMAL_CSTATE_INVALID;
> > +}
> > +
> > +/**
> > + * state_get_freq() - get the frequency corresponding to a cooling=
 state
> > + * @dfc:       Pointer to devfreq cooling device
> > + * @state:     cooling device state
> > + *
> > + * Return: the frequency for this cooling device state or 0 for
> > + * invalid states.
> > + */
> > +static unsigned long
> > +state_get_freq(struct devfreq_cooling_device *dfc, unsigned long s=
tate)
> > +{
> > +       if (state >=3D dfc->freq_table_size) {
> > +               dev_warn(dfc->devfreq->dev.parent,
> > +                        "State %lu bigger than frequency table\n",=
 state);
> > +               return 0;
> > +       }
> > +
> > +       return dfc->freq_table[state];
> > +}
> > +
> > +static unsigned long
> > +get_static_power(struct devfreq_cooling_device *dfc, unsigned long=
 freq)
> > +{
> > +       struct devfreq *df =3D dfc->devfreq;
> > +       struct device *dev =3D df->dev.parent;
> > +       unsigned long voltage;
> > +       struct dev_pm_opp *opp;
> > +
> > +       rcu_read_lock();
> > +
> > +       opp =3D dev_pm_opp_find_freq_exact(dev, freq, true);
> > +       if (IS_ERR(opp) && (PTR_ERR(opp) =3D=3D -ERANGE))
> > +               opp =3D dev_pm_opp_find_freq_exact(dev, freq, false=
);
> > +
> > +       voltage =3D dev_pm_opp_get_voltage_always(opp) / 1000; /* m=
V */
> > +
> > +       rcu_read_unlock();
> > +
> > +       if (voltage =3D=3D 0) {
> > +               dev_warn_ratelimited(dev,
> > +                                    "Failed to get voltage for fre=
quency %lu: %ld\n",
> > +                                    freq, IS_ERR(opp) ? PTR_ERR(op=
p) : 0);
> > +               return 0;
> > +       }
> > +
> > +       return dfc->power_ops->get_static_power(voltage);
> > +}
> > +
> > +static int devfreq_cooling_get_requested_power(struct thermal_cool=
ing_device *cdev,
> > +                                              struct thermal_zone_=
device *tz,
> > +                                              u32 *power)
> > +{
> > +       struct devfreq_cooling_device *dfc =3D cdev->devdata;
> > +       struct devfreq *df =3D dfc->devfreq;
> > +       struct devfreq_dev_status *status =3D &df->last_status;
> > +       unsigned long state;
> > +       unsigned long freq =3D status->current_frequency;
> > +       u32 dyn_power, static_power;
> > +
> > +       /* Get dynamic power for state */
> > +       state =3D freq_get_state(dfc, freq);
> > +       if (state =3D=3D THERMAL_CSTATE_INVALID)
> > +               return -EAGAIN;
> > +
> > +       dyn_power =3D dfc->power_table[state];
> > +
> > +       /* Scale dynamic power for utilization */
> > +       dyn_power =3D (dyn_power * status->busy_time) / status->tot=
al_time;
> > +
> > +       /* Get static power */
> > +       static_power =3D get_static_power(dfc, freq);
> > +
> > +       *power =3D dyn_power + static_power;
> > +
> > +       return 0;
> > +}
> > +
> > +static int devfreq_cooling_state2power(struct thermal_cooling_devi=
ce *cdev,
> > +                                      struct thermal_zone_device *=
tz,
> > +                                      unsigned long state,
> > +                                      u32 *power)
> > +{
> > +       struct devfreq_cooling_device *dfc =3D cdev->devdata;
> > +       unsigned long freq;
> > +       u32 static_power;
> > +
> > +       freq =3D state_get_freq(dfc, state);
> > +       static_power =3D get_static_power(dfc, freq);
> > +
> > +       *power =3D dfc->power_table[state] + static_power;
> > +       return 0;
> > +}
> > +
> > +static int devfreq_cooling_power2state(struct thermal_cooling_devi=
ce *cdev,
> > +                                      struct thermal_zone_device *=
tz,
> > +                                      u32 power, unsigned long *st=
ate)
> > +{
> > +       struct devfreq_cooling_device *dfc =3D cdev->devdata;
> > +       struct devfreq *df =3D dfc->devfreq;
> > +       struct devfreq_dev_status *status =3D &df->last_status;
> > +       unsigned long freq =3D status->current_frequency;
> > +       unsigned long busy_time;
> > +       s32 dyn_power;
> > +       u32 static_power;
> > +       int i;
> > +
> > +       static_power =3D get_static_power(dfc, freq);
> > +
> > +       dyn_power =3D power - static_power;
> > +       dyn_power =3D dyn_power > 0 ? dyn_power : 0;
> > +
> > +       /* Scale dynamic power for utilization */
> > +       busy_time =3D status->busy_time ?: 1;
> > +       dyn_power =3D (dyn_power * status->total_time) / busy_time;
> > +
> > +       /*
> > +        * Find the first cooling state that is within the power
> > +        * budget for dynamic power.
> > +        */
> > +       for (i =3D 0; i < dfc->freq_table_size - 1; i++)
> > +               if (dyn_power >=3D dfc->power_table[i])
> > +                       break;
> > +
> > +       *state =3D i;
> > +       return 0;
> > +}
> > +
> > +static struct thermal_cooling_device_ops devfreq_cooling_ops =3D {
> > +       .get_max_state =3D devfreq_cooling_get_max_state,
> > +       .get_cur_state =3D devfreq_cooling_get_cur_state,
> > +       .set_cur_state =3D devfreq_cooling_set_cur_state,
> > +};
> > +
> > +/**
> > + * devfreq_cooling_gen_tables() - Generate power and freq tables.
> > + * @dfc: Pointer to devfreq cooling device.
> > + *
> > + * Generate power and frequency tables: the power table hold the
> > + * device's maximum power usage at each cooling state (OPP).  The
> > + * static and dynamic power using the appropriate voltage and
> > + * frequency for the state, is acquired from the struct
> > + * devfreq_cooling_ops, and summed to make the maximum power draw.
> > + *
> > + * The frequency table holds the frequencies in descending order.
> > + * That way its indexed by cooling device state.
> > + *
> > + * The tables are malloced, and pointers put in dfc.  They must be
> > + * freed when unregistering the devfreq cooling device.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +static int devfreq_cooling_gen_tables(struct devfreq_cooling_devic=
e *dfc)
> > +{
> > +       struct devfreq *df =3D dfc->devfreq;
> > +       struct device *dev =3D df->dev.parent;
> > +       int ret, num_opps;
> > +       struct devfreq_cooling_ops *callbacks =3D dfc->power_ops;
> > +       unsigned long freq;
> > +       u32 *power_table, *freq_table;
> > +       int i;
> > +
> > +       if (!IS_ENABLED(CONFIG_PM_OPP)) {
> > +               dev_warn(dev, "Can't use power extensions of the de=
vfreq cooling device without CONFIG_PM_OPP\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       rcu_read_lock();
> > +       num_opps =3D dev_pm_opp_get_opp_count(dev);
> > +
> > +       power_table =3D kcalloc(num_opps, sizeof(*power_table), GFP=
_KERNEL);
>=20
> kcalloc() may sleep.  We can't sleep while in an RCU read-side sectio=
n.
>=20
> Cheers,
> Javi
>=20
> > +       if (!power_table) {
> > +               ret =3D -ENOMEM;
> > +               goto unlock;
> > +       }
> > +
> > +       freq_table =3D kcalloc(num_opps, sizeof(*freq_table),
> > +                            GFP_KERNEL);
> > +       if (!freq_table) {
> > +               ret =3D -ENOMEM;
> > +               goto free_power_table;
> > +       }
> > +
> > +       for (i =3D 0, freq =3D ULONG_MAX; i < num_opps; i++, freq--=
) {
> > +               unsigned long power_dyn, voltage;
> > +               struct dev_pm_opp *opp;
> > +
> > +               opp =3D dev_pm_opp_find_freq_floor(dev, &freq);
> > +               if (IS_ERR(opp)) {
> > +                       ret =3D PTR_ERR(opp);
> > +                       goto free_tables;
> > +               }
> > +
> > +               voltage =3D dev_pm_opp_get_voltage(opp) / 1000; /* =
mV */
> > +
> > +               power_dyn =3D callbacks->get_dynamic_power(freq, vo=
ltage);
> > +
> > +               dev_info(dev, "Dynamic power table: %lu MHz @ %lu m=
V: %lu =3D %lu mW\n",
> > +                        freq / 1000000, voltage, power_dyn, power_=
dyn);
> > +
> > +               power_table[i] =3D power_dyn;
> > +               freq_table[i] =3D freq;
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       dfc->power_table =3D power_table;
> > +       dfc->freq_table =3D freq_table;
> > +       dfc->freq_table_size =3D num_opps;
> > +
> > +       return 0;
> > +
> > +free_tables:
> > +       kfree(freq_table);
> > +free_power_table:
> > +       kfree(power_table);
> > +unlock:
> > +       rcu_read_unlock();
> > +
> > +       return ret;
> > +}
