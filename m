From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v1 0/8] SCHED_DEADLINE freq/cpu invariance and OPP
 selection
Date: Thu, 6 Jul 2017 11:57:15 -0400
Message-ID: <20170706115715.6154d823@gandalf.local.home>
References: <20170705085905.6558-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705085905.6558-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed,  5 Jul 2017 09:58:57 +0100
Juri Lelli <juri.lelli@arm.com> wrote:

> Hi,
> 
> v1 of the RFC set implementing frequency/cpu invariance and OPP selection for

It would be nice if you specify what "OPP" stands for. A quick google
search shows "Other Peoples Privates", which isn't the type of
selection I would be looking for.

-- Steve


> SCHED_DEADLINE [1]. The set is based on tip/sched/core as of today
> (72298e5c92c5), which now already includes Luca's "CPU reclaiming for
> SCHED_DEADLINE".
>
