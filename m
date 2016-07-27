From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute NX-protected page" when resuming from hibernate to disk
Date: Thu, 28 Jul 2016 01:29:49 +0200
Message-ID: <1670639.GCDubuBUSI@vostro.rjw.lan>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <20160727221738.ilmm6mnvlmzmvfnt@treble> <1703386.0Oti4h65x8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52146 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932335AbcG0XYp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2016 19:24:45 -0400
In-Reply-To: <1703386.0Oti4h65x8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Thursday, July 28, 2016 01:20:53 AM Rafael J. Wysocki wrote:
> On Wednesday, July 27, 2016 05:17:38 PM Josh Poimboeuf wrote:
> > On Thu, Jul 28, 2016 at 12:12:15AM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, July 27, 2016 12:59:18 PM Josh Poimboeuf wrote:
> > > > Hm... I have a theory, but I'm not sure about it.  I noticed that
> > > > x86_acpi_enter_sleep_state(),
> > > 
> > > I think you mean x86_acpi_suspend_lowlevel().
> > 
> > Oops!
> > 
> > > > which is involved in suspend, overwrites
> > > > several global variables (e.g, initial_code) which are used by the CPU
> > > > boot code in head_64.S.  But surprisingly, it doesn't restore those
> > > > variables to their original values after it resumes.
> > > 
> > > Is the head_64.S code also used to bring up offline CPUs?
> > 
> > Yes.
> 
> OK
> 
> So it is really interesting why and how that stuff works for everybody.
> 
> Basically, CPU online should fail after a suspend-resume cycle, but it
> doesn't most of the time AFAICS.

do_boot_cpu() restores those values, so I think we're safe from that angle.

That should apply to the CPU online during resume from hibernation too.

Thanks,
Rafael

