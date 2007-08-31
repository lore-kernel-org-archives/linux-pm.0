From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation: kexec
	jump
Date: Fri, 31 Aug 2007 16:27:22 +0800
Message-ID: <1188548842.1365.13.camel__18697.8551130325$1188548833$gmane$org@caritas-dev.intel.com>
References: <1188177280.3247.37.camel@caritas-dev.intel.com>
	<20070827184829.GB4104@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070827184829.GB4104@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-08-27 at 18:48 +0000, Pavel Machek wrote:
> Hi!
> 
> > To support jumping back from kexeced kernel, before executing the new
> > kernel, the devices are put into quiescent state (to be fully
> > implemented), and the state of devices and CPU is saved. After jumping
> > back from kexeced kernel, the state of devices and CPU are restored
> > accordingly. The devices/CPU state save/restore code of software
> > suspend is called to implement corresponding function.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> Looks quite ok to me...
> 
> 
> > Index: linux-2.6.23-rc3/include/asm-i386/kexec.h
> > ===================================================================
> > --- linux-2.6.23-rc3.orig/include/asm-i386/kexec.h	2007-08-25 21:56:54.000000000 +0800
> > +++ linux-2.6.23-rc3/include/asm-i386/kexec.h	2007-08-25 21:57:00.000000000 +0800
> > @@ -94,6 +94,10 @@
> >  		unsigned long start_address,
> >  		unsigned int has_pae) ATTRIB_NORET;
> >  
> > +#ifdef CONFIG_KEXEC_JUMP
> > +extern asmlinkage int machine_kexec_real_jump(void *buf);
> > +#endif
> 
> Is it really neccessery to have ifdef here?

It is not necessary. I will fix it in the next version.

> > +#ifdef CONFIG_KEXEC_JUMP
> > +#define KEXEC_JUMP_FLAG_IS_KEXECED_KERNEL     0x1
> > +#endif /* CONFIG_KEXEC_JUMP */
> 
> And here? ... It would be nice to use slightly shorter identifier.
> 'KJUMP_IS_KEXECED' should be enough.

Yes, that is nicer. I will fix it.

> > +/*
> > + * Must be relocatable PIC code callable as a C function
> > + */
> > +#define HALF_PAGE_ALIGNED (1 << (PAGE_SHIFT-1))
> > +
> > +#define EBX	0x0
> > +#define ESI	0x4
> > +#define EDI	0x8
> > +#define EBP	0xc
> > +#define ESP	0x10
> > +#define CR0	0x14
> > +#define CR3	0x18
> > +#define CR4	0x1c
> > +#define FLAG	0x20
> > +#define RET	0x24
> 
> Hmm, is this enough? Should it use struct ptregs for normal registers?
> What about segment registers -- they could change between kernel
> version. Should some kind of 'version of kjump protocol' be
> introduced?

All "preserve" registers defined in ABI are saved, I think that is
sufficient. The "swsusp_arch_suspend" saves only these registers too.

An extensible inter-kernel kjump protocol and corresponding version
number seems sensible. I will work on this.

> 
> What about CX/DX/fpu state? GDT pointer?
> 
> Actually I think that you _do_ need to save FPU. You should probably
> use relevant swsusp parts here.

Before and after "machine_kexec_jump" is called, the
save_processor_state() and restore_processor_state() are called, where
the MTRR/FPU/GDT/IDT/TR/segments/cr are saved and restored. These two
functions come from swsusp. Thanks swsusp guys. :)

Best Regards,
Huang Ying
