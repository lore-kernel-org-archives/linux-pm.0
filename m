From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: reinitialize new policy min/max when writing
 scaling_(max|min)_freq
Date: Tue, 29 May 2018 15:56:38 +0530
Message-ID: <20180529102638.ikmw2xjf523sf4kf@vireshk-i7>
References: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1527319008-66663-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527319008-66663-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Wangtao <kevin.wangtao@hisilicon.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gengyanping@hisilicon.com, sunzhaosheng@hisilicon.com
List-Id: linux-pm@vger.kernel.org

On 26-05-18, 15:16, Kevin Wangtao wrote:
> consider such situation, current user_policy.min is 1000000,
> current user_policy.max is 1200000, in cpufreq_set_policy,
> other driver may update policy.min to 1200000, policy.max to
> 1300000. After that, If we input "echo 1300000 > scaling_min_freq",
> then user_policy.min will be 1300000, and user_policy.max is
> still 1200000, because the input value is checked with policy.max
> not user_policy.max. if we get all related cpus offline and
> online again, it will cause cpufreq_init_policy fail because
> user_policy.min is higher than user_policy.max.
> 
> The solution is when user space tries to write scaling_(max|min)_freq,
> the min/max of new_policy should be reinitialized with min/max
> of user_policy, like what cpufreq_update_policy does.
> 
> Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b79c532..82123a1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -697,6 +697,8 @@ static ssize_t store_##file_name					\
>  	struct cpufreq_policy new_policy;				\
>  									\
>  	memcpy(&new_policy, policy, sizeof(*policy));			\

Maybe add a comment here on why this is required ?

> +	new_policy.min = policy->user_policy.min;			\
> +	new_policy.max = policy->user_policy.max;			\
>  									\
>  	ret = sscanf(buf, "%u", &new_policy.object);			\
>  	if (ret != 1)							\

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
