From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on scheduler utilization data
Date: Wed, 16 Mar 2016 22:38:14 +0100
Message-ID: <1520262.pnveEYDEnp@vostro.rjw.lan>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan> <11678919.CQLTrQTYxG@vostro.rjw.lan> <20160316175211.GF6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160316175211.GF6344@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 16, 2016 06:52:11 PM Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:
> > +static void sugov_work(struct work_struct *work)
> > +{
> > +	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > +
> > +	mutex_lock(&sg_policy->work_lock);
> > +	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> > +				CPUFREQ_RELATION_L);
> > +	mutex_unlock(&sg_policy->work_lock);
> > +
> 
> Be aware that the below store can creep up and become visible before the
> unlock. AFAICT that doesn't really matter, but still.

It doesn't matter. :-)

Had it mattered, I would have used memory barriers.

> > +	sg_policy->work_in_progress = false;
> > +}
> > +
> > +static void sugov_irq_work(struct irq_work *irq_work)
> > +{
> > +	struct sugov_policy *sg_policy;
> > +
> > +	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
> > +	schedule_work(&sg_policy->work);
> > +}
> 
> If you care what cpu the work runs on, you should schedule_work_on(),
> regular schedule_work() can end up on any random cpu (although typically
> it does not).

I know, but I don't care too much.

"ondemand" and "conservative" use schedule_work() for the same thing, so
drivers need to cope with that if they need things to run on a particular
CPU.

That said I guess things would be a bit more efficient if the work was
scheduled on the same CPU that had queued up the irq_work.  It also wouldn't
be too difficult to implement, so I'll make that change.

