From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/5] cpufreq: governors: Solve the ABBA lockups
Date: Tue, 2 Feb 2016 11:25:11 +0000
Message-ID: <20160202112511.GB3947@e106622-lin>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 02/02/16 16:27, Viresh Kumar wrote:
> Hi Rafael,
> 
> Sorry for doing this, I know you were also looking to fix this in a
> possibly different way. But I thought, it would be better if we fix
> that. We can scrap this version and take yours if that looks better.
> 
> The root cause of all the issues we were facing, was that we were taking
> policy->rwsem while accessing governor sysfs attributes. And that
> happened because we were sharing the show/store calls present in
> cpufreq.c.
> 
> I thought, perhaps the best way to fix it is to give separate sysfs-ops
> to governors. And that's what I did.
> 
> @Juri: I need your help in testing these. My platform doesn't give me
> those lockups (even without these patches) and Juno/Tc2 would fit
> better.
> 
> Can you please run some tests on these?
> 

Sure! Will do in the next few days.

Best,

- Juri

> They are pushed here for easy access (and auto test by build-bot):
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject
> 
> --
> viresh
> 
> Viresh Kumar (5):
>   cpufreq: governor: Kill declare_show_sampling_rate_min()
>   cpufreq: governor: Create separate sysfs-ops
>   cpufreq: governor: Remove unused sysfs attribute macros
>   cpufreq: Don't drop rwsem before calling CPUFREQ_GOV_POLICY_EXIT
>   cpufreq: Get rid of ->governor_enabled and its lock
> 
>  drivers/cpufreq/cpufreq.c              |  29 ----------
>  drivers/cpufreq/cpufreq_conservative.c |  77 ++++++++++---------------
>  drivers/cpufreq/cpufreq_governor.c     |  86 ++++++++++++++++++++--------
>  drivers/cpufreq/cpufreq_governor.h     | 101 +++++++--------------------------
>  drivers/cpufreq/cpufreq_ondemand.c     |  77 ++++++++++---------------
>  include/linux/cpufreq.h                |   5 --
>  6 files changed, 143 insertions(+), 232 deletions(-)
> 
> -- 
> 2.7.0.79.gdc08a19
> 
