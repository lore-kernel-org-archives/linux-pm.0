From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/power/hibernate: Use local labels in asm
Date: Mon, 13 Apr 2015 01:06:38 +0200
Message-ID: <1683783.5ci0mLlA9Y@vostro.rjw.lan>
References: <1428867906-12016-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59196 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752288AbbDLWmI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2015 18:42:08 -0400
In-Reply-To: <1428867906-12016-1-git-send-email-bp@alien8.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org

On Sunday, April 12, 2015 09:45:06 PM Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... so that they don't appear in the object file and thus in objdump
> output. They're local anyway and have a meaning only within that file.
> 
> No functionality change.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-pm@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/power/hibernate_asm_64.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
> index 3c4469a7a929..e2386cb4e0c3 100644
> --- a/arch/x86/power/hibernate_asm_64.S
> +++ b/arch/x86/power/hibernate_asm_64.S
> @@ -78,9 +78,9 @@ ENTRY(restore_image)
>  
>  	/* code below has been relocated to a safe page */
>  ENTRY(core_restore_code)
> -loop:
> +.Lloop:
>  	testq	%rdx, %rdx
> -	jz	done
> +	jz	.Ldone
>  
>  	/* get addresses from the pbe and copy the page */
>  	movq	pbe_address(%rdx), %rsi
> @@ -91,8 +91,8 @@ loop:
>  
>  	/* progress to the next pbe */
>  	movq	pbe_next(%rdx), %rdx
> -	jmp	loop
> -done:
> +	jmp	.Lloop
> +.Ldone:
>  	/* jump to the restore_registers address from the image header */
>  	jmpq	*%rax
>  	/*
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
