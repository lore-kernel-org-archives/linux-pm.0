From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/8] sched,x86: Enable Turbo Boost Max Technology
Date: Thu, 8 Sep 2016 09:59:55 +0200
Message-ID: <20160908075955.GS10153@twins.programming.kicks-ass.net>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1472762024-88771-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33540 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbcIHIAH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 04:00:07 -0400
Content-Disposition: inline
In-Reply-To: <1472762024-88771-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com

On Thu, Sep 01, 2016 at 01:33:41PM -0700, Srinivas Pandruvada wrote:
> +static void enable_sched_itmt(bool enable_itmt)
> +{
> +	mutex_lock(&itmt_update_mutex);
> +
> +	sysctl_sched_itmt_enabled = enable_itmt;
> +	x86_topology_update = true;
> +	rebuild_sched_domains();
> +
> +	mutex_unlock(&itmt_update_mutex);
> +}
> +
> +static int sched_itmt_update_handler(struct ctl_table *table, int write,
> +			      void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	if (ret || !write)
> +		return ret;
> +
> +	enable_sched_itmt(sysctl_sched_itmt_enabled);
> +
> +	return ret;
> +}

I think there's a race here, if two tasks were to write to the sysctl
they'd both change the value before getting stuck on the mutex in
enable_sched_itmt().

One way around that is doing something like:


	struct ctl_table t;
	int val = sysctl_sched_itmt_enabled;

	t = *table;
	t.data = &val;

	proc_dointvec_minmax(&t, ...);

	/* and update the sysctl_sched_itmt_enabled value inside the mutex */
	enable_sched_itmi(val);
