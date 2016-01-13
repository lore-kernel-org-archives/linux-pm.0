From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 14:20:07 -0800
Message-ID: <20160113142007.7c99e826@yairi>
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
	<20160113212602.GT12897@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113212602.GT12897@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Jan 2016 22:26:02 +0100
Borislav Petkov <bp@alien8.de> wrote:

> You mean something like this (I'm having hard time even figuring out
> what goes where):
> 
> 	if (newstate == DC_DISABLE) {
> 		pr_debug("CPU#%d disabling modulation\n", cpu);
> 		rmwmsrl_safe_on_cpu(cpu, MSR_IA32_THERM_CONTROL, (1
> << 4), 0); } else {
> 		pr_debug("CPU#%d setting duty cycle to %d%%\n", cpu,
> ((125 * newstate) / 10)); rmwmsrl_safe_on_cpu(cpu,
> MSR_IA32_THERM_CONTROL, 14, (1 << 4) |	((newstate &
> 0x7)<<1)); }
> 
> Now this is *absolutely* unreadable and hard to use. The previous
> version at least showed what happens to which bits. This call site
> will make everyone go look at the definition of rmwmsrl_safe_on_cpu()
> and see what those last two arguments do actually.
> 
To me the caller code became more readable. I think you are referring
the function name being not readable, which is separate of this
conversion.

> And, again, for the n-th time, this still doesn't work if you need to
> do other stuff between the rdmsr and wrmsr. So your interface will
> cover *some* cases but not all. So people should do
> rmwmsrl_safe_on_cpu() but not always - only if they don't need to do
> stuff between the reads and the writes.
> 
I know, I never disagreed with that :) which is why I am not using it in
the other cases in RAPL driver.
> Hmm, no thanks.
> 
> > > > static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> > > > unsigned int index) {
> > > > ...
> > > > 
> > > > 	rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> > > > 	lo = (lo & ~INTEL_PERF_CTL_MASK) |
> > > > 		((u32)
> > > > sfi_cpufreq_array[next_perf_state].ctrl_val &
> > > > INTEL_PERF_CTL_MASK); wrmsr_on_cpu(policy->cpu,
> > > > MSR_IA32_PERF_CTL, lo, hi);    
> > > 
> > > Ditto.
> > > 
> > > These two examples prove my point, actually.  
> > 
> > same here, it is just clear mask and set mask, why not?  
> 
> Like this?
> 
> 	rmwmsrl_safe_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
> 			    INTEL_PERF_CTL_MASK,
> 			    (u32)sfi_cpufreq_array[next_perf_state].ctrl_val
> & INTEL_PERF_CTL_MASK);
> 
> Yikes!
> 
> So yes, it can work but it is ugly, hard to parse and use, not generic
> enough, etc, etc.
I don't think the conversion adds extra ugliness. It actually makes it
more clear what is the mask to clear and what bits to set.
