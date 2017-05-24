From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 0/8] SCHED_DEADLINE freq/cpu invariance and OPP
 selection
Date: Wed, 24 May 2017 13:31:58 +0200
Message-ID: <20170524113158.qoa3tagiyvtxkd7v@hirez.programming.kicks-ass.net>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523202321.3bygt6ydyiy5xief@hirez.programming.kicks-ass.net>
 <20170524092505.ipsdp2r4btsxxhn3@e106622-lin>
 <20170524094111.irvopsw3aszghry6@hirez.programming.kicks-ass.net>
 <20170524095053.sp6hy4erpyktcmoi@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170524095053.sp6hy4erpyktcmoi@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, May 24, 2017 at 10:50:53AM +0100, Juri Lelli wrote:

> Agreed. However, problem seems to be that
> 
>  - in my opinion (current implementation) this translated into scaling
>    runtime considering current freq and cpu-max-capacity; and this is
>    required when frequency scaling is enabled and we still want to meet
>    a task's guaranteed bandwidth

Just so. The bandwidth they request is based on instructions/work. We
need to get a certain amount of instructions sorted. Nobody cares we get
an exact 10% at random frequency if they loose they finger because we
didn't get that final instruction out that stops the saw blade.

>  - Luca seemed instead to be inclined to say that, if we scale runtime
>    for !reclaim tasks, such tasks are basically allowed to run for more
>    time (when frequency is lower than max) by using some of the
>    bandwidth not allocated to themselves

Yes, that's a wrong view :-) We don't care about 'time', we care about
getting the instruction stream / work completed.
