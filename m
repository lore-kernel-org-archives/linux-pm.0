Return-Path: <SRS0=+UCx=EJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8EEC2D0A3
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 08:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E1922275
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 08:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgKCI1C (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Nov 2020 03:27:02 -0500
Received: from foss.arm.com ([217.140.110.172]:44082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCI1B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 03:27:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42DF1139F;
        Tue,  3 Nov 2020 00:27:01 -0800 (PST)
Received: from [10.57.19.30] (unknown [10.57.19.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E17E63F718;
        Tue,  3 Nov 2020 00:26:56 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v3 1/4] PM / EM: Add a flag indicating units of power
 values in Energy Model
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        amitk@kernel.org, corbet@lwn.net, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rafael@kernel.org, sudeep.holla@arm.com, viresh.kumar@linaro.org,
        sboyd@kernel.org, nm@ti.com
References: <20201019140601.3047-1-lukasz.luba@arm.com>
 <20201019140601.3047-2-lukasz.luba@arm.com>
 <20201102134323.GA2221764@google.com>
Message-ID: <c42109be-74d3-0529-5188-694586afb840@arm.com>
Date:   Tue, 3 Nov 2020 08:26:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201102134323.GA2221764@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/2/20 1:43 PM, Quentin Perret wrote:
> On Monday 19 Oct 2020 at 15:05:58 (+0100), Lukasz Luba wrote:
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index b67a51c574b9..2c31d79bb922 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -29,6 +29,8 @@ struct em_perf_state {
>>    * em_perf_domain - Performance domain
>>    * @table:		List of performance states, in ascending order
>>    * @nr_perf_states:	Number of performance states
>> + * @milliwatts:		Flag indicating the power values are in milli-Watts
>> + *			or some other scale.
>>    * @cpus:		Cpumask covering the CPUs of the domain. It's here
>>    *			for performance reasons to avoid potential cache
>>    *			misses during energy calculations in the scheduler
>> @@ -43,6 +45,7 @@ struct em_perf_state {
>>   struct em_perf_domain {
>>   	struct em_perf_state *table;
>>   	int nr_perf_states;
>> +	bool milliwatts;
>>   	unsigned long cpus[];
>>   };
> 
> Make that an int please, sizeof(bool) is impdef.

OK, I will change it.

> 
> With that:
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> 

Thank you for the review.
