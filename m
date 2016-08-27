From: Xunlei Pang <xpang@redhat.com>
Subject: Re: [PATCH][RFC v4] timekeeping: ignore the bogus sleep time if
 pm_trace is enabled
Date: Sat, 27 Aug 2016 15:08:56 +0800
Message-ID: <57C13C88.3000208@redhat.com>
References: <1471517019-15216-1-git-send-email-yu.c.chen@intel.com>
Reply-To: xlpang@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbcH0HSI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 27 Aug 2016 03:18:08 -0400
In-Reply-To: <1471517019-15216-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Xunlei Pang <xlpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

On 2016/08/18 at 18:43, Chen Yu wrote:
> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, please refer to:
> https://patchwork.kernel.org/patch/9286365/
> It's improper in the first place to call __timekeeping_inject_sleeptime()
> in case that pm_trace is enabled simply because that "hash" time value
> will wreckage the timekeeping subsystem.
>
> So this patch ignores the sleep time if pm_trace is enabled in
> the following situation:
> 1. rtc is used as persist clock to compensate for sleep time,
>    (because system does not have a nonstop clocksource) or
> 2. rtc is used to calculate the sleep time in rtc_resume.
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Xunlei Pang <xlpang@redhat.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Janek Kozicki <cosurgi@gmail.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/kernel/rtc.c     |  7 +++++++
>  kernel/time/timekeeping.c | 14 +++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> index 79c6311c..6039138 100644
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
> @@ -146,6 +147,12 @@ void read_persistent_clock(struct timespec *ts)
>  	x86_platform.get_wallclock(ts);
>  }
>  
> +bool persistent_clock_is_usable(void)
> +{
> +	/* Unusable if pm_trace is enabled. */
> +	return !((x86_platform.get_wallclock == mach_get_cmos_time) &&
> +		 pm_trace_is_enabled());
> +}
>  
>  static struct resource rtc_resources[] = {
>  	[0] = {
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 3b65746..3122bd2b 100644
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
> @@ -1450,6 +1451,11 @@ void __weak read_boot_clock64(struct timespec64 *ts)
>  	ts->tv_nsec = 0;
>  }
>  
> +bool __weak persistent_clock_is_usable(void)
> +{
> +	return true;
> +}
> +

I suddenly think of a way to avoid adding this ugly __weak auxiliary function.

Add a special treatment for read_persistent_clock() in arch/x86/kernel/rtc.c as follows,
void read_persistent_clock(struct timespec *ts)
{
    x86_platform.get_wallclock(ts);

    /* Make rtc-based persistent clock unusable if pm_trace is enabled. */
    if (pm_trace_is_enabled() &&
        x86_platform.get_wallclock == mach_get_cmos_time) {
        ts->tv_sec = 0;
        ts->tv_nsec = 0;
    }
}

In this way, we can avoid the touch of timekeeping core, after all ptrace is currently x86-specific.

What do you think?

Regards,
Xunlei

>  /* Flag for if timekeeping_resume() has injected sleeptime */
>  static bool sleeptime_injected;
>  
> @@ -1551,7 +1557,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>   */
>  bool timekeeping_rtc_skipresume(void)
>  {
> -	return sleeptime_injected;
> +	return sleeptime_injected || pm_trace_is_enabled();
>  }
>  
>  /**
> @@ -1662,6 +1668,12 @@ void timekeeping_resume(void)
>  	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
>  		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
>  		sleeptime_injected = true;
> +		/*
> +		 * If rtc is used as persist clock thus it
> +		 * would be bogus when pm_trace is enabled.
> +		 */
> +		if (!persistent_clock_is_usable())
> +			sleeptime_injected = false;
>  	}
>  
>  	if (sleeptime_injected)

