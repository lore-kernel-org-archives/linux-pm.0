From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 39/46] sched/cpufreq_sched: use static key for cpu
 frequency selection
Date: Sat, 15 Aug 2015 14:40:59 +0200
Message-ID: <20150815124059.GF10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-40-git-send-email-morten.rasmussen@arm.com>
 <20150708151956.9112.52403@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150708151956.9112.52403@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 08, 2015 at 08:19:56AM -0700, Michael Turquette wrote:
> > @@ -254,6 +267,7 @@ static int cpufreq_sched_stop(struct cpufreq_policy *policy)
> >  {
> >         struct gov_data *gd = policy->governor_data;
> >  
> > +       clear_sched_energy_freq();
> 
> <paranoia>
> 
> These controls are exposed to userspace via cpufreq sysfs knobs. Should
> we use a struct static_key_deferred and static_key_slow_dec_deferred()
> instead? This helps avoid a possible attack vector for slowing down the
> system.
> 
> </paranoia>
> 
> I don't really know what a sane default rate limit would be in that case
> though.  Otherwise feel free to add:

Exposed through being able to change the policy, right? No other new
knobs, right?

IIRC the policy is only writable by root, in which case deferred isn't
really needed, root can kill the machine many other ways.
