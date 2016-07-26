From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Wed, 27 Jul 2016 01:08:21 +0200
Message-ID: <CAJZ5v0hDuYZXHsK3G0CrQwnKpO0DVa3sNxKpWNHkh8vofJUT8Q@mail.gmail.com>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <1931457.H9nCOt9KIt@vostro.rjw.lan>
 <20160726215319.twz22r5kbkpsgzfg@treble> <4852923.iQFmCCTKQM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4852923.iQFmCCTKQM@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 27, 2016 at 12:42 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 26, 2016 04:53:19 PM Josh Poimboeuf wrote:
>> On Tue, Jul 26, 2016 at 10:15:39PM +0200, Rafael J. Wysocki wrote:
>> > On Tuesday, July 26, 2016 09:39:05 AM Josh Poimboeuf wrote:
>> > > On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
>> > > > Hi,
>> > > >
>> > > > The following commit:
>> > > >
>> > > > commit 13523309495cdbd57a0d344c0d5d574987af007f
>> > > > Author: Josh Poimboeuf <jpoimboe@redhat.com>
>> > > > Date:   Thu Jan 21 16:49:21 2016 -0600
>> > > >
>> > > >     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
>> > > >
>> > > >     do_suspend_lowlevel() is a callable non-leaf function which doesn't
>> > > >     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
>> > > >
>> > > >     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
>> > > >
>> > > > is reported to cause a resume-from-hibernation regression due to an attempt
>> > > > to execute an NX page (we've seen quite a bit of that recently).
>> > > >
>> > > > I'm asking the reporter to try 4.7, but if the problem is still there, we'll
>> > > > need to revert the above I'm afraid.
>> >
>> > So the bug is still there in 4.7 and it goes away after reverting the above
>> > commit.  I guess I'll send a revert then.
>>
>> Hm, the code in wakeup_64.S seems quite magical, but I can't figure out
>> why this change causes a panic.  Is it really causing the panic or is it
>> uncovering some other bug?
>
> It doesn't matter really.
>
> It surely interacts with something in a really odd way, but that only means
> that its impact goes far beyond what was expected when it was applied.  Its
> changelog is inadequate as a result and so on.
>
>> Maybe we should hold off on reverting until we understand the issue.
>
> Which very well may take forever.
>
> And AFAICS this is a fix for a theoretical issue and it *reliably* triggers a
> very practical kernel panic for this particular reporter.  I'd rather live
> with the theoretical issue unfixed to be honest.

Well, actually, the best part is that do_suspend_lowlevel() is not
even called during hibernation or resume from it.  It only is called
during suspend-to-RAM.

Question now is how the change made by the commit in question can
affect hibernation which is an unrelated code path.  We know for a
fact that it does affect it, but how?

Thanks,
Rafael
