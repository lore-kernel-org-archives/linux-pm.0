From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 07/10] x86/asm/acpi: Fix asmvalidate warnings for
 wakeup_64.S
Date: Wed, 10 Jun 2015 15:21:35 +0200
Message-ID: <20150610132135.GB25572@amd>
References: <cover.1433937132.git.jpoimboe@redhat.com>
 <2817f5690aa760a601a614b738545fd60b087bbb.1433937132.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40649 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933329AbbFJNVh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 09:21:37 -0400
Content-Disposition: inline
In-Reply-To: <2817f5690aa760a601a614b738545fd60b087bbb.1433937132.git.jpoimboe@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

On Wed 2015-06-10 07:06:15, Josh Poimboeuf wrote:
> Fix the following asmvalidate warnings:
> 
>    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x15: unsupported jump to outside of function
>    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x55: unsupported jump to outside of function
>    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64(): unsupported fallthrough at end of function
>    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x9a: unsupported jump to outside of function
>    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x116: unsupported jump to outside of function
>    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): unsupported fallthrough at end of function
>    asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): missing FP_SAVE/RESTORE macros
>

Actually first things first. Purpose of warnings is to pinpoint
errors. Do you believe there are some errors in wakeup_64.S?
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
