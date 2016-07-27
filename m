From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute NX-protected page" when resuming from hibernate to disk
Date: Thu, 28 Jul 2016 00:20:03 +0200
Message-ID: <3933922.01EeUQcCQe@vostro.rjw.lan>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <20160727175918.5uvo4p54iuhuw7ss@treble> <2037077.DPom3MoXJk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49924 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1162811AbcG0WPA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2016 18:15:00 -0400
In-Reply-To: <2037077.DPom3MoXJk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Thursday, July 28, 2016 12:12:15 AM Rafael J. Wysocki wrote:
> On Wednesday, July 27, 2016 12:59:18 PM Josh Poimboeuf wrote:
> > On Wed, Jul 27, 2016 at 01:08:21AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 27, 2016 at 12:42 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > On Tuesday, July 26, 2016 04:53:19 PM Josh Poimboeuf wrote:
> > > >> On Tue, Jul 26, 2016 at 10:15:39PM +0200, Rafael J. Wysocki wrote:
> > > >> > On Tuesday, July 26, 2016 09:39:05 AM Josh Poimboeuf wrote:
> > > >> > > On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
> > > >> > > > Hi,
> > > >> > > >
> > > >> > > > The following commit:
> > > >> > > >
> > > >> > > > commit 13523309495cdbd57a0d344c0d5d574987af007f
> > > >> > > > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > > >> > > > Date:   Thu Jan 21 16:49:21 2016 -0600
> > > >> > > >
> > > >> > > >     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
> > > >> > > >
> > > >> > > >     do_suspend_lowlevel() is a callable non-leaf function which doesn't
> > > >> > > >     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
> > > >> > > >
> > > >> > > >     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
> > > >> > > >
> > > >> > > > is reported to cause a resume-from-hibernation regression due to an attempt
> > > >> > > > to execute an NX page (we've seen quite a bit of that recently).
> > > >> > > >
> > > >> > > > I'm asking the reporter to try 4.7, but if the problem is still there, we'll
> > > >> > > > need to revert the above I'm afraid.
> > > >> >
> > > >> > So the bug is still there in 4.7 and it goes away after reverting the above
> > > >> > commit.  I guess I'll send a revert then.
> > > >>
> > > >> Hm, the code in wakeup_64.S seems quite magical, but I can't figure out
> > > >> why this change causes a panic.  Is it really causing the panic or is it
> > > >> uncovering some other bug?
> > > >
> > > > It doesn't matter really.
> > > >
> > > > It surely interacts with something in a really odd way, but that only means
> > > > that its impact goes far beyond what was expected when it was applied.  Its
> > > > changelog is inadequate as a result and so on.
> > > >
> > > >> Maybe we should hold off on reverting until we understand the issue.
> > > >
> > > > Which very well may take forever.
> > > >
> > > > And AFAICS this is a fix for a theoretical issue and it *reliably* triggers a
> > > > very practical kernel panic for this particular reporter.  I'd rather live
> > > > with the theoretical issue unfixed to be honest.
> > > 
> > > Well, actually, the best part is that do_suspend_lowlevel() is not
> > > even called during hibernation or resume from it.  It only is called
> > > during suspend-to-RAM.
> > > 
> > > Question now is how the change made by the commit in question can
> > > affect hibernation which is an unrelated code path.  We know for a
> > > fact that it does affect it, but how?
> > 
> > Hm... I have a theory, but I'm not sure about it.  I noticed that
> > x86_acpi_enter_sleep_state(),
> 
> I think you mean x86_acpi_suspend_lowlevel().
> 
> > which is involved in suspend, overwrites
> > several global variables (e.g, initial_code) which are used by the CPU
> > boot code in head_64.S.  But surprisingly, it doesn't restore those
> > variables to their original values after it resumes.
> 
> Is the head_64.S code also used to bring up offline CPUs?
> 
> If not, then this is not the problem, because hibernation doesn't use it
> for the boot CPU anyway.
> 
> > So if a suspend and resume were done before the hibernate, those
> > variables would presumably have suspend-centric values, and the first
> > time a CPU is brought up during the hibernation restore operation, it
> > would jump to wakeup_long64() (the suspend resume function) instead of
> > start_secondary (which is the normal CPU boot function).
> > 
> > So, if true, that would explain why my patch triggers a bug:
> > wakeup_long64() always[*] jumps to .Lresume_point, which my patch
> > affected.  Because of the FRAME_END, it would pop an extra value off the
> > stack.  So when restore_processor_state() returns, it would return to
> > whatever random address is on the stack after the real RIP.  Which is
> > consistent with the oops from the bug.  It had a bad instruction
> > pointer, which looked like a stack address.
> 
> OK, so why doesn't it break resume from suspend to RAM?  wakeup_long64 is
> invoked by the CPU startup code then and doesn't the FRAME_END affect
> that too?

Ah, I see.  wakeup_long64 will restore RSP from saved_rsp and that points
to the right address already.  OK

Thanks,
Rafael

