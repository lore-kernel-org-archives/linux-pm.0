From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v3 1/4] time: rtc-lib: Add rtc_show_time(const char *prefix_msg)
Date: Tue, 18 Jul 2017 17:00:04 -0700
Message-ID: <CALAqxLWK+_vnG_bpp4dPguNDTt1=JG6GANJm6b=V8gF1UGi1VQ@mail.gmail.com>
References: <20170718221607.132539-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718221607.132539-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Mark Salyzyn <salyzyn@google.com>, Thierry Strudel <tstrudel@google.com>, Thomas Gleixner <tglx@linutronix.de>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 18, 2017 at 3:15 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> Go directly to the rtc for persistent wall clock time and print.

So, first,  the above doesn't seem accurate to me. You're using
getnstimeofday64() which doesn't touch the RTC.

> Useful if REALTIME is required to be logged in a low level power
> management function or when clock activities are suspended.  An
> aid to permit user space alignment of kernel activities.

This explanation doesn't make much sense either. I've tried looking
over the patch series to better understand but its not super clear
right off.

A good practice is to start by explaining what you want to do ("allow
for battery and suspend time analysis"), and why the current upstream
kernel doesn't provide what you need ("timekeeping can be suspended,
so we want to reference the persistent clock that is always running
and provide a way to align those timestamps with
CLOCK_MONOTONIC/CLOCK_REALTIME timestamps that userspace uses"), and
only then explain how your solution addresses this issue.


> Feature activated by CONFIG_RTC_SHOW_TIME.
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>
> v2
> - move implementation to kernel timekeeping from rtc_lib files
> - use rtc_time64_to_tm() instead of rtc_time_to_tm()
> - use inline in include/linux/rtc.h for !CONFIG_RTC_SHOW_TIME
> v3
> - _correctly_ use rtc_time64_to_tm
> ---
>  include/linux/rtc.h         |  5 +++++
>  kernel/time/Kconfig         | 11 +++++++++++
>  kernel/time/Makefile        |  1 +
>  kernel/time/rtc_show_time.c | 23 +++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
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
> index ac09bc29eb08..4da093ae3e37 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -145,3 +145,14 @@ config HIGH_RES_TIMERS
>
>  endmenu
>  endif
> +
> +config RTC_SHOW_TIME
> +       bool "rtc_show_time instrumentation"
> +       select RTC_LIB
> +       help
> +         Activate rtc_show_time(const char *msg) wall clock time
> +         instrumentation.
> +
> +         The instrumentation is used to help triage and synchronize
> +         kernel logs using CLOCK_MONOTONIC and user space activity
> +         logs utilizing CLOCK_REALTIME references.

RTC_SHOW_TIME seems like a poor name for this, as you're not really
doing much with the RTC here (other then printing the current
CLOCK_REALTIME value to be printed out in in a format that's commonly
used w/ RTC hardware).  As for the reference to CLOCK_MONOTONIC, I
assume you are correlating that via printk timestamp (which may not
always be enabled)?


> diff --git a/kernel/time/Makefile b/kernel/time/Makefile
> index 938dbf33ef49..66f17e641052 100644
> --- a/kernel/time/Makefile
> +++ b/kernel/time/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_GENERIC_SCHED_CLOCK)             += sched_clock.o
>  obj-$(CONFIG_TICK_ONESHOT)                     += tick-oneshot.o tick-sched.o
>  obj-$(CONFIG_DEBUG_FS)                         += timekeeping_debug.o
>  obj-$(CONFIG_TEST_UDELAY)                      += test_udelay.o
> +obj-$(CONFIG_RTC_SHOW_TIME)                    += rtc_show_time.o
> diff --git a/kernel/time/rtc_show_time.c b/kernel/time/rtc_show_time.c
> new file mode 100644
> index 000000000000..bbf4f92abf4f
> --- /dev/null
> +++ b/kernel/time/rtc_show_time.c
> @@ -0,0 +1,23 @@
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
> +       struct timespec64 ts;
> +       struct rtc_time tm;
> +
> +       getnstimeofday64(&ts);
> +       rtc_time64_to_tm(ts.tv_sec, &tm);
> +       pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
> +               prefix_msg ? prefix_msg : "Time:",
> +               tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +               tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> +}
> +EXPORT_SYMBOL(rtc_show_time);

Overall, this does feel very single-use-case specific.

thanks
-john
