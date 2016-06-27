From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: Replacing pstate_id with frequency
 table index
Date: Mon, 27 Jun 2016 12:52:31 +0530
Message-ID: <5770D437.6000406@linux.vnet.ibm.com>
References: <1466776987-19031-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160627063034.GA3341@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48471 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751710AbcF0HWo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 03:22:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5R7IqIs037907
	for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2016 03:22:43 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23sp40sj09-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2016 03:22:43 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
	Mon, 27 Jun 2016 17:22:41 +1000
In-Reply-To: <20160627063034.GA3341@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com

Hi viresh,

My apologies. I realize that i have messed it up a quite a few places. Surely with the checkpatch as well. I will send a v2 with corrections.

On 06/27/2016 12:00 PM, Viresh Kumar wrote:

> Hi Akshay,
>
> Did you try running checkpatch for this?
>
> On 24-06-16, 19:33, Akshay Adiga wrote:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index b29c5c2..f6ce6f0 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -43,6 +43,7 @@
>>   #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>>   #define PMSR_MAX(x)		((x >> 32) & 0xFF)
>>   
>> +
> ?
>
>>   #define MAX_RAMP_DOWN_TIME				5120
>>   /*
>>    * On an idle system we want the global pstate to ramp-down from max value to
>> @@ -124,20 +125,29 @@ static int nr_chips;
>>   static DEFINE_PER_CPU(struct chip *, chip_info);
>>   
>>   /*
>> - * Note: The set of pstates consists of contiguous integers, the
>> - * smallest of which is indicated by powernv_pstate_info.min, the
>> - * largest of which is indicated by powernv_pstate_info.max.
>> + * Note: The set of pstates consists of contiguous integers,
>> + *
>> + * powernv_pstate_info stores the index of the frequency table
>> + *  instead of pstate itself for each of the pstates referred
>>    *
>>    * The nominal pstate is the highest non-turbo pstate in this
>>    * platform. This is indicated by powernv_pstate_info.nominal.
>>    */
>>   static struct powernv_pstate_info {
>> -	int min;
>> -	int max;
>> -	int nominal;
>> -	int nr_pstates;
>> +	unsigned int min;
>> +	unsigned int max;
>> +	unsigned int nominal;
>> +	unsigned int nr_pstates;
>>   } powernv_pstate_info;
>>   
>> +/* Use following macros for conversions between pstate_id and index */
>> +static inline int get_pstate(unsigned int i) {
> Read coding-styles please on how to write functions.
>
>> +	return powernv_freqs[i].driver_data;
>> +}
> Add a blank line here please.
>
>> +static inline unsigned int get_index(int pstate) {
>> +	return abs(pstate - get_pstate(powernv_pstate_info.max));
>> +}
>> +
>>   static inline void reset_gpstates(struct cpufreq_policy *policy)
>>   {
>>   	struct global_pstate_info *gpstates = policy->driver_data;
>> @@ -208,23 +218,28 @@ static int init_powernv_pstates(void)
>>   		return -ENODEV;
>>   	}
>>   
>> +	powernv_pstate_info.nr_pstates = nr_pstates;
>>   	pr_debug("NR PStates %d\n", nr_pstates);
>>   	for (i = 0; i < nr_pstates; i++) {
>>   		u32 id = be32_to_cpu(pstate_ids[i]);
>>   		u32 freq = be32_to_cpu(pstate_freqs[i]);
>>   
>> -		pr_debug("PState id %d freq %d MHz\n", id, freq);
> ?
>
>>   		powernv_freqs[i].frequency = freq * 1000; /* kHz */
>>   		powernv_freqs[i].driver_data = id;
> Will it be possible for Shilpa who was earlier on this to review this patch? As
> we don't really have great knowledge of the internals of this driver.
>

