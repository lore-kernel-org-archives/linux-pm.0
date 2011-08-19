From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v6 3/4] PM / DEVFREQ: add basic governors
Date: Thu, 18 Aug 2011 20:12:57 -0700
Message-ID: <CAJOA=zN++RHMEREcVaqQAQ6jpLEeW6qQLWBM6+nKrfiNLoZ3vA@mail.gmail.com>
References: <1313663262-15308-1-git-send-email-myungjoo.ham@samsung.com>
	<1313663262-15308-4-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313663262-15308-4-git-send-email-myungjoo.ham@samsung.com>
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

On Thu, Aug 18, 2011 at 3:27 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
> Four CPUFREQ-like governors are provided as examples.
>
> powersave: use the lowest frequency possible. The user (device) should
> set the polling_ms as 0 because polling is useless for this governor.
>
> performance: use the highest freqeuncy possible. The user (device)
> should set the polling_ms as 0 because polling is useless for this
> governor.
>
> userspace: use the user specified frequency stored at
> devfreq.user_set_freq. With sysfs support in the following patch, a user
> may set the value with the sysfs interface.
>
> simple_ondemand: simplified version of CPUFREQ's ONDEMAND governor.

In patchset v5 I requested for sysfs entries to control
up-/down-thresholds for simple-ondemand.  Those still are not here;
but that got me thinking... what about multiple devices that want to
use simple-ondemand but have different up/down thresholds?  That's
when I realized that this code is monolithic and will never scale.  It
works today because there is one device on one platform using it.

Below code snippet is from the Nuri code that initializes
devfreq/simple-ondemand for memory bus:
(http://git.infradead.org/users/kmpark/linux-2.6-samsung/commitdiff/d969626=
9b79ca172474b2c1ae84150e8ac276542?hp=3D7dbd341e0780ab59b2aeb85e2691ddfb1ab2=
fd3a)

+static struct devfreq_dev_profile exynos4_devfreq_profile =3D {
+       .max_freq       =3D 400000, /* 400MHz */
+       .initial_freq   =3D 400000,
+       .polling_ms     =3D 50,
+       .target         =3D exynos4_bus_target,
+       .get_dev_status =3D exynos4_bus_get_dev_status,
+};
+static struct devfreq_governor *default_gov =3D &devfreq_simple_ondemand;

This is pretty bad.  Basically only one instance of simple-ondemand
exists and all devices must use it.  There should really be one
governor instance per device.  Later there might be some optimizations
around grouping multiple devices together that need to scale
simultaneously, but lets not concern ourselves with that now.

struct devfreq's governor member should point to a unique instance of
the governor.  That governor's structure should contain all of the
per-governor tunables:

timekeeping (last_polled_at, etc)
up_threshold
down_threshold
etc.

This in fact touches upon my previous complaints about the core code
managing too many of the governors responsibilities.

Regards,
Mike

> When a user updates OPP entries (enable/disable/add), OPP framework
> automatically notifies DEVFREQ to update operating frequency
> accordingly. Thus, DEVFREQ users (device drivers) do not need to update
> DEVFREQ manually with OPP entry updates or set polling_ms for powersave
> , performance, userspace, or any other "static" governors.
>
> Note that these are given only as basic examples for governors and any
> devices with DEVFREQ may implement their own governors with the drivers
> and use them.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> ---
> Changed from v5
> - Seperated governor files from devfreq.c
> - Allow simple ondemand to be tuned for each device
> ---
> =A0drivers/devfreq/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 36 +=
+++++++++++
> =A0drivers/devfreq/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 +
> =A0drivers/devfreq/governor_performance.c =A0 =A0| =A0 24 ++++++++
> =A0drivers/devfreq/governor_powersave.c =A0 =A0 =A0| =A0 24 ++++++++
> =A0drivers/devfreq/governor_simpleondemand.c | =A0 88 +++++++++++++++++++=
++++++++++
> =A0drivers/devfreq/governor_userspace.c =A0 =A0 =A0| =A0 27 +++++++++
> =A0include/linux/devfreq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 41 +=
++++++++++++
> =A07 files changed, 244 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/devfreq/governor_performance.c
> =A0create mode 100644 drivers/devfreq/governor_powersave.c
> =A0create mode 100644 drivers/devfreq/governor_simpleondemand.c
> =A0create mode 100644 drivers/devfreq/governor_userspace.c
>
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 1fb42de..643b055 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -34,6 +34,42 @@ menuconfig PM_DEVFREQ
>
> =A0if PM_DEVFREQ
>
> +comment "DEVFREQ Governors"
> +
> +config DEVFREQ_GOV_SIMPLE_ONDEMAND
> + =A0 =A0 =A0 bool "Simple Ondemand"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Chooses frequency based on the recent load on the devic=
e. Works
> + =A0 =A0 =A0 =A0 similar as ONDEMAND governor of CPUFREQ does. A device =
with
> + =A0 =A0 =A0 =A0 Simple-Ondemand should be able to provide busy/total co=
unter
> + =A0 =A0 =A0 =A0 values that imply the usage rate. A device may provide =
tuned
> + =A0 =A0 =A0 =A0 values to the governor with data field at devfreq_add_d=
evice().
> +
> +config DEVFREQ_GOV_PERFORMANCE
> + =A0 =A0 =A0 bool "Performance"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Sets the frequency at the maximum available frequency.
> + =A0 =A0 =A0 =A0 This governor always returns UINT_MAX as frequency so t=
hat
> + =A0 =A0 =A0 =A0 the DEVFREQ framework returns the highest frequency ava=
ilable
> + =A0 =A0 =A0 =A0 at any time.
> +
> +config DEVFREQ_GOV_POWERSAVE
> + =A0 =A0 =A0 bool "Powersave"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Sets the frequency at the minimum available frequency.
> + =A0 =A0 =A0 =A0 This governor always returns 0 as frequency so that
> + =A0 =A0 =A0 =A0 the DEVFREQ framework returns the lowest frequency avai=
lable
> + =A0 =A0 =A0 =A0 at any time.
> +
> +config DEVFREQ_GOV_USERSPACE
> + =A0 =A0 =A0 bool "Userspace"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Sets the frequency at the user specified one.
> + =A0 =A0 =A0 =A0 This governor returns the user configured frequency if =
there
> + =A0 =A0 =A0 =A0 has been an input to /sys/devices/.../power/devfreq_set=
_freq.
> + =A0 =A0 =A0 =A0 Otherwise, the governor does not change the frequnecy
> + =A0 =A0 =A0 =A0 given at the initialization.
> +
> =A0comment "DEVFREQ Drivers"
>
> =A0endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 168934a..4564a89 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -1 +1,5 @@
> =A0obj-$(CONFIG_PM_DEVFREQ) =A0 =A0 =A0 +=3D devfreq.o
> +obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND) =A0 =A0 =A0+=3D governor_simpl=
eondemand.o
> +obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE) =A0+=3D governor_performance.o
> +obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE) =A0 =A0+=3D governor_powersave.o
> +obj-$(CONFIG_DEVFREQ_GOV_USERSPACE) =A0 =A0+=3D governor_userspace.o
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/gov=
ernor_performance.c
> new file mode 100644
> index 0000000..c47eff8
> --- /dev/null
> +++ b/drivers/devfreq/governor_performance.c
> @@ -0,0 +1,24 @@
> +/*
> + * =A0linux/drivers/devfreq/governor_performance.c
> + *
> + * =A0Copyright (C) 2011 Samsung Electronics
> + * =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/devfreq.h>
> +
> +static int devfreq_performance_func(struct devfreq *df,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uns=
igned long *freq)
> +{
> + =A0 =A0 =A0 *freq =3D UINT_MAX; /* devfreq_do will run "floor" */
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_performance =3D {
> + =A0 =A0 =A0 .name =3D "performance",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_performance_func,
> +};
> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/gover=
nor_powersave.c
> new file mode 100644
> index 0000000..4f128d8
> --- /dev/null
> +++ b/drivers/devfreq/governor_powersave.c
> @@ -0,0 +1,24 @@
> +/*
> + * =A0linux/drivers/devfreq/governor_powersave.c
> + *
> + * =A0Copyright (C) 2011 Samsung Electronics
> + * =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/devfreq.h>
> +
> +static int devfreq_powersave_func(struct devfreq *df,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d long *freq)
> +{
> + =A0 =A0 =A0 *freq =3D 0; /* devfreq_do will run "ceiling" to 0 */
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_powersave =3D {
> + =A0 =A0 =A0 .name =3D "powersave",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_powersave_func,
> +};
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/=
governor_simpleondemand.c
> new file mode 100644
> index 0000000..18fe8be
> --- /dev/null
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -0,0 +1,88 @@
> +/*
> + * =A0linux/drivers/devfreq/governor_simpleondemand.c
> + *
> + * =A0Copyright (C) 2011 Samsung Electronics
> + * =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/devfreq.h>
> +#include <linux/math64.h>
> +
> +/* Default constants for DevFreq-Simple-Ondemand (DFSO) */
> +#define DFSO_UPTHRESHOLD =A0 =A0 =A0 (90)
> +#define DFSO_DOWNDIFFERENCTIAL (5)
> +static int devfreq_simple_ondemand_func(struct devfreq *df,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned long *freq)
> +{
> + =A0 =A0 =A0 struct devfreq_dev_status stat;
> + =A0 =A0 =A0 int err =3D df->profile->get_dev_status(df->dev, &stat);
> + =A0 =A0 =A0 unsigned long long a, b;
> + =A0 =A0 =A0 unsigned int dfso_upthreshold =3D DFSO_UPTHRESHOLD;
> + =A0 =A0 =A0 unsigned int dfso_downdifferential =3D DFSO_DOWNDIFFERENCTI=
AL;
> + =A0 =A0 =A0 struct devfreq_simple_ondemand_data *data =3D df->data;
> +
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 if (data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->upthreshold)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dfso_upthreshold =3D data->=
upthreshold;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->downdifferential)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dfso_downdifferential =3D d=
ata->downdifferential;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (dfso_upthreshold > 100 ||
> + =A0 =A0 =A0 =A0 =A0 dfso_upthreshold < dfso_downdifferential)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* Assume MAX if it is going to be divided by zero */
> + =A0 =A0 =A0 if (stat.total_time =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D UINT_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Prevent overflow */
> + =A0 =A0 =A0 if (stat.busy_time >=3D (1 << 24) || stat.total_time >=3D (=
1 << 24)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.busy_time >>=3D 7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.total_time >>=3D 7;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set MAX if it's busy enough */
> + =A0 =A0 =A0 if (stat.busy_time * 100 >
> + =A0 =A0 =A0 =A0 =A0 stat.total_time * dfso_upthreshold) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D UINT_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set MAX if we do not know the initial frequency */
> + =A0 =A0 =A0 if (stat.current_frequency =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D UINT_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Keep the current frequency */
> + =A0 =A0 =A0 if (stat.busy_time * 100 >
> + =A0 =A0 =A0 =A0 =A0 stat.total_time * (dfso_upthreshold - dfso_downdiff=
erential)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D stat.current_frequency;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set the desired frequency based on the load */
> + =A0 =A0 =A0 a =3D stat.busy_time;
> + =A0 =A0 =A0 a *=3D stat.current_frequency;
> + =A0 =A0 =A0 b =3D div_u64(a, stat.total_time);
> + =A0 =A0 =A0 b *=3D 100;
> + =A0 =A0 =A0 b =3D div_u64(b, (dfso_upthreshold - dfso_downdifferential =
/ 2));
> + =A0 =A0 =A0 *freq =3D (unsigned long) b;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_simple_ondemand =3D {
> + =A0 =A0 =A0 .name =3D "simple_ondemand",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_simple_ondemand_func,
> +};
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/gover=
nor_userspace.c
> new file mode 100644
> index 0000000..6af8b6d
> --- /dev/null
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -0,0 +1,27 @@
> +/*
> + * =A0linux/drivers/devfreq/governor_simpleondemand.c
> + *
> + * =A0Copyright (C) 2011 Samsung Electronics
> + * =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/devfreq.h>
> +
> +static int devfreq_userspace_func(struct devfreq *df, unsigned long *fre=
q)
> +{
> + =A0 =A0 =A0 if (df->user_set_freq =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D df->previous_freq; /* No user fre=
q specified yet */
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D df->user_set_freq;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_userspace =3D {
> + =A0 =A0 =A0 .name =3D "userspace",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_userspace_func,
> +};
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 13ddf49..d088ad3 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -13,6 +13,7 @@
> =A0#ifndef __LINUX_DEVFREQ_H__
> =A0#define __LINUX_DEVFREQ_H__
>
> +#include <linux/opp.h>
> =A0#include <linux/notifier.h>
>
> =A0#define DEVFREQ_NAME_LEN 16
> @@ -62,6 +63,8 @@ struct devfreq_governor {
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "devfreq_monitor" executions=
 to reevaluate
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frequency/voltage of the dev=
ice. Set by
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 profile's polling_ms interva=
l.
> + * @user_set_freq =A0 =A0 =A0User specified adequete frequency value (th=
ru sysfs
> + * =A0 =A0 =A0 =A0 =A0 =A0 interface). Governors may and may not use thi=
s value.
> =A0* @data =A0 =A0 =A0 Private data of the governor. The devfreq framewor=
k does not
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 touch this.
> =A0*
> @@ -78,6 +81,7 @@ struct devfreq {
> =A0 =A0 =A0 =A0unsigned long previous_freq;
> =A0 =A0 =A0 =A0unsigned int next_polling;
>
> + =A0 =A0 =A0 unsigned long user_set_freq; /* governors may ignore this. =
*/
> =A0 =A0 =A0 =A0void *data; /* private data for governors */
> =A0};
>
> @@ -87,6 +91,37 @@ extern int devfreq_add_device(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devfreq_govern=
or *governor,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data);
> =A0extern int devfreq_remove_device(struct device *dev);
> +
> +#ifdef CONFIG_DEVFREQ_GOV_POWERSAVE
> +extern struct devfreq_governor devfreq_powersave;
> +#endif
> +#ifdef CONFIG_DEVFREQ_GOV_PERFORMANCE
> +extern struct devfreq_governor devfreq_performance;
> +#endif
> +#ifdef CONFIG_DEVFREQ_GOV_USERSPACE
> +extern struct devfreq_governor devfreq_userspace;
> +#endif
> +#ifdef CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND
> +extern struct devfreq_governor devfreq_simple_ondemand;
> +/**
> + * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
> + * =A0 =A0 and devfreq_add_device
> + * @ upthreshold =A0 =A0 =A0 If the load is over this value, the frequen=
cy jumps.
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specify 0 to use the default.=
 Valid value =3D 0 to 100.
> + * @ downdifferential =A0If the load is under upthreshold - downdifferen=
tial,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the governor may consider slo=
wing the frequency down.
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specify 0 to use the default.=
 Valid value =3D 0 to 100.
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 downdifferential < upthreshol=
d must hold.
> + *
> + * If the fed devfreq_simple_ondemand_data pointer is NULL to the govern=
or,
> + * the governor uses the default values.
> + */
> +struct devfreq_simple_ondemand_data {
> + =A0 =A0 =A0 unsigned int upthreshold;
> + =A0 =A0 =A0 unsigned int downdifferential;
> +};
> +#endif
> +
> =A0#else /* !CONFIG_PM_DEVFREQ */
> =A0static int devfreq_add_device(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devfreq_dev_pr=
ofile *profile,
> @@ -100,6 +135,12 @@ static int devfreq_remove_device(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +#define devfreq_powersave =A0 =A0 =A0NULL
> +#define devfreq_performance =A0 =A0NULL
> +#define devfreq_userspace =A0 =A0 =A0NULL
> +#define devfreq_simple_ondemand =A0 =A0 =A0 =A0NULL
> +
> =A0#endif /* CONFIG_PM_DEVFREQ */
>
> =A0#endif /* __LINUX_DEVFREQ_H__ */
> --
> 1.7.4.1
>
>
