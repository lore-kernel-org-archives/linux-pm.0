From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH v11] acpi, apei, arm64: APEI initial support for aarch64.
Date: Thu, 28 Jul 2016 10:39:51 +0100
Message-ID: <f018fd18-03e7-3247-7d65-af430092230e@arm.com>
References: <1469640545-5848-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1469640545-5848-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: fu.wei@linaro.org, tn@semihalf.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linaro-acpi@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, mark.rutland@arm.com, Marc.Zyngier@arm.com, lorenzo.pieralisi@arm.com, rruigrok@codeaurora.org, harba@qti.qualcomm.com, tbaicar@codeaurora.org, jcm@redhat.com, msalter@redhat.com, grant.likely@linaro.org, rrichter@cavium.com, jarkko.nikula@linux.intel.com, jon.zhixiong.zhang@gmail.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 27/07/16 18:29, fu.wei@linaro.org wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> This commit provides APEI arch-specific bits for aarch64
>
> Meanwhile,
> (1)add a new subfunction "hest_ia32_init" for
> "acpi_disable_cmcff" which is used by IA-32 Architecture
> Corrected Machine Check (CMC).
> (2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
> a generic place.
> (3)select HAVE_ACPI_APEI when EFI and ACPI is set on ARM64,
> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>
> [Fu Wei: improve && upstream]
>


> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 5420cb0..d3d02dc 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -17,6 +17,7 @@
>
>  #include <asm/cputype.h>
>  #include <asm/smp_plat.h>
> +#include <asm/tlbflush.h>
>
>  /* Macros for consistency checks of the GICC subtable of MADT */
>  #define ACPI_MADT_GICC_LENGTH	\
> @@ -110,8 +111,21 @@ static inline const char *acpi_get_enable_method(int cpu)
>  }
>
>  #ifdef	CONFIG_ACPI_APEI
> +#define acpi_disable_cmcff 1
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
> -#endif
> +
> +/*
> + * Despite its name, this function must still broadcast the TLB
> + * invalidation in order to ensure other CPUs don't up with with junk

Please fix the comment above ^^^.


Suzuki
