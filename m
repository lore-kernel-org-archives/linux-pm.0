From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in
 __cpufreq_governor
Date: Tue, 12 Jan 2016 15:50:25 +0530
Message-ID: <20160112102025.GC1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-12-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-12-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 17:35, Juri Lelli wrote:
> __cpufreq_governor works on policy, so policy->rwsem has to be held.
> Add assertion for such condition.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f1f9fbc..e7fc5c9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1950,6 +1950,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  	/* Don't start any governor operations if we are entering suspend */
>  	if (cpufreq_suspended)
>  		return 0;
> +
> +	lockdep_assert_held(&policy->rwsem);
> +

We had an ABBA problem with the EXIT governor callback and so this
rwsem is dropped just before that from set_policy()..

commit 955ef4833574 ("cpufreq: Drop rwsem lock around
CPUFREQ_GOV_POLICY_EXIT")

-- 
viresh
