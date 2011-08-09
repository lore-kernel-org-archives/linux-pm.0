From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v3] PM: add statistics debugfs file for
 suspend to ram
Date: Tue, 9 Aug 2011 13:49:57 +0900
Message-ID: <CAJ0PZbQ4Bk7Up9texX2hU8NP583da7UP9Hk3GRHE6-VKsg69kA__27245.92079544$1312865455$gmane$org@mail.gmail.com>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B8057C306@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6E3BC7F7C9A4BF4286DD4C043110F30B5B8057C306@shsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Liu, ShuoX" <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 9, 2011 at 11:27 AM, Liu, ShuoX <shuox.liu@intel.com> wrote:
> From: ShuoX Liu <shuox.liu@intel.com>
>
> Record S3 failure time about each reason and the latest two failed
> devices' names in S3 progress.
> We can check it through 'suspend_stats' entry in debugfs.
>
> The motivation of the patch:
>
> We are enabling power features on Medfield. Comparing with PC/notebook,
> a mobile enters/exits suspend-2-ram (we call it s3 on Medfield) far
> more frequently. If it can't enter suspend-2-ram in time, the power
> might be used up soon.
>
> We often find sometimes, a device suspend fails. Then, system retries
> s3 over and over again. As display is off, testers and developers
> don't know what happens.
>
> Some testers and developers complain they don't know if system
> tries suspend-2-ram, and what device fails to suspend. They need
> such info for a quick check. The patch adds suspend_stats under
> debugfs for users to check suspend to RAM statistics quickly.
>
> If not using this patch, we have other methods to get info about
> what device fails. One is to turn on =A0CONFIG_PM_DEBUG, but users
> would get too much info and testers need recompile the system.
>
> In addition, dynamic debug is another good tool to dump debug info.
> But it still doesn't match our utilization scenario closely.
> 1) user need write a user space parser to process the syslog output;
> 2) Our testing scenario is we leave the mobile for at least hours.
> =A0 Then, check its status. No serial console available during the
> =A0 testing. One is because console would be suspended, and the other
> =A0 is serial console connecting with spi or HSU devices would consume
> =A0 power. These devices are powered off at suspend-2-ram.
>
> Thank Greg and Rafael for their great comments.
>
> Change Log:
> =A0V3: Change some programming styles.
> =A0V2:
> =A0 =A0 =A0 =A01) Change the sysfs entry to debugfs.
> =A0 =A0 =A0 =A02) Add some explanation in document file.
>
> Contribution:
> =A0 =A0 =A0 =A0yanmin_zhang@linux.intel.com
>
> Signed-off-by: ShuoX Liu <shuox.liu@intel.com>
> ---
> =A0Documentation/power/basic-pm-debugging.txt | =A0 19 +++++++++
> =A0drivers/base/power/main.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 35 =
++++++++++++++--
> =A0include/linux/suspend.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 1=
6 +++++++
> =A0kernel/power/main.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 59 ++++++++++++++++++++++++++++
> =A0kernel/power/suspend.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 1=
5 ++++++-
> =A05 files changed, 136 insertions(+), 8 deletions(-)
>

This patch looks very helpful. Great! :)

Anyway, how about including the error value induced by the device
along with the device name?
For example,

failed_devs:
         last_failed: alarm -5
                      adc -10

or

failed_devs:
         last_failed: alarm
                      adc
         last_errorno: -5
                      -10

Or, even, we may consider including the failed step:
failed_devs:
         last_failed: alarm
                      adc
         last_errorno: -5
                      -10
         last_step: suspend
                      suspend_noirq


Cheers!
MyungJoo

> diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/p=
ower/basic-pm-debugging.txt
> index ddd7817..acbd3e0 100644
> --- a/Documentation/power/basic-pm-debugging.txt
> +++ b/Documentation/power/basic-pm-debugging.txt
> @@ -201,3 +201,22 @@ case, you may be able to search for failing drivers =
by following the procedure
> =A0analogous to the one described in section 1. =A0If you find some faili=
ng drivers,
> =A0you will have to unload them every time before an STR transition (ie. =
before
> =A0you run s2ram), and please report the problems with them.
> +
> +There is a debugfs entry which shows the suspend to RAM statistics. Here=
 is an
> +example of its output.
> + =A0 =A0 =A0 # mount -t debugfs none /sys/kernel/debug
> + =A0 =A0 =A0 # cat /sys/kernel/debug/suspend_stats
> + =A0 =A0 =A0 success: 20
> + =A0 =A0 =A0 fail: 5
> + =A0 =A0 =A0 failed_freeze: 0
> + =A0 =A0 =A0 failed_prepare: 0
> + =A0 =A0 =A0 failed_suspend: 5
> + =A0 =A0 =A0 failed_suspend_noirq: 0
> + =A0 =A0 =A0 failed_resume: 0
> + =A0 =A0 =A0 failed_resume_noirq: 0
> + =A0 =A0 =A0 failed_devs:
> + =A0 =A0 =A0 =A0 last_failed: alarm
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0adc
> +Field success means the success number of suspend to RAM, and field fail=
 means
> +the failure number. Others are the failure number of different steps of =
suspend
> +to RAM. suspend_stats just lists the last 2 failed devices.
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index a854591..111f86c 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -46,6 +46,7 @@ LIST_HEAD(dpm_prepared_list);
> =A0LIST_HEAD(dpm_suspended_list);
> =A0LIST_HEAD(dpm_noirq_list);
>
> +struct suspend_stats suspend_stats;
> =A0static DEFINE_MUTEX(dpm_list_mtx);
> =A0static pm_message_t pm_transition;
>
> @@ -180,6 +181,15 @@ static void initcall_debug_report(struct device *dev=
, ktime_t calltime,
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static void dpm_save_dev_name(const char *name)
> +{
> + =A0 =A0 =A0 strlcpy(suspend_stats.failed_devs[suspend_stats.last_failed=
],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(suspend_stats.failed_devs[0]));
> + =A0 =A0 =A0 suspend_stats.last_failed++;
> + =A0 =A0 =A0 suspend_stats.last_failed %=3D REC_FAILED_DEV_NUM;
> +}
> +
> =A0/**
> =A0* dpm_wait - Wait for a PM operation to complete.
> =A0* @dev: Device to wait for.
> @@ -464,8 +474,11 @@ void dpm_resume_noirq(pm_message_t state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&dpm_list_mtx);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D device_resume_noirq(dev, state);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.failed_resume=
_noirq++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpm_save_dev_name(dev_name(=
dev));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_dev_err(dev, state, " e=
arly", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&dpm_list_mtx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_device(dev);
> @@ -626,8 +639,11 @@ void dpm_resume(pm_message_t state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&dpm_list_mtx=
);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D device_resume(de=
v, state, false);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_sta=
ts.failed_resume++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpm_save_de=
v_name(dev_name(dev));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_dev_err=
(dev, state, "", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&dpm_list_mtx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -802,6 +818,8 @@ int dpm_suspend_noirq(pm_message_t state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&dpm_list_mtx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_dev_err(dev, state, " l=
ate", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.failed_suspen=
d_noirq++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpm_save_dev_name(dev_name(=
dev));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_device(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -923,8 +941,10 @@ static void async_suspend(void *data, async_cookie_t=
 cookie)
> =A0 =A0 =A0 =A0int error;
>
> =A0 =A0 =A0 =A0error =3D __device_suspend(dev, pm_transition, true);
> - =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpm_save_dev_name(dev_name(dev));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_dev_err(dev, pm_transition, " async", e=
rror);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0put_device(dev);
> =A0}
> @@ -967,6 +987,7 @@ int dpm_suspend(pm_message_t state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&dpm_list_mtx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_dev_err(dev, state, "",=
 error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpm_save_dev_name(dev_name(=
dev));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_device(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -980,7 +1001,9 @@ int dpm_suspend(pm_message_t state)
> =A0 =A0 =A0 =A0async_synchronize_full();
> =A0 =A0 =A0 =A0if (!error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D async_error;
> - =A0 =A0 =A0 if (!error)
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.failed_suspend++;
> + =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dpm_show_time(starttime, state, NULL);
> =A0 =A0 =A0 =A0return error;
> =A0}
> @@ -1088,7 +1111,9 @@ int dpm_suspend_start(pm_message_t state)
> =A0 =A0 =A0 =A0int error;
>
> =A0 =A0 =A0 =A0error =3D dpm_prepare(state);
> - =A0 =A0 =A0 if (!error)
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.failed_prepare++;
> + =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D dpm_suspend(state);
> =A0 =A0 =A0 =A0return error;
> =A0}
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 6bbcef2..6a8ff23 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -34,6 +34,22 @@ typedef int __bitwise suspend_state_t;
> =A0#define PM_SUSPEND_MEM =A0 =A0 =A0 =A0 ((__force suspend_state_t) 3)
> =A0#define PM_SUSPEND_MAX =A0 =A0 =A0 =A0 ((__force suspend_state_t) 4)
>
> +struct suspend_stats {
> + =A0 =A0 =A0 int =A0 =A0 success;
> + =A0 =A0 =A0 int =A0 =A0 fail;
> + =A0 =A0 =A0 int =A0 =A0 failed_freeze;
> + =A0 =A0 =A0 int =A0 =A0 failed_prepare;
> + =A0 =A0 =A0 int =A0 =A0 failed_suspend;
> + =A0 =A0 =A0 int =A0 =A0 failed_suspend_noirq;
> + =A0 =A0 =A0 int =A0 =A0 failed_resume;
> + =A0 =A0 =A0 int =A0 =A0 failed_resume_noirq;
> +#define =A0 =A0 =A0 =A0REC_FAILED_DEV_NUM =A0 =A0 =A02
> + =A0 =A0 =A0 char =A0 =A0failed_devs[REC_FAILED_DEV_NUM][40];
> + =A0 =A0 =A0 int =A0 =A0 last_failed;
> +};
> +
> +extern struct suspend_stats suspend_stats;
> +
> =A0/**
> =A0* struct platform_suspend_ops - Callbacks for managing platform depend=
ent
> =A0* =A0 =A0 system sleep states.
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6c601f8..0977f5d 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -12,6 +12,8 @@
> =A0#include <linux/string.h>
> =A0#include <linux/resume-trace.h>
> =A0#include <linux/workqueue.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
>
> =A0#include "power.h"
>
> @@ -133,6 +135,59 @@ power_attr(pm_test);
>
> =A0#endif /* CONFIG_PM_SLEEP */
>
> +#ifdef CONFIG_DEBUG_FS
> +static int suspend_stats_show(struct seq_file *s, void *unused)
> +{
> + =A0 =A0 =A0 int i, index, last_index;
> +
> + =A0 =A0 =A0 last_index =3D suspend_stats.last_failed + REC_FAILED_DEV_N=
UM - 1;
> + =A0 =A0 =A0 last_index %=3D REC_FAILED_DEV_NUM;
> + =A0 =A0 =A0 seq_printf(s, "%s: %d\n%s: %d\n%s: %d\n%s: %d\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: %d\n%s: %d\n%s: %d\n%s=
: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "success", suspend_stats.su=
ccess,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fail", suspend_stats.fail,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed_freeze", suspend_st=
ats.failed_freeze,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed_prepare", suspend_s=
tats.failed_prepare,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed_suspend", suspend_s=
tats.failed_suspend,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed_suspend_noirq",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_sta=
ts.failed_suspend_noirq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed_resume", suspend_st=
ats.failed_resume,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed_resume_noirq",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_sta=
ts.failed_resume_noirq);
> + =A0 =A0 =A0 seq_printf(s, =A0 "failed_devs:\n =A0last_failed:\t%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.failed_devs[l=
ast_index]);
> + =A0 =A0 =A0 for (i =3D 1; i < REC_FAILED_DEV_NUM; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D last_index + REC_FAILED_DEV_NUM -=
 i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 index %=3D REC_FAILED_DEV_NUM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "\t\t%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.failed_devs[i=
ndex]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int suspend_stats_open(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 return single_open(file, suspend_stats_show, NULL);
> +}
> +
> +static const struct file_operations suspend_stats_operations =3D {
> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D suspend_stats_open,
> + =A0 =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D seq_read,
> + =A0 =A0 =A0 .llseek =A0 =A0 =A0 =A0 =3D seq_lseek,
> + =A0 =A0 =A0 .release =A0 =A0 =A0 =A0=3D single_release,
> +};
> +
> +static int __init pm_debugfs_init(void)
> +{
> + =A0 =A0 =A0 debugfs_create_file("suspend_stats", S_IFREG | S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, NULL, &suspend_stats_=
operations);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +late_initcall(pm_debugfs_init);
> +#endif /* CONFIG_DEBUG_FS */
> +
> =A0struct kobject *power_kobj;
>
> =A0/**
> @@ -194,6 +249,10 @@ static ssize_t state_store(struct kobject *kobj, str=
uct kobj_attribute *attr,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (state < PM_SUSPEND_MAX && *s)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D enter_state(state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.fail++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.success++;
> =A0#endif
>
> =A0Exit:
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b6b71ad..e5197a0 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -104,7 +104,9 @@ static int suspend_prepare(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto Finish;
>
> =A0 =A0 =A0 =A0error =3D suspend_freeze_processes();
> - =A0 =A0 =A0 if (!error)
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.failed_freeze++;
> + =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0suspend_thaw_processes();
> @@ -315,8 +317,15 @@ int enter_state(suspend_state_t state)
> =A0*/
> =A0int pm_suspend(suspend_state_t state)
> =A0{
> - =A0 =A0 =A0 if (state > PM_SUSPEND_ON && state <=3D PM_SUSPEND_MAX)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return enter_state(state);
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 if (state > PM_SUSPEND_ON && state <=3D PM_SUSPEND_MAX) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D enter_state(state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.fail++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_stats.success++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
> =A0EXPORT_SYMBOL(pm_suspend);
> --
> 1.7.1
>
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>



-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
