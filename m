From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [discuss] [RFC][PATCH -mm 1/4] Hibernation:
	Arbitrary boot kernel support on x86_64
Date: Tue, 21 Aug 2007 16:37:10 +0200
Message-ID: <200708211637.11004.rjw@sisk.pl>
References: <200708201510.03734.rjw@sisk.pl> <200708201511.34254.rjw@sisk.pl>
	<20070821075710.GE7258@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070821075710.GE7258@elf.ucw.cz>
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

On Tuesday, 21 August 2007 09:57, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Make it possible to restore a hibernation image on x86_64 with the help of a
> > kernel different from the one in the image.
> 
> Looks mostly ok to me.
> 
> Should this be split in half (generic support, x86-64 support) and be
> done last in the series, so that suspend still works when bisecting?

Yes, I can do that, but the x86-64 support must go at least before the 4/4
patch which depends on it.

> >  done:
> > +	/* jump to the restore_registers address from the image header */
> > +	jmpq	*%rax
> 
> So this is where the change from kernel text 1 to kernel text 2
> happens, right?

Yes.

> I see you are using %r10 for something here, perhaps that should be
> commented? 

%r10 is used to store the address of the data to copy into the skipped page.
I'll try to add a comment for that.

> > +.balign PAGE_SIZE
> > +ENTRY(restore_registers)
> > +	/* we are in the image kernel's text now */
> > +	testq	%r10, %r10
> > +	jz	1f
> > +	/* copy the skipped page */
> > +	movq	%r10, %rsi
> > +	movq	%r9, %rdi
> > +	movq	$(PAGE_SIZE >> 3), %rcx
> > +	rep
> > +	movsq
> 
> > @@ -84,10 +127,7 @@ done:
> >  	movq	%rcx, %cr3
> >  	movq	%rax, %cr4;  # turn PGE back on
> >  
> > -	movl	$24, %eax
> > -	movl	%eax, %ds
> > -
> > -	/* We don't restore %rax, it must be 0 anyway */
> > +	/* restore GPRs (we don't restore %rax, it must be 0 anyway) */
> >  	movq	$saved_context, %rax
> >  	movq	pt_regs_rsp(%rax), %rsp
> >  	movq	pt_regs_rbp(%rax), %rbp
> 
> Hmm, in the old code, we knew we don't have to restore %ds, because it
> is constant for one kernel. Now, we rely on %ds being constant accross
> kernels. Not nice, and should be at least documented.

Well, in fact we rely on it all the time (eg. the
"movq mmu_cr4_features(%rip), %rax" above wouldn't work if that's not true),
but I can keep the old code here just fine. ;-)

I'll send the reworked patch series in a new thread.

Greetings,
Rafael
