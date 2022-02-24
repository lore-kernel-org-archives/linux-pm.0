Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEFDC433EF
	for <linux-pm@archiver.kernel.org>; Thu, 24 Feb 2022 09:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiBXJOh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBXJOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:14:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C024D19E0A5;
        Thu, 24 Feb 2022 01:14:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67431D6E;
        Thu, 24 Feb 2022 01:14:07 -0800 (PST)
Received: from [10.57.8.211] (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009443F70D;
        Thu, 24 Feb 2022 01:14:04 -0800 (PST)
Message-ID: <d018a6f0-15f2-b474-9688-6c42010e7dbf@arm.com>
Date:   Thu, 24 Feb 2022 09:14:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/4] dt-bindings: opp: Add "opp-microwatt" entry in the
 OPP
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-2-lukasz.luba@arm.com>
 <20220224090120.3f7sp23hism3wd36@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220224090120.3f7sp23hism3wd36@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/24/22 09:01, Viresh Kumar wrote:
> On 24-02-22, 08:11, Lukasz Luba wrote:
>> Add new entry for the OPP which provides information about power
>> expressed in micro-Watts. It is useful for the Energy Model framework.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   .../devicetree/bindings/opp/opp-v2-base.yaml      | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
> 
> Also need to update patternProperties section I think.
> 

You're right. If that would be the only thing for the patch set,
I will just resend this patch 1/4 below this thread.

Thank you for having a look at it.
