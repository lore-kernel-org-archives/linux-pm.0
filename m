From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 7/7][Update] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Thu, 17 Mar 2016 12:36:22 +0100
Message-ID: <20160317113622.GS6344@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <4088601.C2vItRYpQn@vostro.rjw.lan>
 <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <18957412.GBWZqUOZtk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57207 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912AbcCQLg0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 07:36:26 -0400
Content-Disposition: inline
In-Reply-To: <18957412.GBWZqUOZtk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Thu, Mar 17, 2016 at 01:01:45AM +0100, Rafael J. Wysocki wrote:
> +	} else if (sg_policy->next_freq != next_freq) {
> +		sg_policy->work_cpu = smp_processor_id();
> +		irq_work_queue(&sg_policy->irq_work);
> +	}
> +}

> +static void sugov_irq_work(struct irq_work *irq_work)
> +{
> +	struct sugov_policy *sg_policy;
> +
> +	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
> +	schedule_work_on(sg_policy->work_cpu, &sg_policy->work);
> +}

Not sure I see the point of ->work_cpu, irq_work_queue() does guarantee
the same CPU, so the above is identical to:

	schedule_work_on(smp_processor_id(), &sq_policy->work);
