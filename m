From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Wed, 15 Mar 2017 17:57:00 +0000
Message-ID: <20170315175659.GH18557@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <CAEi0qNkAK_3a_2x9BgvyEC+bFvckGFoQX1fjFba6boC1ws_R5w@mail.gmail.com>
 <20170315112020.GA18557@e110439-lin>
 <CAJWu+or4AJ6_J8XJicKDJReMP6Dj7t7SbB7k78ia8FdhDdXXoA@mail.gmail.com>
 <20170315161048.GJ3637@linux.vnet.ibm.com>
 <20170315164439.GG18557@e110439-lin>
 <20170315172429.GK3637@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbdCOR5G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 13:57:06 -0400
Content-Disposition: inline
In-Reply-To: <20170315172429.GK3637@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>

On 15-Mar 10:24, Paul E. McKenney wrote:
> On Wed, Mar 15, 2017 at 04:44:39PM +0000, Patrick Bellasi wrote:
> > On 15-Mar 09:10, Paul E. McKenney wrote:
> > > On Wed, Mar 15, 2017 at 06:20:28AM -0700, Joel Fernandes wrote:
> > > > On Wed, Mar 15, 2017 at 4:20 AM, Patrick Bellasi
> > > > <patrick.bellasi@arm.com> wrote:
> > > > > On 13-Mar 03:46, Joel Fernandes (Google) wrote:
> > > > >> On Tue, Feb 28, 2017 at 6:38 AM, Patrick Bellasi
> > > > >> <patrick.bellasi@arm.com> wrote:
> > > > >> > The CPU CGroup controller allows to assign a specified (maximum)
> > > > >> > bandwidth to tasks within a group, however it does not enforce any
> > > > >> > constraint on how such bandwidth can be consumed.
> > > > >> > With the integration of schedutil, the scheduler has now the proper
> > > > >> > information about a task to select  the most suitable frequency to
> > > > >> > satisfy tasks needs.
> > > > >> [..]
> > > > >>
> > > > >> > +static u64 cpu_capacity_min_read_u64(struct cgroup_subsys_state *css,
> > > > >> > +                                    struct cftype *cft)
> > > > >> > +{
> > > > >> > +       struct task_group *tg;
> > > > >> > +       u64 min_capacity;
> > > > >> > +
> > > > >> > +       rcu_read_lock();
> > > > >> > +       tg = css_tg(css);
> > > > >> > +       min_capacity = tg->cap_clamp[CAP_CLAMP_MIN];
> > > > >>
> > > > >> Shouldn't the cap_clamp be accessed with READ_ONCE (and WRITE_ONCE in
> > > > >> the write path) to avoid load-tearing?
> > > > >
> > > > > tg->cap_clamp is an "unsigned int" and thus I would expect a single
> > > > > memory access to write/read it, isn't it? I mean: I do not expect the
> > > > > compiler "to mess" with these accesses.
> > > > 
> > > > This depends on compiler and arch. I'm not sure if its in practice
> > > > these days an issue, but see section on 'load tearing' in
> > > > Documentation/memory-barriers.txt . If compiler decided to break down
> > > > the access to multiple accesses due to some reason, then might be a
> > > > problem.
> > > 
> > > The compiler might also be able to inline cpu_capacity_min_read_u64()
> > > fuse the load from tg->cap_clamp[CAP_CLAMP_MIN] with other accesses.
> > > If min_capacity is used several times in the ensuing code, the compiler
> > > could reload multiple times from tg->cap_clamp[CAP_CLAMP_MIN], which at
> > > best might be a bit confusing.
> > 
> > That's actually an interesting case, however I don't think it applies
> > in this case since cpu_capacity_min_read_u64() is called only via
> > a function poninter and thus it will never be inlined. isn't it?
> > 
> > > > Adding Paul for his expert opinion on the matter ;)
> > > 
> > > My personal approach is to use READ_ONCE() and WRITE_ONCE() unless
> > > I can absolutely prove that the compiler cannot do any destructive
> > > optimizations.  And I not-infrequently find unsuspected opportunities
> > > for destructive optimization in my own code.  Your mileage may vary.  ;-)
> > 
> > I guess here the main concern from Joel is that such a pattern:
> > 
> >    u64 var = unsigned_int_value_from_memory;
> > 
> > can result is a couple of "load from memory" operations.
> 
> Indeed it can.  I first learned this the hard way in the early 1990s,
> so 20-year-old compiler optimizations are quite capable of making this
> sort of thing happen.
> 
> > In that case a similar:
> > 
> >   unsigned_int_left_value = new_unsigned_int_value;
> > 
> > executed on a different thread can overlap with the previous memory
> > read operations and ending up in "var" containing a not consistent
> > value.
> > 
> > Question is: can this really happen, given the data types in use?
> 
> So we have an updater changing the value of unsigned_int_left_value,
> while readers in other threads are accessing it, correct?  And you
> are asking whether the compiler can optimize the updater so as to
> mess up the readers, right?
> 
> One such optimization would be a byte-wise write, though I have no
> idea why a compiler would do such a thing assuming that the variable
> is reasonably sized and aligned.  Another is that the compiler could
> use the variable as temporary storage just before the assignment.
> (You haven't told the compiler that anyone else is reading it, though
> I don't know of this being done by production compilers.)  A third is
> that the compiler could fuse successive stores, which might or might
> not be a problem, depending.
> 
> Probably more, but that should be a start.  ;-)

Definitively yes! :)

Thanks for the detailed explanation, I'll add the READ_ONCE as
Joel suggested! +1

-- 
#include <best/regards.h>

Patrick Bellasi
