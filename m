From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
Date: Thu, 2 Aug 2018 18:07:49 +0200
Message-ID: <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
References: <20180724122521.22109-10-quentin.perret@arm.com>
 <20180802122629.GU2476@hirez.programming.kicks-ass.net> <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
 <20180802130801.GL2494@hirez.programming.kicks-ass.net> <20180802131849.mqpt5lbtcqrxbwig@queper01-lin>
 <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
 <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin> <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin> <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Aug 2018 at 18:00, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 02 Aug 2018 at 17:55:24 (+0200), Vincent Guittot wrote:
> > On Thu, 2 Aug 2018 at 17:30, Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > On Thursday 02 Aug 2018 at 17:14:15 (+0200), Vincent Guittot wrote:
> > > > On Thu, 2 Aug 2018 at 16:14, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > > Good point, setting the util_avg to 0 for new tasks should help
> > > > > filtering out those tiny tasks too. And that would match with the idea
> > > > > of letting tasks build their history before looking at their util_avg ...
> > > > >
> > > > > But there is one difference w.r.t frequency selection. The current code
> > > > > won't mark the system overutilized, but will let sugov raise the
> > > > > frequency when a new task is enqueued. So in case of a fork bomb, we
> > > >
> > > > If the initial value of util_avg is 0, we should not have any impact
> > > > on the util_avg of the cfs rq on which the task is attached, isn't it
> > > > ? so this should not impact both the over utilization state and the
> > > > frequency selected by sugov or I'm missing something ?
> > >
> > > What I tried to say is that setting util_avg to 0 for new tasks will
> > > prevent schedutil from raising the frequency in case of a fork bomb, and
> > > I think that could be an issue. And I think this isn't an issue with the
> > > patch as-is ...
> >
> > ok. So you also want to deal with fork bomb
> > Not sure that you don't have some problem with current proposal too
> > because select_task_rq_fair will always return prev_cpu because
> > util_avg and util_est are 0 at that time
>
> But find_idlest_cpu() should select a CPU using load in case of a forkee
> no ?

So you have to wait for the next tick that will set the overutilized
and disable the want_energy. Until this point, all new tasks will be
put on the current cpu

>
> Thanks,
> Quentin
