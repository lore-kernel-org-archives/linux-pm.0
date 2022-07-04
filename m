Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B580C43334
	for <linux-pm@archiver.kernel.org>; Mon,  4 Jul 2022 07:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiGDHf6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 Jul 2022 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiGDHf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 03:35:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFF395A5;
        Mon,  4 Jul 2022 00:35:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E0B023A;
        Mon,  4 Jul 2022 00:35:55 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CB8D3F792;
        Mon,  4 Jul 2022 00:35:53 -0700 (PDT)
Message-ID: <ad8dd950-9260-16b3-2134-72984e2ba261@arm.com>
Date:   Mon, 4 Jul 2022 08:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Todd Kjos <tkjos@google.com>,
        Wei Wang <wvw@google.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-6-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-6-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

(+Todd and Wei on CC)


On 7/3/22 19:30, Daniel Lezcano wrote:
> Different functions are exporting the symbols but are actually only
> used by the thermal framework internals. Remove these EXPORT_SYMBOLS.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_helpers.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 3edd047e144f..f4c1e87ef040 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
>   
>   	return trend;
>   }
> -EXPORT_SYMBOL(get_tz_trend);
>   
>   struct thermal_instance *
>   get_thermal_instance(struct thermal_zone_device *tz,
> @@ -228,7 +227,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>   	}
>   	mutex_unlock(&cdev->lock);
>   }
> -EXPORT_SYMBOL(thermal_cdev_update);

I wouldn't remove that export. I can see in my Pixel6 modules dir, that
it's called in 7 places.

I assume that in Android world this is common use.

Regards,
Lukasz
