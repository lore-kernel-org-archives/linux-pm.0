From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Tue, 14 Jun 2016 16:41:08 +0530
Message-ID: <575FE64C.9080107@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com> <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com> <1465854492.3022.30.camel@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19873 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153AbcFNLLT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 07:11:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5EB9aiY112799
	for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2016 07:11:18 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23jfmnamv9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2016 07:11:18 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Tue, 14 Jun 2016 21:11:15 +1000
In-Reply-To: <1465854492.3022.30.camel@au1.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: benh@au1.ibm.com, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, maddy@linux.vnet.ibm.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linuxppc-dev@lists.ozlabs.org



On 06/14/2016 03:18 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2016-06-08 at 11:54 -0500, Shreyas B. Prabhu wrote:
>>
>>  /*
>>   * States for dedicated partition case.
>>   */
>> @@ -167,6 +183,8 @@ static int powernv_add_idle_states(void)
>>  	int nr_idle_states = 1; /* Snooze */
>>  	int dt_idle_states;
>>  	u32 *latency_ns, *residency_ns, *flags;
>> +	u64 *psscr_val = NULL;
>> +	const char *names[CPUIDLE_STATE_MAX];
>>  	int i, rc;
>>  
>>  	/* Currently we have snooze statically defined */
>> @@ -199,12 +217,41 @@ static int powernv_add_idle_states(void)
>>  		goto out_free_latency;
>>  	}
>>  
>> +	rc = of_property_read_string_array(power_mgt,
>> +					   "ibm,cpu-idle-state-names", names,
>> +					   dt_idle_states);
> 
> Ok so from this I assume that dt_idle_states is the number of entries,
> which has been checked properly to be < CPUIDLE_STATE_MAX correct ?
> 
> Beause ...
>

While dt_idle_states should not be > CPUIDLE_STATE_MAX, if that were the
case we will end up corrupting memory while updating powernv_states[].
I'll add a WARN_ON for such a case and
handle adding idle states to powernv_states accordingly. Thanks for
pointing this out.

>> +	if (rc < 0) {
>> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
>> +		goto out_free_latency;
>> +	}
>> +
>> +	/*
>> +	 * If the idle states use stop instruction, probe for psscr values
>> +	 * which are necessary to specify required stop level.
>> +	 */
>> +	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP)) {
>> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
>> +				    GFP_KERNEL);
>> +		rc = of_property_read_u64_array(power_mgt,
>> +						"ibm,cpu-idle-state-psscr",
>> +						psscr_val, dt_idle_states);
> 
> Here, psscr val is only one u64 ... shouldn't you kmalloc sizeof(..) *
> dt_idle_states ?

I'm using kcalloc here since checkpatch script suggested kcalloc over
kzalloc for allocating memory for arrays.
I'll also include a patch to use kcalloc throughout the file for
uniformity in next version. I was originally planning to post that
cleanup separately.

Thanks,
Shreyas

