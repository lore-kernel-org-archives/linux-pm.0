From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] cpufreq: Introduce cpufreq_notify_post_transition()
Date: Sat, 30 Nov 2013 21:20:44 +0100
Message-ID: <15590294.HtstlaFcjF@vostro.rjw.lan>
References: <0d635c6701654a75f6d25dd435705dc1ede3e19c.1385826776.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <0d635c6701654a75f6d25dd435705dc1ede3e19c.1385826776.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, November 30, 2013 09:26:19 PM Viresh Kumar wrote:
> This introduces another routine cpufreq_notify_post_transition() which can be
> used to send POSTCHANGE notification for new freq with or without both
> {PRE|POST}CHANGE notifications for last freq in case of failures. This is useful
> at multiple places, specially for sending transition failure notifications.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Hi Rafael,
> 
> Please see if you want to take it for 3.13 or 14, as this fixes bugs which are
> partly introduced in 3.13..

Which ones?

Rafael


>  drivers/cpufreq/cpufreq.c | 14 ++++++++++++++
>  include/linux/cpufreq.h   |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 606224a..a862aa9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -324,6 +324,20 @@ void cpufreq_notify_transition(struct cpufreq_policy *policy,
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
>  
> +/* Do post notifications when there are chances that transition has failed */
> +void cpufreq_notify_post_transition(struct cpufreq_policy *policy,
> +		struct cpufreq_freqs *freqs, int transition_failed)
> +{
> +	cpufreq_notify_transition(policy, freqs, CPUFREQ_POSTCHANGE);
> +	if (!transition_failed)
> +		return;
> +
> +	swap(freqs->old, freqs->new);
> +	cpufreq_notify_transition(policy, freqs, CPUFREQ_PRECHANGE);
> +	cpufreq_notify_transition(policy, freqs, CPUFREQ_POSTCHANGE);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_notify_post_transition);
> +
>  
>  /*********************************************************************
>   *                          SYSFS INTERFACE                          *
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index ee5fe9d..57e48db 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -314,6 +314,8 @@ int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list);
>  
>  void cpufreq_notify_transition(struct cpufreq_policy *policy,
>  		struct cpufreq_freqs *freqs, unsigned int state);
> +void cpufreq_notify_post_transition(struct cpufreq_policy *policy,
> +		struct cpufreq_freqs *freqs, int transition_failed);
>  
>  #else /* CONFIG_CPU_FREQ */
>  static inline int cpufreq_register_notifier(struct notifier_block *nb,
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
