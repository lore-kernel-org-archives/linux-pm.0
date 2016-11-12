From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] timers: Fix timer inaccuracy
Date: Fri, 11 Nov 2016 17:55:01 -0800
Message-ID: <58267675.9030006@codeaurora.org>
References: <1478684203-11966-1-git-send-email-joonwoop@codeaurora.org> <alpine.DEB.2.20.1611091045040.3501@nanos> <53b2d275-23f2-9ee2-7bde-e441659cf885@codeaurora.org> <alpine.DEB.2.20.1611101039540.3501@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936530AbcKLBzE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 20:55:04 -0500
In-Reply-To: <alpine.DEB.2.20.1611101039540.3501@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Joonwoo Park <joonwoop@codeaurora.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 11/10/2016 02:07 AM, Thomas Gleixner wrote:
> On Wed, 9 Nov 2016, Joonwoo Park wrote:
<SNIP>

> So this timer expired exactly a few micro seconds after arming and therefor
> violates the guarantee of firing not before the specified interval.
>
> So depending on when you arm the timer the expiry is going to be:
>
>     1 jiffie <= expiry <= 2 jiffies
>
> If you disable high resolution timers then your user space program using
> nanosleep will have exactly the same behaviour.
>
> And this is the only sane behaviour you can expect from timers: To not
> expire early.

I completely understand the why you did the +1 jiffy. If you don't know 
at which point between two jiffies the timer was set up, you'll have to 
assume the worst case that the timer was set up just before the jiffy 
rolls over. That why you are doing the +1. Makes sense.

> Every user must cope with late expiry anyway as there is no guarantee that
> the task is scheduled right away. Neither is there a guarantee that the
> softirq (it might be deferred to ksoftirqd) invokes the callback on time.
>
> The timer wheel is optimized for enqueue/dequeue speed and implicit
> batching. Making it artificial accurate for one particular case is just
> adding pointless overhead and aside of that it's going to violate the valid
> assumption that a 1 jiffie sleep is going to sleep at least 1 jiffie.
>
>> If that kind of drivers want to run periodic polling at similar level of
>> accuracy like pre v4.8, each drivers have to switch to hrtimer but there are
>> problems apart from the fact there is no nicely written deferred processing
>> mechanism like workqueue with hrtimer -
>> 1) there is no deferrable hrtimer.
>> 2) hrtimer has more overhead more than low res timer, especially hrtimer will
>> fire interrupt for individual timer lists which will cause power impact.
>
> Deferrable timers shouldn't have been invented in the first place and yes,
> they are not going to happen on hrtimers, quite the contrary, I'm working
> on eliminating them completely.

If you do that, how exactly do you propose drivers do periodic polling 
while the Linux isn't idling, but stop polling when Linux is idle? 
devfreq is a classic example. devfreq is used in a lot of mobile 
devices. Across different vendors, devfreq is used for scaling system 
memory, flash storage, GPU, etc. You are going to kill power if you 
remove deferrable timers without having an alternate mechanism to solve 
this requirement.

For example, when you are browsing on your phone and reading something 
on screen (but not interacting with the device), the 
CPUs/clusters/caches go idle for long periods (several seconds) of time. 
If you remove deferrable timers, you are going to force a CPU wake up 
every 10ms or 50ms or whatever it's configured for.

>> It also makes sense to me that queued timer especially with long delay is
>> tolerable to inaccuracy especially when most of them got canceled prior to its
>> expiry time.
>> But by drivers which use timer as polling mechanism which never cancel it,
>> IMHO this behaviour change could be a regression.
>
> When you can come up with a real regression caused by the rework and not
> just some handwaving theories then we can revisit that, but until then it's
> going to stay as is.

If the polling interval isn't accurate, the regression isn't so much 
about the timer being inaccurate, but more so in the fact that it'll 
take that much longer to react and increase the device frequency. Frame 
rendering time is 16ms. If you react after 20ms instead of 10ms, that's 
way past a frame rendering time. System memory frequency matters a lot 
for frame rendering too.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
