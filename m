From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Fri, 20 May 2016 13:34:27 +0200
Message-ID: <CAJZ5v0gbv4CHmb1KfFgb=VKDNY32d=nzQ776_zVPC+X68h4d-w@mail.gmail.com>
References: <573DF82D.50006@deltatee.com>
	<20160520071517.GB14191@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33649 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbcETLe3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 07:34:29 -0400
In-Reply-To: <20160520071517.GB14191@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Stephen Smalley <sds@tycho.nsa.gov>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Fri, May 20, 2016 at 9:15 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Logan Gunthorpe <logang@deltatee.com> wrote:
>
>> Hi,
>>
>> I have been working on a bug that causes my laptop to freeze during
>> resume from hibernation. I did a bisect to find the offending commit:
>>
>> [ab76f7b4ab] x86/mm: Set NX on gap between __ex_table and rodata
>>
>> There is more information in the bugzilla report [1] that
>> I've been working on but I will summarize things below.
>>
>> I've experienced intermittent but reproducible freezes when resuming
>> from hibernation since about kernel version 3.19. The freeze was
>> significantly more reproducible when a few applications were loaded
>> before hibernation and would largely not happen if hibernated
>> immediately after booting to a desktop. I did some tracing work to find
>> that the kernel gets as far as the resume_image call in
>> swsusp_arch_resume and I could not find any response from the image
>> kernel when I hit the bug. I also did testing that seemed to rule out
>> this being caused by a problematic driver.
>>
>> I did a successful bisect between 3.18 and 3.19 which found a bug in
>> commit f5b2831d6 that was then later fixed by commit 55696b1f66 in 4.4.
>> Then, I did a second bisect with a ported version of the fix to the
>> first bug and found commit ab76f7b4ab in 4.3 to also break hibernation
>> with what appears to be the exact same symptoms. Reverting that commit
>> in recent kernels up to and including 4.6 fixes the issue and restores
>> reliable hibernation. However, it's not at all clear to me why that
>> commit would cause this issue or how to fix the issue without reverting.
>
> I've attached that commit below and also Cc:-ed a few more people who might have
> an idea about why this regressed. Worst-case we'll have to revert it.

Without looking deep into mm, my theory would be that after this patch
the final jump from the boot kernel to the image kernel's trampoline
code during resume may crash the kernel if the trampoline page turns
out to be NX in the boot kernel (it has to be executable in both the
boot and the image kernels).

Thanks,
Rafael
