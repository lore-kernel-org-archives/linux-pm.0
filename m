From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/19] x86: unify power/cpu_(32|64).c
Date: Fri, 12 Jun 2009 12:50:49 +0200
Message-ID: <20090612105049.GI18682__7420.58069813556$1244804000$gmane$org@elf.ucw.cz>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
	<S4AoGnG.A.DG.2cYMKB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <S4AoGnG.A.DG.2cYMKB@chimera>
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
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Magnus Damm <damm@igel.co.jp>, Linux PM List <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-06-11 22:35:11, Rafael J. Wysocki wrote:
> From: Sergio Luis <sergio@larces.uece.br>
> 
> This is the last unification step. Here we do remove one of the files
> and rename the left one as cpu.c, as both are now the same.
> Also update power/Makefile, telling it to build cpu.o, instead of
> cpu_(32|64).o
> 
> Signed-off-by: Sergio Luis <sergio@larces.uece.br>
> Signed-off-by: Lauro Salmito <laurosalmito@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>


> +#ifdef CONFIG_X86_32
> +	store_gdt(&ctxt->gdt);
> +	store_idt(&ctxt->idt);
> +#else
> +/* CONFIG_X86_64 */
> +	store_gdt((struct desc_ptr *)&ctxt->gdt_limit);
> +	store_idt((struct desc_ptr *)&ctxt->idt_limit);
> +#endif

I'd slightly prefer /* CONFIG_X86_64 */ to be moved to line above, or
dropped at all. it seems unneccessarily verbose.


> +	store_tr(ctxt->tr);
> +
> +	/* XMM0..XMM15 should be handled by kernel_fpu_begin(). */
> +	/*
> +	 * segment registers
> +	 */
> +#ifdef CONFIG_X86_32
> +	savesegment(es, ctxt->es);
> +	savesegment(fs, ctxt->fs);
> +	savesegment(gs, ctxt->gs);
> +	savesegment(ss, ctxt->ss);
> +#else
> +/* CONFIG_X86_64 */
> +	asm volatile ("movw %%ds, %0" : "=m" (ctxt->ds));
> +	asm volatile ("movw %%es, %0" : "=m" (ctxt->es));
> +	asm volatile ("movw %%fs, %0" : "=m" (ctxt->fs));
> +	asm volatile ("movw %%gs, %0" : "=m" (ctxt->gs));
> +	asm volatile ("movw %%ss, %0" : "=m" (ctxt->ss));
> +
> +	rdmsrl(MSR_FS_BASE, ctxt->fs_base);
> +	rdmsrl(MSR_GS_BASE, ctxt->gs_base);
> +	rdmsrl(MSR_KERNEL_GS_BASE, ctxt->gs_kernel_base);
> +	mtrr_save_fixed_ranges(NULL);
> +
> +	rdmsrl(MSR_EFER, ctxt->efer);
> +#endif

Can i386's mtrr_save_fixed_ranges() be moved to similar place?

> +	/*
> +	 * control registers
> +	 */
> +	ctxt->cr0 = read_cr0();
> +	ctxt->cr2 = read_cr2();
> +	ctxt->cr3 = read_cr3();
> +#ifdef CONFIG_X86_32
> +	ctxt->cr4 = read_cr4_safe();
> +#else
> +/* CONFIG_X86_64 */
> +	ctxt->cr4 = read_cr4();
> +	ctxt->cr8 = read_cr8();
> +#endif

Could we use read_cr4_safe on x86-64, too? Why the difference?

Should we be saving cr8 on 32-bit machines that have it? (That was
interrupt priority, IIRC?)

> +	/* cr4 was introduced in the Pentium CPU */
> +#ifdef CONFIG_X86_32
> +	if (ctxt->cr4)
> +		write_cr4(ctxt->cr4);
> +#else

Aha, is read_cr4_safe() needed because i486 does not have cr4?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
