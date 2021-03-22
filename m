Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5292AC433E0
	for <linux-pm@archiver.kernel.org>; Mon, 22 Mar 2021 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6EA619A4
	for <linux-pm@archiver.kernel.org>; Mon, 22 Mar 2021 19:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhCVTCM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhCVTB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 15:01:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2EC061574;
        Mon, 22 Mar 2021 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=PqoPQc7AEbXzxG+B43ywR2urtRwkAdqziap8FsINiiw=; b=T5o7ES6g3Ork9494taW79YM0vQ
        +MwQRAgET2k0h/fxYTOnpSHbnb6URBkZKxIKQmZwaDPTQq/O7IdgX3h+P2xyjwHhZvqbAd1IkbA1Q
        zehS28DJ0O0OCvat3eH9+rG77JyfTUNvonpawrERyMs/TcT0YKc2U0WYR+ABRThm8S6nSsqncj++e
        6098FLosAWKIBmTrc2d8BjQvEglwXn8mVOG4imQKq+tRShHAoCRlmmHqUYCasZvZg7oQCssm/JHQ2
        t/F7evobp0G9MY0qgct47DXHdJ/w1wE2JAJLjRLVfKpu7iLt6N9ZBtn6TO7kT11EIMdVSGgxpo7z1
        y/DEc4CA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPni-008wtt-MT; Mon, 22 Mar 2021 19:01:32 +0000
Subject: Re: [PATCH] thermal: Fix a typo in the file soctherm.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210305015320.7614-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <176c4f5c-44d2-f29b-49fe-dd4bcec36f7e@infradead.org>
Date:   Mon, 22 Mar 2021 12:01:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305015320.7614-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/4/21 5:53 PM, Bhaskar Chowdhury wrote:
> 
> s/calibaration/calibration/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 66e0639da4bf..8b8fbd49679b 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -2195,7 +2195,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
> 
> -	/* calculate tsensor calibaration data */
> +	/* calculate tsensor calibration data */
>  	for (i = 0; i < soc->num_tsensors; ++i) {
>  		err = tegra_calc_tsensor_calib(&soc->tsensors[i],
>  					       &shared_calib,
> --


-- 
~Randy

