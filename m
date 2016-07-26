From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Tue, 26 Jul 2016 16:53:19 -0500
Message-ID: <20160726215319.twz22r5kbkpsgzfg@treble>
References: <16541580.dFLT14ScxF@vostro.rjw.lan>
 <20160726143905.xyiryey7weymscix@treble>
 <1931457.H9nCOt9KIt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbcGZVxW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Jul 2016 17:53:22 -0400
Content-Disposition: inline
In-Reply-To: <1931457.H9nCOt9KIt@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Tue, Jul 26, 2016 at 10:15:39PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 26, 2016 09:39:05 AM Josh Poimboeuf wrote:
> > On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > The following commit:
> > > 
> > > commit 13523309495cdbd57a0d344c0d5d574987af007f
> > > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Date:   Thu Jan 21 16:49:21 2016 -0600
> > > 
> > >     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
> > >     
> > >     do_suspend_lowlevel() is a callable non-leaf function which doesn't
> > >     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
> > >     
> > >     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
> > > 
> > > is reported to cause a resume-from-hibernation regression due to an attempt
> > > to execute an NX page (we've seen quite a bit of that recently).
> > > 
> > > I'm asking the reporter to try 4.7, but if the problem is still there, we'll
> > > need to revert the above I'm afraid.
> 
> So the bug is still there in 4.7 and it goes away after reverting the above
> commit.  I guess I'll send a revert then.

Hm, the code in wakeup_64.S seems quite magical, but I can't figure out
why this change causes a panic.  Is it really causing the panic or is it
uncovering some other bug?  Maybe we should hold off on reverting until
we understand the issue.

-- 
Josh
