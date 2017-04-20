From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "cpuidle: Replace ktime_get() with local_clock()"
Date: Thu, 20 Apr 2017 16:41:46 +0200
Message-ID: <20170420144146.fuoqagm6xxrpxfoo@hirez.programming.kicks-ass.net>
References: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
 <20170420130813.h7dycr5cptbrvdkz@hirez.programming.kicks-ass.net>
 <20170420143751.GE2523@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170420143751.GE2523@mai>
Sender: stable-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ville.syrjala@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 20, 2017 at 04:37:51PM +0200, Daniel Lezcano wrote:

> >  
> > +	sched_clock_idle_wakeup_event(0);
> > +
> 
> Is it planned to skip this if the tsc is reliable?

Yes. Current code doesn't quite do that, but if you follow that link I
send earlier, I'm about to fix that (again).

Now, if only this Core2 piece of crap would actually boot a recent
kernel, I could go figure out wth is wrong.. :/
