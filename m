From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor for tickless systems
Date: Thu, 22 Nov 2018 00:44:06 +0100
Message-ID: <2788286.KFAUdKNhO2@aspire.rjw.lan>
References: <102783770.7hZjAahU8c@aspire.rjw.lan> <20181111154017.GD3021@worktop> <3270197.PFh8UsvZCP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3270197.PFh8UsvZCP@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 15, 2018 4:15:59 AM CET Rafael J. Wysocki wrote:
> On Sunday, November 11, 2018 4:40:17 PM CET Peter Zijlstra wrote:

[cut]

> 
> > Anyway; a fair while ago I proposed a different estimator. I've not had
> > time to dig through the 4 prior versions so I cannot tell if you've
> > already tried this, but the idea was simple:
> > 
> >   - track the last @n wakeup distances in the @idle-states buckets;
> >   - sum the buckets in increasing idle state and pick the state before
> >     you reach 50% of @n.
> > 
> > That is computationally cheaper than what you have; and should allow you
> > to increase @n without making the computation more expensive.
> 
> I can do something similar (actually, I have a prototype ready already),
> but do it after walking the idle states once (which will give us a preliminary
> idle state choice based on the time to the closest timer and the "history")
> and then sum the buckets below the idle state selected so far in the decreasing
> order (that will tend to select a shallower state in "tie" situations).

I did that, but the result was not encouraging as it caused state 0 (polling)
to be selected way too often (and the total time spent in it was significantly
greater too).

I have gone back to averaging over the most recent observed idle duration
values, but now I'm doing that after selecting a candidate idle state
(based on the time to the closest timer and the "history") and only taking
values below the target residency of that state into account.  Seems to work
reasonably well.

I'll send a v6 tomorrow if all goes well.
