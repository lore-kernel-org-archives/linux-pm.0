From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 08/14] cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
Date: Sat, 03 Jan 2015 23:28:13 +0100
Message-ID: <2433937.yfFORihJWM@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <dd0f0186a7a3cc759d48ea1c7d3c6494e69db6b9.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61714 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750735AbbACWGA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 17:06:00 -0500
In-Reply-To: <dd0f0186a7a3cc759d48ea1c7d3c6494e69db6b9.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:45 AM Viresh Kumar wrote:
> CPUFREQ_UPDATE_POLICY_CPU notifications were used only from cpufreq-stats which
> doesn't use it anymore. Remove them.
> 
> This also fixes the value of other notification macros, hopefully all users are
> using macro's instead of direct values and nothing will break :)

The paragraph above is completely unclear to me.  Do you mean that it changes
the definitions of CPUFREQ_CREATE_POLICY and CPUFREQ_REMOVE_POLICY too which
may affect code that uses numbers instead of these symbols?

> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ---
>  include/linux/cpufreq.h   | 5 ++---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b88894578fd1..6d97dffeaaf7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1094,9 +1094,6 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
>  	policy->cpu = cpu;
>  	up_write(&policy->rwsem);
>  
> -	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> -			CPUFREQ_UPDATE_POLICY_CPU, policy);
> -
>  	return 0;
>  }
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2d99f12e4199..43013eac26fd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -368,9 +368,8 @@ static inline void cpufreq_resume(void) {}
>  #define CPUFREQ_INCOMPATIBLE		(1)
>  #define CPUFREQ_NOTIFY			(2)
>  #define CPUFREQ_START			(3)
> -#define CPUFREQ_UPDATE_POLICY_CPU	(4)
> -#define CPUFREQ_CREATE_POLICY		(5)
> -#define CPUFREQ_REMOVE_POLICY		(6)
> +#define CPUFREQ_CREATE_POLICY		(4)
> +#define CPUFREQ_REMOVE_POLICY		(5)
>  
>  #ifdef CONFIG_CPU_FREQ
>  int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
