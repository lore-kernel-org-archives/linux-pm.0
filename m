From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] drivers: cpufreq: exynos: update related_cpus mask to fix hotplug dump
Date: Mon, 28 Jan 2013 13:26:31 +0100
Message-ID: <5258369.So5tj1UHcd@vostro.rjw.lan>
References: <1359000647-8366-1-git-send-email-inderpal.singh@linaro.org> <CAOh2x==_n7d+FUyAA6nWuHHLK0TA7smBYXd2M=72HDQef3NG4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57713 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756032Ab3A1MUW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jan 2013 07:20:22 -0500
In-Reply-To: <CAOh2x==_n7d+FUyAA6nWuHHLK0TA7smBYXd2M=72HDQef3NG4w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Inderpal Singh <inderpal.singh@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, patches@linaro.org

On Monday, January 28, 2013 09:45:02 AM Viresh Kumar wrote:
> On Thu, Jan 24, 2013 at 9:40 AM, Inderpal Singh
> <inderpal.singh@linaro.org> wrote:
> > commit "7e6087e595d3...cpufreq: Simplify cpufreq_add_dev()" started using
> > related_cpus mask to check if the current cpu is already managed.
> >
> > With above commit hotplug in exynos gives following dump.
> >
> > / $ echo 1 > /sys/devices/system/cpu/cpu1/online
> > CPU1: Booted secondary processor
> > ------------[ cut here ]------------
> > WARNING: at fs/sysfs/dir.c:536 sysfs_add_one+0x88/0xbc()
> > sysfs: cannot create duplicate filename '/devices/system/cpu/cpu0/cpufreq'
> > Modules linked in:
> > [<c0014560>] (unwind_backtrace+0x0/0xf8) from [<c0020214>] (warn_slowpath_common+0x4c/0x64)
> > [<c0020214>] (warn_slowpath_common+0x4c/0x64) from [<c00202c0>] (warn_slowpath_fmt+0x30/0x40)
> > [<c00202c0>] (warn_slowpath_fmt+0x30/0x40) from [<c00fb548>] (sysfs_add_one+0x88/0xbc)
> > [<c00fb548>] (sysfs_add_one+0x88/0xbc) from [<c00fc184>] (sysfs_do_create_link+0x110/0x208)
> > [<c00fc184>] (sysfs_do_create_link+0x110/0x208) from [<c019a868>] (cpufreq_add_dev_interface+0x218/0x2b0)
> > [<c019a868>] (cpufreq_add_dev_interface+0x218/0x2b0) from [<c019ac0c>] (cpufreq_add_dev+0x30c/0x448)
> > [<c019ac0c>] (cpufreq_add_dev+0x30c/0x448) from [<c01bdb84>] (cpufreq_cpu_callback+0x94/0x9c)
> > [<c01bdb84>] (cpufreq_cpu_callback+0x94/0x9c) from [<c0040fac>] (notifier_call_chain+0x44/0x84)
> > [<c0040fac>] (notifier_call_chain+0x44/0x84) from [<c0023484>] (__cpu_notify+0x28/0x44)
> > [<c0023484>] (__cpu_notify+0x28/0x44) from [<c01bc320>] (_cpu_up+0x104/0x154)
> > [<c01bc320>] (_cpu_up+0x104/0x154) from [<c01bc3d4>] (cpu_up+0x64/0x84)
> > [<c01bc3d4>] (cpu_up+0x64/0x84) from [<c01bafc8>] (store_online+0x50/0x78)
> > [<c01bafc8>] (store_online+0x50/0x78) from [<c016850c>] (dev_attr_store+0x18/0x24)
> > [<c016850c>] (dev_attr_store+0x18/0x24) from [<c00fa12c>] (sysfs_write_file+0x168/0x198)
> > [<c00fa12c>] (sysfs_write_file+0x168/0x198) from [<c00a7424>] (vfs_write+0x9c/0x140)
> > [<c00a7424>] (vfs_write+0x9c/0x140) from [<c00a76b0>] (sys_write+0x3c/0x70)
> > [<c00a76b0>] (sys_write+0x3c/0x70) from [<c000e2c0>] (ret_fast_syscall+0x0/0x30)
> > ---[ end trace 3d002b0ded69f43b ]---
> >
> > This patch fixes it by updating the related_cpus mask.
> >
> > Tested on Rafael's linux-next.
> >
> > Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
> > ---
> >  drivers/cpufreq/exynos-cpufreq.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> > index 7012ea8..8ba4cdb 100644
> > --- a/drivers/cpufreq/exynos-cpufreq.c
> > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > @@ -238,6 +238,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >                 cpumask_copy(policy->cpus, cpu_online_mask);
> >         } else {
> >                 policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> > +               cpumask_setall(policy->related_cpus);
> >                 cpumask_setall(policy->cpus);
> 
> This is required for all SMP systems.

Grumble.

So here's a deal: I'll drop "cpufreq: Simplify cpufreq_add_dev()" for now and
you'll generate a new patch that won't cause the WARN_ON() to trigger.  OK?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
