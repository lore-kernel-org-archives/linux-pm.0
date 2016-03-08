From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Tue, 8 Mar 2016 14:09:56 +0100
Message-ID: <20160308130956.GI6375@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <CAKfTPtDRvM9PAwQQ2KjUjPjnMmKkdi6sCoX4YisKaunDBqLf-A@mail.gmail.com>
 <20160303153817.GO6344@twins.programming.kicks-ass.net>
 <20160303162829.GB6375@twins.programming.kicks-ass.net>
 <56D87457.1050600@arm.com>
 <20160303182624.GU6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303182624.GU6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 03, 2016 at 07:26:24PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 03, 2016 at 05:28:55PM +0000, Dietmar Eggemann wrote:

> > Wasn't there the problem that this ratio goes to zero if the cpu is idle
> > in the old power estimation approach on x86?
> 
> Yeah, there was something funky.

So it might have been that when we're nearly idle the hardware runs at
low frequency, which under that old code would have resulted in lowering
the capacity of that cpu. Which in turn would have resulted in the
scheduler moving the little work it had away and it being even more
idle.
