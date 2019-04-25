From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 9/9] riscv: call pm_power_off from machine_halt /
 machine_power_off
Date: Thu, 25 Apr 2019 12:57:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1904251227220.17442@viisi.sifive.com>
References: <20190411115623.5749-1-hch@lst.de> <20190411115623.5749-10-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411115623.5749-10-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Apr 2019, Christoph Hellwig wrote:

> This way any override of pm_power_off also affects the halt path and
> we don't need additional infrastructure for it.
> 
> Also remove the pm_power_off export - at least for now we don't have
> any modular drivers overriding it.

I'd propose that we keep the pm_power_off export - both to align with 
other architectures:

$ fgrep -r pm_power_off arch/ | grep EXPORT
arch/s390/kernel/setup.c:EXPORT_SYMBOL_GPL(pm_power_off);
arch/m68k/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/hexagon/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/ia64/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/sparc/kernel/process_32.c:EXPORT_SYMBOL(pm_power_off);
arch/sparc/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/sh/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/um/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/openrisc/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/nios2/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/arc/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/arm/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/nds32/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/csky/kernel/power.c:EXPORT_SYMBOL(pm_power_off);
arch/alpha/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/arm64/kernel/process.c:EXPORT_SYMBOL_GPL(pm_power_off);
arch/unicore32/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/c6x/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/xtensa/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/h8300/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/powerpc/kernel/setup-common.c:EXPORT_SYMBOL_GPL(pm_power_off);
arch/mips/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/riscv/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/microblaze/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/x86/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/parisc/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
$

and to make sure there's no hassle with the drivers that expect to assign 
something to it:

$ fgrep -r pm_power_off drivers/ | fgrep =  | cut -f1 -d:  | sort -u | wc -l
39
$

For what it's worth, I agree with the implied criticism that reassigning 
pm_power_off is not a good interface.  There is the obvious problem that 
more than one chunk of independent code could all try to assign to 
pm_power_off.  However, to avoid creating a RISC-V-specific mess when 
someone uses a TI PMIC driver on a RISC-V board, or tries to use ACPI with 
RISC-V, fixing that seems best done as a separate tree-wide series.

...

Replacing machine_power_off() with a call to your default_power_off() 
looks fine to me.  However I think it makes sense to change our existing 
machine_halt() (which was not added by your patch).  Looking at other 
major architectures - x86, ARM64, and ARM - they don't actually try to 
power down the system in machine_halt(), instead just entering an 
infinite loop, WFI, or calling into firmware or a hypervisor.  I'd propose 
that we align with that approach.


- Paul

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/kernel/reset.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index 2a53d26ffdd6..ed637aee514b 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -12,11 +12,15 @@
>   */
>  
>  #include <linux/reboot.h>
> -#include <linux/export.h>
>  #include <asm/sbi.h>
>  
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL(pm_power_off);
> +static void default_power_off(void)
> +{
> +	sbi_shutdown();
> +	while (1);
> +}
> +
> +void (*pm_power_off)(void) = default_power_off;
>  
>  void machine_restart(char *cmd)
>  {
> @@ -26,11 +30,10 @@ void machine_restart(char *cmd)
>  
>  void machine_halt(void)
>  {
> -	machine_power_off();
> +	pm_power_off();
>  }
>  
>  void machine_power_off(void)
>  {
> -	sbi_shutdown();
> -	while (1);
> +	pm_power_off();
>  }
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
