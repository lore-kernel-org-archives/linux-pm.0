From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v5 4/9] x86: Enable Intel Turbo Boost Max Technology 3.0
Date: Wed, 05 Oct 2016 09:05:20 -0700
Message-ID: <1475683520.3916.285.camel@linux.intel.com>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1475322326-160112-5-git-send-email-srinivas.pandruvada@linux.intel.com>
         <alpine.DEB.2.20.1610051616010.8953@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754567AbcJEQFW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 12:05:22 -0400
In-Reply-To: <alpine.DEB.2.20.1610051616010.8953@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com

On Wed, 2016-10-05 at 16:23 +0200, Thomas Gleixner wrote:
> On Sat, 1 Oct 2016, Srinivas Pandruvada wrote:
> > 
> > +void sched_set_itmt_support(bool itmt_supported)
> > +{
> > +	mutex_lock(&itmt_update_mutex);
> > +
> > +	if (itmt_supported != sched_itmt_capable)
> > +		sched_itmt_capable = itmt_supported;
> Yikes. What is this conditional for? The only value it has is to confuse
> the reader.

Will remove the check.

> 
> > 
> > +
> > +	mutex_unlock(&itmt_update_mutex);
> > +}
> > +
> > +DEFINE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
> Darn. Do not stick variable definitiions in the middle of the code and
> especially not glued to the function w/o a newline in between. Move it to
> the top of the file.

Will move to top of file.

> 
> > 
> > +int arch_asym_cpu_priority(int cpu)
> > +{
> > +	return per_cpu(sched_core_priority, cpu);
> > +}
> 
> > 
> > +void sched_set_itmt_core_prio(int prio, int core_cpu)
> > +{
> > +	int cpu, i = 1;
> > +
> > +	for_each_cpu(cpu, topology_sibling_cpumask(core_cpu)) {
> > +		int smt_prio;
> > +
> > +		/*
> > +		 * Ensure that the siblings are moved to the end
> > +		 * of the priority chain and only used when
> > +		 * all other high priority cpus are out of capacity.
> > +		 */
> > +		smt_prio = prio * smp_num_siblings / i;
> > +		i++;
> Your code ordering is really random. What has this i++ to do with the
> store? Nothing. It just makes reading the code harder. Just move it below
> the store.

Will move it to the end of for loop.

> 
> > 
> > +		per_cpu(sched_core_priority, cpu) = smt_prio;

Thanks.

Tim
