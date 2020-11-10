Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E0C388F7
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C650220781
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 10:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJKCF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:02:05 -0500
Received: from foss.arm.com ([217.140.110.172]:53030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJKCF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 05:02:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 537C411D4;
        Tue, 10 Nov 2020 02:02:04 -0800 (PST)
Received: from [10.57.21.178] (unknown [10.57.21.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F2E93F6CF;
        Tue, 10 Nov 2020 02:02:02 -0800 (PST)
Subject: Re: [PATCH 1/4] units: Add Watt units
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <318f6f32-d1d5-d471-edf1-a3e927ccf97f@arm.com>
Date:   Tue, 10 Nov 2020 10:02:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201006122024.14539-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/6/20 1:20 PM, Daniel Lezcano wrote:
> As there are the temperature units, let's add the Watt macros definition.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   include/linux/units.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/units.h b/include/linux/units.h
> index aaf716364ec3..92c234e71cab 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -4,6 +4,10 @@
>   
>   #include <linux/kernel.h>
>   
> +#define MILLIWATT_PER_WATT	1000L
> +#define MICROWATT_PER_MILLIWATT	1000L
> +#define MICROWATT_PER_WATT	1000000L
> +
>   #define ABSOLUTE_ZERO_MILLICELSIUS -273150
>   
>   static inline long milli_kelvin_to_millicelsius(long t)
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
