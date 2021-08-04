Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45DC4338F
	for <linux-pm@archiver.kernel.org>; Wed,  4 Aug 2021 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7C960231
	for <linux-pm@archiver.kernel.org>; Wed,  4 Aug 2021 10:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhHDKvU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:51:20 -0400
Received: from foss.arm.com ([217.140.110.172]:59130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236736AbhHDKvT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Aug 2021 06:51:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1000813A1;
        Wed,  4 Aug 2021 03:51:07 -0700 (PDT)
Received: from [10.57.10.145] (unknown [10.57.10.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E6FF3F719;
        Wed,  4 Aug 2021 03:51:04 -0700 (PDT)
Subject: Re: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation
 failed
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, cristian.marussi@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20210803090744.12143-1-lukasz.luba@arm.com>
 <20210803224145.zyr36sliwa7a67xf@bogus>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <34c0a16b-4f82-8c78-9e29-63d462ea68b8@arm.com>
Date:   Wed, 4 Aug 2021 11:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210803224145.zyr36sliwa7a67xf@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/3/21 11:41 PM, Sudeep Holla wrote:
> On Tue, Aug 03, 2021 at 10:07:44AM +0100, Lukasz Luba wrote:
>> Stop the initialization when cpumask allocation failed and return an
>> error.
>>
> 
> Good catch!
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thank you for the review!
