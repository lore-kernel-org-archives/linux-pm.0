From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Thu, 15 Oct 2015 12:25:27 -0700
Message-ID: <561FFDA7.3080903@codeaurora.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org> <594e7c8e74ca56cef58d29327518f5223e89e208.1444924623.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49604 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbJOTZ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 15:25:29 -0400
In-Reply-To: <594e7c8e74ca56cef58d29327518f5223e89e208.1444924623.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/15/2015 09:05 AM, Viresh Kumar wrote:
> The cpufreq sysfs interface had been a bit inconsistent as one of the
> CPUs for a policy had a real directory within its sysfs 'cpuX' directory
> and all other CPUs had links to it. That also made the code a bit
> complex as we need to take care of moving the sysfs directory if the CPU
> containing the real directory is getting physically hot-unplugged.
>
> Solve this by creating 'policyX' directories (per-policy) in
> /sys/devices/system/cpu/cpufreq/ directory, where X is the CPU for which
> the policy was first created.
>
> This also removes the need of keeping kobj_cpu and we can remove it now.
>
> Suggested-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Since you've added a separate patch for making policyX more consistent:
Reviewed-by: Saravana Kannan <skannan@codeaurora.org>

Btw, does a Review-by have an implicit Acked-by?

> ---
>   drivers/cpufreq/cpufreq.c | 34 ++++------------------------------
>   include/linux/cpufreq.h   |  1 -
>   2 files changed, 4 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04222e7bbc73..4fa2215cc6ec 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -910,9 +910,6 @@ static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
>
>   	/* Some related CPUs might not be present (physically hotplugged) */
>   	for_each_cpu(j, policy->real_cpus) {
> -		if (j == policy->kobj_cpu)
> -			continue;
> -
>   		ret = add_cpu_dev_symlink(policy, j);
>   		if (ret)
>   			break;

Kinda unrelated to this patch, but shouldn't this function undo the 
symlinks is has created so far before returning? Otherwise, we'd be 
leaving around broken symlinks.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
