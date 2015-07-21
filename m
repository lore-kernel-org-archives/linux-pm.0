From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 27/46] sched, cpuidle: Track cpuidle state index in
 the scheduler
Date: Tue, 21 Jul 2015 16:16:19 +0100
Message-ID: <20150721151618.GC15088@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-28-git-send-email-morten.rasmussen@arm.com>
 <20150721064110.GA21501@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150721064110.GA21501@leoy-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Leo Yan,

On Tue, Jul 21, 2015 at 02:41:10PM +0800, Leo Yan wrote:
> Hi Morten,
> 
> On Tue, Jul 07, 2015 at 07:24:10PM +0100, Morten Rasmussen wrote:
> > The idle-state of each cpu is currently pointed to by rq->idle_state but
> > there isn't any information in the struct cpuidle_state that can used to
> > look up the idle-state energy model data stored in struct
> > sched_group_energy. For this purpose is necessary to store the idle
> > state index as well. Ideally, the idle-state data should be unified.
> > 
> > cc: Ingo Molnar <mingo@redhat.com>
> > cc: Peter Zijlstra <peterz@infradead.org>
> > 
> > Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> 
> This patch should re-base with latest kernel; otherwise it will have
> conflict with below commits:
> 
> 827a5ae sched / idle: Call default_idle_call() from cpuidle_enter_state()
> faad384 sched / idle: Call idle_set_state() from cpuidle_enter_state()
> bcf6ad8 sched / idle: Eliminate the "reflect" check from cpuidle_idle_call()
> 82f6632 sched / idle: Move the default idle call code to a separate function

I will make sure to rebase the patches and hopefully make an updated
branch available for those who want test the patches.

Thanks,
Morten
