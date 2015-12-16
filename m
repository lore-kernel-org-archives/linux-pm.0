From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Wed, 16 Dec 2015 09:28:03 +0000
Message-ID: <20151216092803.GL16007@e106622-lin>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214165128.GU6357@twins.programming.kicks-ass.net>
 <20151214223113.5732201a@luca-1225C>
 <20151215123859.GC6357@twins.programming.kicks-ass.net>
 <567015DF.6090206@unitn.it>
 <20151215134229.GH6357@twins.programming.kicks-ass.net>
 <20151215222424.32f4de89@luca-1225C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54031 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbbLPJ2E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Dec 2015 04:28:04 -0500
Content-Disposition: inline
In-Reply-To: <20151215222424.32f4de89@luca-1225C>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luca Abeni <luca.abeni@unitn.it>
Cc: Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Luca,

On 15/12/15 22:24, Luca Abeni wrote:
> On Tue, 15 Dec 2015 14:42:29 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Dec 15, 2015 at 02:30:07PM +0100, Luca Abeni wrote:
> > 
> > > >So I remember something else from the BFQ code, which also had to
> > > >track entries for the 0-lag stuff, and I just had a quick peek at
> > > >that code again. And what they appear to do is keep inactive
> > > >entries with a lag deficit in a separate tree (the idle tree).
> > > >
> > > >And every time they update the vtime, they also push fwd the idle
> > > >tree and expire entries on that.
> > > I am not sure if I understand correctly the idea (I do not know the
> > > BFQ code; I'll have a look), but I think I tried something similar:
> > > - When a task blocks, instead of arming the inactive timer I can
> > > insert the task in an "active non contending" tree (to use GRUB
> > > terminology)
> > > - So, when some sched deadline function is invoked, I check the
> > > "0-lag time" of the first task in the "active non contending" tree,
> > > and if that time is passed I remove the task from the tree and
> > > adjust the active utilisation
> > > 
> > > The resulting code ended up being more complex (basically, I needed
> > > to handle the "active non contending" tree and to check it in
> > > task_tick_dl() and update_curr_dl()). But maybe I did it wrong...
> > > I'll try this approach again, after looking ad the BFQ code.
> > 
> > That sounds about right.
> > 
> > I've no idea if its more or less work. I just had vague memories on an
> > alternative approach to the timer.
> > 
> > Feel free to stick with the timer if that works better, just wanted to
> > mention there are indeed alternative solutions.
> Ok; I'll try to implement this alternative approach again, after
> looking at BFQ, to see if it turns out to be simpler or more complex
> than the timer-based approach.
> 
> If there is interest, I'll send an RFC with these patches after some
> testing.
> 

I think there's definitely interest, as next step will be to start using
the new API for freq selection from DL as well.

Thanks a lot for your time and efforts!

Best,

- Juri
