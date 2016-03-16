From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 16 Mar 2016 18:52:11 +0100
Message-ID: <20160316175211.GF6344@twins.programming.kicks-ass.net>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <11678919.CQLTrQTYxG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11678919.CQLTrQTYxG@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:
> +static void sugov_work(struct work_struct *work)
> +{
> +	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> +
> +	mutex_lock(&sg_policy->work_lock);
> +	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> +				CPUFREQ_RELATION_L);
> +	mutex_unlock(&sg_policy->work_lock);
> +

Be aware that the below store can creep up and become visible before the
unlock. AFAICT that doesn't really matter, but still.

> +	sg_policy->work_in_progress = false;
> +}
> +
> +static void sugov_irq_work(struct irq_work *irq_work)
> +{
> +	struct sugov_policy *sg_policy;
> +
> +	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
> +	schedule_work(&sg_policy->work);
> +}

If you care what cpu the work runs on, you should schedule_work_on(),
regular schedule_work() can end up on any random cpu (although typically
it does not).

In particular schedule_work() -> queue_work() -> queue_work_on(.cpu =
WORK_CPU_UNBOUND) -> __queue_work() if (req_cpu == UNBOUND) cpu =
wq_select_unbound_cpu(), which has a Round-Robin 'feature' to detect
just such dependencies.
