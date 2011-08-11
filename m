From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v5 1/3] PM: Introduce DEVFREQ: generic DVFS
 framework with device-specific OPPs
Date: Wed, 10 Aug 2011 18:00:42 -0700
Message-ID: <CAJOA=zNb_S-CXDBE0VH98A-0OTB7HRiCAeV89LW7t8ZoaydBVg@mail.gmail.com>
References: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
	<1312794188-9823-2-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1312794188-9823-2-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 8, 2011 at 2:03 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wro=
te:
> With OPPs, a device may have multiple operable frequency and voltage
> sets. However, there can be multiple possible operable sets and a system
> will need to choose one from them. In order to reduce the power
> consumption (by reducing frequency and voltage) without affecting the
> performance too much, a Dynamic Voltage and Frequency Scaling (DVFS)
> scheme may be used.
>
> This patch introduces the DVFS capability to non-CPU devices with OPPs.
> DVFS is a techique whereby the frequency and supplied voltage of a
> device is adjusted on-the-fly. DVFS usually sets the frequency as low
> as possible with given conditions (such as QoS assurance) and adjusts
> voltage according to the chosen frequency in order to reduce power
> consumption and heat dissipation.
>
> The generic DVFS for devices, DEVFREQ, may appear quite similar with
> /drivers/cpufreq. =A0However, CPUFREQ does not allow to have multiple
> devices registered and is not suitable to have multiple heterogenous
> devices with different (but simple) governors.
>
> Normally, DVFS mechanism controls frequency based on the demand for
> the device, and then, chooses voltage based on the chosen frequency.
> DEVFREQ also controls the frequency based on the governor's frequency
> recommendation and let OPP pick up the pair of frequency and voltage
> based on the recommended frequency. Then, the chosen OPP is passed to
> device driver's "target" callback.
>
> When PM QoS is going to be used with the DEVFREQ device, the device
> driver should enable OPPs that are appropriate with the current PM QoS
> requests. In order to do so, the device driver may call opp_enable and
> opp_disable at the notifier callback of PM QoS so that PM QoS's
> update_target() call enables the appropriate OPPs. Note that at least
> one of OPPs should be enabled at any time; be careful when there is a
> transition.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> ---
> Tested with memory bus of Exynos4-NURI board.
>
> The test code with board support for Exynos4-NURI is at
> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/hea=
ds/devfreq
>
> ---
> Thank you for your valuable comments, Rafael, Greg, Pavel, Colin, Mike,
> and Kevin.
>
> Changed from v4
> - Removed tickle, which is a duplicated feature; PM QoS can do the same.
> - Allow to extend polling interval if devices have longer polling interva=
ls.
> - Relocated private data of governors.
> - Removed system-wide sysfs
>
> Changed from v3
> - In kerneldoc comments, DEVFREQ has ben replaced by devfreq
> - Revised removing devfreq entries with error mechanism
> - Added and revised comments
> - Removed unnecessary codes
> - Allow to give a name to a governor
> - Bugfix: a tickle call may cancel an older tickle call that is still in
> =A0effect.
>
> Changed from v2
> - Code style revised and cleaned up.
> - Remove DEVFREQ entries that incur errors except for EAGAIN
> - Bug fixed: tickle for devices without polling governors
>
> Changes from v1(RFC)
> - Rename: DVFS --> DEVFREQ
> - Revised governor design
> =A0 =A0. Governor receives the whole struct devfreq
> =A0 =A0. Governor should gather usage information (thru get_dev_status)
> itself
> - Periodic monitoring runs only when needed.
> - DEVFREQ no more deals with voltage information directly
> - Removed some printks.
> - Some cosmetics update
> - Use freezable_wq.
> ---
> =A0drivers/base/power/Makefile =A0| =A0 =A01 +
> =A0drivers/base/power/devfreq.c | =A0303 ++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/base/power/opp.c =A0 =A0 | =A0 =A09 ++
> =A0include/linux/devfreq.h =A0 =A0 =A0| =A0103 ++++++++++++++
> =A0kernel/power/Kconfig =A0 =A0 =A0 =A0 | =A0 34 +++++
> =A05 files changed, 450 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/base/power/devfreq.c
> =A0create mode 100644 include/linux/devfreq.h
>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 3647e11..20118dc 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_RUNTIME) =A0 =A0 =A0 =A0+=3D runtime.o
> =A0obj-$(CONFIG_PM_TRACE_RTC) =A0 =A0 +=3D trace.o
> =A0obj-$(CONFIG_PM_OPP) =A0 +=3D opp.o
> =A0obj-$(CONFIG_HAVE_CLK) +=3D clock_ops.o
> +obj-$(CONFIG_PM_DEVFREQ) =A0 =A0 =A0 +=3D devfreq.o
>
> =A0ccflags-$(CONFIG_DEBUG_DRIVER) :=3D -DDEBUG
> \ No newline at end of file
> diff --git a/drivers/base/power/devfreq.c b/drivers/base/power/devfreq.c
> new file mode 100644
> index 0000000..6f4bd3a
> --- /dev/null
> +++ b/drivers/base/power/devfreq.c
> @@ -0,0 +1,303 @@
> +/*
> + * devfreq: Generic Dynamic Voltage and Frequency Scaling (DVFS) Framewo=
rk
> + * =A0 =A0 =A0 =A0 for Non-CPU Devices Based on OPP.
> + *
> + * Copyright (C) 2011 Samsung Electronics
> + * =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/opp.h>
> +#include <linux/devfreq.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_device.h>
> +#include <linux/list.h>
> +#include <linux/printk.h>
> +#include <linux/hrtimer.h>
> +
> +/*
> + * devfreq polling interval in ms.
> + * It is recommended to be "jiffy_in_ms" * n, where n is an integer >=3D=
 1.
> + */
> +static unsigned int devfreq_interval =3D 20;

Instead of devfreq_interval, how about devices specify their
devfreq->profile->polling_ms which gets turned into a jiffies value
called devfreq->profile->next_monitor?  devfreq->profile->next_monitor
is a jiffies value some time in the future.

When the monitor is run then devfreq->profile->next_monitor will
simply be "jiffies + msecs_to_jiffies(devfreq->profile->polling_ms)".
That would remove the unnecessary interval which is pretty restrictive
for someone that *really* wants a 50ms polling interval (not a
multiple of 20).

Then something like the following can be done in devfreq_monitor:

	unsigned long next_monitor =3D UINT_MAX;
	for_each_entry(devfreq, &devfreq_list, node) {
		next_monitor =3D minimum(next_monitor, devfreq->next_monitor);
	}
	queue_delayed_work(devfreq_wq, &devfreq_work, next_monitor);

> +
> +/*
> + * devfreq_work periodically (given by devfreq_interval) monitors every
> + * registered device.
> + */
> +static bool polling;

Since patchset v5 removes tickle (so as not to duplicate a QoS
constraint), devfreq should no longer handle any non-polling DVFS
transitions, which can also be expressed through a QoS constraint.
Any static constraint requests from other drivers will use the QoS API
and not devfreq.  As such "polling" can be removed and all the code
that touches it since polling is assumed.  Why use devfreq if you're
not going to poll?

This also makes the performance and powersave governors redundant, and
possibly the userspace governor as well since QoS requests can just as
easily achieve the sort of constraints desirable for a non-polling
implementation.

This also touches on another point that I'll elaborate more on below,
which is that timer queueing/scheduling should be implemented by the
governors, not the core code.

> +static ktime_t last_polled_at;
> +static struct workqueue_struct *devfreq_wq;
> +static struct delayed_work devfreq_work;

Polling should not be implemented in core code.  Instead the devfreq
devices should define their own delayed_work and governors should
schedule that work, possibly with governor-specific work queues, or
using the kernel global workqueue.  E.g: simple-ondemand should have
its own workqueue and each device have it's own delayed_work;
something like devfreq->governor->wq and devfreq->work would suffice.

This is better aligned with CPUfreq, which leaves polling details to
the governors.  For example cpufreq-ondemand has delayed_work for each
CPU and that governor schedules the work, not core code.  Core code
handles little more than registration and sysfs events (including
switching governors).

Some other benefits are increased debugging capability (we know which
governor failed, we know which device failed, etc) by separating the
work queues and the work structs and it simplifies having to figure
out some min_polling/next_polling since workqueues do that for us when
we schedule multiple pieces of work, all with different delays.

> +
> +/* The list of all device-devfreq */
> +static LIST_HEAD(devfreq_list);
> +static DEFINE_MUTEX(devfreq_list_lock);
> +
> +/**
> + * find_device_devfreq() - find devfreq struct using device pointer
> + * @dev: =A0 =A0 =A0 device pointer used to lookup device devfreq.
> + *
> + * Search the list of device devfreqs and return the matched device's
> + * devfreq info. devfreq_list_lock should be held by the caller.
> + */
> +static struct devfreq *find_device_devfreq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct devfreq *tmp_devfreq;
> +
> + =A0 =A0 =A0 if (unlikely(IS_ERR_OR_NULL(dev))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("DEVFREQ: %s: Invalid parameters\n",=
 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_for_each_entry(tmp_devfreq, &devfreq_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp_devfreq->dev =3D=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tmp_devfreq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ERR_PTR(-ENODEV);
> +}
> +
> +/**
> + * devfreq_do() - Check the usage profile of a given device and configure
> + * =A0 =A0 =A0 =A0 =A0 =A0 frequency and voltage accordingly
> + * @devfreq: =A0 devfreq info of the given device
> + */
> +static int devfreq_do(struct devfreq *devfreq)
> +{
> + =A0 =A0 =A0 struct opp *opp;
> + =A0 =A0 =A0 unsigned long freq;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D devfreq->governor->get_target_freq(devfreq, &freq);

Following along with my comments above, the semantics of calling
get_target_freq in devfreq_do are backwards.  This code should go in
the governor and is analogous to the various dbs_check_cpu functions
in those governors.

> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 opp =3D opp_find_freq_ceil(devfreq->dev, &freq);

I know that devfreq was originally developed with OPP as a
requirement, but there is no reason to include such details in
devfreq.  Many platforms may not adopt the OPP libary.

How about the governor calls devfreq->profile->get_target_freq in it's
decision making function (e.g. dbs_check_cpu) and then calls
devfreq->profile->target with the frequency from that same function,
only this time passing in the frequency instead of an OPP?

That target function can determine what to do with the frequency.  In
the case of Exoyns4 the target function can use the OPP library.  In
the case of a simpler device it might just make a clk_set_rate call.
This also removes the drama from V1 of this patchset where the use of
OPP library itself was disputed and allows devfreq to be more generic.

> + =A0 =A0 =A0 if (opp =3D=3D ERR_PTR(-ENODEV))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 opp =3D opp_find_freq_floor(devfreq->dev, &=
freq);
> +
> + =A0 =A0 =A0 if (IS_ERR(opp))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(opp);
> +
> + =A0 =A0 =A0 if (devfreq->previous_freq =3D=3D freq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 err =3D devfreq->profile->target(devfreq->dev, opp);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 devfreq->previous_freq =3D freq;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * devfreq_monitor() - Periodically run devfreq_do()
> + * @work: the work struct used to run devfreq_monitor periodically.
> + *
> + */
> +static void devfreq_monitor(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq, *tmp;
> + =A0 =A0 =A0 int error;
> + =A0 =A0 =A0 unsigned int next_poll_min =3D UINT_MAX;
> + =A0 =A0 =A0 ktime_t now =3D ktime_get();
> + =A0 =A0 =A0 s64 time_passed =3D ktime_to_ms(ktime_sub(now, last_polled_=
at));
> + =A0 =A0 =A0 int iterations_passed =3D 1;
> +
> + =A0 =A0 =A0 /* If n * devfreq_interval has passed, count it */
> + =A0 =A0 =A0 do_div(time_passed, devfreq_interval);
> + =A0 =A0 =A0 if (time_passed > 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iterations_passed =3D time_passed;
> + =A0 =A0 =A0 last_polled_at =3D now;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 list_for_each_entry_safe(devfreq, tmp, &devfreq_list, node)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Reduce more next_polling if devfreq_wq=
 took an extra
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* delay. (i.e., CPU has been idled.)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling <=3D iterations_p=
assed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D devfreq_do(devfre=
q);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Remove a devfreq with an=
 error. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error && error !=3D -EA=
GAIN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev=
freq->dev, "devfreq_do error(%d). "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "devfreq is removed from the device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 error);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&d=
evfreq->node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(devfr=
eq);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->next_polling =3D D=
IV_ROUND_UP(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 devfreq->profile->polling_ms,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 devfreq_interval);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No more polling required=
 (polling_ms changed) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling =
=3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->next_polling -=3D =
iterations_passed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_poll_min =3D (next_poll_min > devfreq-=
>next_polling) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->ne=
xt_polling : next_poll_min;
> + =A0 =A0 =A0 }

Again, I find this whole method of using devfreq_interval and
evaluating every single device in a single delayed_work in a single
workqueue unintuitive.  workqueues already do the job of taking many
pieces of future work and ordering them based on their delay, so why
should we replicate that pattern here by grouping all work together
and manually determining when to run the monitor?

> +
> + =A0 =A0 =A0 if (next_poll_min > 0 && next_poll_min < UINT_MAX) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 polling =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(devfreq_wq, &devfreq_wor=
k, msecs_to_jiffies(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0devfreq_interval * next_poll_min));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 polling =3D false;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> +}
> +
> +/**
> + * devfreq_add_device() - Add devfreq feature to the device
> + * @dev: =A0 =A0 =A0 the device to add devfreq feature.
> + * @profile: =A0 device-specific profile to run devfreq.
> + * @governor: =A0the policy to choose frequency.
> + */
> +int devfreq_add_device(struct device *dev, struct devfreq_dev_profile *p=
rofile,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_governor *gov=
ernor)
> +{
> + =A0 =A0 =A0 struct devfreq *new_devfreq, *devfreq;

Why use new_devfreq at all?  devfreq can be reused after checking for
error conditions.

> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 if (!dev || !profile || !governor) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: Invalid parameters.\n", _=
_func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 devfreq =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 if (!IS_ERR(devfreq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: Unable to create devfreq =
for the device. "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "It already has one.\n", __=
func__);

Put the error string all on one line, even if it goes past 80 chars.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 new_devfreq =3D kzalloc(sizeof(struct devfreq), GFP_KERNEL);
> + =A0 =A0 =A0 if (!new_devfreq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: Unable to create devfreq =
for the device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 new_devfreq->dev =3D dev;
> + =A0 =A0 =A0 new_devfreq->profile =3D profile;
> + =A0 =A0 =A0 new_devfreq->governor =3D governor;
> + =A0 =A0 =A0 new_devfreq->next_polling =3D DIV_ROUND_UP(profile->polling=
_ms,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0devfreq_interval);
> + =A0 =A0 =A0 new_devfreq->previous_freq =3D profile->initial_freq;
> +
> + =A0 =A0 =A0 list_add(&new_devfreq->node, &devfreq_list);
> +
> + =A0 =A0 =A0 if (devfreq_wq && new_devfreq->next_polling && !polling) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 polling =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(devfreq_wq, &devfreq_wor=
k,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec=
s_to_jiffies(devfreq_interval));
> + =A0 =A0 =A0 }
> +out:
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +/**
> + * devfreq_remove_device() - Remove devfreq feature from a device.
> + * @device: =A0 =A0the device to remove devfreq feature.
> + */
> +int devfreq_remove_device(struct device *dev)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq;
> +
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 devfreq =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 if (IS_ERR(devfreq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: Unable to find devfreq en=
try for the device.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_del(&devfreq->node);
> +
> + =A0 =A0 =A0 kfree(devfreq);
> +
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * devfreq_update() - Notify that the device OPP has been changed.
> + * @dev: =A0 =A0 =A0 the device whose OPP has been changed.
> + */
> +int devfreq_update(struct device *dev)

OPP library should implement notifiers which devfreq can subscribe to,
instead of hacking this code into the OPP libary.  I've looped in
Nishanth Menon, author of OPP library, to comment.

> +{
> + =A0 =A0 =A0 struct devfreq *devfreq;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 devfreq =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 if (IS_ERR(devfreq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(devfreq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Reevaluate the proper frequency */
> + =A0 =A0 =A0 err =3D devfreq_do(devfreq);
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> + =A0 =A0 =A0 return err;
> +}
> +
> +/**
> + * devfreq_init() - Initialize data structure for devfreq framework and
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 start polling registered devfreq devices.
> + */
> +static int __init devfreq_init(void)
> +{
> + =A0 =A0 =A0 devfreq_interval =3D jiffies_to_msecs(msecs_to_jiffies(devf=
req_interval));
> + =A0 =A0 =A0 if (devfreq_interval <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("DEVFREQ: devfreq_interval too small=
.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 polling =3D false;
> + =A0 =A0 =A0 devfreq_wq =3D create_freezable_workqueue("devfreq_wq");
> + =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&devfreq_work, devfreq_monitor=
);
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 last_polled_at =3D ktime_get();
> + =A0 =A0 =A0 devfreq_monitor(&devfreq_work.work);
> + =A0 =A0 =A0 return 0;
> +}
> +late_initcall(devfreq_init);
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 56a6899..819c1b3 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -21,6 +21,7 @@
> =A0#include <linux/rculist.h>
> =A0#include <linux/rcupdate.h>
> =A0#include <linux/opp.h>
> +#include <linux/devfreq.h>
>
> =A0/*
> =A0* Internal data structure organization with the OPP layer library is as
> @@ -428,6 +429,11 @@ int opp_add(struct device *dev, unsigned long freq, =
unsigned long u_volt)
> =A0 =A0 =A0 =A0list_add_rcu(&new_opp->node, head);
> =A0 =A0 =A0 =A0mutex_unlock(&dev_opp_list_lock);
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Notify generic dvfs for the change and ignore error
> + =A0 =A0 =A0 =A0* because the device may not have a devfreq entry
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 devfreq_update(dev);

Same comment as above.

> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -512,6 +518,9 @@ unlock:
> =A0 =A0 =A0 =A0mutex_unlock(&dev_opp_list_lock);
> =A0out:
> =A0 =A0 =A0 =A0kfree(new_opp);
> +
> + =A0 =A0 =A0 /* Notify generic dvfs for the change and ignore error */
> + =A0 =A0 =A0 devfreq_update(dev);
> =A0 =A0 =A0 =A0return r;

Same comment as above.

Regards,
Mike

> =A0}
>
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> new file mode 100644
> index 0000000..6ec630b
> --- /dev/null
> +++ b/include/linux/devfreq.h
> @@ -0,0 +1,103 @@
> +/*
> + * devfreq: Generic Dynamic Voltage and Frequency Scaling (DVFS) Framewo=
rk
> + * =A0 =A0 =A0 =A0 for Non-CPU Devices Based on OPP.
> + *
> + * Copyright (C) 2011 Samsung Electronics
> + * =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_DEVFREQ_H__
> +#define __LINUX_DEVFREQ_H__
> +
> +#define DEVFREQ_NAME_LEN 16
> +
> +struct devfreq;
> +struct devfreq_dev_status {
> + =A0 =A0 =A0 /* both since the last measure */
> + =A0 =A0 =A0 unsigned long total_time;
> + =A0 =A0 =A0 unsigned long busy_time;
> + =A0 =A0 =A0 unsigned long current_frequency;
> +};
> +
> +struct devfreq_dev_profile {
> + =A0 =A0 =A0 unsigned long max_freq; /* may be larger than the actual va=
lue */
> + =A0 =A0 =A0 unsigned long initial_freq;
> + =A0 =A0 =A0 int polling_ms; /* 0 for at opp change only */
> +
> + =A0 =A0 =A0 int (*target)(struct device *dev, struct opp *opp);
> + =A0 =A0 =A0 int (*get_dev_status)(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devfreq_=
dev_status *stat);
> +};
> +
> +/**
> + * struct devfreq_governor - Devfreq policy governor
> + * @name =A0 =A0 =A0 =A0 =A0 =A0 =A0 Governor's name
> + * @get_target_freq =A0 =A0Returns desired operating frequency for the d=
evice.
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Basically, get_target_freq wi=
ll run
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq_dev_profile.get_dev_s=
tatus() to get the
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status of the device (load =
=3D busy_time / total_time).
> + */
> +struct devfreq_governor {
> + =A0 =A0 =A0 char name[DEVFREQ_NAME_LEN];
> + =A0 =A0 =A0 int (*get_target_freq)(struct devfreq *this, unsigned long =
*freq);
> +};
> +
> +/**
> + * struct devfreq - Device devfreq structure
> + * @node =A0 =A0 =A0 list node - contains the devices with devfreq that =
have been
> + * =A0 =A0 =A0 =A0 =A0 =A0 registered.
> + * @dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device pointer
> + * @profile =A0 =A0device-specific devfreq profile
> + * @governor =A0 method how to choose frequency based on the usage.
> + * @previous_freq =A0 =A0 =A0previously configured frequency value.
> + * @next_polling =A0 =A0 =A0 the number of remaining "devfreq_monitor" e=
xecutions to
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reevaluate frequency/voltage =
of the device. Set by
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 profile's polling_ms interval.
> + * @data =A0 =A0 =A0 Private data of the governor. The devfreq framework=
 does not
> + * =A0 =A0 =A0 =A0 =A0 =A0 touch this.
> + *
> + * This structure stores the devfreq information for a give device.
> + */
> +struct devfreq {
> + =A0 =A0 =A0 struct list_head node;
> +
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct devfreq_dev_profile *profile;
> + =A0 =A0 =A0 struct devfreq_governor *governor;
> +
> + =A0 =A0 =A0 unsigned long previous_freq;
> + =A0 =A0 =A0 unsigned int next_polling;
> +
> + =A0 =A0 =A0 void *data; /* private data for governors */
> +};
> +
> +#if defined(CONFIG_PM_DEVFREQ)
> +extern int devfreq_add_device(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_dev_p=
rofile *profile,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_gover=
nor *governor);
> +extern int devfreq_remove_device(struct device *dev);
> +extern int devfreq_update(struct device *dev);
> +#else /* !CONFIG_PM_DEVFREQ */
> +static int devfreq_add_device(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_dev_p=
rofile *profile,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_gover=
nor *governor)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int devfreq_remove_device(struct device *dev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int devfreq_update(struct device *dev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +#endif /* CONFIG_PM_DEVFREQ */
> +
> +#endif /* __LINUX_DEVFREQ_H__ */
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 87f4d24..b7e15c8 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -227,3 +227,37 @@ config PM_OPP
> =A0config PM_RUNTIME_CLK
> =A0 =A0 =A0 =A0def_bool y
> =A0 =A0 =A0 =A0depends on PM_RUNTIME && HAVE_CLK
> +
> +config ARCH_HAS_DEVFREQ
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on ARCH_HAS_OPP
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Denotes that the architecture supports DEVFREQ. If the =
architecture
> + =A0 =A0 =A0 =A0 supports multiple OPP entries per device and the freque=
ncy of the
> + =A0 =A0 =A0 =A0 devices with OPPs may be altered dynamically, the archi=
tecture
> + =A0 =A0 =A0 =A0 supports DEVFREQ.
> +
> +config PM_DEVFREQ
> + =A0 =A0 =A0 bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) =
Framework"
> + =A0 =A0 =A0 depends on PM_OPP && ARCH_HAS_DEVFREQ
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 With OPP support, a device may have a list of frequenci=
es and
> + =A0 =A0 =A0 =A0 voltages available. DEVFREQ, a generic DVFS framework c=
an be
> + =A0 =A0 =A0 =A0 registered for a device with OPP support in order to le=
t the
> + =A0 =A0 =A0 =A0 governor provided to DEVFREQ choose an operating freque=
ncy
> + =A0 =A0 =A0 =A0 based on the OPP's list and the policy given with DEVFR=
EQ.
> +
> + =A0 =A0 =A0 =A0 Each device may have its own governor and policy. DEVFR=
EQ can
> + =A0 =A0 =A0 =A0 reevaluate the device state periodically and/or based o=
n the
> + =A0 =A0 =A0 =A0 OPP list changes (each frequency/voltage pair in OPP ma=
y be
> + =A0 =A0 =A0 =A0 disabled or enabled).
> +
> + =A0 =A0 =A0 =A0 Like some CPUs with CPUFREQ, a device may have multiple=
 clocks.
> + =A0 =A0 =A0 =A0 However, because the clock frequencies of a single devi=
ce are
> + =A0 =A0 =A0 =A0 determined by the single device's state, an instance of=
 DEVFREQ
> + =A0 =A0 =A0 =A0 is attached to a single device and returns a "represent=
ative"
> + =A0 =A0 =A0 =A0 clock frequency from the OPP of the device, which is al=
so attached
> + =A0 =A0 =A0 =A0 to a device by 1-to-1. The device registering DEVFREQ t=
akes the
> + =A0 =A0 =A0 =A0 responsiblity to "interpret" the frequency listed in OP=
P and
> + =A0 =A0 =A0 =A0 to set its every clock accordingly with the "target" ca=
llback
> + =A0 =A0 =A0 =A0 given to DEVFREQ.
> --
> 1.7.4.1
>
>
