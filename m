Return-Path: <SRS0=+UCx=EJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2888C2D0A3
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 08:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5177720786
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 08:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgKCI2o (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Nov 2020 03:28:44 -0500
Received: from foss.arm.com ([217.140.110.172]:44118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCI2o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 03:28:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1454E139F;
        Tue,  3 Nov 2020 00:28:44 -0800 (PST)
Received: from [10.57.19.30] (unknown [10.57.19.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6B1A3F718;
        Tue,  3 Nov 2020 00:28:38 -0800 (PST)
Subject: Re: [PATCH v3 2/4] docs: Clarify abstract scale usage for power
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
 <20201019140601.3047-3-lukasz.luba@arm.com>
 <20201102134536.GB2221764@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a4985699-18ff-d35d-734e-ce4af1f2d653@arm.com>
Date:   Tue, 3 Nov 2020 08:28:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201102134536.GB2221764@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/2/20 1:45 PM, Quentin Perret wrote:
> On Monday 19 Oct 2020 at 15:05:59 (+0100), Lukasz Luba wrote:
>> diff --git a/Documentation/driver-api/thermal/power_allocator.rst b/Documentation/driver-api/thermal/power_allocator.rst
>> index 67b6a3297238..b7992ae84fef 100644
>> --- a/Documentation/driver-api/thermal/power_allocator.rst
>> +++ b/Documentation/driver-api/thermal/power_allocator.rst
>> @@ -71,7 +71,10 @@ to the speed-grade of the silicon.  `sustainable_power` is therefore
>>   simply an estimate, and may be tuned to affect the aggressiveness of
>>   the thermal ramp. For reference, the sustainable power of a 4" phone
>>   is typically 2000mW, while on a 10" tablet is around 4500mW (may vary
>> -depending on screen size).
>> +depending on screen size). It is possible to have the power value
>> +expressed in an abstract scale. This is the case when the Energy Model
>> +provides the power values in an abstract scale.
> 
> Maybe remove one of the 2 sentences?

I will remove the 2nd sentence.

> 
> Thanks,
> Quentin
> 
