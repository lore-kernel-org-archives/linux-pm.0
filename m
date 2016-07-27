From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute NX-protected page" when resuming from hibernate to disk
Date: Thu, 28 Jul 2016 01:20:53 +0200
Message-ID: <1703386.0Oti4h65x8@vostro.rjw.lan>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <2037077.DPom3MoXJk@vostro.rjw.lan> <20160727221738.ilmm6mnvlmzmvfnt@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50855 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161343AbcG0XPu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2016 19:15:50 -0400
In-Reply-To: <20160727221738.ilmm6mnvlmzmvfnt@treble>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Wednesday, July 27, 2016 05:17:38 PM Josh Poimboeuf wrote:
> On Thu, Jul 28, 2016 at 12:12:15AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 27, 2016 12:59:18 PM Josh Poimboeuf wrote:
> > > Hm... I have a theory, but I'm not sure about it.  I noticed that
> > > x86_acpi_enter_sleep_state(),
> > 
> > I think you mean x86_acpi_suspend_lowlevel().
> 
> Oops!
> 
> > > which is involved in suspend, overwrites
> > > several global variables (e.g, initial_code) which are used by the CPU
> > > boot code in head_64.S.  But surprisingly, it doesn't restore those
> > > variables to their original values after it resumes.
> > 
> > Is the head_64.S code also used to bring up offline CPUs?
> 
> Yes.

OK

So it is really interesting why and how that stuff works for everybody.

Basically, CPU online should fail after a suspend-resume cycle, but it
doesn't most of the time AFAICS.

> > If not, then this is not the problem, because hibernation doesn't use it
> > for the boot CPU anyway.
> > 
> > > So if a suspend and resume were done before the hibernate, those
> > > variables would presumably have suspend-centric values, and the first
> > > time a CPU is brought up during the hibernation restore operation, it
> > > would jump to wakeup_long64() (the suspend resume function) instead of
> > > start_secondary (which is the normal CPU boot function).
> > > 
> > > So, if true, that would explain why my patch triggers a bug:
> > > wakeup_long64() always[*] jumps to .Lresume_point, which my patch
> > > affected.  Because of the FRAME_END, it would pop an extra value off the
> > > stack.  So when restore_processor_state() returns, it would return to
> > > whatever random address is on the stack after the real RIP.  Which is
> > > consistent with the oops from the bug.  It had a bad instruction
> > > pointer, which looked like a stack address.
> > 
> > OK, so why doesn't it break resume from suspend to RAM?
> 
> Because for suspend to RAM, it enters suspend through
> do_suspend_lowlevel(), which has the FRAME_BEGIN which corresponds to
> .Lresume_point's FRAME_END.
> 
> > wakeup_long64 is invoked by the CPU startup code then and doesn't the
> > FRAME_END affect that too?
> 
> Yes, I would imagine that any CPU startup operation (after
> suspend/resume to RAM) would be affected.

That would mean that your patch is needed anyway, wouldn't it?

Thanks,
Rafael

