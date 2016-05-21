From: Kees Cook <keescook@chromium.org>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sat, 21 May 2016 09:39:55 -0700
Message-ID: <CAGXu5jLAzWPSCT0Be182a+i0Y7yb_BriwrdzNshK7xPc8Ts_zA@mail.gmail.com>
References: <573DF82D.50006@deltatee.com> <20160520071517.GB14191@gmail.com>
 <CAJZ5v0gbv4CHmb1KfFgb=VKDNY32d=nzQ776_zVPC+X68h4d-w@mail.gmail.com>
 <7b865a03-484f-2d10-aa3e-d9c0d04caecb@tycho.nsa.gov> <CAJZ5v0gWxVwJ4aNEKtnCnY-GvFACaAjFDJNH__2YeAco-f1kRQ@mail.gmail.com>
 <CAGXu5jJ+hRAVNfa=xWd9c9On5vC6k+kZKkaXGSXS5WfjTK2QcA@mail.gmail.com>
 <CAGXu5jK=YRbrzON7yRFC4wpjziOH6RHUnZ9nUHqj4vdayi=fCw@mail.gmail.com> <573FC081.20006@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36186 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcEUQj6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2016 12:39:58 -0400
Received: by mail-wm0-f41.google.com with SMTP id n129so22012647wmn.1
        for <linux-pm@vger.kernel.org>; Sat, 21 May 2016 09:39:57 -0700 (PDT)
In-Reply-To: <573FC081.20006@deltatee.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Fri, May 20, 2016 at 6:57 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 20/05/16 04:16 PM, Kees Cook wrote:
>>
>> On Fri, May 20, 2016 at 2:59 PM, Kees Cook <keescook@chromium.org> wrote:
>>>
>>> On Fri, May 20, 2016 at 2:46 PM, Rafael J. Wysocki <rafael@kernel.org>
>>> wrote:
>>>>
>>>> On Fri, May 20, 2016 at 3:56 PM, Stephen Smalley <sds@tycho.nsa.gov>
>>>> wrote:
>>>>>
>>>>> On 05/20/2016 07:34 AM, Rafael J. Wysocki wrote:
>>>>>>
>>>>>> On Fri, May 20, 2016 at 9:15 AM, Ingo Molnar <mingo@kernel.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>> * Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I have been working on a bug that causes my laptop to freeze during
>>>>>>>> resume from hibernation. I did a bisect to find the offending
>>>>>>>> commit:
>>>>>>>>
>>>>>>>> [ab76f7b4ab] x86/mm: Set NX on gap between __ex_table and rodata
>>>>>>>>
>>>>>>>> There is more information in the bugzilla report [1] that
>>>>>>>> I've been working on but I will summarize things below.
>>>>>>>>
>>>>>>>> I've experienced intermittent but reproducible freezes when resuming
>>>>>>>> from hibernation since about kernel version 3.19. The freeze was
>>>>>>>> significantly more reproducible when a few applications were loaded
>>>>>>>> before hibernation and would largely not happen if hibernated
>>>>>>>> immediately after booting to a desktop. I did some tracing work to
>>>>>>>> find
>>>>>>>> that the kernel gets as far as the resume_image call in
>>>>>>>> swsusp_arch_resume and I could not find any response from the image
>>>>>>>> kernel when I hit the bug. I also did testing that seemed to rule
>>>>>>>> out
>>>>>>>> this being caused by a problematic driver.
>>>>>>>>
>>>>>>>> I did a successful bisect between 3.18 and 3.19 which found a bug in
>>>>>>>> commit f5b2831d6 that was then later fixed by commit 55696b1f66 in
>>>>>>>> 4.4.
>>>>>>>> Then, I did a second bisect with a ported version of the fix to the
>>>>>>>> first bug and found commit ab76f7b4ab in 4.3 to also break
>>>>>>>> hibernation
>>>>>>>> with what appears to be the exact same symptoms. Reverting that
>>>>>>>> commit
>>>>>>>> in recent kernels up to and including 4.6 fixes the issue and
>>>>>>>> restores
>>>>>>>> reliable hibernation. However, it's not at all clear to me why that
>>>>>>>> commit would cause this issue or how to fix the issue without
>>>>>>>> reverting.
>>>>>>>
>>>>>>>
>>>>>>> I've attached that commit below and also Cc:-ed a few more people who
>>>>>>> might have
>>>>>>> an idea about why this regressed. Worst-case we'll have to revert it.
>>>>>>
>>>>>>
>>>>>> Without looking deep into mm, my theory would be that after this patch
>>>>>> the final jump from the boot kernel to the image kernel's trampoline
>>>>>> code during resume may crash the kernel if the trampoline page turns
>>>>>> out to be NX in the boot kernel (it has to be executable in both the
>>>>>> boot and the image kernels).
>>>>>
>>>>>
>>>>> So, pardon my ignorance, but where is this trampoline page placed in
>>>>> kernel memory?
>>>>
>>>>
>>>> On 32-bit its location has to be the same in both the boot and the
>>>> image kernels and that's within kernel text in both cases, so that
>>>> shouldn't be a problem.
>>>>
>>>> On 64-bit its location depends on the image kernel and specifically on
>>>> the location of the restore_registers routine in it.  The (virtual)
>>>> address of that routine is stored in the restore_jump_address
>>>> variable, so the page containing it (the trampoline page) can be found
>>>> with the help of that.
>>>>
>>>> swsusp_arch_resume() sets up a temporary kernel mapping to finalize
>>>> the image restoration and that page must not be NX in that mapping for
>>>> things to work.
>>>
>>>
>>> It looks like nothing in the swsusp_arch_resume() -> get_safe_page()
>>> -> get_image_page() path sets the page executable...
>>>
>>> Untested, but I wonder if this work work in swsusp_arch_resume()
>>> before the memcpy?
>>
>>
>> I can't type today, it seems. It should read "... if this would work ..."
>>
>> If you can test this and it works for you, I'll send a proper patch... :P
>>
>> -Kees
>>
>
> Hi Kees,
>
> Thanks. I tried the patch but it only resulted in a kernel warning and
> freeze. I've attached a photo showing as much of the messages as I could
> get.
>
> Logan

Ah, dang, ok, thanks for trying it. I'll let Rafael try to figure this one out.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
