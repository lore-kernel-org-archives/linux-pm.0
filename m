Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BDC0015E
	for <linux-pm@archiver.kernel.org>; Fri,  4 Aug 2023 01:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjHDBSp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Aug 2023 21:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDBSo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 21:18:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F2E4204
        for <linux-pm@vger.kernel.org>; Thu,  3 Aug 2023 18:18:43 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RH777547FzNmkn;
        Fri,  4 Aug 2023 09:15:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:18:41 +0800
Message-ID: <af6a09a5-1875-7ffe-b800-d80b4f9e18ac@huawei.com>
Date:   Fri, 4 Aug 2023 09:18:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] power: supply: 88pm860x_battery: fix the return
 value handle for platform_get_irq()
Content-Language: en-US
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>
References: <20230731113959.1957820-1-ruanjinjie@huawei.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230731113959.1957820-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ping.

On 2023/7/31 19:39, Ruan Jinjie wrote:
> There is no possible for platform_get_irq() to return 0,
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/power/supply/88pm860x_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
> index f3f3f8cd1a7f..34619c4d4ece 100644
> --- a/drivers/power/supply/88pm860x_battery.c
> +++ b/drivers/power/supply/88pm860x_battery.c
> @@ -921,12 +921,12 @@ static int pm860x_battery_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	info->irq_cc = platform_get_irq(pdev, 0);
> -	if (info->irq_cc <= 0)
> -		return -EINVAL;
> +	if (info->irq_cc < 0)
> +		return info->irq_cc;
>  
>  	info->irq_batt = platform_get_irq(pdev, 1);
> -	if (info->irq_batt <= 0)
> -		return -EINVAL;
> +	if (info->irq_batt < 0)
> +		return info->irq_batt;
>  
>  	info->chip = chip;
>  	info->i2c =
