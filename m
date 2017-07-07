From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Fri, 7 Jul 2017 12:46:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707071244520.1871@nanos>
References: <20170705085905.6558-1-juri.lelli@arm.com> <20170705085905.6558-4-juri.lelli@arm.com> <CAJWu+op-y5Q6Ginhxk7ntjTrZmNbJX8arMsqOrkxs34m7CukaA@mail.gmail.com> <20170707104341.vrx4gm2bgoaaixwf@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707104341.vrx4gm2bgoaaixwf@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Joel Fernandes <joelaf@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>, Rafael J .
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Jul 2017, Juri Lelli wrote:
> How about SCHED_FLAG_SUGOV then?

I know sugo della carne, but what's sugo V?

Thanks,

	tglx
