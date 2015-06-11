From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 07/10] x86/asm/acpi: Fix asmvalidate warnings for
 wakeup_64.S
Date: Thu, 11 Jun 2015 14:36:54 +0200
Message-ID: <20150611123654.GA24528@amd>
References: <cover.1433937132.git.jpoimboe@redhat.com>
 <2817f5690aa760a601a614b738545fd60b087bbb.1433937132.git.jpoimboe@redhat.com>
 <20150610131914.GA25572@amd>
 <20150610140830.GA25848@treble.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41050 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbbFKMg5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 08:36:57 -0400
Content-Disposition: inline
In-Reply-To: <20150610140830.GA25848@treble.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

Hi!

> > > 5. Remove superfluous rsp changes.
> > 
> > Did you test the changes?
> 
> Yes, I verified that it didn't break suspend/resume on my system.

Ok, so I can not see anything wrong, either. I'd like to understand
why the original code manipulated %rsp, but...

If you did testing with frame pointer on, you can get my

Acked-by: Pavel Machek <pavel@ucw.cz>

> > Do you plan to make similar changes to wakeup_32.S?
> 
> Currently, asmvalidate is x86_64 only, so I'm only fixing the 64-bit
> stuff right now.

Well, you are "improving debuggability", afaict. It worked well before.

> > > @@ -108,8 +108,9 @@ ENTRY(do_suspend_lowlevel)
> > >  	movq	pt_regs_r15(%rax), %r15
> > >  
> > >  	xorl	%eax, %eax
> > > -	addq	$8, %rsp
> > > -	jmp	restore_processor_state
> > > +	call	restore_processor_state
> > > +	FP_RESTORE
> > > +	ret
> > >  ENDPROC(do_suspend_lowlevel)
> > 
> > Umm. I rather liked the direct jump.
> 
> Why?

It is both smaller and faster than the new code. But...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
