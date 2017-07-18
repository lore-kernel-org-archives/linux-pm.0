From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Wed, 19 Jul 2017 00:35:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707190023010.2425@nanos>
References: <20170718211930.123077-1-salyzyn@android.com> <alpine.DEB.2.20.1707182338470.2425@nanos> <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdGRWfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 18:35:11 -0400
In-Reply-To: <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>

On Tue, 18 Jul 2017, Mark Salyzyn wrote:
> On 07/18/2017 02:52 PM, Thomas Gleixner wrote:
> > Why on earth do you need to print that information in RTC format? What's
> > wrong with just doing:
> > 
> >        pr_info("My so important log message %lld\n",
> > ktime_get_real_seconds());
> 
> Legacy (these prints have been in Android tree since 2013) for all our battery
> and power analysis tools are keyed off RTC format. There is some momentum,
> default should be epoch seconds/nanoseconds as that is a good example; and
> another option can select RTC (the option can be an internal patch to alter
> the format ... ick)

Can we please fix the tools and not introduce that horror in the kernel?

> > and then decoding the seconds in post processing? That's completely
> > sufficient as you intend that for logging. Correlation with user space
> > CLOCK_REALTIME is even simpler as this is the same as reading it from user
> > space.
> This is part of triage and post-analysis, there is no user space call that can
> be made after the fact to correlate MONOTONIC time with REALTIME. The
> historgram for the relationship between the two time formats is built up in
> user space based on batched analysis of the kernel logs. Although the values
> slip because of ntp and other sources, suspend/resume/hibernate/restore and
> shutdown are definitive points of interest for analysis. The analysis is
> performed on klogd data which has a longer logging span than the internal
> buffer.

Printing ktime_get_real_seconds() gives you the wall time. I was merily
explaining that this is the same as reading CLOCK_REALTIME from userspace.

Just for the record: You cannot use that stuff deep in the suspend/resume
code because timekeeping is suspended there as well and that call to
getnstimeofday() is going to trigger a WARNON() when called after
timekeeping was suspended. So please be more precise about the limitations
of this.

> > If your main intention is logging/debugging, then you can just use
> > tracepoints. The tracer allows correlation to user space tracing already.
> tracepoints are disabled on field devices. As is debugfs. This is not
> logging/debugging, but field battery and power analysis. Some of the data
> shows up in the Battery Settings screen on the devices. We also _benefit_ from
> this information when correlating kernel logs with user space logs during
> triage.

There was some discussion about making the clock source for dmesg time
stamps selectable, so you can use MONOTONIC, REALTIME, BOOTTIME. The
patches looked sensible, but there was some showstopper vs. the user space
dmesg utility. See:

  http://lkml.kernel.org/r/1456250040-22351-1-git-send-email-prarit@redhat.com

I rather see that resolved and these patches merged than having yet another
half baken special purpose debug band aid. Maybe Prarit can shed some light
on the state of this.

Thanks,

	tglx
