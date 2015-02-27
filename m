From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 0/2] drivers: cpuidle: minor suspend-to-idle fixes
Date: Fri, 27 Feb 2015 10:00:00 +0000
Message-ID: <20150227100000.GA5975@red-moon>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
 <4425438.YlYNQyf1hp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4425438.YlYNQyf1hp@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, preeti@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

[CC'ed Preeti]

On Thu, Feb 26, 2015 at 11:37:54PM +0000, Rafael J. Wysocki wrote:
> Me versions of the two $subject patches follow.

Thank you. I am testing them and I have run into the following issue.

Starting with:

3810631 ("PM / sleep: Re-implement suspend-to-idle handling")

the suspend-to-idle code path in the cpuidle_idle_call() bypasses
the CPUIDLE_FLAG_TIMER_STOP code path entirely. Now, on most of
the current ARM platforms, the deepest idle state loses the tick device
context, therefore this means that going to idle through
suspend-to-idle becomes a brute force way of nuking the tick,
unless I am missing something here.

I am experiencing hangs on resume from suspend-to-idle when the broadcast
timer is the broadast-hrtimer (ie there is no HW broadcast timer in the
platform) and the deepest idle states lose the tick device context (ie
they are CPUIDLE_FLAG_TIMER_STOP), I hope Preeti can help me test this on
Power, still chasing the issue.

I could not reproduce the issue with a HW broadcast timer device.

Platform has deepest idle states that allow CPUs shutdown where the
local tick device is gone on entry, I am trying to provide you with a
backtrace, I need time to debug.

The question I have: is it safe to bypass the CPUIDLE_FLAG_TIMER_STOP
and related broadcast mode entry/exit in the suspend-to-idle path ?

I do not think it is, but I am asking.

I can "force" tick freeze by initializing the enter_freeze pointer
in the idle states (that's the next thing I will test), but still, for
platforms where that's not possible my question above is still valid.

Thanks,
Lorenzo
