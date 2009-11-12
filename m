From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Thu, 12 Nov 2009 08:36:17 +0100
Message-ID: <20091112073616.GA11365@elf.ucw.cz>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>
	<4AFA210B.3020207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AFA210B.3020207@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue 2009-11-10 18:27:23, Yinghai Lu wrote:
> 
> try to find_e820_area/reserve_early, and call acpi_reserve_memory early
> 
> to get area is below 1M

Does it fix anything? I can't tell from the changelog...

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Please CC me on suspend patches.
>  /*
>   * Check if the CPU can handle C2 and deeper
> Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
> +++ linux-2.6/arch/x86/kernel/acpi/sleep.c
> @@ -119,29 +119,32 @@ void acpi_restore_state_mem(void)
>  
>  
>  /**
> - * acpi_reserve_bootmem - do _very_ early ACPI initialisation
> + * acpi_reserve_wakeup_memory - do _very_ early ACPI initialisation
>   *
>   * We allocate a page from the first 1MB of memory for the wakeup
>   * routine for when we come back from a sleep state. The
>   * runtime allocator allows specification of <16MB pages, but not
>   * <1MB pages.
>   */
> -void __init acpi_reserve_bootmem(void)
> +void __init acpi_reserve_wakeup_memory(void)
>  {
> +	unsigned long mem;
> +
>  	if ((&wakeup_code_end - &wakeup_code_start) > WAKEUP_SIZE) {
>  		printk(KERN_ERR
>  		       "ACPI: Wakeup code way too big, S3 disabled.\n");
>  		return;
>  	}
>  
> -	acpi_realmode = (unsigned long)alloc_bootmem_low(WAKEUP_SIZE);
> +	mem = find_e820_area(0, 1<<20, WAKEUP_SIZE, PAGE_SIZE);
>  
> -	if (!acpi_realmode) {
> +	if (mem == -1L) {
>  		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
>  		return;
>  	}

How is it better then old code?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
