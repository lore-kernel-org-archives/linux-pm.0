From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v6-resubmit of 2/4] PM: Introduce DEVFREQ:
 generic DVFS framework with device-specific OPPs
Date: Mon, 22 Aug 2011 11:19:32 -0700
Message-ID: <CAJOA=zMRu52Pcj+ViXbZcX+uzmA8t6v4WiPa4URy3C1YxnXE1g@mail.gmail.com>
References: <CAJOA=zPyG5Yn1bBR1sPxhsEh=n_+_4+whGWy4fKEzNbTvUvhkA@mail.gmail.com>
	<1313742609-3446-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313742609-3446-1-git-send-email-myungjoo.ham@samsung.com>
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

On Fri, Aug 19, 2011 at 1:30 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
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
> The test code with board support for Exynos4-NURI is at
> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/hea=
ds/devfreq
>
> ---
> Thank you for your valuable comments, Rafael, Greg, Pavel, Colin, Mike,
> and Kevin.
>
> Changes at v6-resubmit from v6
> - Use jiffy directly instead of ktime
> - Be prepared for profile->polling_ms changes (not supported fully at
> =A0this stage)
>
> Changes from v5
> - Uses OPP availability change notifier
> - Removed devfreq_interval. Uses one jiffy instead. DEVFREQ adjusts
> =A0polling interval based on the interval requirement of DEVFREQ
> =A0devices.
> - Moved devfreq to /drivers/devfreq to accomodate devfreq-related files
> =A0including governors and devfreq drivers.
> - Coding style revised.
> - Updated devfreq_add_device interface to get tunable values.
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
> =A0 =A0 =A0 =A0. Governor receives the whole struct devfreq
> =A0 =A0 =A0 =A0. Governor should gather usage information (thru get_dev_s=
tatus) itself
> - Periodic monitoring runs only when needed.
> - DEVFREQ no more deals with voltage information directly
> - Removed some printks.
> - Some cosmetics update
> - Use freezable_wq.
> ---
> =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/devfreq/Kconfig =A0 | =A0 39 ++++++
> =A0drivers/devfreq/Makefile =A0| =A0 =A01 +
> =A0drivers/devfreq/devfreq.c | =A0312 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A0include/linux/devfreq.h =A0 | =A0111 ++++++++++++++++
> =A06 files changed, 467 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/devfreq/Kconfig
> =A0create mode 100644 drivers/devfreq/Makefile
> =A0create mode 100644 drivers/devfreq/devfreq.c
> =A0create mode 100644 include/linux/devfreq.h
>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 95b9e7e..a1efd75 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -130,4 +130,6 @@ source "drivers/iommu/Kconfig"
>
> =A0source "drivers/virt/Kconfig"
>
> +source "drivers/devfreq/Kconfig"
> +
> =A0endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 7fa433a..97c957b 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -127,3 +127,5 @@ obj-$(CONFIG_IOMMU_SUPPORT) +=3D iommu/
>
> =A0# Virtualization drivers
> =A0obj-$(CONFIG_VIRT_DRIVERS) =A0 =A0 +=3D virt/
> +
> +obj-$(CONFIG_PM_DEVFREQ) =A0 =A0 =A0 +=3D devfreq/
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> new file mode 100644
> index 0000000..1fb42de
> --- /dev/null
> +++ b/drivers/devfreq/Kconfig
> @@ -0,0 +1,39 @@
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
> +menuconfig PM_DEVFREQ
> + =A0 =A0 =A0 bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) =
support"
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
> +
> +if PM_DEVFREQ
> +
> +comment "DEVFREQ Drivers"
> +
> +endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> new file mode 100644
> index 0000000..168934a
> --- /dev/null
> +++ b/drivers/devfreq/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_PM_DEVFREQ) =A0 =A0 =A0 +=3D devfreq.o
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> new file mode 100644
> index 0000000..af848ffa
> --- /dev/null
> +++ b/drivers/devfreq/devfreq.c
> @@ -0,0 +1,312 @@
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
> + * devfreq_work periodically monitors every registered device.
> + * The minimum polling interval is one jiffy. The polling interval is
> + * determined by the minimum polling period among all polling devfreq
> + * devices. The resolution of polling interval is one jiffy.
> + */
> +static bool polling;
> +static struct workqueue_struct *devfreq_wq;
> +static struct delayed_work devfreq_work;
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
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 opp =3D opp_find_freq_ceil(devfreq->dev, &freq);
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
> + * devfreq_update() - Notify that the device OPP has been changed.
> + * @dev: =A0 =A0 =A0 the device whose OPP has been changed.
> + */
> +static int devfreq_update(struct notifier_block *nb, unsigned long type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *devp)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 devfreq =3D container_of(nb, struct devfreq, nb);
> + =A0 =A0 =A0 /* Reevaluate the proper frequency */
> + =A0 =A0 =A0 err =3D devfreq_do(devfreq);
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> + =A0 =A0 =A0 return err;
> +}
> +
> +/**
> + * devfreq_monitor() - Periodically run devfreq_do()
> + * @work: the work struct used to run devfreq_monitor periodically.
> + *
> + */
> +static void devfreq_monitor(struct work_struct *work)
> +{
> + =A0 =A0 =A0 static unsigned long last_polled_at;
> + =A0 =A0 =A0 struct devfreq *devfreq, *tmp;
> + =A0 =A0 =A0 int error;
> + =A0 =A0 =A0 int jiffies_passed;
> + =A0 =A0 =A0 unsigned long next_jiffies =3D ULONG_MAX, now =3D jiffies;
> +
> + =A0 =A0 =A0 /* Initially last_polled_at =3D 0, polling every device at =
bootup */
> + =A0 =A0 =A0 jiffies_passed =3D now - last_polled_at;
> + =A0 =A0 =A0 last_polled_at =3D now;
> +
> + =A0 =A0 =A0 if (jiffies_passed =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies_passed =3D 1;
> + =A0 =A0 =A0 if (jiffies_passed < 0) /* "Infinite Timeout" */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies_passed =3D INT_MAX;

This doesn't account for jiffies rollover (~49 days on architectures
with HZ =3D=3D 1000).  At rollover-time some devices might incorrectly get
marked as having an infinite timeout.

> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 list_for_each_entry_safe(devfreq, tmp, &devfreq_list, node)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reflect the changes in profile->polling_=
ms */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->polling_ms !=3D devfreq->profi=
le->polling_ms) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->polling_ms =3D dev=
freq->profile->polling_ms;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->polling_jiffies =
=3D msecs_to_jiffies(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 devfreq->polling_ms);

Does struct devfreq need ->polling_ms?  It seems like useless storage
since we're really interested in ->polling_jiffies.

How about removing devfreq->polling_ms and then just doing the
conversion whenever the sysfs file is written to?

Regards,
Mike

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling =
=3D=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->polling_ji=
ffies)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->ne=
xt_polling =3D 1; /* Poll Now */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (devfreq->polling_j=
iffies =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->ne=
xt_polling =3D 0; /* Stop Polling */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Reduce more next_polling if devfreq_wq=
 took an extra
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* delay. (i.e., CPU has been idled.)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling <=3D jiffies_pass=
ed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D devfreq_do(devfre=
q);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Remove a devfreq with an=
 error. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error && error !=3D -EA=
GAIN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev=
freq->dev, "Due to devfreq_do error(%d), devfreq(%s) is removed from the de=
vice\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 error, devfreq->governor->name);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&d=
evfreq->node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(devfr=
eq);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->next_polling =3D d=
evfreq->polling_jiffies;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No more polling required=
 (polling_ms changed) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling =
=3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->next_polling -=3D =
jiffies_passed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_jiffies =3D (next_jiffies > devfreq->n=
ext_polling) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->ne=
xt_polling : next_jiffies;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (next_jiffies > 0 && next_jiffies < ULONG_MAX) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 polling =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(devfreq_wq, &devfreq_wor=
k, next_jiffies);
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
> + * @data: =A0 =A0 =A0private data for the governor. The devfreq framewor=
k does not
> + * =A0 =A0 =A0 =A0 =A0 =A0 touch this value.
> + */
> +int devfreq_add_device(struct device *dev, struct devfreq_dev_profile *p=
rofile,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_governor *gov=
ernor, void *data)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq;
> + =A0 =A0 =A0 struct srcu_notifier_head *nh;
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
for the device. It already has one.\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 devfreq =3D kzalloc(sizeof(struct devfreq), GFP_KERNEL);
> + =A0 =A0 =A0 if (!devfreq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: Unable to create devfreq =
for the device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 devfreq->dev =3D dev;
> + =A0 =A0 =A0 devfreq->profile =3D profile;
> + =A0 =A0 =A0 devfreq->governor =3D governor;
> + =A0 =A0 =A0 devfreq->polling_ms =3D profile->polling_ms;
> + =A0 =A0 =A0 devfreq->next_polling =3D devfreq->polling_jiffies
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D msecs_to_ji=
ffies(devfreq->polling_ms);
> + =A0 =A0 =A0 devfreq->previous_freq =3D profile->initial_freq;
> + =A0 =A0 =A0 devfreq->data =3D data;
> +
> + =A0 =A0 =A0 devfreq->nb.notifier_call =3D devfreq_update;
> + =A0 =A0 =A0 nh =3D opp_get_notifier(dev);
> + =A0 =A0 =A0 if (IS_ERR(nh)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(nh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 err =3D srcu_notifier_chain_register(nh, &devfreq->nb);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 list_add(&devfreq->node, &devfreq_list);
> +
> + =A0 =A0 =A0 if (devfreq_wq && devfreq->next_polling && !polling) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 polling =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(devfreq_wq, &devfreq_wor=
k,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devf=
req->next_polling);
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
> + =A0 =A0 =A0 struct srcu_notifier_head *nh;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 devfreq =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 if (IS_ERR(devfreq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(devfreq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 nh =3D opp_get_notifier(dev);
> + =A0 =A0 =A0 if (IS_ERR(nh)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(nh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_del(&devfreq->node);
> + =A0 =A0 =A0 srcu_notifier_chain_unregister(nh, &devfreq->nb);
> + =A0 =A0 =A0 kfree(devfreq);
> +out:
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * devfreq_init() - Initialize data structure for devfreq framework and
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 start polling registered devfreq devices.
> + */
> +static int __init devfreq_init(void)
> +{
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 polling =3D false;
> + =A0 =A0 =A0 devfreq_wq =3D create_freezable_workqueue("devfreq_wq");
> + =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&devfreq_work, devfreq_monitor=
);
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> +
> + =A0 =A0 =A0 devfreq_monitor(&devfreq_work.work);
> + =A0 =A0 =A0 return 0;
> +}
> +late_initcall(devfreq_init);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> new file mode 100644
> index 0000000..18e94cb
> --- /dev/null
> +++ b/include/linux/devfreq.h
> @@ -0,0 +1,111 @@
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
> +#include <linux/notifier.h>
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
> + * @nb =A0 =A0 =A0 =A0 notifier block registered to the corresponding OP=
P to get
> + * =A0 =A0 =A0 =A0 =A0 =A0 notified for frequency availability updates.
> + * @polling_jiffies =A0 =A0interval in jiffies.
> + * @polling_ms =A0 =A0 =A0 =A0 interval in ms. to compare with profile's=
 polling_ms
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and update polling_jiffies if=
 the device has changed
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the polling interval.
> + * @previous_freq =A0 =A0 =A0previously configured frequency value.
> + * @next_polling =A0 =A0 =A0 the number of remaining jiffies to poll with
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "devfreq_monitor" executions =
to reevaluate
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frequency/voltage of the devi=
ce. Set by
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
> + =A0 =A0 =A0 struct notifier_block nb;
> +
> + =A0 =A0 =A0 unsigned long polling_jiffies;
> + =A0 =A0 =A0 int polling_ms;
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
nor *governor,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *data);
> +extern int devfreq_remove_device(struct device *dev);
> +#else /* !CONFIG_PM_DEVFREQ */
> +static int devfreq_add_device(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_dev_p=
rofile *profile,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devfreq_gover=
nor *governor,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *data)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int devfreq_remove_device(struct device *dev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +#endif /* CONFIG_PM_DEVFREQ */
> +
> +#endif /* __LINUX_DEVFREQ_H__ */
> --
> 1.7.4.1
>
>
