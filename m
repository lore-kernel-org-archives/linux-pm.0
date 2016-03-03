From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 17:14:43 +0000
Message-ID: <20160303171443.GZ18792@e106622-lin>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <20160303122030.GN6356@twins.programming.kicks-ass.net>
 <CAJZ5v0ifY7V48Vh8PdErobxiB0_NAweQ3XiSaMgby54varMLkQ@mail.gmail.com>
 <20160303163735.GS6356@twins.programming.kicks-ass.net>
 <20160303165544.GY18792@e106622-lin>
 <20160303165640.GT6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303165640.GT6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 03/03/16 17:56, Peter Zijlstra wrote:
> On Thu, Mar 03, 2016 at 04:55:44PM +0000, Juri Lelli wrote:
> > On 03/03/16 17:37, Peter Zijlstra wrote:
> > > But given the platform's cpuidle information, maybe coupled with an avg
> > > idle est, we can compute the benefit of race-to-idle and over provision
> > > based on that, right?
> > > 
> > 
> > Shouldn't this kind of considerations be a scheduler thing? I'm not
> > really getting why we want to put more "intelligence" in a new governor.
> > Also, if I understand Ingo's point correctly, I think we want to make
> > this kind of policy decisions inside the scheduler.
> 
> Well sure, put it in kernel/sched/cpufreq.c or wherever. My point was
> more that we don't have to guess/hardcode race-to-idle assumptions but
> can actually calculate some of that.
> 

Right, thanks for clarifying!
