From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Wed, 15 Mar 2017 09:10:48 -0700
Message-ID: <20170315161048.GJ3637@linux.vnet.ibm.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <CAEi0qNkAK_3a_2x9BgvyEC+bFvckGFoQX1fjFba6boC1ws_R5w@mail.gmail.com>
 <20170315112020.GA18557@e110439-lin>
 <CAJWu+or4AJ6_J8XJicKDJReMP6Dj7t7SbB7k78ia8FdhDdXXoA@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJWu+or4AJ6_J8XJicKDJReMP6Dj7t7SbB7k78ia8FdhDdXXoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 15, 2017 at 06:20:28AM -0700, Joel Fernandes wrote:
> On Wed, Mar 15, 2017 at 4:20 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 13-Mar 03:46, Joel Fernandes (Google) wrote:
> >> On Tue, Feb 28, 2017 at 6:38 AM, Patrick Bellasi
> >> <patrick.bellasi@arm.com> wrote:
> >> > The CPU CGroup controller allows to assign a specified (maximum)
> >> > bandwidth to tasks within a group, however it does not enforce any
> >> > constraint on how such bandwidth can be consumed.
> >> > With the integration of schedutil, the scheduler has now the proper
> >> > information about a task to select  the most suitable frequency to
> >> > satisfy tasks needs.
> >> [..]
> >>
> >> > +static u64 cpu_capacity_min_read_u64(struct cgroup_subsys_state *css,
> >> > +                                    struct cftype *cft)
> >> > +{
> >> > +       struct task_group *tg;
> >> > +       u64 min_capacity;
> >> > +
> >> > +       rcu_read_lock();
> >> > +       tg = css_tg(css);
> >> > +       min_capacity = tg->cap_clamp[CAP_CLAMP_MIN];
> >>
> >> Shouldn't the cap_clamp be accessed with READ_ONCE (and WRITE_ONCE in
> >> the write path) to avoid load-tearing?
> >
> > tg->cap_clamp is an "unsigned int" and thus I would expect a single
> > memory access to write/read it, isn't it? I mean: I do not expect the
> > compiler "to mess" with these accesses.
> 
> This depends on compiler and arch. I'm not sure if its in practice
> these days an issue, but see section on 'load tearing' in
> Documentation/memory-barriers.txt . If compiler decided to break down
> the access to multiple accesses due to some reason, then might be a
> problem.

The compiler might also be able to inline cpu_capacity_min_read_u64()
fuse the load from tg->cap_clamp[CAP_CLAMP_MIN] with other accesses.
If min_capacity is used several times in the ensuing code, the compiler
could reload multiple times from tg->cap_clamp[CAP_CLAMP_MIN], which at
best might be a bit confusing.

> Adding Paul for his expert opinion on the matter ;)

My personal approach is to use READ_ONCE() and WRITE_ONCE() unless
I can absolutely prove that the compiler cannot do any destructive
optimizations.  And I not-infrequently find unsuspected opportunities
for destructive optimization in my own code.  Your mileage may vary.  ;-)

							Thanx, Paul
