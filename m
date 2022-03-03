Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D8C433FE
	for <linux-pm@archiver.kernel.org>; Thu,  3 Mar 2022 06:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiCCG6n (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiCCG6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2022 01:58:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D8D013F7C;
        Wed,  2 Mar 2022 22:57:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 671ED1424;
        Wed,  2 Mar 2022 22:57:53 -0800 (PST)
Received: from [10.57.21.106] (unknown [10.57.21.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68FBB3F66F;
        Wed,  2 Mar 2022 22:57:51 -0800 (PST)
Message-ID: <c2dabec3-ffdb-909a-a8dd-f8e77a8108ed@arm.com>
Date:   Thu, 3 Mar 2022 06:57:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/5] Introduce "opp-microwatt" and Energy Model from DT
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220302112917.27270-1-lukasz.luba@arm.com>
 <20220303040539.ocnslxyswnvua3o7@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220303040539.ocnslxyswnvua3o7@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/3/22 04:05, Viresh Kumar wrote:
> On 02-03-22, 11:29, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set solves a few issues:
>> 1. It allows to register EM from DT, when the voltage information is not
>>     available. (Some background of the issues present on Chromebook devices
>>     can be checked at [1].)
>> 2. It allows to register 'advanced' EM from the DT, which is more accurate
>>     and reflects total power (dynamic + static).
>>
>> Implementation details:
>> Existing machinery in the OPP framework now handles "opp-microwatt", similarly
>> to "opp-microamp". It also has helper exported function to get power from OPP.
>> For the EM, it adds a new callback in OPP framework to use this new API and
>> read power while having an opp pointer. It's agreed to work with OPP-v2.
>>
>> Comments, suggestions are very welcome.
>>
>> changelog:
>> v5:
>> - added dual-macro to conditionally setup needed callback and compile
>>    on !EM kernel gently
>> - removed 'advanced' word from OPP patch header description
>> v4 [2]
> 
> Applied. Thanks.
> 

Thank you Viresh for your reviews.

Regards,
Lukasz
