From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Thu, 30 Jun 2016 10:23:14 -0700
Message-ID: <CALCETrXA-wsVBYmCmifTeZTwH8kPZ3e=8xci-7jyHua=MH0JFw@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <CAGXu5j+1_06mKVsV2BeBZtitRk8GtjMPH8_zAxocfxtp7NeLXg@mail.gmail.com>
 <1735047.Yzv12qmPPB@vostro.rjw.lan> <1735143.jkZ4XHok9E@vostro.rjw.lan>
 <20160630150539.GA3962@pd.tnic> <CAJZ5v0jZ6vPjuKT8h+B6i2bBoEU2=wjXiptZGrcjm7B2b6uQ9w@mail.gmail.com>
 <CALCETrU38QiDYBpZKJOjezsQ==ON=H3SCUhAVbBJuFq2MGwsZA@mail.gmail.com> <CAJZ5v0gdhVKyGppf5fcnWsk2k8=wp_DkZ51geXDOiyzhNGpo4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35235 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbcF3RXf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2016 13:23:35 -0400
Received: by mail-vk0-f54.google.com with SMTP id u68so76773455vkf.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 10:23:34 -0700 (PDT)
In-Reply-To: <CAJZ5v0gdhVKyGppf5fcnWsk2k8=wp_DkZ51geXDOiyzhNGpo4A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Thu, Jun 30, 2016 at 8:29 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 30, 2016 at 5:24 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Thu, Jun 30, 2016 at 8:17 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Thu, Jun 30, 2016 at 5:05 PM, Borislav Petkov <bp@alien8.de> wrote:
>>>> On Thu, Jun 30, 2016 at 03:17:20PM +0200, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Logan Gunthorpe reports that hibernation stopped working reliably for
>>>>> him after commit ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table
>>>>> and rodata).
>>>>
>>>> ...
>>>>
>>>>> +static int relocate_restore_code(void)
>>>>> +{
>>>>> +     pgd_t *pgd;
>>>>> +     pud_t *pud;
>>>>> +
>>>>> +     relocated_restore_code = get_safe_page(GFP_ATOMIC);
>>>>> +     if (!relocated_restore_code)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     memcpy((void *)relocated_restore_code, &core_restore_code, PAGE_SIZE);
>>>>> +
>>>>> +     /* Make the page containing the relocated code executable */
>>>>> +     pgd = (pgd_t *)__va(read_cr3()) + pgd_index(relocated_restore_code);
>>>>> +     pud = pud_offset(pgd, relocated_restore_code);
>>>>> +     if (pud_large(*pud)) {
>>>>> +             set_pud(pud, __pud(pud_val(*pud) & ~_PAGE_NX));
>>>>> +     } else {
>>>>> +             pmd_t *pmd = pmd_offset(pud, relocated_restore_code);
>>>>> +
>>>>> +             if (pmd_large(*pmd)) {
>>>>> +                     set_pmd(pmd, __pmd(pmd_val(*pmd) & ~_PAGE_NX));
>>>>> +             } else {
>>>>> +                     pte_t *pte = pte_offset_kernel(pmd, relocated_restore_code);
>>>>> +
>>>>> +                     set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_NX));
>>>>> +             }
>>>>> +     }
>>>>> +     flush_tlb_all();
>>>>
>>>> I know you want to flush TLBs but this causes the splat below on the
>>>> resume kernel.
>>>>
>>>> Most likely because:
>>>>
>>>> resume_target_kernel() does local_irq_disable() and then
>>>>
>>>> swsusp_arch_resume() -> relocate_restore_code() -> flush_tlb_all()
>>>>
>>>> and smp_call_function_many() doesn't like it when IRQs are disabled.
>>>
>>> Right.
>>>
>>> Can I invoke __flush_tlb_all() from here to flush the TLB on the local
>>> CPU?  That should be sufficient IMO.
>>
>> Yes, unless there's another CPU already up at the time, but that seems unlikely.
>
> They are all offline at that time.
>
> OK, let me do that then.
>
>> FWIW, the CPU can and will cache the NX bit and the CPU will *not*
>> refresh the TLB before sending a page fault.  You definitely need to
>> flush.
>
> OK
>
>>  I wonder if this is also why you're seeing a certain amount of
>> random corruption.
>
> Well, the corruption we saw was not really random.  I can give you all
> of the details if you're interested, maybe you'll be able to figure
> out what might be happening. :-)

Sure, or at least in abbreviated form.  No guarantee that I'll have
any clue, though.

--Andy
