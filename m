From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute NX-protected page" when resuming from hibernate to disk
Date: Tue, 26 Jul 2016 22:42:05 +0200
Message-ID: <6149171.h4XKmh1LvZ@vostro.rjw.lan>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <1931457.H9nCOt9KIt@vostro.rjw.lan> <CAGXu5j+mOW=m5iZp8RM6Mp9g9PzmrW6EgiUeeUcs2kQ6UHp8YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57478 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752813AbcGZUhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2016 16:37:04 -0400
In-Reply-To: <CAGXu5j+mOW=m5iZp8RM6Mp9g9PzmrW6EgiUeeUcs2kQ6UHp8YA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Tuesday, July 26, 2016 01:31:00 PM Kees Cook wrote:
> On Tue, Jul 26, 2016 at 1:15 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, July 26, 2016 09:39:05 AM Josh Poimboeuf wrote:
> >> On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
> >> > Hi,
> >> >
> >> > The following commit:
> >> >
> >> > commit 13523309495cdbd57a0d344c0d5d574987af007f
> >> > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> >> > Date:   Thu Jan 21 16:49:21 2016 -0600
> >> >
> >> >     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
> >> >
> >> >     do_suspend_lowlevel() is a callable non-leaf function which doesn't
> >> >     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
> >> >
> >> >     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
> >> >
> >> > is reported to cause a resume-from-hibernation regression due to an attempt
> >> > to execute an NX page (we've seen quite a bit of that recently).
> >> >
> >> > I'm asking the reporter to try 4.7, but if the problem is still there, we'll
> >> > need to revert the above I'm afraid.
> >
> > So the bug is still there in 4.7 and it goes away after reverting the above
> > commit.  I guess I'll send a revert then.
> 
> To make sure I understand:
> 
> There are two separate bugs here that break hibernation?

Yes, there are.

The first one is the BZ 150021 as reported here.

The second one is the clash with new ASLR-related changes as reported by Boris.

Thanks,
Rafael

