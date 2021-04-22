Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7AEC433B4
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 08:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1128D61426
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 08:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhDVIWK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 22 Apr 2021 04:22:10 -0400
Received: from foss.arm.com ([217.140.110.172]:48148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235075AbhDVIWJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 04:22:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6867511D4;
        Thu, 22 Apr 2021 01:21:34 -0700 (PDT)
Received: from [10.57.27.187] (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 232753F774;
        Thu, 22 Apr 2021 01:21:32 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] thermal: create a helper __thermal_cdev_update()
 without a lock
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210421174145.8213-1-lukasz.luba@arm.com>
 <20210421174145.8213-4-lukasz.luba@arm.com>
 <3d08d5cf-9e3b-ae26-cfd5-bf9a40d11643@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <eafc2eb1-5b0f-61b9-b992-339a5a962fbd@arm.com>
Date:   Thu, 22 Apr 2021 09:21:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3d08d5cf-9e3b-ae26-cfd5-bf9a40d11643@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/22/21 8:58 AM, Daniel Lezcano wrote:
> On 21/04/2021 19:41, Lukasz Luba wrote:
>> There is a need to have a helper function which updates cooling device
>> state from the governors code. With this change governor can use
>> lock and unlock while calling helper function. This avoid unnecessary
>> second time lock/unlock which was in previous solution present in
>> governor implementation. This new helper function must be called
>> with mutex 'cdev->lock' hold.
>>
>> The changed been discussed and part of code presented in thread:
>> https://lore.kernel.org/linux-pm/20210419084536.25000-1-lukasz.luba@arm.com/
>>
>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c |  5 +----
>>   drivers/thermal/thermal_core.h        |  1 +
>>   drivers/thermal/thermal_helpers.c     | 28 +++++++++++++++++----------
> 
> Why not add this patch first (without the ipa changes) and then replace
> patch 2 by using the new function ? That will prevent to go back and forth.

I thought that it would show also the motivation and usage in the
governor. I can had this patch as first in the set, but then I thought
about this example.
I can change it if you like in v4.

