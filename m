From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 12:32:54 +0000
Message-ID: <20160303123254.GU18792@e106622-lin>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <20160303122030.GN6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303122030.GN6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 03/03/16 13:20, Peter Zijlstra wrote:
> On Wed, Mar 02, 2016 at 11:49:48PM +0100, Rafael J. Wysocki wrote:
> > >>> +       min_f = sg_policy->policy->cpuinfo.min_freq;
> > >>> +       max_f = sg_policy->policy->cpuinfo.max_freq;
> > >>> +       next_f = util > max ? max_f : min_f + util * (max_f - min_f) / max;
> 
> > In case a more formal derivation of this formula is needed, it is
> > based on the following 3 assumptions:
> > 
> > (1) Performance is a linear function of frequency.
> > (2) Required performance is a linear function of the utilization ratio
> > x = util/max as provided by the scheduler (0 <= x <= 1).
> 
> > (3) The minimum possible frequency (min_freq) corresponds to x = 0 and
> > the maximum possible frequency (max_freq) corresponds to x = 1.
> > 
> > (1) and (2) combined imply that
> > 
> > f = a * x + b
> > 
> > (f - frequency, a, b - constants to be determined) and then (3) quite
> > trivially leads to b = min_freq and a = max_freq - min_freq.
> 
> 3 is the problem, that just doesn't make sense and is probably the
> reason why you see very little selection of the min freq.
> 
> Suppose a machine with the following frequencies:
> 
> 	500, 750, 1000
> 
> And a utilization of 0.4, how does asking for 500 + 0.4 * (1000-500) =
> 700 make any sense? Per your point 1, it should should be asking for
> 0.4 * 1000 = 400.
> 
> Because, per 1, at 500 it runs exactly half as fast as at 1000, and we
> only need 0.4 times as much. Therefore 500 is more than sufficient.
> 

Oh, and that is probably also why the governor can reach max OPP with
freq invariance enabled (the point Vincent was making). When we run at
500 the util signal is capped at that capacity, but the formula makes us
requesting more, so we can jump to the next step and so on.
