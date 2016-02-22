From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC/RFT][PATCH 1/1] cpufreq: New governor using utilization
 data from the scheduler
Date: Mon, 22 Feb 2016 14:16:39 +0000
Message-ID: <20160222141639.GF27380@e106622-lin>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
 <2004800.S71i79juRi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57168 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992AbcBVOPo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Feb 2016 09:15:44 -0500
Content-Disposition: inline
In-Reply-To: <2004800.S71i79juRi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

Hi Rafael,

thanks for this RFC. I'm going to test it more in the next few days, but
I already have some questions from skimming through it. Please find them
inline below.

On 22/02/16 00:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new cpufreq scaling governor, called "schedutil", that uses
> scheduler-provided CPU utilization information as input for making
> its decisions.
> 

I guess the first (macro) question is why did you decide to go with a
complete new governor, where new here is w.r.t. the sched-freq solution.
AFAICT, it is true that your solution directly builds on top of the
latest changes to cpufreq core and governor, but it also seems to have
more than a few points in common with sched-freq, and sched-freq has
been discussed and evaluated for already quite some time. Also, it
appears to me that they both shares (or they might encounter in the
future as development progresses) the same kind of problems, like for
example the fact that we can't trigger opp changes from scheduler
context ATM.

Don't get me wrong. I think that looking at different ways to solve a
problem is always beneficial, since I guess that the goal in the end is
to come up with something that suits everybody's needs. I was only
curious about your thoughts on sched-freq. But we can also wait for the
next RFC from Steve for this macro question. :-)

[...]

> +static void sugov_update_commit(struct policy_dbs_info *policy_dbs, u64 time,
> +				unsigned int next_freq)
> +{
> +	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
> +
> +	sg_policy->next_freq = next_freq;
> +	policy_dbs->last_sample_time = time;
> +	policy_dbs->work_in_progress = true;
> +	irq_work_queue(&policy_dbs->irq_work);

Here we basically use the system wq to be able to do the freq transition
in process context. CFS is probably fine with this, but don't you think
we might get into troubles when, in the future, we will want to service
RT/DL requests more properly and they will end up being serviced
together with all the others wq users and at !RT priority?

> +}
> +
> +static void sugov_update_shared(struct update_util_data *data, u64 time,
> +				unsigned long util, unsigned long max)
> +{

We don't have a way to tell from which scheduling class this is coming
from, do we? And if that is true can't a request from CFS overwrite
RT/DL go to max requests?

[...]

Anyway, I'm going to start using our existing testing infrastructure
used to evaluate sched-freq to try to better understand the implications
of your approach.

Best,

- Juri
