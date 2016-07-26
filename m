From: Kees Cook <keescook@chromium.org>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Tue, 26 Jul 2016 13:33:02 -0700
Message-ID: <CAGXu5jLEbETSntwVQnNt4MZsHiU3E0OCN51VgBScvVAjCP7auA@mail.gmail.com>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <20160726140442.GA2832@nazgul.tnic>
 <2437449.FpDj7DlX4Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2437449.FpDj7DlX4Y@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org, Thomas Garnier <thgarnie@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 26, 2016 at 1:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 26, 2016 04:04:42 PM Borislav Petkov wrote:
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
>>
>> So I can't resume properly from disk too, on the Intel laptop this time. Top
>> commit is from tip/master:
>>
>> commit 516f48acf59722429acd323b3d283f74f02891fe (refs/remotes/tip/master)
>> Merge: a4823bbffc96 dd9506954539
>> Author: Ingo Molnar <mingo@kernel.org>
>> Date:   Mon Jul 25 08:39:43 2016 +0200
>>
>>     Merge branch 'linus'
>>
>>
>> So I thought it might be Josh's patch above and reverted it. No joy.
>>
>> Then I remembered that I enabled CONFIG_RANDOMIZE_MEMORY for the
>> microcode loader breakage which we've been debugging. Turned that off
>> and machine resumes fine again.
>
> Well, I wasn't aware of *another* flavor of ASLR in the works.  And there
> was no hope it would not break hibernation if you asked me.
>
>> It looks like
>>
>>   0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")
>>
>> broke a bunch of things. Off the top of my head, we probably should make
>> suspend to disk and CONFIG_RANDOMIZE_MEMORY mutually exclusive, like it
>> was the case with ASLR previously, AFAIR.
>
> Please no.
>
> First off, it should be perfectly possible to make hibernation work along
> with this new variant of ASLR.  Second, quite obviously, the author of these
> ASLR changes had not done sufficient research to estimate the possible
> impact of them.

I think that's a bit unfair: Thomas did a lot of testing, and it has
been living in -next for a while.

> Honestly, I don't think it is a good idea to introduce random Kconfig options
> for working around cases in which the author of some changes cannot be bothered
> with doing things right.  Even if that is security.

I would agree: let's try to get this fixed soon.

> So IMO, either we should fix the problem, or that whole new ASLR stuff should
> be reverted.
>
> I think I know how to fix it, but I won't be able to get to that before the
> next week.  I guess it can wait till then, though.

Thomas, will you have some time to examine this and estimate the work for a fix?

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
