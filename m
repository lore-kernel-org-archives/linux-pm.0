From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V3 11/17] thermal: cpu_cooling: get rid of 'allowed_cpus'
Date: Mon, 24 Apr 2017 17:53:10 +0100
Message-ID: <78b14ec9-e107-95dc-03b6-194b00834d6a@arm.com>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
 <4da549d2565a75420633850b6963fe50b3f02bad.1492579345.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S975125AbdDXQxP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Apr 2017 12:53:15 -0400
In-Reply-To: <4da549d2565a75420633850b6963fe50b3f02bad.1492579345.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

Hi Viresh,

I have been testing the patch set and found one of the issues.
Please see the comment below.

On 19/04/17 06:29, Viresh Kumar wrote:
> 'allowed_cpus' is a copy of policy->related_cpus and can be replaced by
> it directly. At some places we are only concerned about online CPUs and
> policy->cpus can be used there.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 77 ++++++++++++-------------------------------
>  1 file changed, 21 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index ce387f62c93e..1097162f7f8a 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -74,7 +74,6 @@ struct power_table {
>   *	frequency.
>   * @max_level: maximum cooling level. One less than total number of valid
>   *	cpufreq frequencies.
> - * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
>   * @node: list_head to link all cpufreq_cooling_device together.
>   * @last_load: load measured by the latest call to cpufreq_get_requested_power()
>   * @time_in_idle: previous reading of the absolute time that this cpu was idle
> @@ -97,7 +96,6 @@ struct cpufreq_cooling_device {
>  	unsigned int clipped_freq;
>  	unsigned int max_level;
>  	unsigned int *freq_table;	/* In descending order */
> -	struct cpumask allowed_cpus;
>  	struct list_head node;
>  	u32 last_load;
>  	u64 *time_in_idle;
> @@ -161,7 +159,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>
>  	mutex_lock(&cooling_list_lock);
>  	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
> -		if (!cpumask_test_cpu(policy->cpu, &cpufreq_cdev->allowed_cpus))
> +		if (policy != cpufreq_cdev->policy)
The policy pointer forwarded from cpufreq_update_policy()
is a local variable 'new_policy' so cannot be compared with pinned
policy pointer in the cooling device.
You should do the cpumask test like before:
	if (!cpumask_test_cpu(policy->cpu,
			      cpufreq_cdev->policy->related_cpus))


But there is something still in the patch set...
I will try to check it tomorrow.

Best regards,
Lukasz
