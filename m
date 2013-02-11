From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dereference cpufreq_driver after check
Date: Mon, 11 Feb 2013 20:43:45 +0530
Message-ID: <CAKohpom30wqCnxdf-Bp1NvaD1ZyOiNqrupvdxg2xnwcviyM8XA@mail.gmail.com>
References: <1360593460-1575-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34419 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255Ab3BKPNq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Feb 2013 10:13:46 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so6118166obc.19
        for <linux-pm@vger.kernel.org>; Mon, 11 Feb 2013 07:13:45 -0800 (PST)
In-Reply-To: <1360593460-1575-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Nathan Zimmer <nzimmer@sgi.com>, Fengguang Wu <fengguang.wu@intel.com>

On 11 February 2013 20:07, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Commit e1ee7c86 ("cpufreq: Convert the cpufreq_driver_lock to use RCU")
> introduces an RCU storage for cpufreq_driver. On Intel Medfield board we are
> getting a warning during kernel boot.
>
> [    6.074511] ===============================
> [    6.078634] [ INFO: suspicious RCU usage. ]
> [    6.082930] 3.8.0-rc6-next-20130208-00036-g83eb4b6-dirty #1058 Not tainted
> [    6.089748] -------------------------------
> [    6.093926] drivers/cpufreq/cpufreq.c:1766 suspicious rcu_dereference_check() usage!
> [    6.101651]
> [    6.101651] other info that might help us debug this:
> [    6.101651]
> [    6.109659]
> [    6.109659] rcu_scheduler_active = 1, debug_locks = 0
> [    6.116215] no locks held by swapper/0/1.
> [    6.120167]
> [    6.120167] stack backtrace:
> [    6.124516] Pid: 1, comm: swapper/0 Not tainted 3.8.0-rc6-next-20130208-00036-g83eb4b6-dirty #1058
> [    6.133470] Call Trace:
> [    6.135917]  [<c1067669>] lockdep_rcu_suspicious+0xd4/0xdd
> [    6.141390]  [<c181d642>] ? cpufreq_core_init+0x8e/0x8e
> [    6.146604]  [<c1344879>] cpufreq_update_policy+0x71/0x1d7
> [    6.152081]  [<c1069d2f>] ? __lock_acquire+0xca4/0xcd4
> [    6.157210]  [<c1067ef0>] ? mark_lock+0x1f/0x209
> [    6.161820]  [<c1068137>] ? mark_held_locks+0x5d/0x7d
> [    6.166862]  [<c150c209>] ? __mutex_lock_common+0x2e0/0x344
> [    6.172425]  [<c106825c>] ? trace_hardirqs_on_caller+0x105/0x195
> [    6.178425]  [<c150c3ae>] ? __mutex_unlock_slowpath+0xe6/0x100
> [    6.184250]  [<c106825c>] ? trace_hardirqs_on_caller+0x105/0x195
> [    6.190248]  [<c10682f7>] ? trace_hardirqs_on+0xb/0xd
> [    6.195291]  [<c181d642>] ? cpufreq_core_init+0x8e/0x8e
> [    6.200506]  [<c150c3d0>] ? mutex_unlock+0x8/0xa
> [    6.205114]  [<c181d642>] ? cpufreq_core_init+0x8e/0x8e
> [    6.210331]  [<c181d68a>] cpufreq_stats_init+0x48/0xbd
> [    6.215461]  [<c181d68a>] ? cpufreq_stats_init+0x48/0xbd
> [    6.220763]  [<c181d642>] ? cpufreq_core_init+0x8e/0x8e
> [    6.225981]  [<c1001085>] do_one_initcall+0x6c/0x10b
> [    6.230938]  [<c17faa52>] ? kernel_init_freeable+0xf3/0x18e
> [    6.236501]  [<c17faa68>] kernel_init_freeable+0x109/0x18e
> [    6.241978]  [<c14fa2b4>] kernel_init+0x8/0xb4
> [    6.246412]  [<c150e937>] ret_from_kernel_thread+0x1b/0x28
> [    6.251889]  [<c14fa2ac>] ? rest_init+0x108/0x108
>
> The patch moves dereferencing part after policy check.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 79511ab..7d84b205 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1763,13 +1763,15 @@ int cpufreq_update_policy(unsigned int cpu)
>         struct cpufreq_policy *data = cpufreq_cpu_get(cpu);
>         struct cpufreq_policy policy;
>         int ret;
> -       struct cpufreq_driver *driver = rcu_dereference(cpufreq_driver);
> +       struct cpufreq_driver *driver;
>
>         if (!data) {
>                 ret = -ENODEV;
>                 goto no_policy;
>         }
>
> +       driver = rcu_dereference(cpufreq_driver);
> +

Hi Andy,

I don't quite understand why this warning came at the first place and how it
got fixed :(

Another thing, rcu patch is already dropped by Rafael for 3.9 and isn't there in
linux-next.
