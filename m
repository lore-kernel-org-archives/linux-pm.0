From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2 1/2] thermal: add available policies attribut
Date: Wed, 15 Jan 2014 19:26:30 +0800
Message-ID: <52D67066.8010403@nvidia.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com> <1389611863-7812-2-git-send-email-wni@nvidia.com> <52D40D36.9060702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16602 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaAOLZ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2014 06:25:28 -0500
In-Reply-To: <52D40D36.9060702@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 01/13/2014 11:58 PM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
> 
> On 13-01-2014 07:17, Wei Ni wrote:
>> The Linux thermal framework support to change governor policy
>> in run time, but it can't show what available policies supported.
>>
>> This patch adds available_policies attribut to the thermal
> 
> s/attribut/attribute/g

oh, thanks, I will fix it.

> 
>> framework, it can list the thermal governors which can be
>> used for a particular zone. This attribut is read only.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  Documentation/thermal/sysfs-api.txt |    6 ++++++
>>  drivers/thermal/thermal_core.c      |   25 +++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
>> index 87519cb..6a70b55c 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -172,6 +172,7 @@ Thermal zone device sys I/F, created once it's registered:
>>      |---temp:			Current temperature
>>      |---mode:			Working mode of the thermal zone
>>      |---policy:			Thermal governor used for this zone
>> +    |---available_policies	Available governors for this zone
> 
> I would prefer:
> "Available thermal governors for this zone"

Ok.

> 
>>      |---trip_point_[0-*]_temp:	Trip point temperature
>>      |---trip_point_[0-*]_type:	Trip point type
>>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
>> @@ -238,6 +239,10 @@ policy
>>  	One of the various thermal governors used for a particular zone.
>>  	RW, Required
>>  
>> +available_policies
>> +	Availabe thermal governors which can be used for a particular zone.
>> +	RO, Required
>> +
>>  trip_point_[0-*]_temp
>>  	The temperature above which trip point will be fired.
>>  	Unit: millidegree Celsius
>> @@ -330,6 +335,7 @@ method, the sys I/F structure will be built like this:
>>      |---temp:			37000
>>      |---mode:			enabled
>>      |---policy:			step_wise
>> +    |---available_policies:	step_wise fair_share
>>      |---trip_point_0_temp:	100000
>>      |---trip_point_0_type:	critical
>>      |---trip_point_1_temp:	80000
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 338a88b..aab1df8 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -761,6 +761,24 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
>>  	return sprintf(buf, "%s\n", tz->governor->name);
>>  }
>>  
>> +static ssize_t
>> +available_policies_show(struct device *dev, struct device_attribute *devattr,
>> +			char *buf)
>> +{
>> +	struct thermal_governor *pos;
>> +	ssize_t count = 0;
>> +
>> +	mutex_lock(&thermal_governor_lock);
>> +
>> +	list_for_each_entry(pos, &thermal_governor_list, governor_list)
>> +		count += sprintf(buf + count, "%s ", pos->name);
> 
> I would prefer if you'd used scnprintf
> 
>> +	count += sprintf(buf + count, "\n");
> 
> ditto.
> 
> 
> It is unlikely, but What if count if greater than PAGE_SIZE?

hmm, I checked the sysfs driver, in funciton sysfs_kf_seq_show(), it
seems it can handle the count greater than PAGE_SIZE.
Or we can return error here directly.
What do you think about it?

> 
>> +
>> +	mutex_unlock(&thermal_governor_lock);
>> +
>> +	return count;
>> +}
>> +
>>  #ifdef CONFIG_THERMAL_EMULATION
>>  static ssize_t
>>  emul_temp_store(struct device *dev, struct device_attribute *attr,
>> @@ -794,6 +812,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
>>  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
>> +static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
>>  
>>  /* sys I/F for cooling device */
>>  #define to_cooling_device(_dev)	\
>> @@ -1527,6 +1546,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>>  	if (result)
>>  		goto unregister;
>>  
>> +	/* Create available_policies attribute */
>> +	result = device_create_file(&tz->device, &dev_attr_available_policies);
>> +	if (result)
>> +		goto unregister;
>> +
>>  	/* Update 'this' zone's governor information */
>>  	mutex_lock(&thermal_governor_lock);
>>  
>> @@ -1622,6 +1646,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>>  	if (tz->ops->get_mode)
>>  		device_remove_file(&tz->device, &dev_attr_mode);
>>  	device_remove_file(&tz->device, &dev_attr_policy);
>> +	device_remove_file(&tz->device, &dev_attr_available_policies);
>>  	remove_trip_attrs(tz);
>>  	tz->governor = NULL;
>>  
>>
> 
> 

