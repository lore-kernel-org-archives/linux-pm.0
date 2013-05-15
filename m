From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Wed, 15 May 2013 12:15:26 +0530
Message-ID: <CAKohpongKq7Oi0Gm2-xfh5yQMDtTDEy2COuB6MNekUcDd2-X5w@mail.gmail.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com>
	<65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
	<51922F68.2010404@linux.vnet.ibm.com>
	<2396135.fo7RrTTQCl@vostro.rjw.lan>
	<51924221.2080707@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:58741 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3EOGp1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2013 02:45:27 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so1697016oag.20
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 23:45:26 -0700 (PDT)
In-Reply-To: <51924221.2080707@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 14 May 2013 19:24, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Subject: [PATCH v2] cpufreq: Preserve sysfs file permissions across suspend/resume
>
> The file permissions of cpufreq per-cpu sysfs files are not preserved across
> suspend/resume because we internally go through the CPU Hotplug path which
> reinitializes the file permissions on CPU online.
>
> But the user is not supposed to know that we are using CPU hotplug
> internally within suspend/resume (IOW, the kernel should not silently wreck
> the user-set file permissions across a suspend cycle). Therefore, we need to
> preserve the file permissions as it is, across suspend/resume.
>
> The simplest way to achieve that is to just not touch the sysfs files at
> all - ie., just ignore the CPU hotplug events in the suspend/resume path
> (_FROZEN) in the cpufreq hotplug callback.
>
> Reported-by: Robert Jarzmik <robert.jarzmik@intel.com>
> Reported-by: Durgadoss R <durgadoss.r@intel.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> v2: Use UP_CANCELED_FROZEN notification to delete the sysfs files if the
> CPUs don't come up during resume.
>
>  drivers/cpufreq/cpufreq.c       |    4 +---
>  drivers/cpufreq/cpufreq_stats.c |    7 ++++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1b8a48e..284ba63 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1832,15 +1832,13 @@ static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
>         if (dev) {
>                 switch (action) {
>                 case CPU_ONLINE:
> -               case CPU_ONLINE_FROZEN:
>                         cpufreq_add_dev(dev, NULL);
>                         break;
>                 case CPU_DOWN_PREPARE:
> -               case CPU_DOWN_PREPARE_FROZEN:
> +               case CPU_UP_CANCELED_FROZEN:
>                         __cpufreq_remove_dev(dev, NULL);
>                         break;
>                 case CPU_DOWN_FAILED:
> -               case CPU_DOWN_FAILED_FROZEN:
>                         cpufreq_add_dev(dev, NULL);
>                         break;
>                 }
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index bfd6273..fb65dec 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -349,15 +349,16 @@ static int __cpuinit cpufreq_stat_cpu_callback(struct notifier_block *nfb,
>
>         switch (action) {
>         case CPU_ONLINE:
> -       case CPU_ONLINE_FROZEN:
>                 cpufreq_update_policy(cpu);
>                 break;
>         case CPU_DOWN_PREPARE:
> -       case CPU_DOWN_PREPARE_FROZEN:
>                 cpufreq_stats_free_sysfs(cpu);
>                 break;
>         case CPU_DEAD:
> -       case CPU_DEAD_FROZEN:
> +               cpufreq_stats_free_table(cpu);
> +               break;
> +       case CPU_UP_CANCELED_FROZEN:
> +               cpufreq_stats_free_sysfs(cpu);
>                 cpufreq_stats_free_table(cpu);
>                 break;
>         }

I accept that the patch makes things work but honestly speaking I
didn't like it much :(

As it looks like more of a hack than a proper solution. We are off-lining
cpus but we are still keeping cpufreq directories (cpu/cpu*/cpufreq)...
That goes against the basic rules...

This works because there is no potential user between suspend/resume
who can notice above issue. But that doesn't mean we write such code.

On the other side, it looks difficult to preserve permissions by writing some
complicated code to preserve and restore original settings for
Suspend/resume.

For now I can't imaging this breaking some stuff in cpufreq core.

I don't want to but I have to (As i don't have a better solution):

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
