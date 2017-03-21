From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 14:22:53 +0100
Message-ID: <20170321132253.vjp7f72qkubpttmf@hirez.programming.kicks-ass.net>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan>
 <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbdCUNXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 09:23:03 -0400
Content-Disposition: inline
In-Reply-To: <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Tue, Mar 21, 2017 at 09:50:28AM +0100, Vincent Guittot wrote:
> On 20 March 2017 at 22:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> > To work around this issue use the observation that, from the
> > schedutil governor's perspective, it does not make sense to decrease
> > the frequency of a CPU that doesn't enter idle and avoid decreasing
> > the frequency of busy CPUs.
> 
> I don't fully agree with that statement.
> If there are 2 runnable tasks on CPU A and scheduler migrates the
> waiting task to another CPU B so CPU A is less loaded now, it makes
> sense to reduce the OPP. That's even for that purpose that we have
> decided to use scheduler metrics in cpufreq governor so we can adjust
> OPP immediately when tasks migrate.
> That being said, i probably know why you see such OPP switches in your
> use case. When we migrate a task, we also migrate/remove its
> utilization from CPU.
> If the CPU is not overloaded, it means that runnable tasks have all
> computation that they need and don't have any reason to use more when
> a task migrates to another CPU. so decreasing the OPP makes sense
> because the utilzation is decreasing
> If the CPU is overloaded, it means that runnable tasks have to share
> CPU time and probably don't have all computations that they would like
> so when a task migrate, the remaining tasks on the CPU will increase
> their utilization and fill space left by the task that has just
> migrated. So the CPU's utilization will decrease when a task migrates
> (and as a result the OPP) but then its utilization will increase with
> remaining tasks running more time as well as the OPP
> 
> So you need to make the difference between this 2 cases: Is a CPU
> overloaded or not. You can't really rely on the utilization to detect
> that but you could take advantage of the load which take into account
> the waiting time of tasks

I'm confused. What two cases? You only list the overloaded case, but he
does exactly that. Note that the lack of idle time is an exact
equivalent of 100% utilized.

So even while we cannot currently detect the 100% utilized state through
the running state tracking; because averages etc.. we can detect the
lack of idle time.
