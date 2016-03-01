From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 1 Mar 2016 15:31:40 +0100
Message-ID: <20160301143140.GW6357@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <2385082.eyZDGGeAFk@vostro.rjw.lan>
 <56D1236A.3030301@linaro.org>
 <14036594.SVLbCmZIEY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54102 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbcCAObt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 09:31:49 -0500
Content-Disposition: inline
In-Reply-To: <14036594.SVLbCmZIEY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Sun, Feb 28, 2016 at 03:26:21AM +0100, Rafael J. Wysocki wrote:

> > > That said I'm unconvinced about the approach still.
> > > 
> > > Having more RT threads in a system that already is under RT pressure seems like
> > > a recipe for trouble.  Moreover, it's likely that those new RT threads will
> > > disturb the system's normal operation somehow even without the RT pressure and
> > > have you investigated that?
> > 
> > Sorry I'm not sure what you mean by disturb normal operation.
> 
> That would introduce a number of extra RT threads that would be woken up quite
> often and on a regular basis, so there would be some extra RT noise in the
> system, especially on systems with one CPU per cpufreq policy and many CPUs.
> 
> That's not present ATM and surely need not be completely transparent.

Having RT tasks should not be a problem. You can always set their
priority such that they do not interfere with an actual RT workload.

> > Generally speaking, increasing the capacity of a heavily loaded system
> > seems to me to be something that should run urgently, so that the system
> > can potentially get itself out of trouble and meet the workload's needs.
> > 
> > > Also having them per policy may be overkill and
> > > binding them to policy CPUs only is not necessary.
> > > 
> > > Overall, it looks like a dynamic pool of threads that may run on every CPU
> > > might be a better approach, but that would almost duplicate the workqueues
> > > subsystem, so is it really worth it?
> > > 
> > > And is the problem actually visible in practice?  I have no record of any reports
> > > mentioning it, although theoretically it's been there forever, so had it been
> > > real, someone would have noticed it and complained about it IMO.
> > 
> > While I don't have a test case drawn up to provide it seems like it'd be
> > easy to create one. More importantly the interactive governor in Android
> > uses this same kind of model, starting a frequency change thread and
> > making it RT. Android is particularly sensitive to latency in frequency
> > response. So that's likely one big reason why you're not hearing about
> > this issue - some folks have already worked around it.
> 
> OK, so Android is the reason. :-)
> 
> Fair enough.  I still think that care is needed here, though.

So I sort of see the point of having per-cpu RT kthread tasks to effect
the OPP change for CFS. And here I would indeed suggest just having a
task per cpu, moving tasks about is too complex and generates even more
noise.

But the problem of having RT tasks is that you should run RT tasks at
max OPP.

Now you can probably fudge things and not account these RT tasks to the
RT 'workload' since you know their characteristics etc.. But its going
to be ugly I suspect.
