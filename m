From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Thu, 15 Jun 2017 09:28:10 +0100
Message-ID: <20170615082810.mhdjklnshxt3azcb@e106622-lin>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com>
 <CAKfTPtDB=5mQnJfzES+iU-nmNjVDM48f_iKuc7WefkRVWW4JOQ@mail.gmail.com>
 <9716a48d-8198-a1d8-9450-de6386338665@arm.com>
 <CAKfTPtBnUWyAWTMJ2H8C+SPT+fVj-NkAs_pdOu+_a1zJ=VXZdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdFOI2Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Jun 2017 04:28:16 -0400
Content-Disposition: inline
In-Reply-To: <CAKfTPtBnUWyAWTMJ2H8C+SPT+fVj-NkAs_pdOu+_a1zJ=VXZdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LAK <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

Hi,

On 14/06/17 15:08, Vincent Guittot wrote:
> On 14 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > On 06/12/2017 04:27 PM, Vincent Guittot wrote:
> > > On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > Hi Vincent,
> >
> > Thanks for the review!
> >
> > [...]
> >
> > >> @@ -225,8 +265,14 @@ static int __init register_cpufreq_notifier(void)
> > >>
> > >>          cpumask_copy(cpus_to_visit, cpu_possible_mask);
> > >>
> > >> -       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
> > >> -                                        CPUFREQ_POLICY_NOTIFIER);
> > >> +       ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
> > >> +                                       CPUFREQ_POLICY_NOTIFIER);
> > >> +
> > >> +       if (ret)
> > >
> > > Don't you have to free memory allocated for cpus_to_visit in case of
> > > errot ? it was not done before your patch as well
> >
> > Yes, we should free cpus_to_visit if the policy notifier registration
> > fails. But IMHO also, once the parsing of the capacity-dmips-mhz property
> > is done. free cpus_to_visit is only used in the notifier call
> > init_cpu_capacity_callback() after being allocated and initialized in
> > register_cpufreq_notifier().
> >
> > We could add something like this as the first patch of this set. Only
> > mildly tested on Juno. Juri, what do you think?
> >
> > Author: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Date:   Tue Jun 13 23:21:59 2017 +0100
> >
> >     drivers base/arch_topology: free cpumask cpus_to_visit
> >
> >     Free cpumask cpus_to_visit in case registering
> >     init_cpu_capacity_notifier has failed or the parsing of the cpu
> >     capacity-dmips-mhz property is done. The cpumask cpus_to_visit is
> >     only used inside the notifier call init_cpu_capacity_callback.
> >
> >     Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> >     Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> your proposal for freeing cpus_to_visit looks good for me
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> 

Yep, looks good to me too. Thanks for fixing!

Best,

- Juri
