From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 22:26:02 +0100
Message-ID: <20160113212602.GT12897@pd.tnic>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <alpine.DEB.2.11.1601131042590.3575@nanos>
 <20160113082113.3314fa92@icelake>
 <20160113163610.GH12897@pd.tnic>
 <20160113095124.186ff487@yairi>
 <20160113180412.GN12897@pd.tnic>
 <20160113102138.4e34e890@yairi>
 <20160113191622.GP12897@pd.tnic>
 <20160113121003.3e9c2108@yairi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56131 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbcAMV0S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 16:26:18 -0500
Content-Disposition: inline
In-Reply-To: <20160113121003.3e9c2108@yairi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Wed, Jan 13, 2016 at 12:10:03PM -0800, Jacob Pan wrote:
> > > 	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
> > > 	if (newstate == DC_DISABLE) {
> > > 		pr_debug("CPU#%d disabling modulation\n", cpu);
> > > 		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l &
> > > ~(1<<4), h); } else {
> > > 		pr_debug("CPU#%d setting duty cycle to %d%%\n",
> > > 			cpu, ((125 * newstate) / 10));
> > > 		/* bits 63 - 5	: reserved
> > > 		 * bit  4	: enable/disable
> > > 		 * bits 3-1	: duty cycle
> > > 		 * bit  0	: reserved
> > > 		 */
> > > 		l = (l & ~14);
> > > 		l = l | (1<<4) | ((newstate & 0x7)<<1);
> > > 		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l, h);
> > > 	}   
> > 
> > This cannot be converted because you need to do the stuff between the
> > rdmsr_on_cpu() and wrmsr_on_cpu() calls.
> > 
> it can be converted if move the below if statement outside read/write
> pair. 
>  	if (newstate == DC_DISABLE) {

You mean something like this (I'm having hard time even figuring out what
goes where):

	if (newstate == DC_DISABLE) {
		pr_debug("CPU#%d disabling modulation\n", cpu);
		rmwmsrl_safe_on_cpu(cpu, MSR_IA32_THERM_CONTROL, (1 << 4), 0);
	} else {
		pr_debug("CPU#%d setting duty cycle to %d%%\n", cpu, ((125 * newstate) / 10));
		rmwmsrl_safe_on_cpu(cpu, MSR_IA32_THERM_CONTROL, 14, (1 << 4) |	((newstate & 0x7)<<1));
	}

Now this is *absolutely* unreadable and hard to use. The previous
version at least showed what happens to which bits. This call site will
make everyone go look at the definition of rmwmsrl_safe_on_cpu() and see
what those last two arguments do actually.

And, again, for the n-th time, this still doesn't work if you need to do
other stuff between the rdmsr and wrmsr. So your interface will cover
*some* cases but not all. So people should do rmwmsrl_safe_on_cpu() but
not always - only if they don't need to do stuff between the reads and
the writes.

Hmm, no thanks.

> > > static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> > > unsigned int index) {
> > > ...
> > > 
> > > 	rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> > > 	lo = (lo & ~INTEL_PERF_CTL_MASK) |
> > > 		((u32) sfi_cpufreq_array[next_perf_state].ctrl_val &
> > > 		INTEL_PERF_CTL_MASK);
> > > 	wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);  
> > 
> > Ditto.
> > 
> > These two examples prove my point, actually.
> 
> same here, it is just clear mask and set mask, why not?

Like this?

	rmwmsrl_safe_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
			    INTEL_PERF_CTL_MASK,
			    (u32)sfi_cpufreq_array[next_perf_state].ctrl_val & INTEL_PERF_CTL_MASK);

Yikes!

So yes, it can work but it is ugly, hard to parse and use, not generic
enough, etc, etc.

So thanks, but no thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
