From: Kees Cook <keescook@chromium.org>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Tue, 26 Jul 2016 13:31:00 -0700
Message-ID: <CAGXu5j+mOW=m5iZp8RM6Mp9g9PzmrW6EgiUeeUcs2kQ6UHp8YA@mail.gmail.com>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <20160726143905.xyiryey7weymscix@treble>
 <1931457.H9nCOt9KIt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1931457.H9nCOt9KIt@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 26, 2016 at 1:15 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 26, 2016 09:39:05 AM Josh Poimboeuf wrote:
>> On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
>> > Hi,
>> >
>> > The following commit:
>> >
>> > commit 13523309495cdbd57a0d344c0d5d574987af007f
>> > Author: Josh Poimboeuf <jpoimboe@redhat.com>
>> > Date:   Thu Jan 21 16:49:21 2016 -0600
>> >
>> >     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
>> >
>> >     do_suspend_lowlevel() is a callable non-leaf function which doesn't
>> >     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
>> >
>> >     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
>> >
>> > is reported to cause a resume-from-hibernation regression due to an attempt
>> > to execute an NX page (we've seen quite a bit of that recently).
>> >
>> > I'm asking the reporter to try 4.7, but if the problem is still there, we'll
>> > need to revert the above I'm afraid.
>
> So the bug is still there in 4.7 and it goes away after reverting the above
> commit.  I guess I'll send a revert then.

To make sure I understand:

There are two separate bugs here that break hibernation?

>> Hi Rafael,
>>
>> Is the oops output available somewhere?
>
> Not yet, but I've just ask the reporter to attach it to the $subject BZ entry.
>
> In any case, this is nasty stuff and the reason why we made that change was
> relatively weak IMO.
>
> Thanks,
> Rafael
>

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
