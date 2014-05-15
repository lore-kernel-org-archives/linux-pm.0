From: Javi Merino <javi.merino@arm.com>
Subject: Re: [RFC PATCH 3/5] thermal: add a basic cpu power actor
Date: Thu, 15 May 2014 18:02:53 +0100
Message-ID: <20140515170253.GB3964@e102654-lin.cambridge.arm.com>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
 <1399377998-14870-4-git-send-email-javi.merino@arm.com>
 <20140513225752.GB28174@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59582 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaEORC7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 13:02:59 -0400
In-Reply-To: <20140513225752.GB28174@developer>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Zhang Rui <rui.zhang@intel.com>

Hi Eduardo,

On Tue, May 13, 2014 at 11:57:52PM +0100, Eduardo Valentin wrote:
> On Tue, May 06, 2014 at 01:06:36PM +0100, Javi Merino wrote:
> > Introduce a new thermal_cooling_unit: THERMAL_UNIT_POWER and let
> > cpu_cooling device operate using it as well as "states".  This allows
> > governors that call cpufreq_get_max/cpufreq_get_cur/cpufreq_set_cur()
> > with THERMAL_UNIT_POWER to use cpufreq cooling devices.
> >
> > If the cpu cooling device is registered using
> > {of_,}cpufreq_power_actor_register() instead of
> > {of_,}cpufreq_cooling_register() it uses the current frequency (as
> > reported by cpufreq) as well as load and OPPs for the power
> > calculations.  The cpus must have registered their OPPs in the OPP
> > library.
> >
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  drivers/thermal/cpu_cooling.c  |  430 ++++++++++++++++++++++++++++++++++++----
> >  drivers/thermal/thermal_core.c |    4 +-
> >  include/linux/cpu_cooling.h    |   28 +++
> >  include/linux/thermal.h        |    4 +
> >  4 files changed, 422 insertions(+), 44 deletions(-)
> 
> Could you please also document under Documentation/thermal/sysfs-api.txt the exposed APIs ?
> 
> 
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index f3f4e6b5798e..8052cd1f4a39 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -24,10 +24,27 @@
> >  #include <linux/thermal.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/err.h>
> > +#include <linux/pm_opp.h>
> >  #include <linux/slab.h>
> >  #include <linux/cpu.h>
> >  #include <linux/cpu_cooling.h>
> >
> > +/* Maximum number of opps we can track */
> > +#define MAX_NUM_OPPS 32
> > +
> > +/**
> > + * struct power_table - frequency to power conversion
> > + * @frequency:       frequency in KHz
> > + * @power:   power in mW
> > + *
> > + * This structure is built when the cooling device registers and helps
> > + * in translating frequency to power and viceversa.
> > + */
> > +struct power_table {
> > +     u32 frequency;
> > +     u32 power;
> > +};
> > +
> >  /**
> >   * struct cpufreq_cooling_device - data for cooling device with cpufreq
> >   * @id: unique integer value corresponding to each cpufreq_cooling_device
> > @@ -39,6 +56,14 @@
> >   * @cpufreq_val: integer value representing the absolute value of the clipped
> >   *   frequency.
> >   * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
> > + * @power_table: array of struct power_table for frequency to power conversion
> > + * @power_table_entries: number of entries in the @power_table array
> > + * @time_in_idle: previous reading of the absolute time that this cpu was idle
> > + * @time_in_idle_timestamp: wall time of the last invocation of
> > + *   get_cpu_idle_time_us()
> > + * @last_load: load measured by the latest call to cpufreq_get_cur()
> > + * @freq: frequency in KHz of the cpus represented by the cooling device
> > + * @capacitance: the dynamic power coefficient of these cpus
> >   *
> >   * This structure is required for keeping information of each
> >   * cpufreq_cooling_device registered. In order to prevent corruption of this a
> > @@ -50,11 +75,19 @@ struct cpufreq_cooling_device {
> >       unsigned int cpufreq_state;
> >       unsigned int cpufreq_val;
> >       struct cpumask allowed_cpus;
> > +     struct power_table power_table[MAX_NUM_OPPS];
> 
> Can we build this table dynamically?
> 
> I believe we should be able to fetch this table from opp layer. Besides,
> should not be trouble of this code to estimate the max number of opps.

Ok, I'll change that as you suggested below and remove MAX_NUM_OPPS.

> > +     int power_table_entries;
> > +     u64 time_in_idle[NR_CPUS];
> > +     u64 time_in_idle_timestamp[NR_CPUS];
> > +     u32 last_load;
> > +     u32 freq;
> > +     u32 capacitance;
> >  };
> >  static DEFINE_IDR(cpufreq_idr);
> >  static DEFINE_MUTEX(cooling_cpufreq_lock);
> >
> >  static unsigned int cpufreq_dev_count;
> > +static bool power_actor_notifier_registered;
> 
> Are you sure you need this bool? Shouldn' t you be using a counter?

Yes, that should be a counter, like cpufreq_dev_count.  It's used
exactly like cpufreq_dev_count (to prevent registering the same
notifier_block more than once) so it should have the same semantics.

> You probably need locking on this.

True, added.

> >  /* notify_table passes value to the CPUFREQ_ADJUST callback function. */
> >  #define NOTIFY_INVALID NULL
> > @@ -115,6 +148,59 @@ static int is_cpufreq_valid(int cpu)
> >       return !cpufreq_get_policy(&policy, cpu);
> >  }
> >
> > +static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_device,
> > +                     u32 freq)
> > +{
> > +     int i;
> > +     struct power_table *pt = cpufreq_device->power_table;
> > +
> > +     for (i = 0; i < cpufreq_device->power_table_entries - 1; i++)
> > +             if (freq <= pt[i].frequency)
> > +                     break;
> > +
> > +     return pt[i].power;
> > +}
> > +
> > +static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device,
> > +                     u32 power)
> > +{
> > +     int i;
> > +     struct power_table *pt = cpufreq_device->power_table;
> > +
> > +     for (i = 0; i < cpufreq_device->power_table_entries - 1; i++)
> > +             if (power <= pt[i].power)
> > +                     break;
> > +
> > +     return pt[i].frequency;
> > +}
> > +
> > +/**
> > + * get_load - get load for a cpu since last updated
> > + * @cpufreq_device: struct cpufreq_cooling_device for this cooling device
> > + * @cpu: cpu number
> > + *
> > + * Return the average load of cpu @cpu in percentage since this
> > + * function was last called.
> > + */
> > +static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu)
> > +{
> > +     u32 load;
> > +     u64 now, now_idle, delta_time, delta_idle;
> > +
> > +     now_idle = get_cpu_idle_time(cpu, &now, 0);
> > +     delta_idle = now_idle - cpufreq_device->time_in_idle[cpu];
> > +     delta_time = now - cpufreq_device->time_in_idle_timestamp[cpu];
> > +
> > +     if (delta_time <= delta_idle)
> > +             load = 0;
> > +     else
> > +             load = div64_u64(100 * (delta_time - delta_idle), delta_time);
> > +
> > +     cpufreq_device->time_in_idle[cpu] = now_idle;
> > +     cpufreq_device->time_in_idle_timestamp[cpu] = now;
> 
> nip: blank line here.

Ok

> > +     return load;
> > +}
> > +
> >  enum cpufreq_cooling_property {
> >       GET_LEVEL,
> >       GET_FREQ,
> > @@ -342,98 +428,193 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
> >       return 0;
> >  }
> >
> > +/**
> > + * cpufreq_frequency_change - notifier callback for cpufreq frequency changes
> > + * @nb:              struct notifier_block * with callback info
> > + * @event:   value showing cpufreq event for which this function invoked
> > + * @data:    callback-specific data
> > + *
> > + * Callback to get notifications of frequency changes.  In the
> > + * CPUFREQ_POSTCHANGE @event we store the new frequency so that
> > + * cpufreq_get_cur() knows the current frequency and can convert it
> > + * into power.
> > + */
> > +static int cpufreq_frequency_change(struct notifier_block *nb,
> > +                             unsigned long event, void *data)
> > +{
> > +     struct thermal_cooling_device *cdev;
> > +     struct cpufreq_freqs *freqs = data;
> > +
> > +     /* Only update frequency on postchange */
> > +     if (event != CPUFREQ_POSTCHANGE)
> > +             return NOTIFY_DONE;
> > +
> > +     mutex_lock(&thermal_list_lock);
> > +
> > +     list_for_each_entry(cdev, &thermal_cdev_list, node) {
> > +             struct cpufreq_cooling_device *cpufreq_device;
> > +
> > +             if (strncmp(cdev->type, "thermal-cpufreq", THERMAL_NAME_LENGTH))
> > +                     continue;
> > +
> 
> I am not sure I follow why you need to go through the list of cooling devices
> here. Can you please elaborate a bit more?

Because of the code below, you need to find the cpufreq_device for
this cpu to update its frequency.  I've reworked most of this patch
and I think this loop is now clearer (and simpler) in the new version.

> > +             cpufreq_device = cdev->devdata;
> > +
> > +             if (cpumask_test_cpu(freqs->cpu, &cpufreq_device->allowed_cpus))
> > +                     cpufreq_device->freq = freqs->new;
> > +     }
> > +
> > +     mutex_unlock(&thermal_list_lock);
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> >  /* cpufreq cooling device callback functions are defined below */
> >
> >  /**
> > - * cpufreq_get_max_state - callback function to get the max cooling state.
> > + * cpufreq_get_max - callback function to get the max cooling state/power.
> >   * @cdev: thermal cooling device pointer.
> > - * @state: fill this variable with the max cooling state.
> > - * @unit: the units in which @state should be in.
> > + * @val: fill this variable with the max cooling state/power.
> > + * @unit: whether to put state or power in @val.
> >   *
> >   * Callback for the thermal cooling device to return the cpufreq max
> > - * cooling state.  Currently only THERMAL_UNIT_STATE is valid for
> > - * @unit.
> > + * cooling state/power.  If @unit is THERMAL_UNIT_STATE, @val contains
> > + * the maximum cooling state; if @unit is THERMAL_UNIT_POWER, @val
> > + * maximum is power in milliwatts.
> >   *
> >   * Return: 0 on success, an error code otherwise.
> >   */
> > -static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
> > -                             unsigned long *state,
> > -                             enum thermal_cooling_unit unit)
> > +static int cpufreq_get_max(struct thermal_cooling_device *cdev,
> > +                        unsigned long *val, enum thermal_cooling_unit unit)
> 
> Shouldn't this change be part of previous patch?

I've nuked most of this and moved it to a specific file.  Bottom line
is, extending the cooling device interface is a bit of a stretch and
doesn't work as well as I thought.  Take for example this function:
cpufreq_get_max(cdev, &val, THERMAL_UNIT_STATE) gives you the maximum
cooling state, i.e. minimum frequency.  OTOH,
cpufreq_get_max(cdev, &val, THERMAL_UNIT_POWER) gives you the maximum
power, i.e. the power consumption at maximum frequency.

Not only that, the interface is to rigid to allow for
platform-specific power models.  More on that below, as you've pointed
out some of the issues.

> >  {
> >       struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
> >       struct cpumask *mask = &cpufreq_device->allowed_cpus;
> >       unsigned int cpu;
> >       unsigned int count = 0;
> > -     int ret;
> > -
> > -     if (unit != THERMAL_UNIT_STATE)
> > -             return -EINVAL;
> 
> What happens to this code if tomorrow we add yet another unit?
> 
> 
> > +     int ret = 0;
> >
> >       cpu = cpumask_any(mask);
> >
> > -     ret = get_property(cpu, 0, &count, GET_MAXL);
> > +     if ((unit == THERMAL_UNIT_POWER) &&
> > +             (cpufreq_device->power_table_entries)) {
> 
> I think a cleaner code would use a switch case statement. You should
> deal with the power_table_entries restriction separatedly.
> 
> > +             unsigned int num_cpus;
> > +             unsigned long max_freq;
> > +
> > +             max_freq = get_cpu_frequency(cpu, 0);
> > +             if (!max_freq)
> > +                     return -EINVAL;
> >
> > -     if (count > 0)
> > -             *state = count;
> > +             num_cpus = cpumask_weight(mask);
> > +             *val = cpu_freq_to_power(cdev->devdata, max_freq) * num_cpus;
> > +     } else if (unit == THERMAL_UNIT_STATE) {
> > +             ret = get_property(cpu, 0, &count, GET_MAXL);
> > +
> > +             if (count > 0)
> > +                     *val = count;
> > +     } else {
> > +             ret = -EINVAL;
> > +     }
> >
> >       return ret;
> >  }
> >
> >  /**
> > - * cpufreq_get_cur_state - callback function to get the current cooling state.
> > + * cpufreq_get_cur - callback function to get the current cooling state/power.
> >   * @cdev: thermal cooling device pointer.
> > - * @state: fill this variable with the current cooling state.
> > - * @unit: the units in which state should be in
> > + * @val: fill this variable with the current cooling state/power.
> > + * @unit: whether to put state or power in @val.
> >   *
> >   * Callback for the thermal cooling device to return the cpufreq
> > - * current cooling state.  Currently only THERMAL_UNIT_STATE is valid
> > - * for @unit.
> > + * current cooling state/power.  If @unit is THERMAL_UNIT_STATE, @val
> > + * contains the current cooling state; if @unit is THERMAL_UNIT_POWER,
> > + * @val is current power consumption in milliwatts.
> >   *
> >   * Return: 0 on success, an error code otherwise.
> >   */
> > -static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> > -                              unsigned long *state,
> > -                              enum thermal_cooling_unit unit)
> > +static int cpufreq_get_cur(struct thermal_cooling_device *cdev,
> > +                        unsigned long *val, enum thermal_cooling_unit unit)
> >  {
> >       struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
> >
> > -     if (unit != THERMAL_UNIT_STATE)
> > -             return -EINVAL;
> > +     if ((unit == THERMAL_UNIT_POWER) &&
> > +             (cpufreq_device->power_table_entries)) {
> 
> ditto.
> 
> > +             int cpu;
> > +             u32 total_load = 0, raw_cpu_power, power = 0;
> > +
> > +             raw_cpu_power = cpu_freq_to_power(cpufreq_device,
> > +                                             cpufreq_device->freq);
> > +
> > +             for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
> > +                     u32 load;
> >
> > -     *state = cpufreq_device->cpufreq_state;
> > +                     if (!cpu_online(cpu))
> > +                             continue;
> > +
> > +                     load = get_load(cpufreq_device, cpu);
> > +                     power += (raw_cpu_power * load) / 100;
> > +                     total_load += load;
> > +             }
> > +
> > +             cpufreq_device->last_load = total_load;
> > +             *val = power;
> > +     } else if (unit == THERMAL_UNIT_STATE) {
> > +             *val = cpufreq_device->cpufreq_state;
> > +     } else {
> > +             return -EINVAL;
> > +     }
> >
> >       return 0;
> >  }
> >
> >  /**
> > - * cpufreq_set_cur_state - callback function to set the current cooling state.
> > + * cpufreq_set_cur - callback function to set the current cooling state/power.
> >   * @cdev: thermal cooling device pointer.
> > - * @state: set this variable to the current cooling state.
> > - * @unit: the units in which @state should be in.
> > + * @val: set this variable to the current cooling state/power.
> > + * @unit: whether @val is a cooling state or power.
> >   *
> >   * Callback for the thermal cooling device to change the cpufreq
> > - * current cooling state.  Currently only THERMAL_UNIT_STATE is valid for
> > - * @unit.
> > + * current cooling state/power.  If @unit is THERMAL_UNIT_STATE, @val
> > + * is a cooling state; if @unit is THERMAL_UNIT_POWER, @val is the target
> > + * power consumption in milliwatts.
> >   *
> >   * Return: 0 on success, an error code otherwise.
> >   */
> > -static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> > -                              unsigned long state,
> > -                              enum thermal_cooling_unit unit)
> > +static int cpufreq_set_cur(struct thermal_cooling_device *cdev,
> > +                        unsigned long val, enum thermal_cooling_unit unit)
> >  {
> >       struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
> > -
> > -     if (unit != THERMAL_UNIT_STATE)
> > +     unsigned long state;
> > +
> > +     if ((unit == THERMAL_UNIT_POWER) &&
> > +             (cpufreq_device->power_table_entries)) {
> 
> ditto.
> 
> > +             unsigned int cpu, freq;
> > +             u32 normalised_power, last_load;
> > +
> > +             cpu = cpumask_any(&cpufreq_device->allowed_cpus);
> > +             last_load = cpufreq_device->last_load ?
> > +                     cpufreq_device->last_load : 1;
> > +             normalised_power = (val * 100) / last_load;
> > +             freq = cpu_power_to_freq(cpufreq_device, normalised_power);
> > +
> > +             state = cpufreq_cooling_get_level(cpu, freq);
> > +             if (state == THERMAL_CSTATE_INVALID) {
> > +                     pr_err("Failed to convert %dKHz for cpu %d into a cdev state\n",
> > +                             freq, cpu);
> > +                     return -EINVAL;
> > +             }
> > +     } else if (unit == THERMAL_UNIT_STATE) {
> > +             state = val;
> > +     } else {
> >               return -EINVAL;
> > +     }
> >
> >       return cpufreq_apply_cooling(cpufreq_device, state);
> >  }
> >
> >  /* Bind cpufreq callbacks to thermal cooling device ops */
> >  static struct thermal_cooling_device_ops const cpufreq_cooling_ops = {
> > -     .get_max = cpufreq_get_max_state,
> > -     .get_cur = cpufreq_get_cur_state,
> > -     .set_cur = cpufreq_set_cur_state,
> > +     .get_max = cpufreq_get_max,
> > +     .get_cur = cpufreq_get_cur,
> > +     .set_cur = cpufreq_set_cur,
> >  };
> >
> >  /* Notifier for cpufreq policy change */
> > @@ -441,10 +622,95 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
> >       .notifier_call = cpufreq_thermal_notifier,
> >  };
> >
> > +/* Notifier for cpufreq frequency changes */
> > +struct notifier_block cpufreq_transition_notifier = {
> > +     .notifier_call = cpufreq_frequency_change,
> > +};
> > +
> > +/**
> > + * build_cpu_power_table - create a power to frequency table
> > + * @cpufreq_dev:     the cpufreq_cooling_device in which to store the table
> > + *
> > + * Build a power to frequency table for this cpu and store it in
> > + * @cpufreq_dev.  This table will be used in cpu_power_to_freq() and
> > + * cpu_freq_to_power() to convert between power and frequency
> > + * efficiently.  Power is stored in mW, frequency in KHz.  The
> > + * resulting table is in ascending order.
> > + *
> > + * Returns 0 on success, -E* on error.
> > + */
> > +static int build_cpu_power_table(struct cpufreq_cooling_device *cpufreq_dev)
> > +{
> > +     struct dev_pm_opp *opp;
> > +     struct device *dev = NULL;
> > +     int num_opps, cpu, i, ret = 0;
> > +     unsigned long freq;
> > +
> > +     num_opps = 0;
> > +
> > +     rcu_read_lock();
> > +
> > +     for_each_cpu(cpu, &cpufreq_dev->allowed_cpus) {
> > +             dev = get_cpu_device(cpu);
> > +             if (!dev)
> > +                     continue;
> > +
> > +             num_opps = dev_pm_opp_get_opp_count(dev);
> > +             if (num_opps > 0) {
> > +                     break;
> > +             } else if (num_opps < 0) {
> > +                     ret = num_opps;
> > +                     goto unlock;
> > +             }
> > +     }
> > +
> > +     if ((num_opps == 0) || (num_opps > MAX_NUM_OPPS)) {
> 
> hmm.. Does it mean that if an existing platform has more than 32
> opps, we won't support it? I would preffer we dynamically allocate
> the table here and cover any number of opps.

Will do.

> > +             ret = -EINVAL;
> > +             goto unlock;
> > +     }
> > +
> > +     i = 0;
> > +     for (freq = 0;
> > +          opp = dev_pm_opp_find_freq_ceil(dev, &freq), !IS_ERR(opp);
> > +          freq++) {
> > +             u32 freq_mhz, voltage_mv;
> > +             u64 power;
> > +
> > +             freq_mhz = freq / 1000000;
> > +             voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
> > +
> > +             /*
> > +              * Do the multiplication with MHz and millivolt so as
> > +              * to not overflow.
> > +              */
> > +             power = (u64)cpufreq_dev->capacitance * freq_mhz *
> > +                     voltage_mv * voltage_mv;
> 
> Essentially: P = C x F x V^2 right? Your model covers for dynamic power
> only.
> 
> I believe this power model neglets leakage. Static power consumption
> cannot be negleted nowadays, specially on thermal constrained CPUs.
> (which happens to be the target of this subsystem).
> 
> My suggestion is that you model power as:
> P = P_{dyn} + P_{static}
> 
> P_{dyn} can be what you propose above, for instance, or some other
> better increasing convex function. But we cannot neglect P_{static}.

For P_{static} we need the current temperature, which is a pain to get
from here without passing more parameters to the cooling device.
That's why I've removed this extension to the cooling device API and
just created another API to deal with getting and setting power.

> I suggest allowing platform device driver writer to input
> power models here somehow. Either by using callbacks to
> implement their own power model, or by feeding the API with
> their own table.

True, the power model needs to be "pluggable" and platforms should be
able to add their own.

> > +             do_div(power, 1000000000);
> > +
> > +             /* frequency is stored in power_table in KHz */
> > +             cpufreq_dev->power_table[i].frequency = freq / 1000;
> > +             cpufreq_dev->power_table[i].power = power;
> > +
> > +             i++;
> > +     }
> > +
> > +     if (i == 0) {
> > +             ret = PTR_ERR(opp);
> > +             goto unlock;
> > +     }
> > +
> > +     cpufreq_dev->power_table_entries = i;
> > +
> > +unlock:
> > +     rcu_read_unlock();
> > +     return ret;
> > +}
> > +
> >  /**
> >   * __cpufreq_cooling_register - helper function to create cpufreq cooling device
> >   * @np: a valid struct device_node to the cooling device device tree node
> >   * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
> > + * @capacitance: dynamic power coefficient for these cpus
> >   *
> >   * This interface function registers the cpufreq cooling device with the name
> >   * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
> > @@ -456,7 +722,7 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
> >   */
> >  static struct thermal_cooling_device *
> >  __cpufreq_cooling_register(struct device_node *np,
> > -                        const struct cpumask *clip_cpus)
> > +                     const struct cpumask *clip_cpus, u32 capacitance)
> >  {
> >       struct thermal_cooling_device *cool_dev;
> >       struct cpufreq_cooling_device *cpufreq_dev = NULL;
> > @@ -485,6 +751,7 @@ __cpufreq_cooling_register(struct device_node *np,
> >               return ERR_PTR(-ENOMEM);
> >
> >       cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
> > +     cpufreq_dev->capacitance = capacitance;
> >
> >       ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
> >       if (ret) {
> > @@ -531,7 +798,7 @@ __cpufreq_cooling_register(struct device_node *np,
> >  struct thermal_cooling_device *
> >  cpufreq_cooling_register(const struct cpumask *clip_cpus)
> >  {
> > -     return __cpufreq_cooling_register(NULL, clip_cpus);
> > +     return __cpufreq_cooling_register(NULL, clip_cpus, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
> >
> > @@ -555,11 +822,90 @@ of_cpufreq_cooling_register(struct device_node *np,
> >       if (!np)
> >               return ERR_PTR(-EINVAL);
> >
> > -     return __cpufreq_cooling_register(np, clip_cpus);
> > +     return __cpufreq_cooling_register(np, clip_cpus, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
> >
> >  /**
> > + * of_cpufreq_power_actor_register - function to create a cpu cooling device with power capabilities
> > + * @np:              a valid struct device_node to the cooling device tree node
> > + * @clip_cpus:       cpumask of cpus where the frequency constraints will happen
> > + * @capacitance:     the dynamic power coefficient for these cpus
> > + *
> > + * Similar to of_cpufreq_cooling_register() this function registers a
> > + * cooling device linked to the device tree node provided.  It has a
> > + * simple power model so that get_cur/get_max/set_cur can operate with
> > + * THERMAL_UNIT_POWER
> > + *
> > + * The cpus must have registered their OPPs in the OPP library.
> > + *
> > + * Return: a valid struct thermal_cooling_device pointer on success,
> > + * on failure, it returns a corresponding ERR_PTR().
> > + */
> > +struct thermal_cooling_device *
> > +of_cpufreq_power_actor_register(struct device_node *np,
> > +                             const struct cpumask *clip_cpus,
> > +                             u32 capacitance)
> > +{
> > +     struct thermal_cooling_device *cdev, *err_ret;
> > +     int ret;
> > +
> > +     cdev = __cpufreq_cooling_register(np, clip_cpus, capacitance);
> > +     if (IS_ERR(cdev))
> > +             return cdev;
> > +
> > +     ret = build_cpu_power_table(cdev->devdata);
> > +     if (ret) {
> > +             err_ret = ERR_PTR(ret);
> > +             goto unregister;
> > +     }
> > +
> > +     /*
> > +      * You can't register multiple times the same notifier_block.
> > +      * The first power actor registered is the only one that
> > +      * registers the notifier.
> > +      */
> > +     if (!power_actor_notifier_registered) {
> > +             ret = cpufreq_register_notifier(&cpufreq_transition_notifier,
> > +                                             CPUFREQ_TRANSITION_NOTIFIER);
> > +             if (ret) {
> > +                     err_ret = ERR_PTR(ret);
> > +                     goto unregister;
> > +             }
> > +             power_actor_notifier_registered = true;
> 
> I believe you need locking to update this global variable.

Yes.

> > +     }
> > +
> > +     return cdev;
> > +
> > +unregister:
> > +     cpufreq_cooling_unregister(cdev);
> > +     return err_ret;
> > +}
> > +EXPORT_SYMBOL_GPL(of_cpufreq_power_actor_register);
> 
> This needs documentation under Documentation/thermal/sysfs-api.txt.

It's gone, but the new functions will need to be documented, yes.

Thanks,
Javi

