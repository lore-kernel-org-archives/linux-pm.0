Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE7C433ED
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BBD61435
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 17:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDVRee (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:34:34 -0400
Received: from foss.arm.com ([217.140.110.172]:54458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236681AbhDVRee (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 13:34:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A7E11063;
        Thu, 22 Apr 2021 10:33:59 -0700 (PDT)
Received: from [10.57.27.187] (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC22B3F694;
        Thu, 22 Apr 2021 10:33:57 -0700 (PDT)
Subject: Re: [PATCH 0/3] Thermal governors improvements and a fix
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210422153624.6074-1-lukasz.luba@arm.com>
 <25ceedef-f3eb-0187-7397-9d4ca30fcb93@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d783748d-105d-5919-6550-442229dd612a@arm.com>
Date:   Thu, 22 Apr 2021 18:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <25ceedef-f3eb-0187-7397-9d4ca30fcb93@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/22/21 6:31 PM, Daniel Lezcano wrote:
> On 22/04/2021 17:36, Lukasz Luba wrote:
>> Hi all,
>>
>> The patch set introduces one fix (patch 1/3) and two improvements, which
>> are possible thanks to the new helper function [1].
>> The patch 1/3 with a fix for fair share thermal governor is also sent
>> CC'ed stable, but it's hard to point a particular commit, which back
>> then was for fair_share.c.
>>
>> The patch set should apply on top of [1].
>>
>> Regards,
>> Lukasz
>>
>> [1] https://lore.kernel.org/linux-pm/20210422114308.29684-2-lukasz.luba@arm.com/
>>
>> Lukasz Luba (3):
>>    thermal: fair share: lock thermal zone while looping over instances
>>    thermal: fair share: use __thermal_cdev_update()
>>    thermal: power allocator: use __thermal_cdev_update()
>>
>>   drivers/thermal/gov_fair_share.c      | 11 +++++++----
>>   drivers/thermal/gov_power_allocator.c |  3 +--
>>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> Applied, thanks

thanks!

> 
> Two users left of thermal_cdev_update ;)
> 
> 

True, I didn't dare to touch them, since that would require more
work and understandings :)
