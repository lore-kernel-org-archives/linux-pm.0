From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH RFC v3 04/12] arm64: kernel: cpu_{suspend/resume}
 implementation
Date: Fri, 20 Dec 2013 11:57:35 +0000
Message-ID: <20131220115735.GH25477@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1385033059-25896-5-git-send-email-lorenzo.pieralisi@arm.com>
 <52B42A48.5090202@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <52B42A48.5090202@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leo Yan <leoy@marvell.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Yu Tang <ytang5@marvell.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Loc Ho <lho@apm.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Dave P Martin <Dave.Martin@arm.com>, Feng Kan <fkan@apm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Colin Cross <ccross@android.com>, Christoffer Dall <christoffer.dall@linaro.org>, Zhou
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 20, 2013 at 11:30:16AM +0000, Leo Yan wrote:
> On 11/21/2013 07:24 PM, Lorenzo Pieralisi wrote:
> > +/*
> > + * x0 must contain the sctlr value retrieved from restored context
> > + */
> > +ENTRY(cpu_resume_mmu)
> > +	ldr	x3, =cpu_resume_after_mmu
> > +	msr	sctlr_el1, x0		// restore sctlr_el1
> > +	isb
> > +	br	x3			// global jump to virtual address
> > +ENDPROC(cpu_resume_mmu)
> > +cpu_resume_after_mmu:
> > +	mov	x0, #0			// return zero on success
> > +	ldp	x19, x20, [sp, #16]
> > +	ldp	x21, x22, [sp, #32]
> > +	ldp	x23, x24, [sp, #48]
> > +	ldp	x25, x26, [sp, #64]
> > +	ldp	x27, x28, [sp, #80]
> > +	ldp	x29, lr, [sp], #96
> > +	ret
> > +ENDPROC(cpu_resume_after_mmu)
> > +
> > +	.data
> > +ENTRY(cpu_resume)
> > +	bl	el2_setup		// if in EL2 drop to EL1 cleanly
> 
> Compare to v2's patch set, here remove the calculation fro the offset 
> b/t PHYS_OFFSET - PAGE_OFFSET; so when i verify the patch set, i saw x28 
> is zero and finally introduce the EL2's sync exception. Below are pasted 
> v2's code for reference.
> 
> do u want use firmware to set the x28 for the offset value? :-) IMHO, 
> v2's implementation is more reasonable and it's better keep the code.
> 
> ENTRY(cpu_resume)
>            adr     x4, sleep_save_sp
>            ldr     x5, =sleep_save_sp
>            sub     x28, x4, x5             // x28 = PHYS_OFFSET - 
> PAGE_OFFSET
>            /*
>             * make sure el2 is sane, el2_setup expects:
>             * x28 = PHYS_OFFSET - PAGE_OFFSET
>             */
>            bl      el2_setup               // if in EL2 drop to EL1 cleanly

With commit 85cc00eaa81d (arm64: kernel: add code to set cpu boot mode
to secondary_entry shim) we no longer compute the phys-page offset
before el2_setup.

Where does the fault happen?

-- 
Catalin
