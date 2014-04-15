From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCHC 0/3] sched/idle : find the idlest cpu with cpuidle info
Date: Tue, 15 Apr 2014 17:33:20 +0200
Message-ID: <2100495.CxRsoJUgjf@vostro.rjw.lan>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1930679.LtC4HPqI3x@vostro.rjw.lan> <20140415132510.GO11182@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140415132510.GO11182@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 15, 2014 03:25:10 PM Peter Zijlstra wrote:
> On Fri, Apr 04, 2014 at 01:43:00PM +0200, Rafael J. Wysocki wrote:
> > > That's what this patch series is about.  The find_idlest_cpu code should 
> > > look for the idle CPU with the shallowest idle state, or the one with 
> > > the smallest load.  In this context "find_idlest_cpu" might become a 
> > > misnomer.
> > 
> > Yes, clearly.  It should be called find_best_cpu or something like that.
> 
> Ha!, but for what purpose? We already have find_busiest_cpu() to find
> the CPU to steal work from. The converse action, currently called
> find_idlest_cpu() is finding the CPU where to put work.
> 
> 'Best' is ambiguous in all regards, it doesn't convey the direction nor
> the quality sorted on.
> 
> So while idlest might be somewhat of a misnomer, it at least conveys the
> directional thing fairly well. Also we are still searching the least
> busy, and preferable an idle, cpu. 'Idlest' being a superlative also
> conveys the meaning of order.

But 'idlest' can also be understood as 'deepest idle', which clearly is not the
intent.  Perhaps find_cpu_for_work() reflects what it does, but I'm not sure
if that's a good name either.

Rafael
