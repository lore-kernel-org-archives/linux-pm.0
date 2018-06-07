From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][RFC] sched: cpufreq: Fix long idle judgement logic in
 load calculation
Date: Thu, 7 Jun 2018 10:15:43 +0530
Message-ID: <20180607044543.d7pswad5tshw26lc@vireshk-i7>
References: <1528341454-16991-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528341454-16991-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Artem S Tashkinov <t.artem@mailcity.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07-06-18, 11:17, Chen Yu wrote:
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 871bf9c..9792c80 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  			 * calls, so the previous load value can be used then.
>  			 */
>  			load = j_cdbs->prev_load;
> -		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
> +		} else if (((int)idle_time > 0) && unlikely(idle_time > 2 * sampling_rate &&

Yes the figures are insane, but if the idle time is around 36 minutes, the
conversion to int will make a positive value look negative and we will exit the
conditional block. And if we don't think that we will ever get such insane idle
times or we don't want to care about them, then what about doing this instead:

		} else if ((unlikely((int)idle_time > 2 * sampling_rate &&

same below.

-- 
viresh
