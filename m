From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Wed, 27 Jul 2016 12:59:18 -0500
Message-ID: <20160727175918.5uvo4p54iuhuw7ss@treble>
References: <16541580.dFLT14ScxF@vostro.rjw.lan>
 <1931457.H9nCOt9KIt@vostro.rjw.lan>
 <20160726215319.twz22r5kbkpsgzfg@treble>
 <4852923.iQFmCCTKQM@vostro.rjw.lan>
 <CAJZ5v0hDuYZXHsK3G0CrQwnKpO0DVa3sNxKpWNHkh8vofJUT8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42312 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884AbcG0R7V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Jul 2016 13:59:21 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDuYZXHsK3G0CrQwnKpO0DVa3sNxKpWNHkh8vofJUT8Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Wed, Jul 27, 2016 at 01:08:21AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 27, 2016 at 12:42 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, July 26, 2016 04:53:19 PM Josh Poimboeuf wrote:
> >> On Tue, Jul 26, 2016 at 10:15:39PM +0200, Rafael J. Wysocki wrote:
> >> > On Tuesday, July 26, 2016 09:39:05 AM Josh Poimboeuf wrote:
> >> > > On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
> >> > > > Hi,
> >> > > >
> >> > > > The following commit:
> >> > > >
> >> > > > commit 13523309495cdbd57a0d344c0d5d574987af007f
> >> > > > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> >> > > > Date:   Thu Jan 21 16:49:21 2016 -0600
> >> > > >
> >> > > >     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
> >> > > >
> >> > > >     do_suspend_lowlevel() is a callable non-leaf function which doesn't
> >> > > >     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
> >> > > >
> >> > > >     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
> >> > > >
> >> > > > is reported to cause a resume-from-hibernation regression due to an attempt
> >> > > > to execute an NX page (we've seen quite a bit of that recently).
> >> > > >
> >> > > > I'm asking the reporter to try 4.7, but if the problem is still there, we'll
> >> > > > need to revert the above I'm afraid.
> >> >
> >> > So the bug is still there in 4.7 and it goes away after reverting the above
> >> > commit.  I guess I'll send a revert then.
> >>
> >> Hm, the code in wakeup_64.S seems quite magical, but I can't figure out
> >> why this change causes a panic.  Is it really causing the panic or is it
> >> uncovering some other bug?
> >
> > It doesn't matter really.
> >
> > It surely interacts with something in a really odd way, but that only means
> > that its impact goes far beyond what was expected when it was applied.  Its
> > changelog is inadequate as a result and so on.
> >
> >> Maybe we should hold off on reverting until we understand the issue.
> >
> > Which very well may take forever.
> >
> > And AFAICS this is a fix for a theoretical issue and it *reliably* triggers a
> > very practical kernel panic for this particular reporter.  I'd rather live
> > with the theoretical issue unfixed to be honest.
> 
> Well, actually, the best part is that do_suspend_lowlevel() is not
> even called during hibernation or resume from it.  It only is called
> during suspend-to-RAM.
> 
> Question now is how the change made by the commit in question can
> affect hibernation which is an unrelated code path.  We know for a
> fact that it does affect it, but how?

Hm... I have a theory, but I'm not sure about it.  I noticed that
x86_acpi_enter_sleep_state(), which is involved in suspend, overwrites
several global variables (e.g, initial_code) which are used by the CPU
boot code in head_64.S.  But surprisingly, it doesn't restore those
variables to their original values after it resumes.

So if a suspend and resume were done before the hibernate, those
variables would presumably have suspend-centric values, and the first
time a CPU is brought up during the hibernation restore operation, it
would jump to wakeup_long64() (the suspend resume function) instead of
start_secondary (which is the normal CPU boot function).

So, if true, that would explain why my patch triggers a bug:
wakeup_long64() always[*] jumps to .Lresume_point, which my patch
affected.  Because of the FRAME_END, it would pop an extra value off the
stack.  So when restore_processor_state() returns, it would return to
whatever random address is on the stack after the real RIP.  Which is
consistent with the oops from the bug.  It had a bad instruction
pointer, which looked like a stack address.

But then again, maybe there's a hole in that theory, because how could
hibernate after suspend/resume possibly even work today if the CPU boot
goes to wakeup_long64() instead of start_secondary?

So I could be missing something, or even completely off base.  But the
missing restore of those variables does seem like a pretty huge
oversight.  I wonder if the following patch would fix it?


diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index adb3eaf..cd76fc5 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -45,6 +45,12 @@ acpi_status asmlinkage __visible x86_acpi_enter_sleep_state(u8 state)
  */
 int x86_acpi_suspend_lowlevel(void)
 {
+#ifdef CONFIG_64BIT
+	unsigned long prev_initial_code;
+#ifdef CONFIG_SMP
+	unsigned long prev_stack_start, prev_gdt_address, prev_initial_gs;
+#endif
+#endif
 	struct wakeup_header *header =
 		(struct wakeup_header *) __va(real_mode_header->wakeup_header);
 
@@ -99,13 +105,18 @@ int x86_acpi_suspend_lowlevel(void)
 	saved_magic = 0x12345678;
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
+	prev_stack_start = stack_start;
+	prev_gdt_address = early_gdt_descr.address;
+	prev_initial_gs = initial_gs;
+
 	stack_start = (unsigned long)temp_stack + sizeof(temp_stack);
 	early_gdt_descr.address =
 			(unsigned long)get_cpu_gdt_table(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
 #endif
+	prev_initial_code = initial_code;
 	initial_code = (unsigned long)wakeup_long64;
-       saved_magic = 0x123456789abcdef0L;
+	saved_magic = 0x123456789abcdef0L;
 #endif /* CONFIG_64BIT */
 
 	/*
@@ -115,6 +126,16 @@ int x86_acpi_suspend_lowlevel(void)
 	pause_graph_tracing();
 	do_suspend_lowlevel();
 	unpause_graph_tracing();
+
+#ifdef CONFIG_64BIT
+	initial_code = prev_initial_code;
+#ifdef CONFIG_SMP
+	initial_gs = prev_initial_gs;
+	early_gdt_descr.address = prev_gdt_address;
+	stack_start = prev_stack_start;
+#endif
+#endif
+
 	return 0;
 }
 
