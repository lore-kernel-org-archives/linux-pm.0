From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Eas-dev] [PATCH V3 2/3] cpufreq: schedutil: Process remote
 callback for shared policies
Date: Thu, 20 Jul 2017 15:58:01 +0200
Message-ID: <20170720135801.qdqm5aypsxq45wrd@hirez.programming.kicks-ass.net>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org>
 <5968263D.1020801@codeaurora.org>
 <20170714050320.GJ352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936357AbdGTN6K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 09:58:10 -0400
Content-Disposition: inline
In-Reply-To: <20170714050320.GJ352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, sudeep.holla@arm.com

On Fri, Jul 14, 2017 at 10:33:20AM +0530, Viresh Kumar wrote:
> On 13-07-17, 19:02, Saravana Kannan wrote:
> > Honestly, this seems like such a chip/platform specific decision. There's no
> > reason that one can't have a chip where you can change the frequency of any
> > CPU from any other CPU. If there's such a limitation, we should let that be
> > handled at the CPU freq driver level instead of having to know about any of
> > that at the scheduler. Heck, at worst case, the CPU freq driver can send an
> > IPI and execute that work on the CPU of interest.
> > 
> > In all Qualcomm chipsets (well, at least the ones that have been used in
> > Android devices so far), we can switch the frequency of any CPU from any
> > other CPU. If we can do that even without fast switching, why wouldn't any
> > theoretical fast switching be incapable of supporting this?

I spoke with Sudeep since the last email; and the proposed interface
(SCMI) is a shmem/mailbox one, which can indeed change the frequency of
another CPU.

> > Is this a limitation specific to x86 that we are assuming all
> > architectures and platforms are going to have?

You are right in that x86 cannot do this. Sending IPIs is fairly
expensive though :/

> The default assumption in cpufreq core is that any CPU from a policy
> can change freq for that policy. Yes, we surely have cases where any
> CPU can change freq of any other CPU (even in different policies).
> Perhaps all ARM platforms are like that, not sure.
> 
> And so I added a special flag for that in my previous version, but the
> idea here is to get a simple solution merged first and then we can
> have a separate patch later to support freq switching from all CPUs.

I was going to write things about serialization here. How allowing remote
updates would require extra serialization, in part inspired by your
Changelog comment that says cpufreq-shared provides the required
serialization.

But I think that's all nonsense... That is, yes cpufreq-shared needs
additional serialization, but that's not relevant for the problem at
hand.

The thing is, all of this cpufreq_update_*() crud is called with the
relevant rq->lock held. So all those calls are already fully serialized
between CPUs.
