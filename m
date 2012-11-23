From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: governors: remove redundant code
Date: Fri, 23 Nov 2012 14:00:22 +0100
Message-ID: <20121123130022.GB7378@balto.lan>
References: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org>
 <98478a02ae69afc01b3c7860e42a4d763b2045e8.1350677395.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44666 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2KWNA3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Nov 2012 08:00:29 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1631573wib.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Nov 2012 05:00:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <98478a02ae69afc01b3c7860e42a4d763b2045e8.1350677395.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdsw-power-team@arm.com, arvind.chauhan@arm.com

Hello Viresh,

On Sat, Oct 20, 2012 at 01:42:06AM +0530, Viresh Kumar wrote:
> +static inline int delay_for_sampling_rate(unsigned int sampling_rate)
> +{
> +	int delay = usecs_to_jiffies(sampling_rate);
> +
> +	/* We want all CPUs to do sampling nearly on same jiffy */
> +	if (num_online_cpus() > 1)
> +		delay -= jiffies % delay;
> +
> +	return delay;
> +}
[...]
> +static void od_dbs_timer(struct work_struct *work)
> +{
> +	struct od_cpu_dbs_info_s *dbs_info =
> +		container_of(work, struct od_cpu_dbs_info_s, cdbs.work.work);
> +	unsigned int cpu = dbs_info->cdbs.cpu;
> +	int delay, sample_type = dbs_info->sample_type;
> +
> +	mutex_lock(&dbs_info->cdbs.timer_mutex);
>  
> -/* cpufreq_ondemand Governor Tunables */
> -#define show_one(file_name, object)					\
> -static ssize_t show_##file_name						\
> -(struct kobject *kobj, struct attribute *attr, char *buf)              \
> -{									\
> -	return sprintf(buf, "%u\n", dbs_tuners_ins.object);		\
> +	/* Common NORMAL_SAMPLE setup */
> +	dbs_info->sample_type = OD_NORMAL_SAMPLE;
> +	if (sample_type == OD_SUB_SAMPLE) {
> +		delay = dbs_info->freq_lo_jiffies;
> +		__cpufreq_driver_target(dbs_info->cdbs.cur_policy,
> +			dbs_info->freq_lo, CPUFREQ_RELATION_H);
> +	} else {
> +		dbs_check_cpu(&od_dbs_data, cpu);
> +		if (dbs_info->freq_lo) {
> +			/* Setup timer for SUB_SAMPLE */
> +			dbs_info->sample_type = OD_SUB_SAMPLE;
> +			delay = dbs_info->freq_hi_jiffies;
> +		} else {
> +			delay = delay_for_sampling_rate(dbs_info->rate_mult);
                                                        ^^^^^^^^^^^^^^^^^^^

I think this one should be:

delay = delay_for_sampling_rate(od_tuners.sampling_rate * dbs_info->rate_mult);

as currently the timer is firing every jiffy.  This was the old code:

> -static void do_dbs_timer(struct work_struct *work)
[...]
> -			delay = usecs_to_jiffies(dbs_tuners_ins.sampling_rate
> -				* dbs_info->rate_mult);
> -
> -			if (num_online_cpus() > 1)
> -				delay -= jiffies % delay;

I'm sending a patch for this one.

Fabio

-- 
Fabio Baltieri
