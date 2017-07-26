From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Wed, 26 Jul 2017 19:26:38 +0200
Message-ID: <2367709.KiRkWci6fx@aspire.rjw.lan>
References: <cover.1499927699.git.viresh.kumar@linaro.org> <20170724134752.sejehwa5mjqqc2mq@hirez.programming.kicks-ass.net> <20170726062912.GA352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49989 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751413AbdGZRej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 13:34:39 -0400
In-Reply-To: <20170726062912.GA352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org

On Wednesday, July 26, 2017 11:59:12 AM Viresh Kumar wrote:
> On 24-07-17, 15:47, Peter Zijlstra wrote:
> > I said nothing about the shared locking. That is indeed required. All I
> > said is that those two tests you add could be left out.
> 
> I was right, I didn't understood your comment at all :(
> 
> > > > That would then continue to process the iowait and other accounting
> > > > stuff, but stall the moment we call into the actual driver, which will
> > > > then drop the request on the floor as per the first few hunks.
> > > 
> > > I am not sure I understood your comment completely though.
> > 
> > Since we call cpufreq_update_util(@rq, ...) with @rq->lock held, all
> > such calls are in fact serialized for that cpu.
> 
> Yes, they are serialized but ..
> 
> > Therefore the cpu !=
> > current_cpu test you add are pointless.
> 
> .. I didn't understand why you said so. This check isn't there to take
> care of serialization but remote callbacks.
> 
> > Only once we get to the actual cpufreq driver (intel_pstate and others)
> > do we run into the fact that we might not be able to service the request
> > remotely.
> 
> We never check for remote callbacks in drivers.
> 
> > But since you also add a test there, that is sufficient.
> 
> No.
> 
> The diff for intel-pstate that you saw in this patch was for the case
> where intel-pstate works directly with the scheduler (i.e. no
> schedutil governor). The routine that gets called with schedutil is
> intel_cpufreq_target(), which doesn't check for remoteness at all.

And of course acpi-cpufreq doesn't check for that too, for example.

Thanks,
Rafael
