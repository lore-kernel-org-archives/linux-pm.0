From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v2 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Tue, 18 Jul 2017 15:06:20 -0700
Message-ID: <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
References: <20170718211930.123077-1-salyzyn@android.com>
 <alpine.DEB.2.20.1707182338470.2425@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1707182338470.2425@nanos>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 07/18/2017 02:52 PM, Thomas Gleixner wrote:
> On Tue, 18 Jul 2017, Mark Salyzyn wrote:
>
>> Go directly to the rtc for persistent wall clock time and print.
>> Useful if REALTIME is required to be logged in a low level power
>> management function or when clock activities are suspended.  An
>> aid to permit user space alignment of kernel activities.
> That's a horrible idea, really. And there is no point at all.
>
>> +void rtc_show_time(const char *prefix_msg)
>> +{
>> +	struct timespec ts;
>> +	struct rtc_time tm;
>> +
>> +	getnstimeofday(&ts);
> It calls getnstimeofday(), which is wrong to begin with as we switch
> everything in kernel to the 64bit variants.

oops, good catch.
>
>> +	rtc_time64_to_tm(ts.tv_sec, &tm);
> This is even more wrong as rtc_time64_to_tm is for 64 bit wide second
> values....
Again, oops, changed rtc_time_to_tm to rtc_time64_to_tm as requested, 
did not change other pieces.
>
>> +	pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
>> +		prefix_msg ? prefix_msg : "Time:",
>> +		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>> +		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> Why on earth do you need to print that information in RTC format? What's
> wrong with just doing:
>
>        pr_info("My so important log message %lld\n", ktime_get_real_seconds());

Legacy (these prints have been in Android tree since 2013) for all our 
battery and power analysis tools are keyed off RTC format. There is some 
momentum, default should be epoch seconds/nanoseconds as that is a good 
example; and another option can select RTC (the option can be an 
internal patch to alter the format ... ick)
>
> and then decoding the seconds in post processing? That's completely
> sufficient as you intend that for logging. Correlation with user space
> CLOCK_REALTIME is even simpler as this is the same as reading it from user
> space.
This is part of triage and post-analysis, there is no user space call 
that can be made after the fact to correlate MONOTONIC time with 
REALTIME. The historgram for the relationship between the two time 
formats is built up in user space based on batched analysis of the 
kernel logs. Although the values slip because of ntp and other sources, 
suspend/resume/hibernate/restore and shutdown are definitive points of 
interest for analysis. The analysis is performed on klogd data which has 
a longer logging span than the internal buffer.
>
> If your main intention is logging/debugging, then you can just use
> tracepoints. The tracer allows correlation to user space tracing already.
tracepoints are disabled on field devices. As is debugfs. This is not 
logging/debugging, but field battery and power analysis. Some of the 
data shows up in the Battery Settings screen on the devices. We also 
_benefit_ from this information when correlating kernel logs with user 
space logs during triage.
>
> So unless you can come up with a reasonable explanation why all this voodoo
> is required, this is going nowhere.
>
> Thanks,
>
> 	tglx
>
>
>
>
