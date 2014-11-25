From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Ref the policy object sooner
Date: Tue, 25 Nov 2014 16:40:23 +0530
Message-ID: <CAKohponYcoFkbezPjjUbedzZRgbyROJVgKhecALPH+O2yKQfow@mail.gmail.com>
References: <CAKohponxpSoUXHc9S-y_zgo=T44-6Ayk4vRbW=jRHqQRsdbrGQ@mail.gmail.com>
	<1416820083-20902-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416820083-20902-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 24 November 2014 at 14:38, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Do it before it's assigned to cpufreq_cpu_data, otherwise when a driver
> tries to get the cpu frequency during initialization the policy kobj is
> referenced and we get this warning:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 64 at include/linux/kref.h:47 kobject_get+0x64/0x70()
> Modules linked in:
> CPU: 1 PID: 64 Comm: irq/77-tegra-ac Not tainted 3.18.0-rc4-next-20141114ccu-00050-g3eff942 #326
> [<c0016fac>] (unwind_backtrace) from [<c001272c>] (show_stack+0x10/0x14)
> [<c001272c>] (show_stack) from [<c06085d8>] (dump_stack+0x98/0xd8)
> [<c06085d8>] (dump_stack) from [<c002892c>] (warn_slowpath_common+0x84/0xb4)
> [<c002892c>] (warn_slowpath_common) from [<c00289f8>] (warn_slowpath_null+0x1c/0x24)
> [<c00289f8>] (warn_slowpath_null) from [<c0220290>] (kobject_get+0x64/0x70)
> [<c0220290>] (kobject_get) from [<c03e944c>] (cpufreq_cpu_get+0x88/0xc8)
> [<c03e944c>] (cpufreq_cpu_get) from [<c03e9500>] (cpufreq_get+0xc/0x64)
> [<c03e9500>] (cpufreq_get) from [<c0285288>] (actmon_thread_isr+0x134/0x198)
> [<c0285288>] (actmon_thread_isr) from [<c0069008>] (irq_thread_fn+0x1c/0x40)
> [<c0069008>] (irq_thread_fn) from [<c0069324>] (irq_thread+0x134/0x174)
> [<c0069324>] (irq_thread) from [<c0040290>] (kthread+0xdc/0xf4)
> [<c0040290>] (kthread) from [<c000f4b8>] (ret_from_fork+0x14/0x3c)
> ---[ end trace b7bd64a81b340c59 ]---
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> ---
>
> v2:     * Properly unwind when erroring out.
> ---
>  drivers/cpufreq/cpufreq.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4473eba..ae27ea6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -898,46 +898,31 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
>         struct freq_attr **drv_attr;
>         int ret = 0;
>
> -       /* prepare interface data */
> -       ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
> -                                  &dev->kobj, "cpufreq");
> -       if (ret)
> -               return ret;
> -
>         /* set up files for this cpu device */
>         drv_attr = cpufreq_driver->attr;
>         while ((drv_attr) && (*drv_attr)) {
>                 ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
>                 if (ret)
> -                       goto err_out_kobj_put;
> +                       return ret;
>                 drv_attr++;
>         }
>         if (cpufreq_driver->get) {
>                 ret = sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
>                 if (ret)
> -                       goto err_out_kobj_put;
> +                       return ret;
>         }
>
>         ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
>         if (ret)
> -               goto err_out_kobj_put;
> +               return ret;
>
>         if (cpufreq_driver->bios_limit) {
>                 ret = sysfs_create_file(&policy->kobj, &bios_limit.attr);
>                 if (ret)
> -                       goto err_out_kobj_put;
> +                       return ret;
>         }

We should add proper handling for error returned from sysfs_create_file()
someday, but its obviously not what you are trying to fix.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
