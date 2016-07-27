From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Wed, 27 Jul 2016 17:17:38 -0500
Message-ID: <20160727221738.ilmm6mnvlmzmvfnt@treble>
References: <16541580.dFLT14ScxF@vostro.rjw.lan>
 <CAJZ5v0hDuYZXHsK3G0CrQwnKpO0DVa3sNxKpWNHkh8vofJUT8Q@mail.gmail.com>
 <20160727175918.5uvo4p54iuhuw7ss@treble>
 <2037077.DPom3MoXJk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162535AbcG0WRk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Jul 2016 18:17:40 -0400
Content-Disposition: inline
In-Reply-To: <2037077.DPom3MoXJk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Thu, Jul 28, 2016 at 12:12:15AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 27, 2016 12:59:18 PM Josh Poimboeuf wrote:
> > Hm... I have a theory, but I'm not sure about it.  I noticed that
> > x86_acpi_enter_sleep_state(),
> 
> I think you mean x86_acpi_suspend_lowlevel().

Oops!

> > which is involved in suspend, overwrites
> > several global variables (e.g, initial_code) which are used by the CPU
> > boot code in head_64.S.  But surprisingly, it doesn't restore those
> > variables to their original values after it resumes.
> 
> Is the head_64.S code also used to bring up offline CPUs?

Yes.

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
> OK, so why doesn't it break resume from suspend to RAM?

Because for suspend to RAM, it enters suspend through
do_suspend_lowlevel(), which has the FRAME_BEGIN which corresponds to
.Lresume_point's FRAME_END.

> wakeup_long64 is invoked by the CPU startup code then and doesn't the
> FRAME_END affect that too?

Yes, I would imagine that any CPU startup operation (after
suspend/resume to RAM) would be affected.

-- 
Josh
