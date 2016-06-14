From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Tue, 14 Jun 2016 16:17:12 +0530
Message-ID: <575FE0B0.4030309@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com> <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com> <20160613153446.GF10634@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33003 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750805AbcFNKrZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 06:47:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5EAhlDa090912
	for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2016 06:47:24 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23geh49fvn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2016 06:47:24 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Tue, 14 Jun 2016 20:47:21 +1000
In-Reply-To: <20160613153446.GF10634@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: mpe@ellerman.id.au, benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org



On 06/13/2016 09:04 PM, Daniel Lezcano wrote:
> On Wed, Jun 08, 2016 at 11:54:30AM -0500, Shreyas B. Prabhu wrote:
>> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>>  a) new instruction named stop is added.
>>  b) new per thread SPR named PSSCR is added which controls the behavior
>> 	of stop instruction.
>>
>> Supported idle states and value to be written to PSSCR register to enter
>> any idle state is exposed via ibm,cpu-idle-state-names and
>> ibm,cpu-idle-state-psscr respectively. To enter an idle state,
>> platform provided power_stop() needs to be invoked with the appropriate
>> PSSCR value.
>>
>> This patch adds support for this new mechanism in cpuidle powernv driver.
>>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@ozlabs.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
> 
> [ ... ]
> 
>> +	rc = of_property_read_string_array(power_mgt,
>> +					   "ibm,cpu-idle-state-names", names,
>> +					   dt_idle_states);
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
> 
> if (!psscr_val) check missing.

I ignored adding this check because this is part of initcall and we are
unlikely to run out of memory at this state. But I'll add the check in
next version.
> 
>> +		rc = of_property_read_u64_array(power_mgt,
>> +						"ibm,cpu-idle-state-psscr",
>> +						psscr_val, dt_idle_states);
>> +		if (rc) {
>> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
>> +			goto out_free_psscr;
>> +		}
>> +	}
>>  	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
> 
> if (!residency_ns) check missing.
> 
> I suppose the code is relying on 'of_property_read_u32_array' to check it, 
> right ?

I'll add the NULL check for existing kzalloc's in the file as well in
the next version.

Thanks,
Shreyas

