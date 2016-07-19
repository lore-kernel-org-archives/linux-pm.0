From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin
 array
Date: Tue, 19 Jul 2016 12:40:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1607191234200.3596@nanos>
References: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com> <alpine.DEB.2.11.1607191031260.3596@nanos> <578DEDBB.9030602@intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-883778797-1468924814=:3596"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <578DEDBB.9030602@intel.com>
Sender: stable-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: John Stultz <john.stultz@linaro.org>, "Rafael J. Wysock" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, "Stable # 3 . 17+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-883778797-1468924814=:3596
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 19 Jul 2016, Chen Yu wrote:
> On 2016年07月19日 16:36, Thomas Gleixner wrote:
> > On Tue, 19 Jul 2016, Chen Yu wrote:
> > > Further investigation shows that, the problem is caused by setting
> > > /sys/power/pm_trace to 1 before the 1st hibernation, since once
> > > pm_trace is enabled, the rtc becomes an unmeaningful value after resumed,
> >
> > So why is the RTC value useless if pm_trace is enabled? I really have a hard
> > time to understand why pm_trace would affect the sleep time readout from
> > RTC.
>
> After pm_trace is enabled, during system suspend/hibernate, the hash name of
> each devices will be written to rtc, so the rtc value depends on what we
> write in last suspend round, thus pm_trace can be used for diagnose which
> device failed to suspend(eg, the suspending on this device hang the system,
> we reboot the system , and check rtc hash value).
> 
> In our case, after first hibernate/resume round, we found our current system
> time is at 2117, so syscore_resume -> timekeeping_resume :
> __timekeeping_inject_sleeptime(tk, &ts_delta) would inject a quite large
> delta : 2117 - 2017 year, thus the sleep_time_bin is overflow.

While the range check is certainly correct and a good thing to have it's wrong
in the first place to call __timekeeping_inject_sleeptime() in case that
pm_trace is enabled simply because that "hash" time value will also wreckage
timekeeping. Your patch is just curing the symptom in the debug code but not
fixing the root cause.

Thanks,

	tglx
--8323329-883778797-1468924814=:3596--
