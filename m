From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin
 array
Date: Tue, 19 Jul 2016 10:36:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1607191031260.3596@nanos>
References: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: John Stultz <john.stultz@linaro.org>, "Rafael J. Wysock" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, "Stable # 3 . 17+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 19 Jul 2016, Chen Yu wrote:

> It is reported the hibernation fails at 2nd attempt, which
> hangs at hibernate() -> syscore_resume() -> i8237A_resume()
> -> claim_dma_lock(), because the lock has already been taken.
> However there is actually no other process would like to grab
> this lock on that problematic platform.
> 
> Further investigation shows that, the problem is caused by setting
> /sys/power/pm_trace to 1 before the 1st hibernation, since once
> pm_trace is enabled, the rtc becomes an unmeaningful value after resumed,

So why is the RTC value useless if pm_trace is enabled? I really have a hard
time to understand why pm_trace would affect the sleep time readout from RTC.

Thanks,

	tglx
