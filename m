From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Date: Fri, 22 Mar 2019 10:03:31 +0100
Message-ID: <0754bf38-319e-f1a7-1ae6-fe2de548b882@suse.de>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1605148.8jT99SsvVP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1605148.8jT99SsvVP@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>
List-Id: linux-pm@vger.kernel.org

On 3/21/19 11:18 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current handling of MSR_IA32_ENERGY_PERF_BIAS in the kernel is
> problematic, because it may cause changes made by user space to that
> MSR (with the help of the x86_energy_perf_policy tool, for example)
> to be lost every time a CPU goes offline and then back online as well
> as during system-wide power management transitions into sleep states
> and back into the working state.
> 
> The first problem is that if the current EPB value for a CPU going
> online is 0 ('performance'), the kernel will change it to 6 ('normal')
> regardless of whether or not this is the first bring-up of that CPU.
> That also happens during system-wide resume from sleep states
> (including, but not limited to, hibernation).  However, the EPB may
> have been adjusted by user space this way and the kernel should not
> blindly override that setting.
> 
> The second problem is that if the platform firmware resets the EPB
> values for any CPUs during system-wide resume from a sleep state,
> the kernel will not restore their previous EPB values that may
> have been set by user space before the preceding system-wide
> suspend transition.  Again, that behavior may at least be confusing
> from the user space perspective.
> 
> In order to address these issues, rework the handling of
> MSR_IA32_ENERGY_PERF_BIAS so that the EPB value is saved on CPU
> offline and restored on CPU online as well as (for the boot CPU)
> during the syscore stages of system-wide suspend and resume
> transitions, respectively.
> 
> However, retain the policy by which the EPB is set to 6 ('normal')
> on the first bring-up of each CPU if its initial value is 0, based
> on the observation that 0 may mean 'not initialized' just as well as
> 'performance' in that case.
> 
> While at it, move the MSR_IA32_ENERGY_PERF_BIAS handling code into
> a separate file and document it in Documentation/admin-guide.
> 
> Fixes: abe48b108247 (x86, intel, power: Initialize MSR_IA32_ENERGY_PERF_BIAS)
> Fixes: b51ef52df71c (x86/cpu: Restore MSR_IA32_ENERGY_PERF_BIAS after resume)
> Reported-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
