From: skannan@codeaurora.org
Subject: Re: [PATCH] timers: Fix timer inaccuracy
Date: Sun, 13 Nov 2016 15:26:37 -0800
Message-ID: <7124a235ee8f16a59de23bc1c9f01a56@codeaurora.org>
References: <1478684203-11966-1-git-send-email-joonwoop@codeaurora.org>
 <alpine.DEB.2.20.1611091045040.3501@nanos>
 <53b2d275-23f2-9ee2-7bde-e441659cf885@codeaurora.org>
 <alpine.DEB.2.20.1611101039540.3501@nanos> <58267675.9030006@codeaurora.org>
 <alpine.DEB.2.20.1611121215190.3501@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1611121215190.3501@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Joonwoo Park <joonwoop@codeaurora.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2016-11-12 03:25, Thomas Gleixner wrote:
> On Fri, 11 Nov 2016, Saravana Kannan wrote:
>> On 11/10/2016 02:07 AM, Thomas Gleixner wrote:
>> > Deferrable timers shouldn't have been invented in the first place and yes,
>> > they are not going to happen on hrtimers, quite the contrary, I'm working
>> > on eliminating them completely.
>> 
>> If you do that, how exactly do you propose drivers do periodic polling 
>> while
>> the Linux isn't idling, but stop polling when Linux is idle? devfreq 
>> is a
>> classic example. devfreq is used in a lot of mobile devices. Across 
>> different
>> vendors, devfreq is used for scaling system memory, flash storage, 
>> GPU, etc.
>> You are going to kill power if you remove deferrable timers without 
>> having an
>> alternate mechanism to solve this requirement.
>> 
>> For example, when you are browsing on your phone and reading something 
>> on
>> screen (but not interacting with the device), the CPUs/clusters/caches 
>> go idle
>> for long periods (several seconds) of time. If you remove deferrable 
>> timers,
>> you are going to force a CPU wake up every 10ms or 50ms or whatever 
>> it's
>> configured for.
> 
> I know how all that works, but there are other ways to deal with those
> timers.

I won't pretend to be a timer expert. So, could you please let me know 
what you had in mind? The other ideas that have been thrown around are 
things like cancelling the timers in the idle path of the last CPU, etc. 
But that has a lot of problems associated with it and doesn't seem like 
an elegant solution to me.

> We had complaints in the past because those timers can be stuck
> forever on a fully idle cpu and that's not a good thing either.

Agreed.

> The whole
> concept is ill defined or not defined at all, lacks any form of sane
> semantics and was shoved into the kernel w/i much thought. In hindsight 
> I
> should have rejected that deferrable mess 5+ years ago.

At least as an end user the semantics I expected and feel the semantics 
needs to be: The timer needs to fire similar to any other timer, but if 
the all the CPUs running this instance of the Linux kernel are idle, 
then don't fire the timer till one of them wakes up.

>> > When you can come up with a real regression caused by the rework and not
>> > just some handwaving theories then we can revisit that, but until then it's
>> > going to stay as is.
>> 
>> If the polling interval isn't accurate, the regression isn't so much 
>> about the
>> timer being inaccurate, but more so in the fact that it'll take that 
>> much
>> longer to react and increase the device frequency. Frame rendering 
>> time is
>> 16ms. If you react after 20ms instead of 10ms, that's way past a frame
>> rendering time. System memory frequency matters a lot for frame 
>> rendering too.
> 
> If you need precise timers use hrtimers and not a tick based mechanism,
> it's that simple.

Which goes back to the point that hrtimers will always wake up the CPU, 
but that's something we don't want.

To summarize, mobile devices have needs for timers that are generally 
accurate but also don't wake up the CPUs just to run them (something 
with the semantics of a deferrable hrtimer but not necessarily that 
implementation). Unbound deferrable timers did/do that, but had a 
problem of getting stuck on a CPU that's idle for a long time while the 
rest of the CPUs are up. But Joonwoo's fix for the "getting stuck" part 
had valid concerns from TGLX that it could cause cache thrashing. But 
the current fix makes the timers inaccurate (but again, I agree with the 
reasoning for the +1 jiffy). So, it looks likee there's currently no 
solution in the kernel for the above requirements and removing 
deferrable timers would make it even worse for an end mobile product.

Thanks,
Saravana
