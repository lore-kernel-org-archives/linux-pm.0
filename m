From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Fri, 7 Jul 2017 18:15:49 -0400
Message-ID: <20170707181549.5ca5cf31@gandalf.local.home>
References: <20170705085905.6558-1-juri.lelli@arm.com>
        <alpine.DEB.2.20.1707071244520.1871@nanos>
        <20170707105316.whutk3h6x2h6xvyt@e106622-lin>
        <4582085.aKtjXTl7qR@aspire.rjw.lan>
        <20170707175805.6bd8f34d@gandalf.local.home>
        <CAJWu+ord8UTQhQs0cThPejg-H+56j+7kH6ohaukwO2466_zg1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJWu+ord8UTQhQs0cThPejg-H+56j+7kH6ohaukwO2466_zg1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Luca Abeni <luca.abeni@santannapisa.it>, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>Ingo Molnar <mi>
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Jul 2017 15:07:09 -0700
Joel Fernandes <joelaf@google.com> wrote:


> > It is rather long. Although I actually hate the SUGOV, it is easily
> > grepable. Just comment what it stands for. We can always change it
> > later.  
> 
> I was thinking why not just SCHED_FLAG_CPUFREQ. That says its for
> cpufreq purposes, and is a bit self-documenting. "WORKER" is a bit
> redundant and can be dropped in my opinion.

I was thinking that too, but was wondering how tightly coupled is this
with SCHED_DEADLINE? I like the searchability of SUGOV, where as
CPUFREQ is still quite broad.

-- Steve
