Return-Path: <SRS0=P4yl=BO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1183BC433DF
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 09:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B8322B40
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 09:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgHDJLJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:11:09 -0400
Received: from foss.arm.com ([217.140.110.172]:41630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgHDJLJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 05:11:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2337B1FB;
        Tue,  4 Aug 2020 02:11:08 -0700 (PDT)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777193F718;
        Tue,  4 Aug 2020 02:11:06 -0700 (PDT)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: propagate error from
 exynos5_counters_get()
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <CGME20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d@eucas1p2.samsung.com>
 <20200804061210.5415-1-m.szyprowski@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <24675559-b807-5b80-1318-805c1530ffb3@arm.com>
Date:   Tue, 4 Aug 2020 10:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200804061210.5415-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 8/4/20 7:12 AM, Marek Szyprowski wrote:
> exynos5_counters_get() might fail with -EPROBE_DEFER if the driver for
> devfreq event counter is not yet probed. Propagate that error value to
> the caller to ensure that the exynos5422-dmc driver will be probed again
> when devfreq event contuner is available.
> 
> This fixes boot hang if both exynos5422-dmc and exynos-ppmu drivers are
> compiled as modules.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index b9c7956e5031..639811a3eecb 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -914,7 +914,7 @@ static int exynos5_dmc_get_status(struct device *dev,
>   	} else {
>   		ret = exynos5_counters_get(dmc, &load, &total);
>   		if (ret < 0)
> -			return -EINVAL;
> +			return ret;
>   
>   		/* To protect from overflow, divide by 1024 */
>   		stat->busy_time = load >> 10;
> 

Thank you for the patch, LGTM.
Some questions are still there, though. The function
exynos5_performance_counters_init() should capture that the counters
couldn't be enabled or set. So the functions:
exynos5_counters_enable_edev() and exynos5_counters_set_event()
must pass gently because devfreq device is registered.
Then devfreq checks device status, and reaches the state when
counters 'get' function returns that they are not ready...

If that is a kind of 2-stage initialization, maybe we should add
another 'check' in the exynos5_performance_counters_init() and call
the devfreq_event_get_event() to make sure that we are ready to go,
otherwise return ret from that function (which is probably EPROBE_DEFER)
and not register the devfreq device.

Marek do want to submit such patch or I should bake it and submit on top
of this patch?

Could you tell me how I can reproduce this? Do you simply load one
module after another (exynos-ppmu than exynos5422-dmc) or in parallel?

Regards,
Lukasz
