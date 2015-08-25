From: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH] x86 kernel crash fix when thermal interrupt called
Date: Tue, 25 Aug 2015 11:36:04 +0300
Message-ID: <CAK3bHNUiPNfOwMMoPLJE3LOwia-akYC-WAOBzpztjD05Lxy6qw@mail.gmail.com>
References: <1440155140-30678-1-git-send-email-aospan@netup.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.netup.ru ([77.72.80.15]:38904 "EHLO imap.netup.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbbHYIgH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 04:36:07 -0400
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com [209.85.217.174])
	by imap.netup.ru (Postfix) with ESMTPA id 3E814718B26
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2015 11:36:05 +0300 (MSK)
Received: by lbbpu9 with SMTP id pu9so95183713lbb.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2015 01:36:04 -0700 (PDT)
In-Reply-To: <1440155140-30678-1-git-send-email-aospan@netup.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Abylay Ospan <aospan@netup.ru>

Hi All,

Please ignore this patch. I will send another patch (v2). Problem bit
bigger then expected.

2015-08-21 14:05 GMT+03:00 Abylay Ospan <aospan@netup.ru>:
> platform_thermal_package_notify can be called while initialization not
> complete. In this case pkg_temp_thermal_threshold_work not inited and we got
> kernel crash:
> [   86.158612] kernel BUG at kernel/time/timer.c:973!
> [   86.187998] invalid opcode: 0000 [#1] PREEMPT SMP
> ...
> [   86.451489] CPU: 0 PID: 4025 Comm: modprobe Tainted: G     U  W
> 4.1.6-netup-iptv-1.12.0+ #8
> ...
> [   87.162383] Call Trace:
> [   87.177624]  <IRQ>
> [   87.189170]  [<ffffffff8106964a>] __queue_delayed_work+0x12a/0x160
> [   87.228490]  [<ffffffff810696c5>] queue_delayed_work_on+0x45/0x80
> [   87.265525]  [<ffffffffa05880d7>]
> pkg_temp_thermal_platform_thermal_notify+0xb7/0x110 [x86_pkg_temp_thermal]
> [   87.324973]  [<ffffffff8102f201>] intel_thermal_interrupt+0x201/0x240
> [   87.364138]  [<ffffffff8102f25b>] smp_thermal_interrupt+0x1b/0x40
> [   87.401221]  [<ffffffff81ebcf00>] thermal_interrupt+0x70/0x80
>
> Signed-off-by: Abylay Ospan <aospan@netup.ru>
> ---
>  drivers/thermal/x86_pkg_temp_thermal.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
> index 50d1d2c..e78c7c8 100644
> --- a/drivers/thermal/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> @@ -585,10 +585,6 @@ static int __init pkg_temp_thermal_init(void)
>                 return -ENODEV;
>
>         spin_lock_init(&pkg_work_lock);
> -       platform_thermal_package_notify =
> -                       pkg_temp_thermal_platform_thermal_notify;
> -       platform_thermal_package_rate_control =
> -                       pkg_temp_thermal_platform_thermal_rate_control;
>
>         cpu_notifier_register_begin();
>         for_each_online_cpu(i)
> @@ -597,6 +593,11 @@ static int __init pkg_temp_thermal_init(void)
>         __register_hotcpu_notifier(&pkg_temp_thermal_notifier);
>         cpu_notifier_register_done();
>
> +       platform_thermal_package_notify =
> +                       pkg_temp_thermal_platform_thermal_notify;
> +       platform_thermal_package_rate_control =
> +                       pkg_temp_thermal_platform_thermal_rate_control;
> +
>         pkg_temp_debugfs_init(); /* Don't care if fails */
>
>         return 0;
> --
> 2.1.4
>



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv
