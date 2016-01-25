From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 5/5] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Date: Mon, 25 Jan 2016 12:16:42 +0530
Message-ID: <56A5C4D2.7040500@linux.vnet.ibm.com>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1453447145-17722-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <20160123194053.366ef17f@cotter.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:44066 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcAYGrj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 01:47:39 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Mon, 25 Jan 2016 16:47:37 +1000
In-Reply-To: <20160123194053.366ef17f@cotter.ozlabs.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com

Hi,

On 01/23/2016 02:10 PM, Balbir Singh wrote:
> On Fri, 22 Jan 2016 12:49:05 +0530
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:
> 
>> Create sysfs attributes to export throttle information in
>> /sys/devices/system/cpu/cpufreq/chipN. The newly added sysfs files are as
>> follows:
>>
>> 1)/sys/devices/system/cpu/cpufreq/chip0/throttle_frequencies
>>   This gives the throttle stats for each of the available frequencies.
>>   The throttle stat of a frequency is the total number of times the max
>>   frequency is reduced to that frequency.
>>   # cat /sys/devices/system/cpu/cpufreq/chip0/throttle_frequencies
>>   4023000 0
>>   3990000 0
>>   3956000 1
>>   3923000 0
>>   3890000 0
>>   3857000 2
>>   3823000 0
>>   3790000 0
>>   3757000 2
>>   3724000 1
>>   3690000 1
>>   ...
>>
>> 2)/sys/devices/system/cpu/cpufreq/chip0/throttle_reasons
>>   This directory contains throttle reason files. Each file gives the
>>   total number of times the max frequency is throttled, except for
>>   'throttle_reset', which gives the total number of times the max
> 
> Is reset a good name? Ideally a reset, reset's stats.

Is unthrottle_count a better name?

> 
>>   frequency is unthrottled after being throttled.
>>   # cd /sys/devices/system/cpu/cpufreq/chip0/throttle_reasons
>>   # cat cpu_over_temperature
>>   7
>>   # cat occ_reset
>>   0
>>   # cat over_current
>>   0
>>   # cat power_cap
>>   0
>>   # cat power_supply_failure
>>   0
>>   # cat throttle_reset
>>   7
>>
>> 3)/sys/devices/system/cpu/cpufreq/chip0/throttle_stat
>>   This gives the total number of events of max frequency throttling to
>>   lower frequencies in the turbo range of frequencies and the sub-turbo(at
>>   and below nominal) range of frequencies.
>>   # cat /sys/devices/system/cpu/cpufreq/chip0/throttle_stat
>>   turbo 7
>>   sub-turbo 0
>>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> snip
> 
>>  
>> +enum throt_reason_type {
>> +	NO_THROTTLE = 0,
> NO is not throttled or number_throttle?

It stands for not throttled.

> 
>> +	POWERCAP,
>> +	CPU_OVERTEMP,
>> +	POWER_SUPPLY_FAILURE,
>> +	OVERCURRENT,
>> +	OCC_RESET_THROTTLE,
>> +	OCC_MAX_REASON
>> +};
>> +
>>  static struct chip {
>>  	unsigned int id;
>>  	bool throttled;
>> @@ -62,6 +72,11 @@ static struct chip {
>>  	u8 throt_reason;
>>  	cpumask_t mask;
>>  	struct work_struct throttle;
>> +	int throt_turbo;
> 
> The enum uses _THROTTLE so why can't the struct member
> be throttle_nominal? throttle_turbo?

Okay will change the struct members to throttle_*

> 
>> +	int throt_nominal;
>> +	int reason[OCC_MAX_REASON];
>> +	int *pstate_stat;
>> +	struct kobject *kobj;
>>  } *chips;
>>  
>>  static int nr_chips;
>> @@ -196,6 +211,128 @@ static struct freq_attr *powernv_cpu_freq_attr[] = {
>>  	NULL,
>>  };
>>  
>> +static inline int get_chip_index(unsigned int id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < nr_chips; i++)
>> +		if (chips[i].id == id)
>> +			return i;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t throttle_freq_show(struct kobject *kobj,
>> +				  struct kobj_attribute *attr, char *buf)
>> +{
>> +	int i, count = 0, id;
>> +
>> +	i = kstrtoint(kobj->name + 4, 0, &id);
> 
> Why the +4 magic, make it more readable?

Okay. Will do.

> 
>> +	if (i)
>> +		return i;
>> +
>> +	id = get_chip_index(id);
>> +	if (id < 0) {
>> +		pr_warn_once("%s Matching chip-id not found\n", __func__);
> 
> The pr_warn_once should also print which chip-id was not found, please
> add that to the print

Okay will do.

> 
>> +		return id;
>> +	}
>> +
>> +	for (i = 0; i < powernv_pstate_info.nr_pstates; i++)
>> +		count += sprintf(&buf[count], "%d %d\n",
>> +			       powernv_freqs[i].frequency,
>> +			       chips[id].pstate_stat[i]);
>> +
>> +	return count;
>> +}
>> +
>> +static struct kobj_attribute attr_throttle_frequencies =
>> +__ATTR(throttle_frequencies, 0444, throttle_freq_show, NULL);
>> +
>> +static ssize_t throttle_stat_show(struct kobject *kobj,
>> +				  struct kobj_attribute *attr, char *buf)
>> +{
>> +	int ret, id, count = 0;
>> +
>> +	ret = kstrtoint(kobj->name + 4, 0, &id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	id = get_chip_index(id);
>> +	if (id < 0) {
>> +		pr_warn_once("%s Matching chip-id not found\n", __func__);
>> +		return id;
>> +	}
>> +
> 
> The above 9 lines look like common code, you can easily collapse it
> instead of repeating it

okay will do.


