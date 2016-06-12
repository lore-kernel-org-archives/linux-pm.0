From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sat, 11 Jun 2016 22:48:08 -0600
Message-ID: <575CE988.9030201@deltatee.com>
References: <573DF82D.50006@deltatee.com> <2597967.kdkjeIcHno@vostro.rjw.lan>
 <575C4CE4.6060608@deltatee.com> <3878383.bGDWSmEsze@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:59177 "EHLO ale.deltatee.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbcFLEsZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 12 Jun 2016 00:48:25 -0400
In-Reply-To: <3878383.bGDWSmEsze@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

Hey,

On 11/06/16 07:05 PM, Rafael J. Wysocki wrote:
>> 1) Commit ab76f7b4ab only extends the NX bit between __ex_table and
>> rodata; which, by my understanding, shouldn't be used by anything. And
>> __ex_table and rodata are fixed by the kernel's binary so both symbols
>> should be the same in both the image kernel and the boot kernel given
>> that both are running from the same binary.
>
> Well, what if the kernel is relocated?

Ah, I'm sure I don't fully grasp the implications of that but I would 
assume that if the image kernel were located somewhere else it would 
still be far away from the boot kernel's ex_table/rodata boundary.

>> 2) When ab76f7b4ab is reverted, hibernation seems to work 100%. Though,
>> when it's in place, it only works some of the time. Given that commit is
>> only extending the NX region a bit, if there is some random mismatch,
>> why does it never reach rodata? In other words, why is rodata a magic
>> line that seems to work all the time -- why doesn't this random mismatch
>> ever extend into the rodata region? rodata isn't _that_ far away from
>> the end of ex_table.
>
> That's a very good question. :-)

Yeah, I guess if we knew the answer we'd understand what was going on 
and have a fix.


> Can you please check if the patch below makes any difference?

I'm afraid it's no different. The kernel still freezes on resume. 
Though, no warnings with this one.

Thanks,

Logan
