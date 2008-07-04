From: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Subject: Re: [PATCH] x86 ACPI: Fix resume from suspend to RAM on
	uniprocessor x86-64
Date: Sat, 5 Jul 2008 00:08:29 +0200
Message-ID: <200807050008.30497.Rafal.Wysocki__34618.0583736443$1215209479$gmane$org@fuw.edu.pl>
References: <200807050005.31272.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807050005.31272.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Dionisus Torimens <djtm@gmx.net>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 of July 2008, Rafael J. Wysocki wrote:
> Hi Ingo,
> 
> This is a regression fix, please push to Linus ASAP.
> 
> Thanks,
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Since the trampoline code is now used for ACPI resume from suspend to RAM,
> the trampoline page tables have to be fixed up during boot not only on SMP
> systems, but also on UP systems that use the trampoline.
> 
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=10923
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

I should have added:

Reported-by: Dionisus Torimens <djtm@gmx.net>

> ---
>  arch/x86/kernel/head_64.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/x86/kernel/head_64.S
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/head_64.S
> +++ linux-2.6/arch/x86/kernel/head_64.S
> @@ -128,7 +128,7 @@ ident_complete:
>  	/* Fixup phys_base */
>  	addq	%rbp, phys_base(%rip)
>  
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_X86_TRAMPOLINE
>  	addq	%rbp, trampoline_level4_pgt + 0(%rip)
>  	addq	%rbp, trampoline_level4_pgt + (511*8)(%rip)
>  #endif
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
Rafael J. Wysocki, Ph.D.
Institute of Theoretical Physics
Faculty of Physics of Warsaw University
ul. Hoza 69, 00-681 Warsaw
[tel: +48 22 55 32 263]
[mob: +48 60 50 53 693]
----------------------------
One should not increase, beyond what is necessary,
the number of entities required to explain anything.
			-- William of Ockham
