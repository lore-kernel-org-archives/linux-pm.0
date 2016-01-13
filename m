From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 20:16:22 +0100
Message-ID: <20160113191622.GP12897@pd.tnic>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <alpine.DEB.2.11.1601131042590.3575@nanos>
 <20160113082113.3314fa92@icelake>
 <20160113163610.GH12897@pd.tnic>
 <20160113095124.186ff487@yairi>
 <20160113180412.GN12897@pd.tnic>
 <20160113102138.4e34e890@yairi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160113102138.4e34e890@yairi>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 13, 2016 at 10:21:38AM -0800, Jacob Pan wrote:
> static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
> {
> ...
> 
> 	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
> 	if (newstate == DC_DISABLE) {
> 		pr_debug("CPU#%d disabling modulation\n", cpu);
> 		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l & ~(1<<4),
> 	h); } else {
> 		pr_debug("CPU#%d setting duty cycle to %d%%\n",
> 			cpu, ((125 * newstate) / 10));
> 		/* bits 63 - 5	: reserved
> 		 * bit  4	: enable/disable
> 		 * bits 3-1	: duty cycle
> 		 * bit  0	: reserved
> 		 */
> 		l = (l & ~14);
> 		l = l | (1<<4) | ((newstate & 0x7)<<1);
> 		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l, h);
> 	} 

This cannot be converted because you need to do the stuff between the
rdmsr_on_cpu() and wrmsr_on_cpu() calls.

> static int sfi_cpufreq_target(struct cpufreq_policy *policy, unsigned
> int index) {
> ...
> 
> 	rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> 	lo = (lo & ~INTEL_PERF_CTL_MASK) |
> 		((u32) sfi_cpufreq_array[next_perf_state].ctrl_val &
> 		INTEL_PERF_CTL_MASK);
> 	wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);

Ditto.

These two examples prove my point, actually.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
