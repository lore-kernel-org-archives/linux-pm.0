From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 03/18] cpufreq: Create for_each_governor()
Date: Tue, 03 Feb 2015 14:23:09 -0800
Message-ID: <54D14A4D.1030106@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <8abc55e0c15c5abed4944018195480374ea96b3c.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42475 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbBCWXK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 17:23:10 -0500
In-Reply-To: <8abc55e0c15c5abed4944018195480374ea96b3c.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> To make code more readable and less error prone, lets create a helper macro for
> iterating over all available governors.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9dfefb8ece6d..cf8ce523074f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -37,6 +37,11 @@ static LIST_HEAD(cpufreq_policy_list);
>   #define for_each_policy(__policy)				\
>   	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
>
> +/* Iterate over governors */
> +static LIST_HEAD(cpufreq_governor_list);
> +#define for_each_governor(__governor)				\
> +	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
> +
>   /**
>    * The "cpufreq driver" - the arch- or hardware-dependent low
>    * level driver of CPUFreq support, and its spinlock. This lock
> @@ -99,7 +104,6 @@ void disable_cpufreq(void)
>   {
>   	off = 1;
>   }
> -static LIST_HEAD(cpufreq_governor_list);
>   static DEFINE_MUTEX(cpufreq_governor_mutex);
>
>   bool have_governor_per_policy(void)
> @@ -434,7 +438,7 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
>   {
>   	struct cpufreq_governor *t;
>
> -	list_for_each_entry(t, &cpufreq_governor_list, governor_list)
> +	for_each_governor(t)
>   		if (!strncasecmp(str_governor, t->name, CPUFREQ_NAME_LEN))
>   			return t;
>
> @@ -636,7 +640,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>   		goto out;
>   	}
>
> -	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
> +	for_each_governor(t) {
>   		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
>   		    - (CPUFREQ_NAME_LEN + 2)))
>   			goto out;
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
