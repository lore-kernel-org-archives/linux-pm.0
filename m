From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH 1/1] cpufreq: New governor using utilization data from the scheduler
Date: Fri, 26 Feb 2016 03:36:56 +0100
Message-ID: <1770063.xTkquAS3z6@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <CAJZ5v0j7jScr8TStyVHPDgd5qHaFDzUO3KnfxtEoYjrfc8gOQA@mail.gmail.com> <20160225110120.GF3680@pablo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59198 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751495AbcBZCf0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 21:35:26 -0500
In-Reply-To: <20160225110120.GF3680@pablo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Thursday, February 25, 2016 11:01:20 AM Juri Lelli wrote:
> On 23/02/16 00:02, Rafael J. Wysocki wrote:
> > On Mon, Feb 22, 2016 at 3:16 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> > > Hi Rafael,
> > 
> > Hi,
> > 
> 
> Sorry, my reply to this got delayed a bit.

No problem at all.

> > > thanks for this RFC. I'm going to test it more in the next few days, but
> > > I already have some questions from skimming through it. Please find them
> > > inline below.
> > >
> > > On 22/02/16 00:18, Rafael J. Wysocki wrote:
> > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>
> > >> Add a new cpufreq scaling governor, called "schedutil", that uses
> > >> scheduler-provided CPU utilization information as input for making
> > >> its decisions.
> > >>
> > >
> > > I guess the first (macro) question is why did you decide to go with a
> > > complete new governor, where new here is w.r.t. the sched-freq solution.
> > 
> > Probably the most comprehensive answer to this question is my intro
> > message: http://marc.info/?l=linux-pm&m=145609673008122&w=2
> > 
> > The executive summary is probably that this was the most
> > straightforward way to use the scheduler-provided numbers in cpufreq
> > that I could think about.
> > 
> > > AFAICT, it is true that your solution directly builds on top of the
> > > latest changes to cpufreq core and governor, but it also seems to have
> > > more than a few points in common with sched-freq,
> > 
> > That surely isn't a drawback, is it?
> > 
> 
> Not at all. I guess that I was simply wondering why you felt that a new
> approach was required. But you explain this below. :-)
> 
> > If two people come to the same conclusions in different ways, that's
> > an indication that the conclusions may actually be correct.
> > 
> > > and sched-freq has been discussed and evaluated for already quite some time.
> > 
> > Yes, it has.
> > 
> > Does this mean that no one is allowed to try any alternatives to it now?
> >
> 
> Of course not. I'm mostly inline with what Steve replied here. But yes,
> I think that we can only gain better understanding by reviewing both
> RFCs.
> 
> > > Also, it appears to me that they both shares (or they might encounter in the
> > > future as development progresses) the same kind of problems, like for
> > > example the fact that we can't trigger opp changes from scheduler
> > > context ATM.
> > 
> > "Give them a finger and they will ask for the hand."
> > 
> 
> I'm sorry if you felt that I was asking too much from an RFC. I wasn't
> in fact, what I wanted to say is that the two alternatives seemed to
> share the same kind of problems. Well, now it seems that you have
> already proposed a solution for one of them. :-)

That actually was a missing piece that I had planned to add from the outset, but
then decided to keep it simple to start with and omit that part until I can
clean up the ACPI driver enough to make it fit the whole picture more naturally.

I still want to do that which is mostly why I'm regarding that patch as a
prototype.

> > If you read my intro message linked above, you'll find a paragraph or
> > two about that in it.
> > 
> > And the short summary is that I have a plan to actually implement that
> > feature in the schedutil governor at least for the ACPI cpufreq
> > driver.  It shouldn't be too difficult to do either AFAICS.  So it is
> > not "we can't", but rather "we haven't implemented that yet" in this
> > particular case.
> > 
> > I may not be able to do that in the next few days, as I have other
> > things to do too, but you may expect to see that done at one point.
> > 
> > So it's not a fundamental issue or anything, it's just that I haven't
> > done that *yet* at this point, OK?
> > 
> 
> Sure. I saw what you are proposing to solve this. I'll reply to that
> patch if I'll have any comments.
> 
> > > Don't get me wrong. I think that looking at different ways to solve a
> > > problem is always beneficial, since I guess that the goal in the end is
> > > to come up with something that suits everybody's needs.
> > 
> > Precisely.
> > 
> > > I was only curious about your thoughts on sched-freq. But we can also wait for the
> > > next RFC from Steve for this macro question. :-)
> > 
> > Right, but I have some thoughts anyway.
> > 
> > My goal, that may be quite different from yours, is to reduce the
> > cpufreq's overhead as much as I possibly can.  If I have to change the
> > way it drives the CPU frequency selection to achieve that goal, I will
> > do that, but if that can stay the way it is, that's fine too.
> > 
> 
> As Steve already said, this was not our primary goal. But it is for sure
> beneficail for everybody.
> 
> > Some progress has been made already here: we have dealt with the
> > timers for good now I think.
> > 
> > This patch deals with the overhead associated with the load tracking
> > carried by "traditional" cpufreq governors and with a couple of
> > questionable things done by "ondemand" in addition to that (which is
> > one of the reasons why I didn't want to modify "ondemand" itself for
> > now).
> > 
> > The next step will be to teach the governor and the ACPI driver to
> > switch CPU frequencies in the scheduler context, without spawning
> > extra work items etc.
> > 
> > Finally, the sampling should go away and that's where I want it to be.
> > 
> > I just don't want to run extra code when that's not necessary and I
> > want things to stay simple when that's as good as it can get.  If
> > sched-freq can pull that off for me, that's fine, but can it really?
> > 
> > > [...]
> > >
> > >> +static void sugov_update_commit(struct policy_dbs_info *policy_dbs, u64 time,
> > >> +                             unsigned int next_freq)
> > >> +{
> > >> +     struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
> > >> +
> > >> +     sg_policy->next_freq = next_freq;
> > >> +     policy_dbs->last_sample_time = time;
> > >> +     policy_dbs->work_in_progress = true;
> > >> +     irq_work_queue(&policy_dbs->irq_work);
> > >
> > > Here we basically use the system wq to be able to do the freq transition
> > > in process context. CFS is probably fine with this, but don't you think
> > > we might get into troubles when, in the future, we will want to service
> > > RT/DL requests more properly and they will end up being serviced
> > > together with all the others wq users and at !RT priority?
> > 
> > That may be regarded as a problem, but I'm not sure why you're talking
> > about it in the context of this particular patch.  That problem has
> > been there forever in cpufreq: in theory RT tasks may stall frequency
> > changes indefinitely.
> > 
> > Is the problem real, though?
> > 
> > Suppose that that actually happens and there are RT tasks effectively
> > stalling frequency updates.  In that case some other important
> > activities of the kernel would be stalled too.  Pretty much everything
> > run out of regular workqueues would be affected.
> > 
> > OK, so do we need to address that somehow?  Maybe, but then we should
> > take care of all of the potentially affected stuff and not about the
> > frequency changes only, shouldn't we?
> > 
> 
> Ideally yes I'd say. But since we are at it with what reagrds frequency
> changes, I thought we could spend some more time understading if we can
> achieve something that is better that what we have today.

That's a worthy goal in general, but the approach with using dedicated RT
threads is not my favourite to be honest.

One problem with it I can see is that if things are starverd by RT threads
already, adding more RT threads to the mix will only add to the starvation
of the *other* stuff which may need to make progress too for the system
to stay generally usable.

Plus I'm not sure how it prevents starvation that may be caused by FIFO RT
things from happening.

Having those threads per policy (and bound to the policy CPUs) is also rather
wasteful, because it is not even necessary to invoke __cpufreq_driver_target()
from one of the policy CPUs.  Drivers should just do the right thing if that's
not the case as the "old" governors don't guarantee that anyway. So maybe
something like a pool of threads that may run on any available CPU would work,
but that's so similar to the workqueue subsystem design that I'm not sure if
duplicating it is really a good idea. 

Quite honestly, the only way to avoid this problem in frequency scaling
I can see today is to do the switching of frequencies from the scheduler,
but there are systems where that's clearly impossible.  Tough one. :-)

> > Moreover, I don't really think that having a separate RT process for
> > every CPU in the system just for this purpose is the right approach.
> > It's just way overkill IMO and doesn't cover the other potentially
> > affected stuff at all.
> > 
> > >> +}
> > >> +
> > >> +static void sugov_update_shared(struct update_util_data *data, u64 time,
> > >> +                             unsigned long util, unsigned long max)
> > >> +{
> > >
> > > We don't have a way to tell from which scheduling class this is coming
> > > from, do we? And if that is true can't a request from CFS overwrite
> > > RT/DL go to max requests?
> > 
> > Yes, it can, but we get updated when the CPU is updating its own rq
> > only, so if my understanding of things is correct, an update from a
> > different sched class means that the given class is in charge now.
> > 
> 
> That is right. But, can't an higher priority class eat all the needed
> capacity. I mean, suppose that both CFS and DL need 30% of CPU capacity
> on the same CPU. DL wins and gets its 30% of capacity. When CFS gets to
> run it's too late for requesting anything more (w.r.t. the same time
> window). If we somehow aggregate requests instead, we could request 60%
> and both classes can have their capacity to run. It seems to me that
> this is what governors were already doing by using the 1 - idle metric.

That's interesting, because it is about a few different things at a time. :-)

So first of all the "old" governors only collect information about what
happened in the past and make decisions on that basis (kind of in the hope
that what happened once will happen again), while the idea behind what
you're describing seems to be to attempt to project future needs for
capacity and use that to make decisions (just for the very near future,
but that should be sufficient).  If successful, that would be the most
suitable approach IMO.

Of course, the $subject patch is not aspiring to anything of that kind.
It only uses information about current needs that's already available to
it in a very straightforward way.

But there's more to it.  In the sampling, or rate-limiting if you will,
situation you really have a window in which many things can happen and
making a good decision at the beginning of it is important.  However, if
you just can handle *every* request and really switch frequencies on the
fly, then each of them may come with a "currently needed capacity" number
and you can just give it what it asks for every time.

My point is that there are quite a few things to consider here and I'm
expecting a learning process to happen before we are happy with what we
have.  So my approach would be (and is) to start very simple and then
add more complexity over time as needed instead of just trying to address
every issue I can think about from the outset.

Thanks,
Rafael

