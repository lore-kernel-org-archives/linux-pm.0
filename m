From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/4] Hibernation: Arbitrary boot
	kernel support on x86_64
Date: Tue, 21 Aug 2007 09:57:10 +0200
Message-ID: <20070821075710.GE7258@elf.ucw.cz>
References: <200708201510.03734.rjw@sisk.pl> <200708201511.34254.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708201511.34254.rjw@sisk.pl>
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

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make it possible to restore a hibernation image on x86_64 with the help of a
> kernel different from the one in the image.

Looks mostly ok to me.

Should this be split in half (generic support, x86-64 support) and be
done last in the series, so that suspend still works when bisecting?

>  done:
> +	/* jump to the restore_registers address from the image header */
> +	jmpq	*%rax

So this is where the change from kernel text 1 to kernel text 2
happens, right? I see you are using %r10 for something here, perhaps
that should be commented?

> +.balign PAGE_SIZE
> +ENTRY(restore_registers)
> +	/* we are in the image kernel's text now */
> +	testq	%r10, %r10
> +	jz	1f
> +	/* copy the skipped page */
> +	movq	%r10, %rsi
> +	movq	%r9, %rdi
> +	movq	$(PAGE_SIZE >> 3), %rcx
> +	rep
> +	movsq

> @@ -84,10 +127,7 @@ done:
>  	movq	%rcx, %cr3
>  	movq	%rax, %cr4;  # turn PGE back on
>  
> -	movl	$24, %eax
> -	movl	%eax, %ds
> -
> -	/* We don't restore %rax, it must be 0 anyway */
> +	/* restore GPRs (we don't restore %rax, it must be 0 anyway) */
>  	movq	$saved_context, %rax
>  	movq	pt_regs_rsp(%rax), %rsp
>  	movq	pt_regs_rbp(%rax), %rbp

Hmm, in the old code, we knew we don't have to restore %ds, because it
is constant for one kernel. Now, we rely on %ds being constant accross
kernels. Not nice, and should be at least documented.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
