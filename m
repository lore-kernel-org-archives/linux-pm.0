From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/power/64: Use char arrays for asm function names
Date: Tue, 09 May 2017 23:18:56 +0200
Message-ID: <4065405.RHJSHBFYFE@aspire.rjw.lan>
References: <20170509210051.GA36504@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45754 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbdEIVZZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 17:25:25 -0400
In-Reply-To: <20170509210051.GA36504@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>

On Tuesday, May 09, 2017 02:00:51 PM Kees Cook wrote:
> This switches the hibernate_64.S function names into character arrays
> to match other areas of the kernel where this is done (e.g., linker
> scripts). Specifically this fixes a compile-time error noticed by the
> future CONFIG_FORTIFY_SOURCE routines that complained about PAGE_SIZE
> being copied out of the "single byte" core_restore_code variable.
> 
> Additionally drops the "acpi_save_state_mem" exern which does not
> appear to be used anywhere else in the kernel.
> 
> Cc: Daniel Micay <danielmicay@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or I can queue this up if that's preferred.

> ---
>  arch/x86/include/asm/suspend_64.h | 5 ++---
>  arch/x86/power/hibernate_64.c     | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
> index 6136a18152af..2bd96b4df140 100644
> --- a/arch/x86/include/asm/suspend_64.h
> +++ b/arch/x86/include/asm/suspend_64.h
> @@ -42,8 +42,7 @@ struct saved_context {
>  	set_debugreg((thread)->debugreg##register, register)
>  
>  /* routines for saving/restoring kernel state */
> -extern int acpi_save_state_mem(void);
> -extern char core_restore_code;
> -extern char restore_registers;
> +extern char core_restore_code[];
> +extern char restore_registers[];
>  
>  #endif /* _ASM_X86_SUSPEND_64_H */
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index 6a61194ffd58..2cc419990ab7 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -147,7 +147,7 @@ static int relocate_restore_code(void)
>  	if (!relocated_restore_code)
>  		return -ENOMEM;
>  
> -	memcpy((void *)relocated_restore_code, &core_restore_code, PAGE_SIZE);
> +	memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
>  
>  	/* Make the page containing the relocated code executable */
>  	pgd = (pgd_t *)__va(read_cr3()) + pgd_index(relocated_restore_code);
> @@ -292,8 +292,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  
>  	if (max_size < sizeof(struct restore_data_record))
>  		return -EOVERFLOW;
> -	rdr->jump_address = (unsigned long)&restore_registers;
> -	rdr->jump_address_phys = __pa_symbol(&restore_registers);
> +	rdr->jump_address = (unsigned long)restore_registers;
> +	rdr->jump_address_phys = __pa_symbol(restore_registers);
>  	rdr->cr3 = restore_cr3;
>  	rdr->magic = RESTORE_MAGIC;
>  
> 
