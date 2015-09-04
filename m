From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 09:13:05 -0600
Message-ID: <20150904151305.GB876@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
 <20150904035910.GL15099@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34271 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbbIDPNH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 11:13:07 -0400
Received: by padhy16 with SMTP id hy16so24795892pad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2015 08:13:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150904035910.GL15099@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Thu, Sep 03 2015 at 21:59 -0600, Stephen Boyd wrote:
>On 09/03, Lina Iyer wrote:
>> @@ -137,7 +138,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>>  	}
>>
>> -
>
>Please remove noise.
>
Sorry, I forgot to address it earlier. Thought I did.
Apologize.

>>  	memset(&secondary_data, 0, sizeof(secondary_data));
>>  	return ret;
>>  }
>> @@ -271,6 +271,16 @@ void __cpu_die(unsigned int cpu)
>>  void __ref cpu_die(void)
>>  {
>>  	unsigned int cpu = smp_processor_id();
>> +	struct device *cpu_dev;
>> +
>> +	/*
>> +	 * We dont need the CPU device anymore.
>
>s/dont/don't/
>
>> +	 * Lets do this before IRQs are disabled to allow
>
>s/Lets/Let's/
>
>> +	 * runtime PM to suspend the domain as well.
>> +	 */
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
