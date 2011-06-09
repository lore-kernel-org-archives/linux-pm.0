From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
 support
Date: Thu, 9 Jun 2011 17:44:58 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1106091742350.11513__49092.2444886111$1307638048$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF0F45A.3030103@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, tuxonice-devel@tuxonice.net, Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Thu, 9 Jun 2011, Santosh Shilimkar wrote:

> On 6/9/2011 9:10 PM, Russell King - ARM Linux wrote:
>> On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
>>> Btw, when testing this I found that generic cpu_suspend seems to be just
>>> fine for OMAP3; the OMAP platforms though do not at this time use the
>>> generic cpu_suspend/resume for sleep, is it planned to change that ?
>> 
>> That's because OMAP was doing changes to their sleep code while I was
>> consolidating the sleep code, and although I asked several times that
>> the OMAP folk should participate in this effort, but evidentally I was
>> unsuccessful in achieving anything in that direction.
>> 
> Agreed but the situation at that point was the code was not at
> all in convertible position. Looking at your below comment,
> it's still not :)
>
>> And of course since then it's been forgotten about, and I've given up
>> on that particular aspect.  I've also come to the conclusion that OMAP
>> is sufficiently weird (requiring soo much to execute from SRAM) that
>> its hopeless to persue.
>> 
> We did discuss this Russell and requested your help here. I guess
> you have already looked at OMAP code from generic suspend
> hooks point of view and the SRAM execution, Errata's seems to
> make you feel it's not going to work.
> Is that what you mean here ?
>
> Regards
> Santosh
>

Sorry for interjecting ... you're right there's a lot special about OMAP. 
What I've been talking about is a rather small(ish) bit. Maybe the diff 
illustrates what I mean - use cpu_suspend/resume for the parts of off-mode 
save/restore that are non-OMAP-specific.

Like this (not tested, just for illustration what I mean):


diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 63f1066..913279b 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -216,63 +216,14 @@ save_context_wfi:
  	beq	clean_caches

  l1_logic_lost:
-	mov	r4, sp			@ Store sp
+	mrs	r4, cpsr		@ Store cpsr
  	mrs	r5, spsr		@ Store spsr
-	mov	r6, lr			@ Store lr
-	stmia	r8!, {r4-r6}
-
-	mrc	p15, 0, r4, c1, c0, 2	@ Coprocessor access control register
-	mrc	p15, 0, r5, c2, c0, 0	@ TTBR0
-	mrc	p15, 0, r6, c2, c0, 1	@ TTBR1
-	mrc	p15, 0, r7, c2, c0, 2	@ TTBCR
-	stmia	r8!, {r4-r7}
-
-	mrc	p15, 0, r4, c3, c0, 0	@ Domain access Control Register
-	mrc	p15, 0, r5, c10, c2, 0	@ PRRR
-	mrc	p15, 0, r6, c10, c2, 1	@ NMRR
-	stmia	r8!,{r4-r6}
-
-	mrc	p15, 0, r4, c13, c0, 1	@ Context ID
-	mrc	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
-	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
-	mrs	r7, cpsr		@ Store current cpsr
-	stmia	r8!, {r4-r7}
-
-	mrc	p15, 0, r4, c1, c0, 0	@ save control register
-	stmia	r8!, {r4}
-
-clean_caches:
-	/*
-	 * jump out to kernel flush routine
-	 *  - reuse that code is better
-	 *  - it executes in a cached space so is faster than refetch per-block
-	 *  - should be faster and will change with kernel
-	 *  - 'might' have to copy address, load and jump to it
-	 * Flush all data from the L1 data cache before disabling
-	 * SCTLR.C bit.
-	 */
-	ldr	r1, kernel_flush
-	mov	lr, pc
-	bx	r1
-
-	/*
-	 * Clear the SCTLR.C bit to prevent further data cache
-	 * allocation. Clearing SCTLR.C would make all the data accesses
-	 * strongly ordered and would not hit the cache.
-	 */
-	mrc	p15, 0, r0, c1, c0, 0
-	bic	r0, r0, #(1 << 2)	@ Disable the C bit
-	mcr	p15, 0, r0, c1, c0, 0
-	isb
+	stmia	sp!, {r4-r5}
+	mov	r1, #(PHYS_OFFSET - PAGE_OFFSET)
+	ldr	r3, =restore_mmu_on
+	bl	cpu_suspend

  	/*
-	 * Invalidate L1 data cache. Even though only invalidate is
-	 * necessary exported flush API is used here. Doing clean
-	 * on already clean cache would be almost NOP.
-	 */
-	ldr	r1, kernel_flush
-	blx	r1
-	/*
  	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
  	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
  	 * This sequence switches back to ARM.  Note that .align may insert a
@@ -463,115 +414,15 @@ l2_inv_gp:
  	ldr	r0, [r3,#12]
  	mov	r12, #0x2
  	smc	#0			@ Call SMI monitor (smieq)
-logic_l1_restore:
-	ldr	r1, l2dis_3630
-	cmp	r1, #0x1		@ Test if L2 re-enable needed on 3630
-	bne	skipl2reen
-	mrc	p15, 0, r1, c1, c0, 1
-	orr	r1, r1, #2		@ re-enable L2 cache
-	mcr	p15, 0, r1, c1, c0, 1
-skipl2reen:
-	mov	r1, #0
-	/*
-	 * Invalidate all instruction caches to PoU
-	 * and flush branch target cache
-	 */
-	mcr	p15, 0, r1, c7, c5, 0
-
-	ldr	r4, scratchpad_base
-	ldr	r3, [r4,#0xBC]
-	adds	r3, r3, #16
-
-	ldmia	r3!, {r4-r6}
-	mov	sp, r4			@ Restore sp
-	msr	spsr_cxsf, r5		@ Restore spsr
-	mov	lr, r6			@ Restore lr
-
-	ldmia	r3!, {r4-r7}
-	mcr	p15, 0, r4, c1, c0, 2	@ Coprocessor access Control Register
-	mcr	p15, 0, r5, c2, c0, 0	@ TTBR0
-	mcr	p15, 0, r6, c2, c0, 1	@ TTBR1
-	mcr	p15, 0, r7, c2, c0, 2	@ TTBCR
-
-	ldmia	r3!,{r4-r6}
-	mcr	p15, 0, r4, c3, c0, 0	@ Domain access Control Register
-	mcr	p15, 0, r5, c10, c2, 0	@ PRRR
-	mcr	p15, 0, r6, c10, c2, 1	@ NMRR
-
-
-	ldmia	r3!,{r4-r7}
-	mcr	p15, 0, r4, c13, c0, 1	@ Context ID
-	mcr	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
-	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
-	msr	cpsr, r7		@ store cpsr
-
-	/* Enabling MMU here */
-	mrc	p15, 0, r7, c2, c0, 2 	@ Read TTBRControl
-	/* Extract N (0:2) bits and decide whether to use TTBR0 or TTBR1 */
-	and	r7, #0x7
-	cmp	r7, #0x0
-	beq	usettbr0
-ttbr_error:
-	/*
-	 * More work needs to be done to support N[0:2] value other than 0
-	 * So looping here so that the error can be detected
-	 */
-	b	ttbr_error
-usettbr0:
-	mrc	p15, 0, r2, c2, c0, 0
-	ldr	r5, ttbrbit_mask
-	and	r2, r5
-	mov	r4, pc
-	ldr	r5, table_index_mask
-	and	r4, r5			@ r4 = 31 to 20 bits of pc
-	/* Extract the value to be written to table entry */
-	ldr	r1, table_entry
-	/* r1 has the value to be written to table entry*/
-	add	r1, r1, r4
-	/* Getting the address of table entry to modify */
-	lsr	r4, #18
-	/* r2 has the location which needs to be modified */
-	add	r2, r4
-	/* Storing previous entry of location being modified */
-	ldr	r5, scratchpad_base
-	ldr	r4, [r2]
-	str	r4, [r5, #0xC0]
-	/* Modify the table entry */
-	str	r1, [r2]
-	/*
-	 * Storing address of entry being modified
-	 * - will be restored after enabling MMU
-	 */
-	ldr	r5, scratchpad_base
-	str	r2, [r5, #0xC4]
-
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 4	@ Flush prefetch buffer
-	mcr	p15, 0, r0, c7, c5, 6	@ Invalidate branch predictor array
-	mcr	p15, 0, r0, c8, c5, 0	@ Invalidate instruction TLB
-	mcr	p15, 0, r0, c8, c6, 0	@ Invalidate data TLB
-	/*
-	 * Restore control register. This enables the MMU.
-	 * The caches and prediction are not enabled here, they
-	 * will be enabled after restoring the MMU table entry.
-	 */
-	ldmia	r3!, {r4}
-	/* Store previous value of control register in scratchpad */
-	str	r4, [r5, #0xC8]
-	ldr	r2, cache_pred_disable_mask
-	and	r4, r2
-	mcr	p15, 0, r4, c1, c0, 0
-	dsb
-	isb
-	ldr     r0, =restoremmu_on
-	bx      r0
-
  /*
   * ==============================
   * == Exit point from OFF mode ==
   * ==============================
   */
  restoremmu_on:
+	ldmfd	sp!, {r0,r1}
+	msr	cpsr, r0
+	msr	spsr, r1
  	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return




FrankH.
