From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Mon, 14 Nov 2016 10:22:52 +0100
Message-ID: <20161114092252.GT3117@twins.programming.kicks-ass.net>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it>
 <20161111143935.GK3117@twins.programming.kicks-ass.net>
 <CAKohponr4=8Bf9C1=_YEhsvDXm0t2vXyGOnrrEr6HaMKzVOcnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponr4=8Bf9C1=_YEhsvDXm0t2vXyGOnrrEr6HaMKzVOcnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Nov 12, 2016 at 10:52:35AM +0530, Viresh Kumar wrote:
> On 11 November 2016 at 20:09, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Nov 11, 2016 at 03:32:04PM +0100, Tommaso Cucinotta wrote:
> >> >+    struct sched_param param = { .sched_priority = 50 };
> >>
> >> won't you have a tunable here? (sysctl?)
> >
> > You can use the regular userspace tools, like schedtool and chrt to set
> > priorities.
> 
> I wanted to get some help from you on this Peter. The out of tree Interactive
> governor has always used MAX_RT_PRIORITY - 1 here instead of 50.
> 
> But Steve started with 50. What do you think should the value be ?

Any static prio value is wrong (static prio assignment requires system
knowledge that the kernel doesn't and cannot have), 50 is what threaded
IRQs default too as well IIRC, so it would at least be consistent with
that.
