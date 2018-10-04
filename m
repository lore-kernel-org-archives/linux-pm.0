From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Date: Thu, 4 Oct 2018 11:35:06 +0200
Message-ID: <20181004093506.GK19272@hirez.programming.kicks-ass.net>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <20181004075703.GG19272@hirez.programming.kicks-ass.net>
 <e4cf9124-2dbb-45cb-6b45-f0b92a6ac88e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e4cf9124-2dbb-45cb-6b45-f0b92a6ac88e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 04, 2018 at 10:12:44AM +0200, Daniel Lezcano wrote:
> 
> Hi Peter,
> 
> On 04/10/2018 09:57, Peter Zijlstra wrote:
> > On Thu, Oct 04, 2018 at 09:42:07AM +0200, Daniel Lezcano wrote:
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index b88a145..5605f03 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -2873,25 +2873,12 @@ unsigned long long nr_context_switches(void)
> >>  
> >>  	return sum;
> >>  }
> >> -/*
> >> - * Consumers of these two interfaces, like for example the cpufreq menu
> >> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> >> - * IO-wait which might not even end up running the task when it does become
> >> - * runnable.
> >> - */
> >>  
> >>  unsigned long nr_iowait_cpu(int cpu)
> >  
> > +static
> 
> The function is exported in include/linux/sched/stat.h and used by
> drivers/cpuidle/governors/menu.c
> 
> Do you want to declare it static inline in the stat.h file ?

No, but if there's a user left, that comment needs to stay. The number
it returns is utter crap.
