Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59F8C433DB
	for <linux-pm@archiver.kernel.org>; Mon, 18 Jan 2021 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7354122C7E
	for <linux-pm@archiver.kernel.org>; Mon, 18 Jan 2021 17:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393506AbhARRRB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:17:01 -0500
Received: from foss.arm.com ([217.140.110.172]:39796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390188AbhARRQ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 12:16:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D7F31B;
        Mon, 18 Jan 2021 09:15:42 -0800 (PST)
Received: from [10.57.2.166] (unknown [10.57.2.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8D4A3F719;
        Mon, 18 Jan 2021 09:15:40 -0800 (PST)
Subject: Re: [PATCH] thermal: power allocator: Add control for non-power actor
 devices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210105190107.30479-1-lukasz.luba@arm.com>
 <3b98cbfa-3bfb-607c-aa4d-2c2ef3e61990@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2550a12b-aed6-dd89-0260-69241d04d39b@arm.com>
Date:   Mon, 18 Jan 2021 17:15:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3b98cbfa-3bfb-607c-aa4d-2c2ef3e61990@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/18/21 4:07 PM, Daniel Lezcano wrote:
> On 05/01/2021 20:01, Lukasz Luba wrote:
>> The cooling devices which are used in IPA should provide power mapping
>> functions. The callback functions are used for power estimation and state
>> setting. When these functions are missing IPA ignores such cooling devices
>> and does not limit their performance. It could happen that the platform
>> configuration is missing these functions in example when the Energy Model
>> was not setup properly (missing DT entry 'dynamic-power-coefficient').
>>
>> The patch adds basic control over these devices' performance. It
>> manages to throttle them to stay safe and not overheat. It also adds a
>> warning during the binding phase, so it can be captured during testing.
>>
>> The patch covers also a corner case when all of the cooling devices are
>> non-power actors.
> 
> In my opinion this is a user space problem. If a device does not have
> power information, then it should use the step-wise governor instead.
> 
> It is not the power allocator to overcome a wrong or unsupported setup.
> 
> Usually, the default governor is the step-wise and the userspace sets
> the power allocator policy.

True, but currently there is even no warning to the user, that some
device (quite big, like GPU) is not controlled. This could be dangerous.

> 
> A solution can be to fail to change the policy or bind if the associated
> cooling devices are not all power actors.

I tend to agree, we can simply 'fail' during the binding and print
some warning.

The code in that case would be much simpler. Let me send a v2 then.
Thank you for your comments.

Regards,
Lukasz
