From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/3 v4] powercap, intel_rapl, implement get_max_time_window
Date: Tue, 05 Apr 2016 09:14:35 -0400
Message-ID: <5703BA3B.5010502@redhat.com>
References: <1458563236-19269-1-git-send-email-prarit@redhat.com>	 <1458563236-19269-2-git-send-email-prarit@redhat.com> <1459448760.4569.87.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbcDENOi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Apr 2016 09:14:38 -0400
In-Reply-To: <1459448760.4569.87.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Jovanovic, Radivoje" <radivoje.jovanovic@intel.com>, "s.ikarashi@jp.fujitsu.com" <s.ikarashi@jp.fujitsu.com>, "David Rajamanickam, Ajay Thomas" <ajay.thomas.david.rajamanickam@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "minipli@googlemail.com" <minipli@googlemail.com>



On 03/31/2016 02:28 PM, Pandruvada, Srinivas wrote:
> On Mon, 2016-03-21 at 08:27 -0400, Prarit Bhargava wrote:
>> The MSR_PKG_POWER_INFO register (Intel ASDM, section 14.9.3
>> "Package RAPL Domain") provides a maximum time window which the
>> system can support.  This window is read-only and is currently
>> not examined when setting the time windows for the package.
>>
> Usually this field has lot of junk. It is not supported uniformly.
> The system provides this value from another ACPI element called PPCC.
> If supported this will be in 
> 
> $ /sys/bus/pci/devices/0000:00:04.0/power_limits
> $ grep . *
> power_limit_0_max_uw:15000000
> power_limit_0_min_uw:125000
> power_limit_0_step_uw:1000000
> power_limit_0_tmax_us:32000000
> power_limit_0_tmin_us:28000000
> power_limit_1_max_uw:25000000
> power_limit_1_min_uw:25000000
> power_limit_1_step_uw:1000000
> power_limit_1_tmax_us:0
> power_limit_1_tmin_us:0
> 

Interesting.  I'll go and take a look on my test system to see if this is supported.

P.

> Thanks,
> Srinivas
>> This patch implements get_max_time_window_us() and checks the window
>> when
>> a user attempts to set power capping for the package.
>>
>> Before the patch it was possible to set the window to, for example,
>> 10000
>> micro seconds:
>>
>> [root@intel-chiefriver-03 rhel7]# echo 10000 >
>> /sys/devices/virtual/powercap/intel-rapl/intel-
>> rapl\:0/constraint_0_time_window_us;
>> egrep ^ /sys/devices/virtual/powercap/intel-rapl/intel-
>> rapl\:0/constraint_0_time_window_us
>>
>> /sys/devices/virtual/powercap/intel-rapl/intel-
>> rapl:0/constraint_0_time_window_us:1:9765
>>
>> but from 'turbostat -d', the package is limited to 976us:
>>
>> cpu0: MSR_PKG_POWER_INFO: 0x01200168 (45 W TDP, RAPL 36 - 0 W,
>> 0.000977 sec.)
>>
>> (Note, there appears to be a rounding issue in turbostat which needs
>> to
>> also be fixed.  Looking at the values in the register it is clear the
>> value is 1/1024 = 976us.)
>>
>> After the patch we are limited by the maximum time window:
>>
>> [root@intel-chiefriver-03 rhel7]# echo 10000 >
>> /sys/devices/virtual/powercap/intel-rapl/intel-
>> rapl\:0/constraint_0_time_window_us;
>> egrep ^ /sys/devices/virtual/powercap/intel-rapl/intel-
>> rapl\:0/constraint_0_time_window_us
>>
>> -bash: echo: write error: Invalid argument
>> /sys/devices/virtual/powercap/intel-rapl/intel-
>> rapl:0/constraint_0_time_window_us:1:976
>>
>> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>> Cc: Prarit Bhargava <prarit@redhat.com>
>> Cc: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
>> Cc: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
>> Cc: Mathias Krause <minipli@googlemail.com>
>> Cc: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> ---
>>  drivers/powercap/intel_rapl.c   |   31
>> +++++++++++++++++++++++++++++++
>>  drivers/powercap/powercap_sys.c |    6 ++++--
>>  2 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/powercap/intel_rapl.c
>> b/drivers/powercap/intel_rapl.c
>> index 6c592dc..feb063d 100644
>> --- a/drivers/powercap/intel_rapl.c
>> +++ b/drivers/powercap/intel_rapl.c
>> @@ -493,13 +493,42 @@ static int get_current_power_limit(struct
>> powercap_zone *power_zone, int id,
>>  	return ret;
>>  }
>>  
>> +static int get_max_time_window(struct powercap_zone *power_zone, int
>> id,
>> +			       u64 *data)
>> +{
>> +	struct rapl_domain *rd;
>> +	int ret = 0;
>> +	u64 val;
>> +
>> +	get_online_cpus();
>> +	rd = power_zone_to_rapl_domain(power_zone);
>> +
>> +	if (rapl_read_data_raw(rd, MAX_TIME_WINDOW, true, &val))
>> +		ret = -EIO;
>> +	else
>> +		*data = val;
>> +
>> +	put_online_cpus();
>> +	return ret;
>> +}
>> +
>>  static int set_time_window(struct powercap_zone *power_zone, int id,
>>  								u64
>> window)
>>  {
>>  	struct rapl_domain *rd;
>>  	int ret = 0;
>> +	u64 max_window;
>>  
>>  	get_online_cpus();
>> +	ret = get_max_time_window(power_zone, id, &max_window);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	if (window > max_window) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>>  	rd = power_zone_to_rapl_domain(power_zone);
>>  	switch (rd->rpl[id].prim_id) {
>>  	case PL1_ENABLE:
>> @@ -511,6 +540,7 @@ static int set_time_window(struct powercap_zone
>> *power_zone, int id,
>>  	default:
>>  		ret = -EINVAL;
>>  	}
>> +out:
>>  	put_online_cpus();
>>  	return ret;
>>  }
>> @@ -590,6 +620,7 @@ static const struct powercap_zone_constraint_ops
>> constraint_ops = {
>>  	.set_time_window_us = set_time_window,
>>  	.get_time_window_us = get_time_window,
>>  	.get_max_power_uw = get_max_power,
>> +	.get_max_time_window_us = get_max_time_window,
>>  	.get_name = get_constraint_name,
>>  };
>>  
>> diff --git a/drivers/powercap/powercap_sys.c
>> b/drivers/powercap/powercap_sys.c
>> index 14bde0d..53fad0f 100644
>> --- a/drivers/powercap/powercap_sys.c
>> +++ b/drivers/powercap/powercap_sys.c
>> @@ -101,7 +101,7 @@ static ssize_t store_constraint_##_attr(struct
>> device *dev,\
>>  	int err; \
>>  	u64 value; \
>>  	struct powercap_zone *power_zone = to_powercap_zone(dev); \
>> -	int id; \
>> +	int id, ret; \
>>  	struct powercap_zone_constraint *pconst;\
>>  	\
>>  	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
>> @@ -113,8 +113,10 @@ static ssize_t store_constraint_##_attr(struct
>> device *dev,\
>>  	if (err) \
>>  		return -EINVAL; \
>>  	if (pconst && pconst->ops && pconst->ops->set_##_attr) { \
>> -		if (!pconst->ops->set_##_attr(power_zone, id,
>> value)) \
>> +		ret = pconst->ops->set_##_attr(power_zone, id,
>> value); \
>> +		if (!ret) \
>>  			return count; \
>> +		return ret; \
>>  	} \
>>  	\
>>  	return -ENODATA; \
