From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 22:49:47 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601132203190.3575@nanos>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com> <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com> <alpine.DEB.2.11.1601131042590.3575@nanos> <20160113082113.3314fa92@icelake> <20160113163610.GH12897@pd.tnic>
 <20160113095124.186ff487@yairi> <20160113180412.GN12897@pd.tnic> <20160113102138.4e34e890@yairi> <20160113191622.GP12897@pd.tnic> <20160113121003.3e9c2108@yairi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52297 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbcAMVut (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 16:50:49 -0500
In-Reply-To: <20160113121003.3e9c2108@yairi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Wed, 13 Jan 2016, Jacob Pan wrote:
> On Wed, 13 Jan 2016 20:16:22 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Wed, Jan 13, 2016 at 10:21:38AM -0800, Jacob Pan wrote:
> > > static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
> > > {
> > > ...
> > > 
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
> 
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

And what's the actual saving over a simple function which does that rdmsr,
modify, wrmsr thing and call it via smp_call_function like you did for 2 of 3
places in the rapl driver?

The amount of IPIs is the same. The amount of saved code is questionable. Lets
look at your usecase:

@@ -805,30 +809,18 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
                        enum rapl_primitives prim,
                        unsigned long long value)
 {
-       u64 msr_val;
-       u32 msr;
        struct rapl_primitive_info *rp = &rpi[prim];
        int cpu;
+       u64 bits;
 
        cpu = find_active_cpu_on_package(rd->package_id);
        if (cpu < 0)
                return cpu;
-       msr = rd->msrs[rp->id];
-       if (rdmsrl_safe_on_cpu(cpu, msr, &msr_val)) {
-               dev_dbg(&rd->power_zone.dev,
-                       "failed to read msr 0x%x on cpu %d\n", msr, cpu);
-               return -EIO;
-       }
-       value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
-       msr_val &= ~rp->mask;
-       msr_val |= value << rp->shift;
-       if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
-               dev_dbg(&rd->power_zone.dev,
-                       "failed to write msr 0x%x on cpu %d\n", msr, cpu);
-               return -EIO;
-       }
 
-       return 0;
+       bits = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
+       bits |= bits << rp->shift;
+
+       return rmwmsrl_safe_on_cpu(cpu, rd->msrs[rp->id], rp->mask, bits);
 }

So that has:	5 insertions and 17 deletions

And the library code adds 65 lines including an export. So the text size
balance of this is:

Mainline:
text	data	bss  dec     hex   filename
 5021	1008    0     6029   178d  ../build/arch/x86/lib/built-in.o
10870	1040	24   11934   2e9e  ../build/drivers/powercap/intel_rapl.o

Your patch (Just the above part which uses the lib stuff)
 5385	1008	0     6393   18f9  ../build/arch/x86/lib/built-in.o
10838	1040    24   11902   2e7e  ../build/drivers/powercap/intel_rapl.o
-----
+ 332

Now you have two more possible candidates, which require another 65 lines of
different library code and lets assume another 364 bytes of library code. So
lets further assume the above examples safe us like the rapl one 32 bytes
each, then the net damage is: 632 byte extra text size.

So what exactly is the point of this exercise?

Thanks,

	tglx
