From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC] ACPI throttling: Save/restore tstate for each CPUs
 across suspend/resume
Date: Wed, 23 Nov 2016 00:03:22 +0100
Message-ID: <CAJZ5v0iMT4+qVdQ-8ev_NRavLNnLhr_+eEO9M=85WJC+zfDySw@mail.gmail.com>
References: <1479145444-29269-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35502 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932461AbcKVXDY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 18:03:24 -0500
In-Reply-To: <1479145444-29269-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rui Wang <ruwang@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On Mon, Nov 14, 2016 at 6:44 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> This is a trial version and any comments are appreciated.
>
> Previously a bug was reported that on certain Broadwell
> platforms, after resuming from S3, the CPU is running at
> an anomalously low speed, due to BIOS has enabled the
> throttling across S3. The solution to this is to introduce
> a quirk framework to save/restore tstate MSR register
> around suspend/resume, in Commit 7a9c2dd08ead ("x86/pm:
> Introduce quirk framework to save/restore extra MSR
> registers around suspend/resume").
>
> However more and more reports show that other platforms also
> experienced the same issue, because some BIOSes would like to
> adjust the tstate if he thinks the temperature is too high.
> To deal with this situation, the Linux uses a compensation strategy
> that, the thermal management leverages thermal_pm_notify() upon resume
> to check if the Processors inside the thermal zone should be throttled
> or not, thus tstate would be re-evaluated. Unfortunately on these bogus
> platforms, none of the Processors are inside any thermal zones due
> to BIOS's implementation. Thus tstate for Processors never has a
> chance to be brought back to normal.
>
> This patch tries to save/restore tstate on receiving the
> PM_SUSPEND_PREPARE and PM_POST_SUSPEND, to be more specific,
> the tstate is saved after thermal_pm_notify(PM_SUSPEND_PREPARE)
> is called, while it's restored before thermal_pm_notify(PM_POST_SUSPEND),
> in this way the thermal zone would adjust the tstate eventually and
> also help adjust the tstate for Processors which do not have
> thermal zone bound. Thus it does not imapct the old semantics.
>
> Another concern is that, each CPU should take care of the
> save/restore operation, thus this patch uses percpu workqueue
> to achieve this.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=90041
> Reported-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Reported-by: Kadir <kadir@colakoglu.nl>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/processor_throttling.c | 70 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index d51ca1c..8ddc7d6 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/cpufreq.h>
>  #include <linux/acpi.h>
> +#include <linux/suspend.h>
>  #include <acpi/processor.h>
>  #include <asm/io.h>
>  #include <asm/uaccess.h>
> @@ -758,6 +759,75 @@ static int acpi_throttling_wrmsr(u64 value)
>         }
>         return ret;
>  }
> +
> +#ifdef CONFIG_PM_SLEEP
> +static DEFINE_PER_CPU(u64, tstate_msr);

Call it saved_tstate_msr maybe?

> +
> +static long tstate_pm_fn(void *data)
> +{
> +       u64 value;
> +       bool save = *(bool *)data;
> +
> +       if (save) {
> +               acpi_throttling_rdmsr(&value);
> +               this_cpu_write(tstate_msr, value);
> +       } else {
> +               value = this_cpu_read(tstate_msr);
> +               if (value)
> +                       acpi_throttling_wrmsr(value);
> +       }
> +       return 0;
> +}

I would split the above into two functions, one for saving and one for
restoring ->

> +
> +static void tstate_check(unsigned long mode, bool suspend)
> +{
> +       int cpu;
> +       bool save;
> +
> +       if (suspend && mode == PM_SUSPEND_PREPARE)
> +               save = true;
> +       else if (!suspend && mode == PM_POST_SUSPEND)
> +               save = false;
> +       else
> +               return;
> +
> +       get_online_cpus();
> +       for_each_online_cpu(cpu)

-> and decide here which one to invoke.

> +               work_on_cpu(cpu, tstate_pm_fn, &save);

Does work_on_cpu() wait for the work to complete?

> +       put_online_cpus();
> +}
> +
> +static int tstate_suspend(struct notifier_block *nb,
> +                               unsigned long mode, void *_unused)
> +{
> +       tstate_check(mode, true);
> +       return 0;
> +}
> +
> +static int tstate_resume(struct notifier_block *nb,
> +                               unsigned long mode, void *_unused)
> +{
> +       tstate_check(mode, false);
> +       return 0;
> +}
> +
> +static int __init tstate_pm_init(void)
> +{
> +       /*
> +        * tstate_suspend should save tstate after
> +        * thermal zone's update in thermal_pm_notify,
> +        * vice versa tstate_resume restore tstate before
> +        * thermal_pm_notify, thus the thermal framework
> +        * has a chance to re-adjust tstate according to the
> +        * temperature trend.
> +        */
> +       pm_notifier(tstate_suspend, -1);
> +       pm_notifier(tstate_resume, 1);

I don't think this is going to do what you really want.

Each of these notifiers is going to be invoked during both suspend and
resume, so I guess you only need one notifier?

> +       return 0;
> +}
> +
> +core_initcall(tstate_pm_init);
> +#endif
>  #else
>  static int acpi_throttling_rdmsr(u64 *value)
>  {
> --

Thanks,
Rafael
