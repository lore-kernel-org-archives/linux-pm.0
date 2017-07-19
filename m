From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v4 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Wed, 19 Jul 2017 23:22:41 +0200
Message-ID: <20170719212241.kla3d3j6vgaxy4ba@piout.net>
References: <20170719194511.28899-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49694 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754455AbdGSVWy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 17:22:54 -0400
Content-Disposition: inline
In-Reply-To: <20170719194511.28899-1-salyzyn@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, linux-rtc@vger.kernel.org, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Richard Cochran <richardcochran@gmail.com>

Hi,

On 19/07/2017 at 12:44:41 -0700, Mark Salyzyn wrote:
> Primary purpose of rtc_show_time is to provide a marker used for
> post-mortem Battery and Power analysis.  These markers occur at
> major discontinuities of time, and thus optionally add a timestamp
> to aid the analysis.  This function is to be called at a higher
> level, and were added because of a lack of current kernel logging
> data.
> 

I really think you should drop rtc from the config, function and file
names because this doesn't have any relationship with any RTC stuff.

I can just see that you are (ab)using rtc_time64_to_tm because there is
no struct tm or gmtime() in the kernel.

> The persistent clock that is used to report Suspended for message
> is not present on all platforms, and is currently standardized for
> millisecond precision.
> 
> An added value to the time report is the ability in post-mortem
> triage analysis to synchronize kernel activities in MONOTONIC
> time with user space activities in REALTIME.
> 
> Feature activated by CONFIG_RTC_SHOW_TIME_<TYPE>, where <TYPE> is
> None (default, disabled), realtime, boottime or monotonic.
> 
> Since this is for post mortem field analysis, there is no debugfs
> or trace facility that can generally be leveraged.  analyze_suspend.py
> for example requires a debug configured kernel, on the other hand
> these prints can remain in a field product.  The purpose for
> rtc_show_time is not for development debugging.
> 
> Data collected may be recorded by klogd with a longer logspan
> than the built-in dmesg buffer, or land in pstore console driver
> to be collected after a reboot.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> 
> v2:
> - move implementation to kernel timekeeping from rtc_lib files
> - use rtc_time64_to_tm() instead of rtc_time_to_tm()
> - use inline in include/linux/rtc.h for !CONFIG_RTC_SHOW_TIME
> v3:
> - _correctly_ use rtc_time64_to_tm
> v4:
> - introduce CONFIG_RTC_SHOW_TIME_<TYPE> and split off rtc time
>   format printing to a separate patch.
> 
> ---
>  include/linux/rtc.h         |  5 +++
>  kernel/time/Kconfig         | 77 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/time/Makefile        |  1 +
>  kernel/time/rtc_show_time.c | 29 +++++++++++++++++
>  4 files changed, 112 insertions(+)
>  create mode 100644 kernel/time/rtc_show_time.c
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 0a0f0d14a5fb..779401c937d5 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -22,6 +22,11 @@ extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year
>  extern int rtc_valid_tm(struct rtc_time *tm);
>  extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
>  extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
> +#ifdef CONFIG_RTC_SHOW_TIME
> +extern void rtc_show_time(const char *prefix_msg);
> +#else
> +static inline void rtc_show_time(const char *prefix_msg) { }
> +#endif
>  ktime_t rtc_tm_to_ktime(struct rtc_time tm);
>  struct rtc_time rtc_ktime_to_tm(ktime_t kt);
>  
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index ac09bc29eb08..2dc891056635 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -145,3 +145,80 @@ config HIGH_RES_TIMERS
>  
>  endmenu
>  endif
> +
> +config RTC_SHOW_TIME
> +	bool
> +	help
> +	  Activate optional rtc_show_time(const char *msg) wall clock
> +	  time instrumentation.
> +
> +	  The primary use of the instrumentation is to aid field
> +	  analysis of Battery and Power usage.  The instrumentation
> +	  may also help triage and synchronize kernel logs and user
> +	  space activity logs at key displacements.  For instance
> +	  CLOCK_MONOTONIC stops while suspended, while CLOCK_REALTIME
> +	  continues, and the timestamps help re-orient post-analysis.
> +
> +	  Select the appropriate RTC_SHOW_TIME_<type>
> +
> +choice
> +	prompt "choose a clock for rtc_show_time"
> +	config RTC_SHOW_TIME_NONE
> +		bool "not activated"
> +		help
> +		  Turn off all printing associated with rtc_show_time
> +
> +		  The primary use of the instrumentation is to aid field
> +		  analysis of Battery and Power usage.  The instrumentation
> +		  may also help triage and synchronize kernel logs and user
> +		  space activity logs at key displacements.  For instance
> +		  CLOCK_MONOTONIC stops while suspended, while CLOCK_REALTIME
> +		  continues, and the timestamps help re-orient post-analysis.
> +
> +		  This is the default behavior.
> +	config RTC_SHOW_TIME_REALTIME
> +		bool "realtime"
> +		select RTC_SHOW_TIME
> +		help
> +		  Activate optional rtc_show_time(const char *msg) wall clock
> +		  time instrumentation.
> +
> +		  The primary use of the instrumentation is to aid field
> +		  analysis of Battery and Power usage.  The instrumentation
> +		  may also help triage and synchronize kernel logs and user
> +		  space activity logs at key displacements.  For instance
> +		  CLOCK_MONOTONIC stops while suspended, while CLOCK_REALTIME
> +		  continues, and the timestamps help re-orient post-analysis.
> +
> +		  Print realtime <epoch>.<ns> timestamp in rtc_show_time
> +	config RTC_SHOW_TIME_MONOTONIC
> +		bool "monotonic"
> +		select RTC_SHOW_TIME
> +		help
> +		  Activate optional rtc_show_time(const char *msg) wall clock
> +		  time instrumentation.
> +
> +		  The primary use of the instrumentation is to aid field
> +		  analysis of Battery and Power usage.  The instrumentation
> +		  may also help triage and synchronize kernel logs and user
> +		  space activity logs at key displacements.  For instance
> +		  CLOCK_MONOTONIC stops while suspended, while CLOCK_REALTIME
> +		  continues, and the timestamps help re-orient post-analysis.
> +
> +		  Print only the supplied message in rtc_show_time
> +	config RTC_SHOW_TIME_BOOTTIME
> +		bool "boottime"
> +		select RTC_SHOW_TIME
> +		help
> +		  Activate optional rtc_show_time(const char *msg) wall clock
> +		  time instrumentation.
> +
> +		  The primary use of the instrumentation is to aid field
> +		  analysis of Battery and Power usage.  The instrumentation
> +		  may also help triage and synchronize kernel logs and user
> +		  space activity logs at key displacements.  For instance
> +		  CLOCK_MONOTONIC stops while suspended, while CLOCK_REALTIME
> +		  continues, and the timestamps help re-orient post-analysis.
> +
> +		  Print boottime <s>.<ns> timestamp in rtc_show_time
> +endchoice
> diff --git a/kernel/time/Makefile b/kernel/time/Makefile
> index 938dbf33ef49..66f17e641052 100644
> --- a/kernel/time/Makefile
> +++ b/kernel/time/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
>  obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
>  obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
>  obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
> +obj-$(CONFIG_RTC_SHOW_TIME)			+= rtc_show_time.o
> diff --git a/kernel/time/rtc_show_time.c b/kernel/time/rtc_show_time.c
> new file mode 100644
> index 000000000000..19a8a0cc94f0
> --- /dev/null
> +++ b/kernel/time/rtc_show_time.c
> @@ -0,0 +1,29 @@
> +/*
> + * rtc time printing utility functions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/rtc.h>
> +
> +void rtc_show_time(const char *prefix_msg)
> +{
> +#if defined(CONFIG_RTC_SHOW_TIME_MONOTONIC) /* dmesg is in monotonic */
> +	pr_info("%s\n", prefix_msg ? prefix_msg : "Time:");
> +#elif defined(CONFIG_RTC_SHOW_TIME_BOOTTIME)
> +	struct timespec64 ts;
> +
> +	getboottime64(&ts);
> +	pr_info("%s %lu.%09lu B\n",
> +		prefix_msg ? prefix_msg : "Time:", ts.tv_sec, ts.tv_nsec);
> +#else /* realtime */
> +	struct timespec64 ts;
> +
> +	getnstimeofday64(&ts);
> +	pr_info("%s %lu.%09lu UTC\n",
> +		prefix_msg ? prefix_msg : "Time:", ts.tv_sec, ts.tv_nsec);
> +#endif
> +}
> +EXPORT_SYMBOL(rtc_show_time);
> -- 
> 2.14.0.rc0.284.gd933b75aa4-goog
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
