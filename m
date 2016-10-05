From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 4/9] x86: Enable Intel Turbo Boost Max Technology
 3.0
Date: Wed, 5 Oct 2016 16:23:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610051616010.8953@nanos>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1475322326-160112-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39259 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbcJEO0V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Oct 2016 10:26:21 -0400
In-Reply-To: <1475322326-160112-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com

On Sat, 1 Oct 2016, Srinivas Pandruvada wrote:
> +void sched_set_itmt_support(bool itmt_supported)
> +{
> +	mutex_lock(&itmt_update_mutex);
> +
> +	if (itmt_supported != sched_itmt_capable)
> +		sched_itmt_capable = itmt_supported;

Yikes. What is this conditional for? The only value it has is to confuse
the reader.

> +
> +	mutex_unlock(&itmt_update_mutex);
> +}
> +
> +DEFINE_PER_CPU_READ_MOSTLY(int, sched_core_priority);

Darn. Do not stick variable definitiions in the middle of the code and
especially not glued to the function w/o a newline in between. Move it to
the top of the file.

> +int arch_asym_cpu_priority(int cpu)
> +{
> +	return per_cpu(sched_core_priority, cpu);
> +}


> +void sched_set_itmt_core_prio(int prio, int core_cpu)
> +{
> +	int cpu, i = 1;
> +
> +	for_each_cpu(cpu, topology_sibling_cpumask(core_cpu)) {
> +		int smt_prio;
> +
> +		/*
> +		 * Ensure that the siblings are moved to the end
> +		 * of the priority chain and only used when
> +		 * all other high priority cpus are out of capacity.
> +		 */
> +		smt_prio = prio * smp_num_siblings / i;
> +		i++;

Your code ordering is really random. What has this i++ to do with the
store? Nothing. It just makes reading the code harder. Just move it below
the store.

> +		per_cpu(sched_core_priority, cpu) = smt_prio;

Thanks,

	tglx
