From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Wed, 20 Dec 2017 09:57:47 +0100
Message-ID: <20171220085747.tgkle5b77z7yz4j4@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161624.oiwdwgitzzwkc35k@hirez.programming.kicks-ass.net>
 <20171215121417.GB19821@e110439-lin>
 <20171215125340.akzm5kwa4pnijavz@hirez.programming.kicks-ass.net>
 <20171215154140.GE19821@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43606 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdLTI54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 03:57:56 -0500
Content-Disposition: inline
In-Reply-To: <20171215154140.GE19821@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Fri, Dec 15, 2017 at 03:41:40PM +0000, Patrick Bellasi wrote:
> Close enough, the actual code is:
> 
>         util_est = p->util_est.ewma;
>     5218:       f9403ba3        ldr     x3, [x29,#112]
>     521c:       f9418462        ldr     x2, [x3,#776]
>         if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
>     5220:       eb010040        subs    x0, x2, x1
>     5224:       da805400        cneg    x0, x0, mi
>     5228:       f100281f        cmp     x0, #0xa
>     522c:       54fff9cd        b.le    5164 <dequeue_task_fair+0xa04>

Ah, that cneg instruction is cute; on x86 we end up with something like:

bool abs_test(long s)
{
        return abs(s) < 32;
}

        cmpl    $-31, %eax
        jl      .L107
        movq    -8(%rbp), %rax
        cmpl    $31, %eax
        jg      .L107
        movl    $1, %eax
        jmp     .L108
.L107:
        movl    $0, %eax
.L108:


But I figured you can actually do:

	abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)

Which, if y is a constant, should result in nicer code, and it does for
x86:

        addq    $31, %rax
        cmpq    $62, %rax
        setbe   %al
        movzbl  %al, %eax

Just not measurably faster, I suppose because of all the dependencies :/
