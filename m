From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 10 Mar 2016 09:43:31 +0100
Message-ID: <20160310084331.GO6344@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
 <56D8AEB7.2050100@linaro.org>
 <36459679.vzZnOsAVeg@vostro.rjw.lan>
 <20160308112759.GF6356@twins.programming.kicks-ass.net>
 <CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
 <20160308192640.GD6344@twins.programming.kicks-ass.net>
 <CAJZ5v0g=dXmoPr0jR6AVuynVYbSwJvnS2dFhb7QnUKq9LRRnrQ@mail.gmail.com>
 <20160309163930.GP6356@twins.programming.kicks-ass.net>
 <CAJZ5v0iKn4dT4ta6WaEcPbdYmA7P08=bmKU+dwcMx+Msk7WRFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iKn4dT4ta6WaEcPbdYmA7P08=bmKU+dwcMx+Msk7WRFg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 10, 2016 at 12:28:52AM +0100, Rafael J. Wysocki wrote:
> > [ I would not have chosen (1 + 1/n), but lets stick to that ]
> 
> Well, what would you choose then? :-)

1/p ; 0 < p < 1

or so. Where p then represents the percentile threshold where you want
to bump to the next freq.

> I think that should be
> 
>   next_freq = (1 + 1/n) * max_freq * util / max
> 
> (where max is the second argument of cpufreq_update_util) or the
> dimensions on both sides don't match.

Well yes, but so far we were treating util (and util_raw) as 0 < u < 1,
values, so already normalized against max.

But yes..

> > if we substitute (2) into (3) we get:
> >
> >                   = (1 + 1/n) * max_freq * util_raw * current_freq / max_freq
> >                   = (1 + 1/n) * current_freq * util_raw (4)
> >
> > Which gets you two formula with the same general behaviour. As (2) is
> > the only approximation of (1) we can make.
> 
> OK
> 
> So since utilization is not frequency invariant in the current
> mainline (or linux-next for that matter) AFAIC, I'm going to use the
> following in the next version of the schedutil patch series:
> 
>   next_freq = 1.25 * current_freq * util_raw / max
> 
> where util_raw and max are what I get from cpufreq_update_util().
> 
> 1.25 is for the 80% tipping point which I think is reasonable.

OK.
