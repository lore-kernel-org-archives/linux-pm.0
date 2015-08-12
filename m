From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 16/46] sched: Allocate and initialize energy data
 structures
Date: Wed, 12 Aug 2015 19:23:18 +0200
Message-ID: <20150812172318.GX16853@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-17-git-send-email-morten.rasmussen@arm.com>
 <20150812101721.GV19282@twins.programming.kicks-ass.net>
 <55CB7DE7.9060403@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55CB7DE7.9060403@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 12, 2015 at 06:09:59PM +0100, Dietmar Eggemann wrote:
> > One more question, if fn() returns a full structure, why are we
> > allocating and copying the thing? Its all const read only data, right?
> > 
> 
> Yeah, that's not strictly necessary. I could get rid of all the
> allocation/copying/ and freeing code and just simply set sd->groups->sge
> = fn(cpu) in init_sched_energy(). Plus delete the atomic_t ref in struct
> sched_group_energy.
> 
> In this case, should I still keep the check_sched_energy_data() function
> to verify that the scheduler got valid data via the struct
> sched_domain_topology_level table from the arch, i.e. to make sure that
> the per-cpu provided sd energy data is consistent for all cpus within
> the sched group cpumask?

Oh yes very much. We want sanity checking of the data handed.
