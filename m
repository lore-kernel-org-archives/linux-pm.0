From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: governor: Protect cpufreq governor_data
Date: Mon, 20 Aug 2018 11:07:49 +0200
Message-ID: <2923321.jmYcvy9DfS@aspire.rjw.lan>
References: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henry Willard <henry.willard@oracle.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 15, 2018 2:01:02 AM CEST Henry Willard wrote:
> If cppc_cpufreq.ko is deleted at the same time that tuned-adm is
> changing profiles, there is a small chance that a race can occur
> between cpufreq_dbs_governor_exit() and cpufreq_dbs_governor_limits()
> resulting in a system failure when the latter tries to use
> policy->governor_data that has been freed by the former.
> 
> This patch uses gov_dbs_data_mutex to synchronize access.
> 
> Signed-off-by: Henry Willard <henry.willard@oracle.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 1d50e97d49f1..43416ee55849 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -555,12 +555,20 @@ void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
>  
>  void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>  {
> -	struct policy_dbs_info *policy_dbs = policy->governor_data;
> +	struct policy_dbs_info *policy_dbs;
> +
> +	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit */
> +	mutex_lock(&gov_dbs_data_mutex);
> +	policy_dbs = policy->governor_data;
> +	if (!policy_dbs)
> +		goto out;
>  
>  	mutex_lock(&policy_dbs->update_mutex);
>  	cpufreq_policy_apply_limits(policy);
>  	gov_update_sample_delay(policy_dbs, 0);
>  
>  	mutex_unlock(&policy_dbs->update_mutex);
> +out:
> +	mutex_unlock(&gov_dbs_data_mutex);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
> 

Applied, thanks!
