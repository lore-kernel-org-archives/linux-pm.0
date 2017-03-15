From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Wed, 15 Mar 2017 11:20:20 +0000
Message-ID: <20170315112020.GA18557@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <CAEi0qNkAK_3a_2x9BgvyEC+bFvckGFoQX1fjFba6boC1ws_R5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEi0qNkAK_3a_2x9BgvyEC+bFvckGFoQX1fjFba6boC1ws_R5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 13-Mar 03:46, Joel Fernandes (Google) wrote:
> On Tue, Feb 28, 2017 at 6:38 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > The CPU CGroup controller allows to assign a specified (maximum)
> > bandwidth to tasks within a group, however it does not enforce any
> > constraint on how such bandwidth can be consumed.
> > With the integration of schedutil, the scheduler has now the proper
> > information about a task to select  the most suitable frequency to
> > satisfy tasks needs.
> [..]
> 
> > +static u64 cpu_capacity_min_read_u64(struct cgroup_subsys_state *css,
> > +                                    struct cftype *cft)
> > +{
> > +       struct task_group *tg;
> > +       u64 min_capacity;
> > +
> > +       rcu_read_lock();
> > +       tg = css_tg(css);
> > +       min_capacity = tg->cap_clamp[CAP_CLAMP_MIN];
> 
> Shouldn't the cap_clamp be accessed with READ_ONCE (and WRITE_ONCE in
> the write path) to avoid load-tearing?

tg->cap_clamp is an "unsigned int" and thus I would expect a single
memory access to write/read it, isn't it? I mean: I do not expect the
compiler "to mess" with these accesses.

However, if your concerns are more about overlapping read/write for the
same capacity from different threads, then perhaps we should better
use a mutex to serialize these two functions... not entirely convinced...

> Thanks,
> Joel

-- 
#include <best/regards.h>

Patrick Bellasi
