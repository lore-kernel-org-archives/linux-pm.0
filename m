From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data pointer
Date: Wed, 03 Feb 2016 17:47:55 -0800
Message-ID: <56B2ADCB.8030400@codeaurora.org>
References: <3705929.bslqXH980s@vostro.rjw.lan> <1876466.AY9fn15fDn@vostro.rjw.lan> <56B2A53C.8080503@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37408 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474AbcBDBr5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 20:47:57 -0500
In-Reply-To: <56B2A53C.8080503@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>

On 02/03/2016 05:11 PM, Saravana Kannan wrote:
> On 02/03/2016 03:22 PM, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If the ondemand and conservative governors cannot use per-policy
>> tunables (CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not set in the cpufreq
>> driver), all policy objects point to the same single dbs_data object.
>> Additionally, that object is pointed to by a global pointer hidden in
>> the governor's data structures.
>>
>> There is no reason for that pointer to be buried in those
>> data structures, though, so make it explicitly global.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/cpufreq/cpufreq_governor.c |   20 ++++++++++----------
>>   drivers/cpufreq/cpufreq_governor.h |   20 ++++++++++----------
>>   2 files changed, 20 insertions(+), 20 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
>> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
>> @@ -78,7 +78,7 @@ __ATTR(_name, 0644, show_##_name##_gov_p
>>   static ssize_t show_##file_name##_gov_sys                \
>>   (struct kobject *kobj, struct attribute *attr, char *buf)        \
>>   {                                    \
>> -    struct _gov##_dbs_tuners *tuners =
>> _gov##_dbs_cdata.gdbs_data->tuners; \
>> +    struct _gov##_dbs_tuners *tuners = global_dbs_data->tuners; \
>>       return sprintf(buf, "%u\n", tuners->file_name);            \
>>   }                                    \
>>                                       \
>> @@ -94,7 +94,7 @@ static ssize_t show_##file_name##_gov_po
>>   static ssize_t store_##file_name##_gov_sys                \
>>   (struct kobject *kobj, struct attribute *attr, const char *buf,
>> size_t count) \
>>   {                                    \
>> -    struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;        \
>> +    struct dbs_data *dbs_data = global_dbs_data;        \
>>       return store_##file_name(dbs_data, buf, count);            \
>>   }                                    \
>>                                       \
>> @@ -201,19 +201,14 @@ struct cs_dbs_tuners {
>>   /* Common Governor data across policies */
>>   struct dbs_data;
>>   struct common_dbs_data {
>> -    /* Common across governors */
>> +    struct cpufreq_governor gov;
>> +

Actually, this line is completely unrelated to this patch. Should go on 
Patch 5?

>
> Cautiously Acked-by: Saravana Kannan <skannan@codeaurora.org>

Good call on the "cautiously" I guess!

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
