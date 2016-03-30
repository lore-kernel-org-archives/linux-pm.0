From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
Date: Wed, 30 Mar 2016 09:05:49 +0200
Message-ID: <CAKv+Gu-BHhf=aQ6ZP3J=q8T9FRtq-hfzTNvdJ3=HgMt=hVP8nQ@mail.gmail.com>
References: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Fu Wei <fu.wei@linaro.org>
Cc: tn@semihalf.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com, pavel@ucw.cz, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Richard Ruigrok <rruigrok@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, "x86@kernel.org" <x86@kernel.org>, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, linux-pm@vger.kernel.org, Marc Zyngier <Marc.Zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.now>
List-Id: linux-pm@vger.kernel.org

On 29 March 2016 at 09:44,  <fu.wei@linaro.org> wrote:
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
> (3)select EFI when ACPI_APEI is set on ARM64,
> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.

I think selecting 'EFI' is not the right approach here, especially
since EFI is implied by ACPI on that architecture. But selecting a
user configurable option like this is typically not recommended. Why
doesn't ACPI_APEI depend on ACPI?

>
> [Fu Wei: improve && upstream]
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
> Changelog:
> v8: Fix a "undefined reference" bug by selecting EFI when ACPI_APEI is set
>     on ARM64.
>
> v7: https://lkml.org/lkml/2016/3/17/183
>     Add comment for arch_apei_flush_tlb_one in arch/arm64/include/asm/acpi.h
>
> v6: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006644.html
>     Move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
>     a generic place.
>     Delete HAVE_ACPI_APEI_HEST_IA32.
>
> v5: https://lkml.org/lkml/2015/12/10/131
>     Add "HAVE_ACPI_APEI_HEST_IA32" instead of
>     "#if defined(__i386__) || defined(__x86_64__)".
>
> v4: https://lkml.org/lkml/2015/12/8/188
>     Rebase to latest kernel version(4.4-rc4).
>     Move arch_apei_flush_tlb_one into header file as a inline function
>     Add a new subfunction "hest_ia_init" for "acpi_disable_cmcff".
>
> v3: https://lkml.org/lkml/2015/12/3/521
>     Remove "acpi_disable_cmcff" from arm64 code,
>     and wrap it in hest.c by "#if defined(__i386__) || defined(__x86_64__)"
>
> v2: https://lkml.org/lkml/2015/12/2/432
>     Rebase to latest kernel version(4.4-rc3).
>     Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c
>
> v1: https://lkml.org/lkml/2015/8/14/199
>     Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
>     Delete arch/arm64/kernel/apei.c.
>     Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".
>
>  arch/arm64/Kconfig            |  1 +
>  arch/arm64/include/asm/acpi.h | 15 ++++++++++++++-
>  arch/x86/kernel/acpi/apei.c   |  3 ---
>  drivers/acpi/apei/Kconfig     |  1 +
>  drivers/acpi/apei/hest.c      | 18 +++++++++++++++---
>  5 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4f43622..08952ec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>         select ACPI_CCA_REQUIRED if ACPI
>         select ACPI_GENERIC_GSI if ACPI
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +       select HAVE_ACPI_APEI if ACPI
>         select ARCH_HAS_DEVMEM_IS_ALLOWED
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_HAS_ELF_RANDOMIZE
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index aee323b..4a6c959 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -17,6 +17,7 @@
>
>  #include <asm/cputype.h>
>  #include <asm/smp_plat.h>
> +#include <asm/tlbflush.h>
>
>  /* Macros for consistency checks of the GICC subtable of MADT */
>  #define ACPI_MADT_GICC_LENGTH  \
> @@ -110,7 +111,19 @@ static inline const char *acpi_get_enable_method(int cpu)
>  }
>
>  #ifdef CONFIG_ACPI_APEI
> +#define acpi_disable_cmcff 1
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
> -#endif
>
> +/*
> + * This inline function is used in IRQ context (by GHES driver now),
> + * see ghes_iounmap_irq and ghes_iounmap_nmi in drivers/acpi/apei/ghes.c.
> + * The page mapped is reserved for firmware in kernel. This invalidate TLB
> + * maintenance should be broadcasted safely to make sure that all the cores
> + * will do TLB invalidation, then get the right pages.
> + */
> +static inline void arch_apei_flush_tlb_one(unsigned long addr)
> +{
> +       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +}
> +#endif /* CONFIG_ACPI_APEI */
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
> index c280df6..ea3046e 100644
> --- a/arch/x86/kernel/acpi/apei.c
> +++ b/arch/x86/kernel/acpi/apei.c
> @@ -24,9 +24,6 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
>         struct acpi_hest_ia_corrected *cmc;
>         struct acpi_hest_ia_error_bank *mc_bank;
>
> -       if (hest_hdr->type != ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
> -               return 0;
> -
>         cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>         if (!cmc->enabled)
>                 return 0;
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index b0140c8..b037c5c 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -8,6 +8,7 @@ config ACPI_APEI
>         bool "ACPI Platform Error Interface (APEI)"
>         select MISC_FILESYSTEMS
>         select PSTORE
> +       select EFI if ARM64
>         select UEFI_CPER
>         depends on HAVE_ACPI_APEI
>         help
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 20b3fcf..792a0d9 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -123,7 +123,18 @@ EXPORT_SYMBOL_GPL(apei_hest_parse);
>   */
>  static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
>  {
> -       return arch_apei_enable_cmcff(hest_hdr, data);
> +       if (hest_hdr->type != ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
> +               return 0;
> +
> +       if (!acpi_disable_cmcff)
> +               return !arch_apei_enable_cmcff(hest_hdr, data);
> +
> +       return 0;
> +}
> +
> +static inline int __init hest_ia32_init(void)
> +{
> +       return apei_hest_parse(hest_parse_cmc, NULL);
>  }
>
>  struct ghes_arr {
> @@ -232,8 +243,9 @@ void __init acpi_hest_init(void)
>                 goto err;
>         }
>
> -       if (!acpi_disable_cmcff)
> -               apei_hest_parse(hest_parse_cmc, NULL);
> +       rc = hest_ia32_init();
> +       if (rc)
> +               goto err;
>
>         if (!ghes_disable) {
>                 rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
> --
> 2.5.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
