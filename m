From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Fri, 7 Jul 2017 15:57:28 -0700
Message-ID: <CAJWu+oodSJ7_f7EORWCtOu+_m9UOVsiPx6zGRJSFQXKMTmvJ8g@mail.gmail.com>
References: <20170705085905.6558-1-juri.lelli@arm.com> <alpine.DEB.2.20.1707071244520.1871@nanos>
 <20170707105316.whutk3h6x2h6xvyt@e106622-lin> <4582085.aKtjXTl7qR@aspire.rjw.lan>
 <20170707175805.6bd8f34d@gandalf.local.home> <CAJWu+ord8UTQhQs0cThPejg-H+56j+7kH6ohaukwO2466_zg1g@mail.gmail.com>
 <20170707181549.5ca5cf31@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34405 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdGGW5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 18:57:30 -0400
Received: by mail-oi0-f46.google.com with SMTP id l130so39233520oib.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2017 15:57:30 -0700 (PDT)
In-Reply-To: <20170707181549.5ca5cf31@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Luca Abeni <luca.abeni@santannapisa.it>, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>Ingo Molnar <mi>

On Fri, Jul 7, 2017 at 3:15 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 7 Jul 2017 15:07:09 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>
>> > It is rather long. Although I actually hate the SUGOV, it is easily
>> > grepable. Just comment what it stands for. We can always change it
>> > later.
>>
>> I was thinking why not just SCHED_FLAG_CPUFREQ. That says its for
>> cpufreq purposes, and is a bit self-documenting. "WORKER" is a bit
>> redundant and can be dropped in my opinion.
>
> I was thinking that too, but was wondering how tightly coupled is this
> with SCHED_DEADLINE? I like the searchability of SUGOV, where as
> CPUFREQ is still quite broad.

Yes this is tightly coupled with DL so in that case probably a more
specific name is better as you mentioned.

thanks,

-Joel
