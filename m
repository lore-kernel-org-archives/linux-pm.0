From: Thomas Garnier <thgarnie@google.com>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Tue, 26 Jul 2016 14:17:29 -0700
Message-ID: <CAJcbSZE0YGP1mpyvRU-3c6jUQsuAhpB5wcyg10hKrNneUtgiPg@mail.gmail.com>
References: <16541580.dFLT14ScxF@vostro.rjw.lan> <2437449.FpDj7DlX4Y@vostro.rjw.lan>
 <CAGXu5jLEbETSntwVQnNt4MZsHiU3E0OCN51VgBScvVAjCP7auA@mail.gmail.com>
 <2264716.77pSArDZvG@vostro.rjw.lan> <CAGXu5jLPN4N1f19OXJboepVuJhnXeeWQghanqDwh4bU=SQXZJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36447 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758265AbcGZVRb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2016 17:17:31 -0400
Received: by mail-yw0-f175.google.com with SMTP id u134so34113329ywg.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2016 14:17:30 -0700 (PDT)
In-Reply-To: <CAGXu5jLPN4N1f19OXJboepVuJhnXeeWQghanqDwh4bU=SQXZJw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

I am sorry, there has been parallel work between KASLR memory
randomization and hibernation support. That's why hibernation was not
tested, it was not supported when the feature was created.
Communication will be better next time.

I will work on identifying the problem and pushing a fix.

Thanks for the feedback and pointer,

On Tue, Jul 26, 2016 at 1:59 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jul 26, 2016 at 1:53 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, July 26, 2016 01:33:02 PM Kees Cook wrote:
>>> On Tue, Jul 26, 2016 at 1:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> > On Tuesday, July 26, 2016 04:04:42 PM Borislav Petkov wrote:
>>> >> On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
>>> >> > Hi,
>>> >> >
>>> >> > The following commit:
>>> >> >
>>> >> > commit 13523309495cdbd57a0d344c0d5d574987af007f
>>> >> > Author: Josh Poimboeuf <jpoimboe@redhat.com>
>>> >> > Date:   Thu Jan 21 16:49:21 2016 -0600
>>> >> >
>>> >> >     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
>>> >> >
>>> >> >     do_suspend_lowlevel() is a callable non-leaf function which doesn't
>>> >> >     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
>>> >> >
>>> >> >     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
>>> >> >
>>> >> > is reported to cause a resume-from-hibernation regression due to an attempt
>>> >> > to execute an NX page (we've seen quite a bit of that recently).
>>> >> >
>>> >> > I'm asking the reporter to try 4.7, but if the problem is still there, we'll
>>> >> > need to revert the above I'm afraid.
>>> >>
>>> >> So I can't resume properly from disk too, on the Intel laptop this time. Top
>>> >> commit is from tip/master:
>>> >>
>>> >> commit 516f48acf59722429acd323b3d283f74f02891fe (refs/remotes/tip/master)
>>> >> Merge: a4823bbffc96 dd9506954539
>>> >> Author: Ingo Molnar <mingo@kernel.org>
>>> >> Date:   Mon Jul 25 08:39:43 2016 +0200
>>> >>
>>> >>     Merge branch 'linus'
>>> >>
>>> >>
>>> >> So I thought it might be Josh's patch above and reverted it. No joy.
>>> >>
>>> >> Then I remembered that I enabled CONFIG_RANDOMIZE_MEMORY for the
>>> >> microcode loader breakage which we've been debugging. Turned that off
>>> >> and machine resumes fine again.
>>> >
>>> > Well, I wasn't aware of *another* flavor of ASLR in the works.  And there
>>> > was no hope it would not break hibernation if you asked me.
>>> >
>>> >> It looks like
>>> >>
>>> >>   0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")
>>> >>
>>> >> broke a bunch of things. Off the top of my head, we probably should make
>>> >> suspend to disk and CONFIG_RANDOMIZE_MEMORY mutually exclusive, like it
>>> >> was the case with ASLR previously, AFAIR.
>>> >
>>> > Please no.
>>> >
>>> > First off, it should be perfectly possible to make hibernation work along
>>> > with this new variant of ASLR.  Second, quite obviously, the author of these
>>> > ASLR changes had not done sufficient research to estimate the possible
>>> > impact of them.
>>>
>>> I think that's a bit unfair: Thomas did a lot of testing, and it has
>>> been living in -next for a while.
>>
>> Well, with all due respect, "a lot of testing" is not quite the same thing as
>> "sufficient research" IMO.
>>
>> It should be known (at least from experience) that hibernation on x86-64 doesn't
>> play well with ASLR quite as a rule, so it would be good to at least check that
>> particular thing or CC a relevant person (ie. me).
>
> Fair enough: we need to practice considering a wider usage model.
>
>> Or even ask me on IRC for that matter.  Give me a heads up ahead of time.
>>
>> But no.  I'm still on the receiving end of the "hibernation doesn't work with
>> ASLR" story which was entirely avoidable this time around.  Sigh.
>
> I'll be sure to keep you in the loop for future x86 KASLR changes;
> sorry for the new pain. :(
>
>>> > Honestly, I don't think it is a good idea to introduce random Kconfig options
>>> > for working around cases in which the author of some changes cannot be bothered
>>> > with doing things right.  Even if that is security.
>>>
>>> I would agree: let's try to get this fixed soon.
>>>
>>> > So IMO, either we should fix the problem, or that whole new ASLR stuff should
>>> > be reverted.
>>> >
>>> > I think I know how to fix it, but I won't be able to get to that before the
>>> > next week.  I guess it can wait till then, though.
>>>
>>> Thomas, will you have some time to examine this and estimate the work for a fix?
>>
>> FWIW, my hunch ATM is that you need to look at the "Set up the direct mapping
>> from scratch" loop in set_up_temporary_mappings() and make it do the right
>> thing when the new ASLR stuff is enabled.
>
> Thanks for the pointer!
>
> -Kees
>
> --
> Kees Cook
> Chrome OS & Brillo Security
