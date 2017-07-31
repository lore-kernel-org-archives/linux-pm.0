From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] cpufreq: Process remote callbacks from any CPU if
 the platform permits
Date: Mon, 31 Jul 2017 09:30:07 +0530
Message-ID: <20170731040007.GB4260@vireshk-i7>
References: <cover.1501223897.git.viresh.kumar@linaro.org>
 <c121a20eff05565155852c070e83504bf117da3e.1501223897.git.viresh.kumar@linaro.org>
 <CAJWu+ooWDUigT8zck1Q24oSLETf8mhSLj0-k+9RB32pzEDQPjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJWu+ooWDUigT8zck1Q24oSLETf8mhSLj0-k+9RB32pzEDQPjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <smuckle.linux@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, eas-dev@lists.linaro.org, Saravana Kannan <skannan@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-07-17, 20:43, Joel Fernandes wrote:
> On Thu, Jul 27, 2017 at 11:46 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On many platforms, CPUs can do DVFS across cpufreq policies. i.e CPU
> > from policy-A can change frequency of CPUs belonging to policy-B.
> >
> > This is quite common in case of ARM platforms where we don't
> > configure any per-cpu register.
> >
> > Add a flag to identify such platforms and update
> > cpufreq_can_do_remote_dvfs() to allow remote callbacks if this flag is
> > set.
> >
> > Also enable the flag for cpufreq-dt driver which is used only on ARM
> > platforms currently.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c |  1 +
> >  include/linux/cpufreq.h      | 18 ++++++++++++++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index fef3c2160691..d83ab94d041a 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -274,6 +274,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >                 transition_latency = CPUFREQ_ETERNAL;
> >
> >         policy->cpuinfo.transition_latency = transition_latency;
> > +       policy->dvfs_possible_from_any_cpu = true;
> >
> 
> Are there also ARM hardware that may not support it?

I don't think so. ARM never had any per-cpu register interface which may break
due to this.

> If yes, wouldn't
> a saner thing to do be to keep default as false and read the property
> from DT for hardware that does support it and then set to true?

I would do it if required, but for now I don't think there are any such users of
cpufreq-dt.

-- 
viresh
