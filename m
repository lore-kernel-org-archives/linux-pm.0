From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Thu, 19 Oct 2017 17:17:42 -0700
Message-ID: <000101d34938$da740870$8f5c1950$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> aiVvdxj7gLueDaiVwdfXxs
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:45683 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbdJTARt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Oct 2017 20:17:49 -0400
In-Reply-To: aiVvdxj7gLueDaiVwdfXxs
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: =?utf-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?utf-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>

Hi Thomas,

Note 1: I think it is just a coincidence that Len Brown also replied to
	this old e-mail earlier today.

Note 2: Rafael referred me to this e-mail about a week ago, after I was
	complaining about excessive energy consumption due to unused CPUs
	not going idle when they should. My example use case was a 100%
	load on one CPU.

Note 3: The patch does not work for me as it was sent. See notes in-line
	further below.

On 2017.07.27 05:50 Thomas Ilsche wrote:

> On several contemporary Intel systems, we have observed that the idle
> power consumption is sometimes significantly too high, e.g. 105 W =
instead
> of 74 W for several seconds.

On my test system, I do not observe this magnitude of excessive idle =
energy.
While I do observe occurrences of excessive time spent in idle state 0, =
they
do not add up to significant energy waste.

> We tracked this issue down to patterns that confuse the heuristic of =
the
> menu idle governor. If the governor observes several consecutive short
> sleeps, it does expect another short sleep duration despite no =
immediate
> timers, sending the CPU into a shallow sleep state. On a dyntick-idle
> kernel, there are no means for the core to enter a more efficient =
sleep
> state if the prediction was wrong. Ironically this is particularly
> problematic if some cores of the system have very infrequent activity, =
i.e.
> many cores and optimized configuration for low idle power.

If I use your "powernightmare" method (or idle-virus as Len called it)
I get a drastic package power consumption difference between
fallback_timer_enabled being enabled or disabled. It seems mainly due
to changes in time spent in idle state 2. There was also a contribution
from idle state 0 on one CPU. This was a surprise to me as my thinking =
was
that wasted energy was dominated by extra time in idle state 0.

Example data (kernel 4.14-rc5 + this patch):

Average package power with fallback timer disabled: ~8.06 watts
Average package power with fallback timer enabled: ~3.95 watts

> The effect, cause, triggers, mitigation technique and verification =
thereof
> are described in detail in the a paper that is pending publication =
[1].

The paper is very interesting. Thank you.

> Fixing the heuristic to make a better prediction does not seem to be
> generally feasible. The following patch addresses this issue by =
setting a
> timer such that when the an expected immediate wake-up fails to =
appear, the
> CPU is woken up to go into a deeper sleep state. If the heuristic was
> right, the timer is simply canceled.
>
> Please consider the patch a draft for discussion. We need to address:
>
>  * Avoid programming the fallback timer when the deepest sleep state =
is
>    already chosen.
>  * Determine good default values for the introduced configurables. =
This
>    is difficult due to the large variety of system configurations =
affected
>    by the menu governor. Nevertheless we believe this can be done such
>     that many systems benefit without significant degradation in any =
case.
>  * Document (or remove) the sysfs entries.
>
> But first, I would like to invite comments if this is going in the =
right
> direction, or if this should be addressed in a different way.

The problem I am struggling with is the patch makes no difference
for my example use case of 100% load on one CPU, others idle.
The wasted power is entirely from idle state 0, and idle state 0
times remain about the same with or without the fallback timer.
If I merely disable idle state 0, things are great. However,
just disabling idle state 0 does not help when "powermightmares"
are present.

Example data (kernel 4.14-rc5 + this patch):

Average package power with fallback timer disabled: ~27.2 watts
Average package power with fallback timer enabled: ~28 watts
Average package power with state 0 disabled, fallback timer disabled: =
~23.9 watts
Average package power with state 0 disabled, fallback timer enabled: =
~23.9 watts

Question: Could this be because I made a mistake re-basing the patch to =
kernel 4.14-rc5?
Answer: Perhaps. I am unfamiliar with this area of the code.

>
> [1] =
https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powe=
rnightmares.pdf
>
> Signed-off-by: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
> Signed-off-by: Marcus H=C3=A4hnel <mhaehnel@os.inf.tu-dresden.de>
> ---
>
> diff --git a/drivers/cpuidle/governors/menu.c =
b/drivers/cpuidle/governors/menu.c
> index 61b64c2b2cb8..45bbeb362809 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -22,6 +22,7 @@
>   #include <linux/sched/stat.h>
>   #include <linux/math64.h>
>   #include <linux/cpu.h>
> +#include <linux/smp.h>
>  =20
>   /*
>    * Please note when changing the tuning values:
> @@ -130,6 +131,10 @@ struct menu_device {
>   	unsigned int	correction_factor[BUCKETS];
>   	unsigned int	intervals[INTERVALS];
>   	int		interval_ptr;
> +
> +	struct hrtimer	fallback_timer;
> +	int             have_timer;
> +	unsigned int	disregard_past;
>   };
>  =20
>  =20
> @@ -190,6 +195,85 @@ static inline int performance_multiplier(unsigned =
long nr_iowaiters, unsigned lo
>  =20
>   static DEFINE_PER_CPU(struct menu_device, menu_devices);
>  =20
> +static unsigned int fallback_timer_disregard_past =3D 1;
> +static unsigned int diff_threshold_bits =3D 8;
> +static unsigned int fallback_timer_enabled;

Shouldn't fallback_timer_enabled be initialized?
On my system it defaults to 0, or disabled, and due to another problem,
see further down, this patch wasn't working.

> +static unsigned int fallback_timer_interval_us =3D 10000;
> +
> +#define MENU_ATTR_RW(name, var, range_min, range_max, wfun) \
> +	static ssize_t show_##name(struct device *dev, \
> +				   struct device_attribute *attr, char *buf) \
> +	{ \
> +		return snprintf(buf, 12, "%i\n", var); \
> +	} \
> +	static ssize_t store_##name(struct device *dev, \
> +				    struct device_attribute *attr, \
> +				    const char *buf, size_t count) \
> +	{ \
> +		unsigned int tmp; \
> +		int ret =3D kstrtouint(buf, 10, &tmp); \
> +		if (ret !=3D 1) \

Shouldn't this be:

 +		if (ret !=3D 0) \

(or maybe just " if (ret) \". I did (and therefore tested) the previous.

?
Anyway, it doesn't work unless I make this change.

> +			return -EINVAL; \
> +		if (tmp > range_max || tmp < range_min) { \
> +			pr_warn("value outside of valid range [%u, %u]\n", \
> +				range_min, range_max); \
> +			return -EINVAL; \
> +		} \
> +		var =3D tmp; \
> +		wfun \
> +		return count; \
> +	} \
> +	static DEVICE_ATTR(fallback_timer_##name, 0644, \
> +			   show_##name, store_##name)
> +
> +MENU_ATTR_RW(threshold_bits, diff_threshold_bits, 0, 31, {});
> +
> +MENU_ATTR_RW(enable, fallback_timer_enabled, 0, 1, {
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		struct menu_device *data =3D per_cpu_ptr(&menu_devices, i);
> +
> +		if (!fallback_timer_enabled) {
> +			data->have_timer =3D 0;
> +			hrtimer_cancel(&(data->fallback_timer));
> +		}
> +	} });
> +
> +MENU_ATTR_RW(interval_us, fallback_timer_interval_us, 1, 1000000, =
{});
> +
> +MENU_ATTR_RW(disregard_past, fallback_timer_disregard_past, 0, 1, {
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		struct menu_device *data =3D per_cpu_ptr(&menu_devices, i);
> +
> +		data->disregard_past =3D 0;
> +	} });
> +
> +static struct attribute *menu_attrs[] =3D {
> +	&dev_attr_fallback_timer_threshold_bits.attr,
> +	&dev_attr_fallback_timer_enable.attr,
> +	&dev_attr_fallback_timer_interval_us.attr,
> +	&dev_attr_fallback_timer_disregard_past.attr,
> +	NULL
> +};
> +
> +static struct attribute_group menu_attr_group =3D {
> +	.attrs =3D menu_attrs,
> +	.name =3D "cpuidle_menu",
> + };
> +
> +int menu_add_interface(struct device *dev)
> +{
> +	return sysfs_create_group(&dev->kobj, &menu_attr_group);
> +}
> +
> +void menu_remove_interface(struct device *dev)
> +{
> +	sysfs_remove_group(&dev->kobj, &menu_attr_group);
> +}
> +
>   static void menu_update(struct cpuidle_driver *drv, struct =
cpuidle_device *dev);
>  =20
>   /*
> @@ -275,6 +359,14 @@ static unsigned int get_typical_interval(struct =
menu_device *data)
>   	goto again;
>   }
>  =20
> +static enum hrtimer_restart fallback_timer_fun(struct hrtimer *tmr)
> +{
> +	struct menu_device *mdata =3D this_cpu_ptr(&menu_devices);
> +
> +	mdata->disregard_past =3D 1;
> +	return HRTIMER_NORESTART;
> +}
> +
>   /**
>    * menu_select - selects the next idle state to enter
>    * @drv: cpuidle driver containing state data
> @@ -293,6 +385,11 @@ static int menu_select(struct cpuidle_driver =
*drv, struct cpuidle_device *dev)
>   	unsigned long nr_iowaiters, cpu_load;
>   	int resume_latency =3D dev_pm_qos_raw_read_value(device);
>  =20
> +	if (fallback_timer_enabled && data->have_timer) {
> +		data->have_timer =3D 0;
> +		hrtimer_cancel(&(data->fallback_timer));
> +	}
> +
>   	if (data->needs_update) {
>   		menu_update(drv, dev);
>   		data->needs_update =3D 0;
> @@ -322,7 +419,32 @@ static int menu_select(struct cpuidle_driver =
*drv, struct cpuidle_device *dev)
>   					 RESOLUTION * DECAY);
>  =20
>   	expected_interval =3D get_typical_interval(data);
> -	expected_interval =3D min(expected_interval, data->next_timer_us);
> +
> +	if (fallback_timer_enabled && fallback_timer_disregard_past
> +	    && data->disregard_past)  {
> +		expected_interval =3D data->next_timer_us;
> +		// Only disregard the past once! Then try again
> +		data->disregard_past =3D 0;
> +	} else {
> +		if (fallback_timer_enabled
> +		    && expected_interval < (data->next_timer_us >> =
diff_threshold_bits)
> +		    && data->next_timer_us > fallback_timer_interval_us * 2) {
> +			/*
> +			 * Program the fallback timer if the gap between the
> +			 * expected interval by heuristic and the next regular
> +			 * timer are too far apart.
> +			 * However, only do this when we didn't just wakup from
> +			 * a timer and are told to disregard the heuristic
> +			 */
> +			ktime_t interval =3D
> +				ktime_set(0, fallback_timer_interval_us * 1000);
> +
> +			hrtimer_start(&(data->fallback_timer), interval,
> +				      HRTIMER_MODE_REL_PINNED);
> +			data->have_timer =3D 1;
> +		}
> +		expected_interval =3D min(expected_interval, data->next_timer_us);
> +	}
> =20
>  	if (CPUIDLE_DRIVER_STATE_START > 0) {
>  		struct cpuidle_state *s =3D =
&drv->states[CPUIDLE_DRIVER_STATE_START];
> @@ -398,6 +520,11 @@ static void menu_reflect(struct cpuidle_device =
*dev, int index)
>  {
>  	struct menu_device *data =3D this_cpu_ptr(&menu_devices);
> =20
> +	if (fallback_timer_enabled && data->have_timer) {
> +		data->have_timer =3D 0;
> +		hrtimer_cancel(&data->fallback_timer);
> +	}
> +
>  	data->last_state_idx =3D index;
>  	data->needs_update =3D 1;
>  }
> @@ -486,6 +613,10 @@ static int menu_enable_device(struct =
cpuidle_driver *drv,
> =20
>  	memset(data, 0, sizeof(struct menu_device));
>  =20
> +	hrtimer_init(&(data->fallback_timer),
> +		     CLOCK_REALTIME, HRTIMER_MODE_REL_PINNED);
> +	data->fallback_timer.function =3D fallback_timer_fun;
> +
>  	/*
>  	 * if the correction factor is 0 (eg first time init or cpu hotplug
>  	 * etc), we actually want to start out with a unity factor.
> @@ -509,6 +640,10 @@ static struct cpuidle_governor menu_governor =3D =
{
>   */
>  static int __init init_menu(void)
>  {
> +	int ret =3D menu_add_interface(cpu_subsys.dev_root);
> +
> +	if (ret)
> +		return ret;
>  	return cpuidle_register_governor(&menu_governor);
>  }
=20
