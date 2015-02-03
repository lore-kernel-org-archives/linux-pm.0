From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 02/18] cpufreq: Create for_each_policy()
Date: Tue, 03 Feb 2015 14:22:25 -0800
Message-ID: <54D14A21.3010007@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <c2b93a536c452b13a09434c3dfaf9725ee8ff95a.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42437 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbbBCWW1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 17:22:27 -0500
In-Reply-To: <c2b93a536c452b13a09434c3dfaf9725ee8ff95a.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> To make code more readable and less error prone, lets create a helper macro for
> iterating over all active policies.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 72990ba59fad..9dfefb8ece6d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -31,6 +31,12 @@
>   #include <linux/tick.h>
>   #include <trace/events/power.h>
>
> +/* Macros to iterate over lists */
> +/* Iterate over online CPUs policies */
> +static LIST_HEAD(cpufreq_policy_list);
> +#define for_each_policy(__policy)				\
> +	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
> +

Could you "export" this macro/list so that it's usable by other clients 
of cpufreq too? If a driver wants to examine all the policies today, it 
has to do "for_each_cpu" and then try to get the policy for each CPU. 
This seems nicer.

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
