From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v4] timekeeping: ignore the bogus sleep time if
 pm_trace is enabled
Date: Sun, 28 Aug 2016 16:28:10 +0800
Message-ID: <20160828082810.GA8446@sharon>
References: <1471517019-15216-1-git-send-email-yu.c.chen@intel.com>
 <57C13C88.3000208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57C13C88.3000208@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xlpang@redhat.com
Cc: linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 27, 2016 at 03:08:56PM +0800, Xunlei Pang wrote:
> On 2016/08/18 at 18:43, Chen Yu wrote:
> > Previously we encountered some memory overflow issues due to
> > the bogus sleep time brought by inconsistent rtc, which is
> > triggered when pm_trace is enabled, please refer to:
> > https://patchwork.kernel.org/patch/9286365/
> > It's improper in the first place to call __timekeeping_inject_sleeptime()
> > in case that pm_trace is enabled simply because that "hash" time value
> > will wreckage the timekeeping subsystem.
> >
> > So this patch ignores the sleep time if pm_trace is enabled in
> > the following situation:
> > 1. rtc is used as persist clock to compensate for sleep time,
> >    (because system does not have a nonstop clocksource) or
> > 2. rtc is used to calculate the sleep time in rtc_resume.
> >
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Xunlei Pang <xlpang@redhat.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reported-by: Janek Kozicki <cosurgi@gmail.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> I suddenly think of a way to avoid adding this ugly __weak auxiliary function.
> 
> Add a special treatment for read_persistent_clock() in arch/x86/kernel/rtc.c as follows,
> void read_persistent_clock(struct timespec *ts)
> {
>     x86_platform.get_wallclock(ts);
> 
>     /* Make rtc-based persistent clock unusable if pm_trace is enabled. */
>     if (pm_trace_is_enabled() &&
>         x86_platform.get_wallclock == mach_get_cmos_time) {
>         ts->tv_sec = 0;
>         ts->tv_nsec = 0;
> 
> In this way, we can avoid the touch of timekeeping core, after all ptrace is currently x86-specific.
> 
> What do you think?
>
OK, I have another question, if we do like this, as read_persistent_clock64
is invoked in timekeeping_suspend/timekeeping_resume/timekeeping_init,
then for timekeeping_init case, if pm_trace is enabled by command line,
we will never use rtc even if we do not suspend?
 
 
 
