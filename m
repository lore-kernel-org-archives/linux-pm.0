From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.39 & -stable] x86 intel power: Initialize
 MSR_IA32_ENERGY_PERF_BIAS
Date: Fri, 1 Apr 2011 08:39:52 +0200
Message-ID: <20110401063952.GB7594__12746.6774466031$1301640051$gmane$org@elte.hu>
References: <alpine.LFD.2.02.1104010156570.2797@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1104010156570.2797@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> Since 2.6.36 (23016bf0d25), Linux prints the existence of "epb" in /proc/cpuinfo,
> Since 2.6.38 (d5532ee7b40), the x86_energy_perf_policy(8) utility has
> been available in-tree to update MSR_IA32_ENERGY_PERF_BIAS.
> 
> However, the typical BIOS fails to initialize the MSR, presumably
> because this is handled by high-volume shrink-wrap operating systems...
> 
> Linux distros, on the other hand, do not yet invoke x86_energy_perf_policy(8).
> As a result, WSM-EP, SNB, and later hardware from Intel will run in its
> default hardware power-on state (performance), which assumes that users
> care for performance at all costs and not for energy efficiency.
> While that is fine for performance benchmarks, the hardware's intended default
> operating point is "normal" mode...
> 
> Initialize the MSR to the "normal" by default during kernel boot.
> 
> x86_energy_perf_policy(8) is available to change the default after boot,
> should the user have a different preference.
> 
> cc: stable@kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h |    3 +++
>  arch/x86/kernel/cpu/intel.c      |   14 ++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 43a18c7..91fedd9 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -250,6 +250,9 @@
>  #define MSR_IA32_TEMPERATURE_TARGET	0x000001a2
>  
>  #define MSR_IA32_ENERGY_PERF_BIAS	0x000001b0
> +#define ENERGY_PERF_BIAS_PERFORMANCE	0
> +#define ENERGY_PERF_BIAS_NORMAL		6
> +#define ENERGY_PERF_BIAS_POWERSWAVE	15
>  
>  #define MSR_IA32_PACKAGE_THERM_STATUS		0x000001b1
>  
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index d16c2c5..48cca4a 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -448,6 +448,20 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
>  
>  	if (cpu_has(c, X86_FEATURE_VMX))
>  		detect_vmx_virtcap(c);
> +
> +	/*
> +	 * Initialize MSR_IA32_ENERGY_PERF_BIAS if BIOS did not.
> +	 * x86_energy_perf_policy(8) is available to change it at run-time
> +	 */
> +	if (cpu_has(c, X86_FEATURE_EPB)) {
> +		u64 epb;

This should be moved into a helper inline function, why complicate init_intel() 
with an open-coded workaround for a BIOS bug?

> +
> +		rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> +		if ((epb & 0xF) == 0) {
> +			epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;

So we first check that the 0xf portion of ebp is zero, then when we mask out 
the 0xf portion - why? Something like this should be equivalent:

			epb |= ENERGY_PERF_BIAS_NORMAL;

> +			wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> +		}
> +	}

Also, at minimum the kernel should printk a warning that the powersaving mode 
has been reduced from 'performance' (BIOS programmed default) to 'normal' 
(Intel intended default), and the message should also mention the specific 
utility that can be used to set it back to 'performance'.

We risk here people reporting performance regressions to us and they will have 
absolutely no chance to see what happened - the v2.6.39 kernel will just 
silently be slower for them.

Also, do distributions package tools/power/x86/x86_energy_perf_policy/ for easy 
access to developers? What if a user sets the BIOS to 'performance' explicitly 
(is this possible?) and *expects* Linux to boot up in fast mode?

Also, will BIOSes be fixed eventually?

Thanks,

	Ingo
