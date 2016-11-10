From: Joonwoo Park <joonwoop@codeaurora.org>
Subject: Re: [PATCH] timers: Fix timer inaccuracy
Date: Wed, 9 Nov 2016 17:32:33 -0800
Message-ID: <53b2d275-23f2-9ee2-7bde-e441659cf885@codeaurora.org>
References: <1478684203-11966-1-git-send-email-joonwoop@codeaurora.org>
 <alpine.DEB.2.20.1611091045040.3501@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1611091045040.3501@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 11/09/2016 01:56 AM, Thomas Gleixner wrote:
> On Wed, 9 Nov 2016, Joonwoo Park wrote:
>
>> When a new timer list enqueued into the time wheel, array index
>> for the given expiry time is:
>>
>>   expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
>>   idx = LVL_OFFS(lvl) + (expires & LVL_MASK);
>>
>> The granularity of the expiry time level is being added to the index
>> in order to fire the timer after its expiry time for the case when
>> the timer cannot fire at the exact time because of each level's
>> granularity.  However current index calculation also increases index
>> of timer list even if the timer can fire at exact time.  Consequently
>> timers which can fire at exact time including all in the first level
>> of bucket fire with one jiffy delay at present.
>>
>> Fix such inaccuracy by adding granularity of expiry time level only
>> when a given timer cannot fire at exact time.
>
> That's simply wrong. We guarantee that the timer sleeps for at least a
> jiffy. So in case of the first wheel we _must_ increment by one simply
> because the next jiffie might be immanent and not doing so would expire the
> timer early.
>
> The wheel is not meant to be accurate at all and I really don't want an
> extra conditional in that path just to make it accurate for some expiry
> values. That's a completely pointless exercise.

I understand it's not meant to provide much of accuracy and also don't 
really care about accuracy of sporadic timer aim and fire.
What I'm worried about is case that relies on periodic timer with 
relatively short interval.
If you see bus scaling driver function devfreq_monitor() in 
drivers/devfreq/devfreq.c, it polls hardware every configured interval 
by using deferrable delayed work.  I'm not quite familiar with bus 
scaling so cc'ing linux-pm.

My guess is that ever since we have timer refactoring, above driver is 
polling every configured jiffy + 1 most of time.
When CONFIG_HZ_100=y and the interval is 1, polling will be happening 
every 20ms rather than configured 10ms which is 100% later than ideal.

If that kind of drivers want to run periodic polling at similar level of 
accuracy like pre v4.8, each drivers have to switch to hrtimer but there 
are problems apart from the fact there is no nicely written deferred 
processing mechanism like workqueue with hrtimer -
1) there is no deferrable hrtimer.
2) hrtimer has more overhead more than low res timer, especially hrtimer 
will fire interrupt for individual timer lists which will cause power 
impact.

It also makes sense to me that queued timer especially with long delay 
is tolerable to inaccuracy especially when most of them got canceled 
prior to its expiry time.
But by drivers which use timer as polling mechanism which never cancel 
it, IMHO this behaviour change could be a regression.

Thanks,
Joonwoo

>
> Thanks,
>
> 	tglx
>
