From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Tue, 18 Jul 2017 23:52:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707182338470.2425@nanos>
References: <20170718211930.123077-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718211930.123077-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Jul 2017, Mark Salyzyn wrote:

> Go directly to the rtc for persistent wall clock time and print.
> Useful if REALTIME is required to be logged in a low level power
> management function or when clock activities are suspended.  An
> aid to permit user space alignment of kernel activities.

That's a horrible idea, really. And there is no point at all.

> +void rtc_show_time(const char *prefix_msg)
> +{
> +	struct timespec ts;
> +	struct rtc_time tm;
> +
> +	getnstimeofday(&ts);

It calls getnstimeofday(), which is wrong to begin with as we switch
everything in kernel to the 64bit variants.

> +	rtc_time64_to_tm(ts.tv_sec, &tm);

This is even more wrong as rtc_time64_to_tm is for 64 bit wide second
values....

> +	pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
> +		prefix_msg ? prefix_msg : "Time:",
> +		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);

Why on earth do you need to print that information in RTC format? What's
wrong with just doing:

      pr_info("My so important log message %lld\n", ktime_get_real_seconds());

and then decoding the seconds in post processing? That's completely
sufficient as you intend that for logging. Correlation with user space
CLOCK_REALTIME is even simpler as this is the same as reading it from user
space.

If your main intention is logging/debugging, then you can just use
tracepoints. The tracer allows correlation to user space tracing already.

So unless you can come up with a reasonable explanation why all this voodoo
is required, this is going nowhere.

Thanks,

	tglx
