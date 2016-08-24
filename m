From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 2/2] timekeeping: Cap array access in timekeeping_debug
 to protect against invalid sleep times
Date: Wed, 24 Aug 2016 08:58:30 +0800
Message-ID: <20160824005830.GA16827@sharon>
References: <1471993702-29148-1-git-send-email-john.stultz@linaro.org>
 <1471993702-29148-3-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19285 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbcHXAu1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Aug 2016 20:50:27 -0400
Content-Disposition: inline
In-Reply-To: <1471993702-29148-3-git-send-email-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Janek Kozicki <cosurgi@gmail.com>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, stable <stable@vger.kernel.org>

Hi John, some small typos below, others should be OK.

On Tue, Aug 23, 2016 at 04:08:22PM -0700, John Stultz wrote:
> It was reported that hibernation could fail on the 2nd attempt,
> where the system hangs at hibernate() -> syscore_resume() ->
> i8237A_resume() -> claim_dma_lock(), because the lock has
> already been taken.
> 
> However there is actually no other process would like to grab
> this lock on that problematic platform.
> 
> Further investigation showed that the problem is triggered by
> setting /sys/power/pm_trace to 1 before the 1st hibernation.
> 
> Since once pm_trace is enabled, the rtc becomes unmeaningful
> after suspend, and meanwhile some BIOSes would like to adjust
> the 'invalid' tsc(e.g, smaller than 1970) to the release date
I checked the previous commit log, and I have made a mistake, it
should be:
s/tsc/RTC
> of that motherboard during POST stage, thus after resumed, it
> may seem that the system had a significant long sleep time might
> due to meaningless tsc or RTC delta.
s/tsc or RTC/RTC
> 
> Then in timekeeping_resume -> tk_debug_account_sleep_time, if
> the bit31 of the sleep time happened to be set to 1, the fls
> returns 32 and then we add 1 to sleep_time_bin[32], which
> caused a memory overwritten.
> 
> As depicted by System.map:
> 0xffffffff81c9d080 b sleep_time_bin
> 0xffffffff81c9d100 B dma_spin_lock
> the dma_spin_lock.val is set to 1, which caused this problem.
> 
> This patch adds a sanity check in tk_debug_account_sleep_time()
> to ensure we don't index past the sleep_time_bin array.
> 
BTW, I've also post a fix to deal with pm_trace which might break
timekeeping at:
https://patchwork.kernel.org/patch/9287347/
could you please hel take a glance? thanks.

Yu
