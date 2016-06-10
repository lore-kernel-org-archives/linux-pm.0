From: Kees Cook <keescook@chromium.org>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Fri, 10 Jun 2016 11:18:47 -0700
Message-ID: <CAGXu5j+SpW0_-_tCey2SsS0729gR1PYkVaJFuedH=YSoUbFtKw@mail.gmail.com>
References: <573DF82D.50006@deltatee.com> <20160520071517.GB14191@gmail.com>
 <CAJZ5v0gbv4CHmb1KfFgb=VKDNY32d=nzQ776_zVPC+X68h4d-w@mail.gmail.com>
 <7b865a03-484f-2d10-aa3e-d9c0d04caecb@tycho.nsa.gov> <CAJZ5v0gWxVwJ4aNEKtnCnY-GvFACaAjFDJNH__2YeAco-f1kRQ@mail.gmail.com>
 <CAGXu5jJ+hRAVNfa=xWd9c9On5vC6k+kZKkaXGSXS5WfjTK2QcA@mail.gmail.com>
 <CAGXu5jK=YRbrzON7yRFC4wpjziOH6RHUnZ9nUHqj4vdayi=fCw@mail.gmail.com>
 <573FC081.20006@deltatee.com> <CAGXu5jLAzWPSCT0Be182a+i0Y7yb_BriwrdzNshK7xPc8Ts_zA@mail.gmail.com>
 <575A3E95.5090100@deltatee.com> <CAGXu5jK15P5CAQd09NzG31YMPEKJGXbhXiYDQ2sRC=WBhAFTrA@mail.gmail.com>
 <575B03F1.3060206@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38430 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbcFJSSu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 14:18:50 -0400
Received: by mail-wm0-f53.google.com with SMTP id m124so2911988wme.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 11:18:49 -0700 (PDT)
In-Reply-To: <575B03F1.3060206@deltatee.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Fri, Jun 10, 2016 at 11:16 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hey,
>
> On 10/06/16 12:09 PM, Kees Cook wrote:
>>> restore_code: ffff880157c3b000
>>> jump_addr: ffffffff81446be0
>>>
>>>
>>> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
>>> index 009947d..6efedb7 100644
>>> --- a/arch/x86/power/hibernate_64.c
>>> +++ b/arch/x86/power/hibernate_64.c
>>> @@ -92,6 +92,9 @@ int swsusp_arch_resume(void)
>>>         memcpy(relocated_restore_code, &core_restore_code,
>>>                &restore_registers - &core_restore_code);
>>>
>>> +       pr_info("restore_code: %p\n", relocated_restore_code);
>>> +       pr_info("jump_addr: %lx\n", restore_jump_address);
>>> +
>>
>> Also interesting would be the "relocated_restore_code" address, as
>> well as a dump of /sys/kernel/debug/kernel_page_tables (from
>> CONFIG_X86_PTDUMP).
>
> Is that not what I printed? If not, can you give me a better hint as to

Oh, whoops, sorry, I saw "restore_code" in the pr_info and
"relocate_restore_code" in the memcpy and didn't scan the right thing
in the pr_info line. :)

> what you're looking for so I can spin another kernel? I'll also provide
> the kernel_page_tables once I do that.

Cool, thanks.

>
>> I'm baffled by the problem, but the best I can understand is the the
>> relocated_restore_code range isn't executable (which should be visible
>> from finding it in /sys/kernel/debug/kernel_page_tables), but I don't
>> see how to solve that since my original patch didn't work.
>
> Yeah this is definitely a baffling problem.

-Kees


-- 
Kees Cook
Chrome OS & Brillo Security
