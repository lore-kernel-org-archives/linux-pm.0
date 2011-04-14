From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 intel power: Initialize
	MSR_IA32_ENERGY_PERF_BIAS
Date: Thu, 14 Apr 2011 11:08:54 +0200
Message-ID: <20110414090854.GB9248__3383.29265728152$1302772225$gmane$org@elte.hu>
References: <alpine.LFD.2.02.1103301819250.31342@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1103301819250.31342@x980>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> Since 2.6.35 (23016bf0d25), Linux prints the existence of "epb" in /proc/cpuinfo,
> Since 2.6.38 (d5532ee7b40), the x86_energy_perf_policy(8) utility is available
> in-tree to update MSR_IA32_ENERGY_PERF_BIAS.
> 
> However, the typical BIOS fails to initialize the MSR,
> and the typical Linux distro neglects to invoke x86_energy_perf_policy(8).
> 
> The result is that some modern hardware is running in hardware default,
> which is "performance" mode, rather than the intended design default
> of "normal" mode.
> 
> Initialize the MSR to the "normal" setting during kernel boot.
> 
> Of course, x86_energy_perf_policy(8) is available to change
> the default after boot, should the user have a policy preference.
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
> +
> +		rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> +		if ((epb & 0xF) == 0) {
> +			epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
> +			wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> +		}
> +	}

Dunno, this patch appears to silently modify the system to be slower than it 
was before under Linux.

Won't people report this as a regression if this change reduces performance for 
them?

They wont be able to see your comments in the code and in the changelog either, 
when this happens to them. They might look into /proc/cpuinfo and see 'epb' 
there but it wont tell them anything. They wont know about a utility available 
in tools/power/x86/ either.

So this patch has 'future trouble' written all over it i'm afraid.

Thanks,

	Ingo
