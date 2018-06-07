From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Thu, 7 Jun 2018 18:26:36 +0100
Message-ID: <20180607172635.GC3597@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180607144422.GA17216@localhost.localdomain>
 <20180607160200.GB3597@e108498-lin.cambridge.arm.com>
 <20180607162910.GE3311@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607162910.GE3311@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 Jun 2018 at 18:29:10 (+0200), Juri Lelli wrote:
> On 07/06/18 17:02, Quentin Perret wrote:
> > On Thursday 07 Jun 2018 at 16:44:22 (+0200), Juri Lelli wrote:
> > > Not sure about this. How about multi-freq domain same max capacity
> > > systems. I understand that most of the energy saving come from selecting
> > > the right (big/LITTLE) cluster, but EM should still be useful to drive
> > > OPP selection (that was one of the use-cases we discussed lately IIRC)
> > > and also to decide between packing or spreading, no?
> > 
> > So, let's discuss the usage of the EM for frequency selection first,
> > and its usage for task placement after.
> > 
> > For frequency selection, schedutil could definitely use the EM as
> > provided by the framework introduced in patch 03/10. We could definitely
> > use that to make policy decisions (jump faster to the so called "knee"
> > if there is one for ex). This is true for symmetric and asymmetric
> > system. And I consider that independent from this patch. This patch is
> > about providing the scheduler with an EM to biais _task placement_.
> > 
> > So, about the task placement ... There are cases (at least theoretical
> > ones) where EAS _could_ help on symmetric systems, but I have never
> > been able to measure any real benefits in practice. Most of the time,
> > it's a good idea from an energy standpoint to just spread the tasks
> > and to keep the OPPs as low as possible on symmetric systems, which is
> > already what CFS does. Of course you can come-up with specific counter
> > examples, but the question is whether or not these (corner) cases are
> > that important. They might or might not, it's not so easy to tell.
> > 
> > On asymmetric systems, it is pretty clear that there is a massive
> > potential for saving energy with a different task placement strategy.
> > So, since the big savings are there, our idea was basically to address
> > that first, while we minimize the risk of hurting others (server folks
> > for ex). I guess that enabling EAS for asymmetric systems can be seen as
> > an incremental step. We should be able to extend the scope of EAS to
> > symmetric systems later, if proven useful.
> > 
> > Another thing is that, if you are using an asymmetric system (e.g.
> > big.LITTLE), it is a good indication that energy/battery life is probably
> > important for your use-case, and that you might be ready to "pay" the
> > cost of EAS to save energy. This isn't that obvious for symmetric
> > systems.
> 
> Ok, I buy the step by step approach starting from the use case that
> seems to fit most. But I still feel that having something like 3. stated
> (or in the code) might stop people from trying to see if having an EM
> around might help other cases (freq, sym, etc.).

Ok, I see what you mean. What I should make more clear is that this
patch-set really is split in two relatively independent parts. Patches
01 to 04 introduce a centralized EM framework, which doesn't depend on
the scheduler, or thermal, or schedutil, or anything. It's an
independent thing. And then you can see patches 05 to 10 as _one
possible use-case_ for this framework: EAS.

I'm not convinced that patches 01-04 can leave on their own though. I
assume it must pretty hard to understand how this whole framework can be
used if there isn't an example of user with it ...


> Also, if no EM data is present should equally result in disabling the
> whole thing, so not much (at all?) overhead for who is simply not
> providing data, no?

Right, but some users might want to have an EM without EAS I guess ...
Otherwise, the other solution would be to have a new knob (a sched_feat
for ex ?) to let users disable EAS if they're not interested in saving
energy.

Thanks,
Quentin
