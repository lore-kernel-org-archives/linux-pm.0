From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Fri, 2 Dec 2016 15:57:38 -0600
Message-ID: <20161202215738.hsdchaxtpinvru3n@treble>
References: <CACT4Y+Z62RBTkiAjTG_ZF1zCZKA=S92fobENzRcq001XOTj36A@mail.gmail.com>
 <20161201175611.gf63mwzomt4wrlxy@treble>
 <20161201203154.mwt5x736g7z6jh3o@treble>
 <5144d695-7ac4-f992-5239-91c772b0c121@virtuozzo.com>
 <20161202140147.gvj452hmlbxnstrg@treble>
 <20161202144240.3tect4hx4cks44iu@treble>
 <d632571d-43cb-9dec-a51f-7cf8a6f91c0b@virtuozzo.com>
 <20161202150819.2h25oyoj7qsvrw77@treble>
 <20161202174221.sfcvvddbvl5uz4f4@treble>
 <20161202210903.GB15126@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbcLBV5k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Dec 2016 16:57:40 -0500
Content-Disposition: inline
In-Reply-To: <20161202210903.GB15126@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, "x86@kernel.org" <x86@kernel.org>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>

On Fri, Dec 02, 2016 at 10:09:03PM +0100, Pavel Machek wrote:
> On Fri 2016-12-02 11:42:21, Josh Poimboeuf wrote:
> > Resuming from a suspend operation is showing a KASAN false positive
> > warning:
> > 
> > 
> > Reported-by: Scott Bauer <scott.bauer@intel.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> > diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> > index 0e9505f..b2a0cff 100644
> > --- a/mm/kasan/kasan.c
> > +++ b/mm/kasan/kasan.c
> > @@ -80,7 +80,14 @@ void kasan_unpoison_task_stack(struct task_struct *task)
> >  /* Unpoison the stack for the current task beyond a watermark sp value. */
> >  asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
> >  {
> > -	__kasan_unpoison_stack(current, watermark);
> > +	/*
> > +	 * Calculate the task stack base address.  Avoid using 'current'
> > +	 * because this function is called by early resume code which hasn't
> > +	 * yet set up the percpu register (%gs).
> > +	 */
> > +	void *base = (void *)((unsigned long)watermark & ~(THREAD_SIZE - 1));
> > +
> > +	kasan_unpoison_shadow(base, watermark - base);
> >  }
> >  
> 
> I know you modified this code to be arch-independend... but is it
> really? I guess it is portable enough across architectures that run
> kasan today..

Yes, it's arch-independent as far as I know.

All the implementations of alloc_thread_stack_node() in kernel/fork.c
create THREAD_SIZE sized/aligned stacks.

ia64 has its own implementation of alloc_thread_stack_node(), which also
has a THREAD_SIZE sized/aligned stack, with task_struct stored at the
beginning.

For those architectures for which stack grows up, they would need to
call a different helper which unpoisons the stack above the watermark,
but that was also the case before my patch.

-- 
Josh
