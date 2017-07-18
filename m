From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/4] rtc-lib: Add rtc_show_time(const char *prefix_msg)
Date: Tue, 18 Jul 2017 19:52:24 +0200
Message-ID: <20170718175224.xccqnv4zjggn4shu@piout.net>
References: <20170718172525.114514-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718172525.114514-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, linux-rtc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 18/07/2017 at 10:25:23 -0700, Mark Salyzyn wrote:
> Go directly to the rtc for persistent wall clock time and print.
> Useful if REALTIME is required to be logged in a low level power
> management function or when clock activities are suspended.  An
> aid to permit user space alignment of kernel activities.
> 
> Feature activated by CONFIG_RTC_SHOW_TIME.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> ---
>  drivers/rtc/Kconfig   | 11 +++++++++++
>  drivers/rtc/rtc-lib.c | 16 ++++++++++++++++
>  include/linux/rtc.h   |  5 +++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 72419ac2c52a..7c308605bf42 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -5,6 +5,17 @@
>  config RTC_LIB
>  	bool
>  
> +config RTC_SHOW_TIME
> +	bool "rtc_show_time instrumentation"
> +	select RTC_LIB
> +	help
> +	  Activate rtc_show_time(const char *msg) wall clock time
> +	  instrumentation.
> +
> +	  The instrumentation is used to help triage and synchronize
> +	  kernel logs using CLOCK_MONOTONIC and user space activity
> +	  logs utilizing CLOCK_REALTIME references.
> +
>  config RTC_MC146818_LIB
>  	bool
>  	select RTC_LIB
> diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
> index 1ae7da5cfc60..676d6a83e843 100644
> --- a/drivers/rtc/rtc-lib.c
> +++ b/drivers/rtc/rtc-lib.c
> @@ -94,6 +94,22 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
>  }
>  EXPORT_SYMBOL(rtc_time64_to_tm);
>  
> +#ifdef CONFIG_RTC_SHOW_TIME
> +void rtc_show_time(const char *prefix_msg)
> +{
> +	struct timespec ts;
> +	struct rtc_time tm;
> +
> +	getnstimeofday(&ts);
> +	rtc_time_to_tm(ts.tv_sec, &tm);

Apart from using rtc_time_to_tm (and you should probably use
rtc_time64_to_tm), none of this is actually related to the RTC
subsystem. I feel like you should find another place to put that, maybe
timekeeping_debug.c?

> +	pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
> +		prefix_msg ? prefix_msg : "Time:",
> +		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> +}
> +EXPORT_SYMBOL(rtc_show_time);
> +#endif
> +
>  /*
>   * Does the rtc_time represent a valid date/time?
>   */
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 0a0f0d14a5fb..bf625e023799 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -22,6 +22,11 @@ extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year
>  extern int rtc_valid_tm(struct rtc_time *tm);
>  extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
>  extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
> +#ifdef CONFIG_RTC_SHOW_TIME
> +extern void rtc_show_time(const char *prefix_msg);
> +#else
> +#define rtc_show_time(prefix_msg)
> +#endif
>  ktime_t rtc_tm_to_ktime(struct rtc_time tm);
>  struct rtc_time rtc_ktime_to_tm(ktime_t kt);
>  
> -- 
> 2.13.2.932.g7449e964c-goog
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
