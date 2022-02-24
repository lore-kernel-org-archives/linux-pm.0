Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7EC433EF
	for <linux-pm@archiver.kernel.org>; Thu, 24 Feb 2022 09:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiBXJfZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiBXJfZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:35:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D942285703;
        Thu, 24 Feb 2022 01:34:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C160CED1;
        Thu, 24 Feb 2022 01:34:42 -0800 (PST)
Received: from [10.57.8.211] (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE37C3F70D;
        Thu, 24 Feb 2022 01:34:40 -0800 (PST)
Message-ID: <bf55d126-cee2-2762-9285-c143ff321bc9@arm.com>
Date:   Thu, 24 Feb 2022 09:34:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] OPP: Add "opp-microwatt" supporting code
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-3-lukasz.luba@arm.com>
 <20220224090325.m4pl36ma3uettxvg@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220224090325.m4pl36ma3uettxvg@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/24/22 09:03, Viresh Kumar wrote:
> On 24-02-22, 08:11, Lukasz Luba wrote:
>> +/**
>> + * dev_pm_opp_get_power() - Gets the power corresponding to an opp
>> + * @opp:	opp for which power has to be returned for
>> + *
>> + * Return: power in micro watt corresponding to the opp, else
>> + * return 0
>> + *
>> + * This is useful only for devices with single power supply.
>> + */
>> +unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
>> +{
>> +	if (IS_ERR_OR_NULL(opp)) {
>> +		pr_err("%s: Invalid parameters\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	return opp->supplies[0].u_watt;
> 
> What about returning the total of all u_watts for this OPP here ?
> Surely it doesn't make sense to do the same for voltage and current,
> but power is different.
> 

OK, I'll do the summation of all used supplies' power here.
