Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0474DC432BE
	for <linux-pm@archiver.kernel.org>; Tue,  3 Aug 2021 08:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DFA61029
	for <linux-pm@archiver.kernel.org>; Tue,  3 Aug 2021 08:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHCIti (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:49:38 -0400
Received: from foss.arm.com ([217.140.110.172]:44852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234622AbhHCIti (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 04:49:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF0611D4;
        Tue,  3 Aug 2021 01:49:27 -0700 (PDT)
Received: from [10.57.9.94] (unknown [10.57.9.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E523F40C;
        Tue,  3 Aug 2021 01:49:23 -0700 (PDT)
Subject: Re: [PATCH] cpufreq: arm_scmi: Fix error path when allocation failed
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20210802204550.12647-1-lukasz.luba@arm.com>
 <20210803043445.7sm4mnl4f5f7co7h@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <455e76f8-43c5-2976-e10b-a0fffeaee25f@arm.com>
Date:   Tue, 3 Aug 2021 09:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210803043445.7sm4mnl4f5f7co7h@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 8/3/21 5:34 AM, Viresh Kumar wrote:
> On 02-08-21, 21:45, Lukasz Luba wrote:
>> Print warning and return an error which would stop the initialization
>> when cpumask allocation failed.
>>
>> Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/scmi-cpufreq.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index ec9a87ca2dbb..b159123e68fd 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -133,8 +133,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   		return -ENODEV;
>>   	}
>>   
>> -	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
>> -		ret = -ENOMEM;
>> +	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL)) {
>> +		dev_warn(cpu_dev, "failed to allocate cpumask\n");
> 
> We shouldn't be printing here anything I believe as the allocation
> core does it for us. That's why you won't see a print message anywhere
> for failed allocations.

Thanks for the comment. Let me send the v2.
