From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 07/10] x86/asm/acpi: Fix asmvalidate warnings for
 wakeup_64.S
Date: Thu, 11 Jun 2015 08:13:28 +0200
Message-ID: <20150611061328.GC30720@gmail.com>
References: <cover.1433937132.git.jpoimboe@redhat.com>
 <2817f5690aa760a601a614b738545fd60b087bbb.1433937132.git.jpoimboe@redhat.com>
 <20150610132135.GB25572@amd>
 <20150610141354.GB25848@treble.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36983 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbFKGNe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 02:13:34 -0400
Content-Disposition: inline
In-Reply-To: <20150610141354.GB25848@treble.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Jun 10, 2015 at 03:21:35PM +0200, Pavel Machek wrote:
> > On Wed 2015-06-10 07:06:15, Josh Poimboeuf wrote:
> > > Fix the following asmvalidate warnings:
> > > 
> > >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x15: unsupported jump to outside of function
> > >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x55: unsupported jump to outside of function
> > >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64(): unsupported fallthrough at end of function
> > >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x9a: unsupported jump to outside of function
> > >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x116: unsupported jump to outside of function
> > >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): unsupported fallthrough at end of function
> > >    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): missing FP_SAVE/RESTORE macros
> > >
> > 
> > Actually first things first. Purpose of warnings is to pinpoint
> > errors. Do you believe there are some errors in wakeup_64.S?
> 
> The "errors" are that it doesn't conform with the guidelines outlined in
> the cover letter.  Specifically, wakeup_long64() is improperly
> annotated, and do_suspend_lowlevel() doesn't honor CONFIG_FRAME_POINTER.

Please create a file for this in Documentation/x86/, outlining the common cases of 
such .S debug info problems and the effects this has on the stack backtrace 
output.

Thanks,

	Ingo
