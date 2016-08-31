From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC v5] timekeeping: Ignore the bogus sleep time if pm_trace is enabled
Date: Wed, 31 Aug 2016 02:31:46 +0200
Message-ID: <4130556.MNmyvLDyHH@vostro.rjw.lan>
References: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51587 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753595AbcHaAZ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 20:25:58 -0400
In-Reply-To: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, "3.17+" <stable@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

On Monday, August 29, 2016 12:40:39 AM Chen Yu wrote:
> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, and we have fixed it
> in recent kernel. However it's improper in the first place
> to call __timekeeping_inject_sleeptime() in case that pm_trace
> is enabled simply because that "hash" time value will wreckage
> the timekeeping subsystem.
> 
> So this patch ignores the sleep time if pm_trace is enabled in
> the following situation:
> 1. rtc is used as persist clock to compensate for sleep time,
>    or
> 2. rtc is used to calculate the sleep time in rtc_resume.
> 
> Cc: stable@vger.kernel.org  (3.17+)
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Xunlei Pang <xlpang@redhat.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Suggested-by: Xunlei Pang <xlpang@redhat.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Janek Kozicki <cosurgi@gmail.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/kernel/rtc.c     | 12 ++++++++++++
>  kernel/time/timekeeping.c |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> index 79c6311c..5c28197 100644
> --- a/arch/x86/kernel/rtc.c
> +++ b/arch/x86/kernel/rtc.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/pnp.h>
>  #include <linux/of.h>
> +#include <linux/pm-trace.h>
>  
>  #include <asm/vsyscall.h>
>  #include <asm/x86_init.h>
> @@ -144,6 +145,17 @@ int update_persistent_clock(struct timespec now)
>  void read_persistent_clock(struct timespec *ts)
>  {
>  	x86_platform.get_wallclock(ts);
> +
> +	/*
> +	 * Make rtc-based persistent clock unusable
> +	 * if pm_trace is enabled, only take effect
> +	 * for timekeeping_suspend/resume.
> +	 */
> +	if (pm_trace_is_enabled() &&
> +	    x86_platform.get_wallclock == mach_get_cmos_time) {
> +		ts->tv_sec = 0;
> +		ts->tv_nsec = 0;
> +	}

I'm not sure about this.  Looks hackish.

>  }
>  
>  
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 3b65746..9af885d 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -23,6 +23,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/pvclock_gtod.h>
>  #include <linux/compiler.h>
> +#include <linux/pm-trace.h>
>  
>  #include "tick-internal.h"
>  #include "ntp_internal.h"
> @@ -1551,7 +1552,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>   */
>  bool timekeeping_rtc_skipresume(void)
>  {
> -	return sleeptime_injected;
> +	return sleeptime_injected || pm_trace_is_enabled();
>  }
>  
>  /**

Thanks,
Rafael

