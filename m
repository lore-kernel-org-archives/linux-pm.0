From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/stats: Add "unknown" frequency field in stats
 tables
Date: Wed, 20 Nov 2013 11:23:51 +0530
Message-ID: <528C4E6F.20507@linaro.org>
References: <b0a2e5d26be45d1d2853940d318d50415db48f6f.1384839287.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <b0a2e5d26be45d1d2853940d318d50415db48f6f.1384839287.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com, shawn.guo@linaro.org, ceh@ti.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 November 2013 11:10 AM, Viresh Kumar wrote:
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 4cf0d28..ebb21cd 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -72,9 +72,13 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  		return 0;
>  	cpufreq_stats_update(stat->cpu);
>  	for (i = 0; i < stat->state_num; i++) {
> -		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
> -			(unsigned long long)
> -			jiffies_64_to_clock_t(stat->time_in_state[i]));
> +		if (stat->freq_table[i] == -1)
> +			return sprintf(buf + len, "unknown");
> +		else
> +			return sprintf(buf + len, "%u", stat->freq_table[i]);
> +
> +		len += sprintf(buf + len, " %llu\n", (unsigned long long)
> +				jiffies_64_to_clock_t(stat->time_in_state[i]));
>  	}
>  	return len;

Somehow I forgot to add below fix with this patch, which I have tested at that time.


diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index ebb21cd..89012d1 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -73,9 +73,9 @@ static ssize_t show_time_in_state(struct cpufreq_policy
*policy, char *buf)
        cpufreq_stats_update(stat->cpu);
        for (i = 0; i < stat->state_num; i++) {
                if (stat->freq_table[i] == -1)
-                       return sprintf(buf + len, "unknown");
+                       len+= sprintf(buf + len, "unknown");
                else
-                       return sprintf(buf + len, "%u", stat->freq_table[i]);
+                       len+= sprintf(buf + len, "%u", stat->freq_table[i]);

                len += sprintf(buf + len, " %llu\n", (unsigned long long)
                                jiffies_64_to_clock_t(stat->time_in_state[i]));

