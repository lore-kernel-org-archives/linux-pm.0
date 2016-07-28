From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/asm/power: Fix hibernation return address corruption
Date: Thu, 28 Jul 2016 10:32:34 -0500
Message-ID: <20160728153234.aonacrbciebuqp5k@treble>
References: <16541580.dFLT14ScxF@vostro.rjw.lan>
 <20160727221738.ilmm6mnvlmzmvfnt@treble>
 <1703386.0Oti4h65x8@vostro.rjw.lan>
 <1670639.GCDubuBUSI@vostro.rjw.lan>
 <20160728151707.nmtkzri4jtumaq6h@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932545AbcG1Pch (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jul 2016 11:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20160728151707.nmtkzri4jtumaq6h@treble>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Thu, Jul 28, 2016 at 10:17:07AM -0500, Josh Poimboeuf wrote:
> On Thu, Jul 28, 2016 at 01:29:49AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 28, 2016 01:20:53 AM Rafael J. Wysocki wrote:
> > > On Wednesday, July 27, 2016 05:17:38 PM Josh Poimboeuf wrote:
> > > > On Thu, Jul 28, 2016 at 12:12:15AM +0200, Rafael J. Wysocki wrote:
> > > > > On Wednesday, July 27, 2016 12:59:18 PM Josh Poimboeuf wrote:
> > > > > > Hm... I have a theory, but I'm not sure about it.  I noticed that
> > > > > > x86_acpi_enter_sleep_state(),
> > > > > 
> > > > > I think you mean x86_acpi_suspend_lowlevel().
> > > > 
> > > > Oops!
> > > > 
> > > > > > which is involved in suspend, overwrites
> > > > > > several global variables (e.g, initial_code) which are used by the CPU
> > > > > > boot code in head_64.S.  But surprisingly, it doesn't restore those
> > > > > > variables to their original values after it resumes.
> > > > > 
> > > > > Is the head_64.S code also used to bring up offline CPUs?
> > > > 
> > > > Yes.
> > > 
> > > OK
> > > 
> > > So it is really interesting why and how that stuff works for everybody.
> > > 
> > > Basically, CPU online should fail after a suspend-resume cycle, but it
> > > doesn't most of the time AFAICS.
> > 
> > do_boot_cpu() restores those values, so I think we're safe from that angle.
> > 
> > That should apply to the CPU online during resume from hibernation too.
> 
> Yeah, my theory was bogus.  And as it turns out, the bug reporter made a
> mistake in the bisect.  The actual offending commit was apparently:
> 
>   ef0f3ed5a4ac ("x86/asm/power: Create stack frames in hibernate_asm_64.S")
> 
> Amazingly enough, I authored that patch as well.  I think "git bisect"
> doesn't like me!
> 
> Here's the fix:
> 
> ----
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] x86/asm/power: Fix hibernation return address corruption
> 
> In kernel bug 150021, a kernel panic was reported when restoring a
> hibernate image.  Only a picture of the oops was reported, so I can't
> paste the whole thing here.  But here are the most interesting parts:
> 
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle kernel paging request at ffff8804615cfd78
>   ...
>   RIP: ffff8804615cfd78
>   RSP: ffff8804615f0000
>   RBP: ffff8804615cfdc0
>   ...
>   Call Trace:
>    do_signal+0x23
>    exit_to_usermode_loop+0x64
>    ...
> 
> The RIP is on the same page as RBP, so it apparently started executing
> on the stack.
> 
> The bug was bisected to commit ef0f3ed5a4ac ("x86/asm/power: Create
> stack frames in hibernate_asm_64.S"), which in retrospect seems quite
> dangerous, since that code saves and restores the stack pointer from a
> global variable ('saved_context').
> 
> There are a lot of moving parts in the hibernate save and restore paths,
> so I don't know exactly what caused the panic.  Presumably, a FRAME_END
> was executed without the corresponding FRAME_BEGIN, or vice versa.  That
> would corrupt the return address on the stack and would be consistent
> with the details of the above panic.
> 
> Instead of doing the frame pointer save/restore around the bounds of the
> affected functions, instead just do it around the call to swsusp_save().
> That has the same effect of ensuring that if swsusp_save() sleeps, the
> frame pointers will be correct.  It's also a much more obviously safe
> way to do it than the original patch.  And objtool still doesn't report
> any warnings.
> 
> Fixes: ef0f3ed5a4ac ("x86/asm/power: Create stack frames in hibernate_asm_64.S")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=150021

> Reported-by: <shuzzle@mailbox.org>
> Tested-by: <shuzzle@mailbox.org>

Actually, Andre gave me his real name and email, so these should be:

Reported-by: Andre Reinke <andre.reinke@mailbox.org>
Tested-by: Andre Reinke <andre.reinke@mailbox.org>

-- 
Josh
