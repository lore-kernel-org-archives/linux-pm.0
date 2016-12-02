From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v3] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Fri, 2 Dec 2016 17:45:18 +0300
Message-ID: <d632571d-43cb-9dec-a51f-7cf8a6f91c0b@virtuozzo.com>
References: <20161201164551.52xlcftamleam6vq@treble>
 <CACT4Y+YXxcFAvBGsStZv8LC_30JvaC==UHznJre1z3UmsoqGsQ@mail.gmail.com>
 <20161201171306.swnvi4f2ezavloxd@treble>
 <CACT4Y+anS0XniR7ZxoEQ1nnAKPsGNvgc5L72uiSThOi3F742gA@mail.gmail.com>
 <20161201173438.bfe5eq23i6ezfxsq@treble>
 <CACT4Y+Z62RBTkiAjTG_ZF1zCZKA=S92fobENzRcq001XOTj36A@mail.gmail.com>
 <20161201175611.gf63mwzomt4wrlxy@treble>
 <20161201203154.mwt5x736g7z6jh3o@treble>
 <5144d695-7ac4-f992-5239-91c772b0c121@virtuozzo.com>
 <20161202140147.gvj452hmlbxnstrg@treble>
 <20161202144240.3tect4hx4cks44iu@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db5eur01on0111.outbound.protection.outlook.com ([104.47.2.111]:65109
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750833AbcLBQTj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Dec 2016 11:19:39 -0500
In-Reply-To: <20161202144240.3tect4hx4cks44iu@treble>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, "x86@kernel.org" <x86@kernel.org>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>



On 12/02/2016 05:42 PM, Josh Poimboeuf wrote:


> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 0e9505f..e9d8ba0 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -80,7 +80,14 @@ void kasan_unpoison_task_stack(struct task_struct *task)
>  /* Unpoison the stack for the current task beyond a watermark sp value. */
>  asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  {
> -	__kasan_unpoison_stack(current, watermark);
> +	/*
> +	 * Calculate the task stack base address.  Avoid using 'current'
> +	 * because this function is called by early resume code which hasn't
> +	 * yet set up the percpu register (%gs).
> +	 */
> +	void *base = (void *)((unsigned long)watermark & CURRENT_MASK);

CURRENT_MASK is defined only on x86...

> +
> +	kasan_unpoison_shadow(base, watermark - base);
>  }
>  
>  /*
> 
