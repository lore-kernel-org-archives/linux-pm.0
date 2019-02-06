From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: stats: Declare freq-attr right after their callbacks
Date: Wed, 06 Feb 2019 11:29:26 +0100
Message-ID: <2982623.nvCWEY4x1A@aspire.rjw.lan>
References: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, February 1, 2019 7:15:44 AM CET Viresh Kumar wrote:
> Freq attribute for "trans_table" is defined right after its callback
> (without any blank line between them), but the others are defined
> separately later on. Keep this consistent and define all attributes
> right after their callbacks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 1572129844a5..941e63e3e652 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -51,6 +51,7 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
>  {
>  	return sprintf(buf, "%d\n", policy->stats->total_trans);
>  }
> +cpufreq_freq_attr_ro(total_trans);
>  
>  static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  {
> @@ -69,6 +70,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	}
>  	return len;
>  }
> +cpufreq_freq_attr_ro(time_in_state);
>  
>  static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>  			   size_t count)
> @@ -77,6 +79,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>  	cpufreq_stats_clear_table(policy->stats);
>  	return count;
>  }
> +cpufreq_freq_attr_wo(reset);
>  
>  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  {
> @@ -126,10 +129,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  }
>  cpufreq_freq_attr_ro(trans_table);
>  
> -cpufreq_freq_attr_ro(total_trans);
> -cpufreq_freq_attr_ro(time_in_state);
> -cpufreq_freq_attr_wo(reset);
> -
>  static struct attribute *default_attrs[] = {
>  	&total_trans.attr,
>  	&time_in_state.attr,
> 

Applied, along with the [2/2], thanks!
