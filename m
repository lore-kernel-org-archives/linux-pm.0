From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/4] Hibernation: Use temporary
	kernel text mapping during restore on x86_64
Date: Tue, 21 Aug 2007 09:59:04 +0200
Message-ID: <20070821075904.GG7258@elf.ucw.cz>
References: <200708201510.03734.rjw@sisk.pl> <200708201517.25622.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708201517.25622.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> Use temporary page tables for the kernel text mapping during hibernation restore
> on x86_64.
> 
> Without the patch, the original boot kernel's page tables that represent the
> kernel text mapping are used while the core of the image kernel is being
> restored.  However, in principle, if the boot kernel is not identical to the
> image kernel, the location of these page tables in the image kernel need not be
> the same, so we should create a safe copy of the kernel text mapping prior to
> restoring the core of the image kernel.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/x86_64/kernel/suspend.c |   41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.23-rc3/arch/x86_64/kernel/suspend.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/arch/x86_64/kernel/suspend.c	2007-08-14 01:06:28.000000000 +0200
> +++ linux-2.6.23-rc3/arch/x86_64/kernel/suspend.c	2007-08-14 01:06:34.000000000 +0200
> @@ -175,7 +175,7 @@ static int res_phys_pud_init(pud_t *pud,
>  
>  			if (paddr >= end)
>  				break;
> -			pe = _PAGE_NX | _PAGE_PSE | _KERNPG_TABLE | paddr;
> +			pe = __PAGE_KERNEL_LARGE | paddr;
>  			pe &= __supported_pte_mask;
>  			set_pmd(pmd, __pmd(pe));
>  		}
> @@ -183,25 +183,42 @@ static int res_phys_pud_init(pud_t *pud,
>  	return 0;
>  }
>  
> +static int res_kernel_text_pud_init(pud_t *pud, unsigned long start)
> +{
> +	pmd_t *pmd;
> +	unsigned long paddr;
> +
> +	pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!pmd)
> +		return -ENOMEM;
> +	set_pud(pud + pud_index(start), __pud(__pa(pmd) | _KERNPG_TABLE));
> +	for (paddr = 0; paddr < KERNEL_TEXT_SIZE; pmd++, paddr += PMD_SIZE) {

Should we have something like "< max possible kernel size here"? IOW
this needs to cover both suspend _and_ resume kernels, no?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
