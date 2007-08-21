From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [discuss] [RFC][PATCH -mm 1/4] Hibernation:
	Arbitrary boot kernel support on x86_64
Date: Tue, 21 Aug 2007 22:47:59 +0200
Message-ID: <200708212248.00058.rjw@sisk.pl>
References: <200708201510.03734.rjw@sisk.pl> <200708211637.11004.rjw@sisk.pl>
	<200708212130.24597.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708212130.24597.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 21 August 2007 21:30, Rafael J. Wysocki wrote:
> On Tuesday, 21 August 2007 16:37, Rafael J. Wysocki wrote:
> > On Tuesday, 21 August 2007 09:57, Pavel Machek wrote:
[--snip--]
> > > >  
> > > > -	movl	$24, %eax
> > > > -	movl	%eax, %ds
> > > > -
> > > > -	/* We don't restore %rax, it must be 0 anyway */
> > > > +	/* restore GPRs (we don't restore %rax, it must be 0 anyway) */
> > > >  	movq	$saved_context, %rax
> > > >  	movq	pt_regs_rsp(%rax), %rsp
> > > >  	movq	pt_regs_rbp(%rax), %rbp
> > > 
> > > Hmm, in the old code, we knew we don't have to restore %ds, because it
> > > is constant for one kernel. Now, we rely on %ds being constant accross
> > > kernels. Not nice, and should be at least documented.
> > 
> > Well, in fact we rely on it all the time (eg. the
> > "movq mmu_cr4_features(%rip), %rax" above wouldn't work if that's not true),
> > but I can keep the old code here just fine. ;-)
> 
> Well, I was wrong.  The new code doesn't work without this change and I'm not
> exactly sure why.

Actually, it works if the boot kernel is the same as the image kernel and it
doesn't work if the boot kernel is different.

I think what happens is that by loading %ds with a new selector we cause
the descriptor to be loaded from the descriptor table pointed to by the boot
kernel's GDT and this need not be in the same area as the image kernel's
global descriptor table.  If that is the case, an exception will trigger, so we
should not load %ds until the GDTR value is restored.

Moreover, according to the AMD tech docs, in 64-bit mode the value of %ds is
ignored, so we don't need to bother loading it anyway.

Greetings,
Rafael
