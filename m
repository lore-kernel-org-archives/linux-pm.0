From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC/RFT][PATCH 1/1] cpufreq: New governor using utilization
 data from the scheduler
Date: Thu, 25 Feb 2016 11:01:20 +0000
Message-ID: <20160225110120.GF3680@pablo>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
 <2004800.S71i79juRi@vostro.rjw.lan>
 <20160222141639.GF27380@e106622-lin>
 <CAJZ5v0j7jScr8TStyVHPDgd5qHaFDzUO3KnfxtEoYjrfc8gOQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j7jScr8TStyVHPDgd5qHaFDzUO3KnfxtEoYjrfc8gOQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23/02/16 00:02, Rafael J. Wysocki wrote:
> On Mon, Feb 22, 2016 at 3:16 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> > Hi Rafael,
> 
> Hi,
> 

Sorry, my reply to this got delayed a bit.

> > thanks for this RFC. I'm going to test it more in the next few days, but
> > I already have some questions from skimming through it. Please find them
> > inline below.
> >
> > On 22/02/16 00:18, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Add a new cpufreq scaling governor, called "schedutil", that uses
> >> scheduler-provided CPU utilization information as input for making
> >> its decisions.
> >>
> >
> > I guess the first (macro) question is why did you decide to go with a
> > complete new governor, where new here is w.r.t. the sched-freq solution.
> 
> Probably the most comprehensive answer to this question is my intro
> message: http://marc.info/?l=linux-pm&m=145609673008122&w=2
> 
> The executive summary is probably that this was the most
> straightforward way to use the scheduler-provided numbers in cpufreq
> that I could think about.
> 
> > AFAICT, it is true that your solution directly builds on top of the
> > latest changes to cpufreq core and governor, but it also seems to have
> > more than a few points in common with sched-freq,
> 
> That surely isn't a drawback, is it?
> 

Not at all. I guess that I was simply wondering why you felt that a new
approach was required. But you explain this below. :-)

> If two people come to the same conclusions in different ways, that's
> an indication that the conclusions may actually be correct.
> 
> > and sched-freq has been discussed and evaluated for already quite some time.
> 
> Yes, it has.
> 
> Does this mean that no one is allowed to try any alternatives to it now?
>

Of course not. I'm mostly inline with what Steve replied here. But yes,
I think that we can only gain better understanding by reviewing both
RFCs.

> > Also, it appears to me that they both shares (or they might encounter in the
> > future as development progresses) the same kind of problems, like for
> > example the fact that we can't trigger opp changes from scheduler
> > context ATM.
> 
> "Give them a finger and they will ask for the hand."
> 

I'm sorry if you felt that I was asking too much from an RFC. I wasn't
in fact, what I wanted to say is that the two alternatives seemed to
share the same kind of problems. Well, now it seems that you have
already proposed a solution for one of them. :-)

> If you read my intro message linked above, you'll find a paragraph or
> two about that in it.
> 
> And the short summary is that I have a plan to actually implement that
> feature in the schedutil governor at least for the ACPI cpufreq
> driver.  It shouldn't be too difficult to do either AFAICS.  So it is
> not "we can't", but rather "we haven't implemented that yet" in this
> particular case.
> 
> I may not be able to do that in the next few days, as I have other
> things to do too, but you may expect to see that done at one point.
> 
> So it's not a fundamental issue or anything, it's just that I haven't
> done that *yet* at this point, OK?
> 

Sure. I saw what you are proposing to solve this. I'll reply to that
patch if I'll have any comments.

> > Don't get me wrong. I think that looking at different ways to solve a
> > problem is always beneficial, since I guess that the goal in the end is
> > to come up with something that suits everybody's needs.
> 
> Precisely.
> 
> > I was only curious about your thoughts on sched-freq. But we can also wait for the
> > next RFC from Steve for this macro question. :-)
> 
> Right, but I have some thoughts anyway.
> 
> My goal, that may be quite different from yours, is to reduce the
> cpufreq's overhead as much as I possibly can.  If I have to change the
> way it drives the CPU frequency selection to achieve that goal, I will
> do that, but if that can stay the way it is, that's fine too.
> 

As Steve already said, this was not our primary goal. But it is for sure
beneficail for everybody.

> Some progress has been made already here: we have dealt with the
> timers for good now I think.
> 
> This patch deals with the overhead associated with the load tracking
> carried by "traditional" cpufreq governors and with a couple of
> questionable things done by "ondemand" in addition to that (which is
> one of the reasons why I didn't want to modify "ondemand" itself for
> now).
> 
> The next step will be to teach the governor and the ACPI driver to
> switch CPU frequencies in the scheduler context, without spawning
> extra work items etc.
> 
> Finally, the sampling should go away and that's where I want it to be.
> 
> I just don't want to run extra code when that's not necessary and I
> want things to stay simple when that's as good as it can get.  If
> sched-freq can pull that off for me, that's fine, but can it really?
> 
> > [...]
> >
> >> +static void sugov_update_commit(struct policy_dbs_info *policy_dbs, u64 time,
> >> +                             unsigned int next_freq)
> >> +{
> >> +     struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
> >> +
> >> +     sg_policy->next_freq = next_freq;
> >> +     policy_dbs->last_sample_time = time;
> >> +     policy_dbs->work_in_progress = true;
> >> +     irq_work_queue(&policy_dbs->irq_work);
> >
> > Here we basically use the system wq to be able to do the freq transition
> > in process context. CFS is probably fine with this, but don't you think
> > we might get into troubles when, in the future, we will want to service
> > RT/DL requests more properly and they will end up being serviced
> > together with all the others wq users and at !RT priority?
> 
> That may be regarded as a problem, but I'm not sure why you're talking
> about it in the context of this particular patch.  That problem has
> been there forever in cpufreq: in theory RT tasks may stall frequency
> changes indefinitely.
> 
> Is the problem real, though?
> 
> Suppose that that actually happens and there are RT tasks effectively
> stalling frequency updates.  In that case some other important
> activities of the kernel would be stalled too.  Pretty much everything
> run out of regular workqueues would be affected.
> 
> OK, so do we need to address that somehow?  Maybe, but then we should
> take care of all of the potentially affected stuff and not about the
> frequency changes only, shouldn't we?
> 

Ideally yes I'd say. But since we are at it with what reagrds frequency
changes, I thought we could spend some more time understading if we can
achieve something that is better that what we have today.

> Moreover, I don't really think that having a separate RT process for
> every CPU in the system just for this purpose is the right approach.
> It's just way overkill IMO and doesn't cover the other potentially
> affected stuff at all.
> 
> >> +}
> >> +
> >> +static void sugov_update_shared(struct update_util_data *data, u64 time,
> >> +                             unsigned long util, unsigned long max)
> >> +{
> >
> > We don't have a way to tell from which scheduling class this is coming
> > from, do we? And if that is true can't a request from CFS overwrite
> > RT/DL go to max requests?
> 
> Yes, it can, but we get updated when the CPU is updating its own rq
> only, so if my understanding of things is correct, an update from a
> different sched class means that the given class is in charge now.
> 

That is right. But, can't an higher priority class eat all the needed
capacity. I mean, suppose that both CFS and DL need 30% of CPU capacity
on the same CPU. DL wins and gets its 30% of capacity. When CFS gets to
run it's too late for requesting anything more (w.r.t. the same time
window). If we somehow aggregate requests instead, we could request 60%
and both classes can have their capacity to run. It seems to me that
this is what governors were already doing by using the 1 - idle metric.

Best,

- Juri
