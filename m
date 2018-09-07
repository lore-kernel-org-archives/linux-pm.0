From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Date: Fri, 7 Sep 2018 09:24:23 +0100
Message-ID: <20180907082139.ogsdxambyryhgsu4@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
 <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
 <20180906092955.tq27mhzfkovo2ehn@queper01-lin>
 <e4e9d572-94ba-9d01-d18a-aa0ddd6fd357@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e4e9d572-94ba-9d01-d18a-aa0ddd6fd357@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 06 Sep 2018 at 16:49:47 (-0700), Dietmar Eggemann wrote:
> I would prefer a sched_feature. I guess it has to be disabled by default so
> that other systems don't have to check rcu_dereference(rd->pd) in the wakeup
> path.

Right, this is what I had in mind too. I guess downstream kernels can
always carry a patch that changes the default if they want it enabled
without messing around in userspace.

> But since at the beginning EAS will be the only user of the EM there is no
> need to change the static key sched_energy_present right now.

Indeed, I could add a patch introducing this sched_feat in the series
that migrates IPA to using the EM framework (to be posted later). It is
just not required until we have a new user.

However that IPA-related patchset would then change the default
behaviour for users who used to get EAS enabled automatically, but
wouldn't after updating their kernel (meaning they'd now have to flip
switches by hand whereas it used to "just work"). Not sure if that
qualifies as "breaking users" (cf. Linus' rule #1 of kernel
development) ...

Thanks,
Quentin
