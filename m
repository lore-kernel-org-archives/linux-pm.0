From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Fri, 10 Jun 2016 12:16:17 -0600
Message-ID: <575B03F1.3060206@deltatee.com>
References: <573DF82D.50006@deltatee.com> <20160520071517.GB14191@gmail.com>
 <CAJZ5v0gbv4CHmb1KfFgb=VKDNY32d=nzQ776_zVPC+X68h4d-w@mail.gmail.com>
 <7b865a03-484f-2d10-aa3e-d9c0d04caecb@tycho.nsa.gov>
 <CAJZ5v0gWxVwJ4aNEKtnCnY-GvFACaAjFDJNH__2YeAco-f1kRQ@mail.gmail.com>
 <CAGXu5jJ+hRAVNfa=xWd9c9On5vC6k+kZKkaXGSXS5WfjTK2QcA@mail.gmail.com>
 <CAGXu5jK=YRbrzON7yRFC4wpjziOH6RHUnZ9nUHqj4vdayi=fCw@mail.gmail.com>
 <573FC081.20006@deltatee.com>
 <CAGXu5jLAzWPSCT0Be182a+i0Y7yb_BriwrdzNshK7xPc8Ts_zA@mail.gmail.com>
 <575A3E95.5090100@deltatee.com>
 <CAGXu5jK15P5CAQd09NzG31YMPEKJGXbhXiYDQ2sRC=WBhAFTrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:54731 "EHLO ale.deltatee.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbcFJSQf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 14:16:35 -0400
In-Reply-To: <CAGXu5jK15P5CAQd09NzG31YMPEKJGXbhXiYDQ2sRC=WBhAFTrA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

Hey,

On 10/06/16 12:09 PM, Kees Cook wrote:
>> restore_code: ffff880157c3b000
>> jump_addr: ffffffff81446be0
>>
>>
>> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
>> index 009947d..6efedb7 100644
>> --- a/arch/x86/power/hibernate_64.c
>> +++ b/arch/x86/power/hibernate_64.c
>> @@ -92,6 +92,9 @@ int swsusp_arch_resume(void)
>>         memcpy(relocated_restore_code, &core_restore_code,
>>                &restore_registers - &core_restore_code);
>>
>> +       pr_info("restore_code: %p\n", relocated_restore_code);
>> +       pr_info("jump_addr: %lx\n", restore_jump_address);
>> +
> 
> Also interesting would be the "relocated_restore_code" address, as
> well as a dump of /sys/kernel/debug/kernel_page_tables (from
> CONFIG_X86_PTDUMP).

Is that not what I printed? If not, can you give me a better hint as to
what you're looking for so I can spin another kernel? I'll also provide
the kernel_page_tables once I do that.

> I'm baffled by the problem, but the best I can understand is the the
> relocated_restore_code range isn't executable (which should be visible
> from finding it in /sys/kernel/debug/kernel_page_tables), but I don't
> see how to solve that since my original patch didn't work.

Yeah this is definitely a baffling problem.

Thanks,

Logan
