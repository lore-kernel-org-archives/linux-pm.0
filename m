From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Fri, 2 Dec 2016 08:01:47 -0600
Message-ID: <20161202140147.gvj452hmlbxnstrg@treble>
References: <20161201145821.imkcgizo4thmiei2@treble>
 <20161201164551.52xlcftamleam6vq@treble>
 <CACT4Y+YXxcFAvBGsStZv8LC_30JvaC==UHznJre1z3UmsoqGsQ@mail.gmail.com>
 <20161201171306.swnvi4f2ezavloxd@treble>
 <CACT4Y+anS0XniR7ZxoEQ1nnAKPsGNvgc5L72uiSThOi3F742gA@mail.gmail.com>
 <20161201173438.bfe5eq23i6ezfxsq@treble>
 <CACT4Y+Z62RBTkiAjTG_ZF1zCZKA=S92fobENzRcq001XOTj36A@mail.gmail.com>
 <20161201175611.gf63mwzomt4wrlxy@treble>
 <20161201203154.mwt5x736g7z6jh3o@treble>
 <5144d695-7ac4-f992-5239-91c772b0c121@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbcLBOBu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Dec 2016 09:01:50 -0500
Content-Disposition: inline
In-Reply-To: <5144d695-7ac4-f992-5239-91c772b0c121@virtuozzo.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, "x86@kernel.org" <x86@kernel.org>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>

On Fri, Dec 02, 2016 at 04:41:09PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 12/01/2016 11:31 PM, Josh Poimboeuf wrote:
> 
> >  arch/x86/kernel/acpi/wakeup_64.S | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> > index 169963f..1df9b75 100644
> > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > @@ -109,6 +109,22 @@ ENTRY(do_suspend_lowlevel)
> >  	movq	pt_regs_r14(%rax), %r14
> >  	movq	pt_regs_r15(%rax), %r15
> >  
> > +#ifdef CONFIG_KASAN
> > +	/*
> > +	 * The suspend path may have poisoned some areas deeper in the stack,
> > +	 * which we now need to unpoison.
> > +	 *
> > +	 * We can't call kasan_unpoison_task_stack_below() because it uses %gs
> > +	 * for 'current', which hasn't been set up yet.  Instead, calculate the
> > +	 * stack range manually and call kasan_unpoison_shadow().
> > +	 */
> > +	movq	%rsp, %rdi
> > +	andq	$CURRENT_MASK, %rdi
> > +	movq	%rsp, %rsi
> > +	xorq	%rdi, %rsi
> > +	call	kasan_unpoison_shadow
> > +#endif
> > +
> 
> Looks good, but in fact we can use kasan_unpoison_task_stack_below(). We just need to change it a little:
> 
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 70c0097..e779236 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -80,7 +80,9 @@ void kasan_unpoison_task_stack(struct task_struct *task)
>  /* Unpoison the stack for the current task beyond a watermark sp value. */
>  asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  {
> -       __kasan_unpoison_stack(current, watermark);
> +       void *base = (void *)((unsigned long)watermark & ~(THREAD_SIZE - 1));
> +
> +       kasan_unpoison_shadow(base, watermark - base);
>  }
> 
> 
> With this we don't have to calculate stack range in assembly.

That is better indeed, will do a v3.

-- 
Josh
