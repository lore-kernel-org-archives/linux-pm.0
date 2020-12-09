Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301DC1B0D9
	for <linux-pm@archiver.kernel.org>; Wed,  9 Dec 2020 15:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCB72251E
	for <linux-pm@archiver.kernel.org>; Wed,  9 Dec 2020 15:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgLIPyv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:54:51 -0500
Received: from foss.arm.com ([217.140.110.172]:36484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731237AbgLIPya (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Dec 2020 10:54:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F481FB;
        Wed,  9 Dec 2020 07:53:31 -0800 (PST)
Received: from [10.57.24.55] (unknown [10.57.24.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE1C3F68F;
        Wed,  9 Dec 2020 07:53:29 -0800 (PST)
Subject: Re: [PATCH RFC 1/4] thermal/core: Emit a warning if the thermal zone
 is updated without ops
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        kai.heng.feng@canonical.com
References: <20201209153440.27643-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <292183a9-deef-b8fe-c3a8-3ee39211808d@arm.com>
Date:   Wed, 9 Dec 2020 15:53:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201209153440.27643-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 12/9/20 3:34 PM, Daniel Lezcano wrote:
> The actual code is silently ignoring a thermal zone update when a
> driver is requesting it without a get_temp ops set.
> 
> That looks not correct, as the caller should not have called this
> function if the thermal zone is unable to read the temperature.
> 
> That makes the code less robust as the check won't detect the driver
> is inconsistently using the thermal API and that does not help to
> improve the framework as these circumvolutions hide the problem at the
> source.
> 
> In order to detect the situation when it happens, let's add a warning
> when the update is requested without the get_temp() ops set.
> 
> Any warning emitted will have to be fixed at the source of the
> problem: the caller must not call thermal_zone_device_update if there
> is not get_temp callback set.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index dee40ff41177..afc02e7d1045 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -548,7 +548,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>   	if (atomic_read(&in_suspend))
>   		return;
>   
> -	if (!tz->ops->get_temp)
> +	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
> +		      "'get_temp' ops set\n", __FUNCTION__))
>   		return;
>   
>   	update_temperature(tz);
> 

With this RFC and the link that you gave me in previous thread, I see
the motivation.

I would change __FUNCTION__ into __func__, but other than that LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
