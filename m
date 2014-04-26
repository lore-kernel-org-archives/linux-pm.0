From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Sat, 26 Apr 2014 08:17:44 +0200
Message-ID: <20140426061744.GB1944@gmail.com>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org>
 <2713863.BLQTYQm2Oa@vostro.rjw.lan>
 <20140425132055.GC11096@twins.programming.kicks-ass.net>
 <15044031.LGKXdkz8J7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15044031.LGKXdkz8J7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Amit Kucheria <amit.kucheria@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> > > Well, so now the question is whether or not we relly want to 
> > > always go to the "power" (or "energy efficiency" if you will) 
> > > mode if the system is on battery.  That arguably may not be a 
> > > good thing even for energy efficiency depending on how exactly 
> > > the modes are defined.
> > 
> > Nobody is talking about always. But in general it seems a good 
> > enough approach. Hell, many of the AC/BAT switches in todays power 
> > management crap things are not always right.
> > 
> > Do I want it to dim the LCD further when I unplug the laptop -- 
> > mostly no, but still it does. And the most annoying one is that it 
> > reduces the screen blank time to something near 5 seconds or so.
> > 
> > Why would this be any different?
> 
> And why do we have to do things that we hate it when they are done 
> by others?

He replied to your question of 'do we want to act on power events'.

The answer is: yes, from the scheduler point of view we want to act on 
power events by default, and if a user does not want that default 
behavior, it's not an unprecedented request and GUIs offer various 
ways to tweak screen dimming and other power saving details.

So "trying to save power" is the default everywhere, and the scheduler 
wants to do the same. The main reason we couldn't do this before was 
that the scheduler's 'power saving mode' was dysfunctional. That is 
being fixed.

So lets try this, it's high time.

Thanks,

	Ingo
