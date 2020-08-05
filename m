Return-Path: <SRS0=bDVj=BP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85335C433DF
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447D72075D
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgHETYP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:24:15 -0400
Received: from foss.arm.com ([217.140.110.172]:33804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgHER1g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 13:27:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD457D6E;
        Wed,  5 Aug 2020 04:04:46 -0700 (PDT)
Received: from [10.37.12.81] (unknown [10.37.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C2F3FA32;
        Wed,  5 Aug 2020 04:04:44 -0700 (PDT)
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
Date:   Wed, 5 Aug 2020 12:04:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/4/20 6:27 PM, Florian Fainelli wrote:
> 
> 
> On 7/29/2020 8:12 AM, Lukasz Luba wrote:
>> Hi all,
>>
>> The existing CPUFreq framework does not tracks the statistics when the
>> 'fast switch' is used or when firmware changes the frequency independently
>> due to e.g. thermal reasons. However, the firmware might track the frequency
>> changes and expose this to the kernel.
> 
> Or the firmware might have changed the CPU frequency in response to a
> request from the secure world for instance.

Possible

> 
>>
>> This patch set aims to introduce CPUfreq statistics gathered by firmware
>> and retrieved by CPUFreq driver. It would require a new API functions
>> in the CPUFreq, which allows to poke drivers to get these stats.
> 
>  From a debugging perspective, it would be helpful if the firmware
> maintained statistics were exposed as a super-set of the Linux cpufreq
> statistics and aggregated into them such that you could view the normal
> world vs. secure world residency of a given frequency point. This would
> help because a lot of times, Linux requests freq X, but the secure world
> requires freq Y (with X >= Y) and people do not really understand why
> the resulting power usage is higher for instance.
> 
> What are your thoughts on this?
> 

I know that Viresh is going to develop patches and improve these
cpufreq stats framework. Maybe he also had this 'aggregation' in mind.
I will leave it him.

Thank you for your feedback.

Regards,
Lukasz



