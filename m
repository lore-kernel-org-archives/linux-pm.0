From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 10:21:38 -0800
Message-ID: <20160113102138.4e34e890@yairi>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.11.1601131042590.3575@nanos>
	<20160113082113.3314fa92@icelake>
	<20160113163610.GH12897@pd.tnic>
	<20160113095124.186ff487@yairi>
	<20160113180412.GN12897@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40074 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbcAMSWB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 13:22:01 -0500
In-Reply-To: <20160113180412.GN12897@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, jacob.jun.pan@linux.intel.com

On Wed, 13 Jan 2016 19:04:12 +0100
Borislav Petkov <bp@alien8.de> wrote:

> > Then i was suggested to add a rmw msr api for the common good :), I
> > think it is a good idea since such operation is not limited to RAPL
> > driver.  
> 
> Others are...?

nothing for the _safe version right now. Quick scan through the code
I see the non safe version has a couple can be converted to rmw.
e.g.

static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
{
...

	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
	if (newstate == DC_DISABLE) {
		pr_debug("CPU#%d disabling modulation\n", cpu);
		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l & ~(1<<4),
	h); } else {
		pr_debug("CPU#%d setting duty cycle to %d%%\n",
			cpu, ((125 * newstate) / 10));
		/* bits 63 - 5	: reserved
		 * bit  4	: enable/disable
		 * bits 3-1	: duty cycle
		 * bit  0	: reserved
		 */
		l = (l & ~14);
		l = l | (1<<4) | ((newstate & 0x7)<<1);
		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l, h);
	} 


static int sfi_cpufreq_target(struct cpufreq_policy *policy, unsigned
int index) {
...

	rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
	lo = (lo & ~INTEL_PERF_CTL_MASK) |
		((u32) sfi_cpufreq_array[next_perf_state].ctrl_val &
		INTEL_PERF_CTL_MASK);
	wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
