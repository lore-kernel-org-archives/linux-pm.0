Return-Path: <SRS0=Wbju=TJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA38C04AB1
	for <linux-pm@archiver.kernel.org>; Thu,  9 May 2019 12:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7821479
	for <linux-pm@archiver.kernel.org>; Thu,  9 May 2019 12:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEIMnn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 May 2019 08:43:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54280 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEIMnn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 08:43:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 10ADC27E935
Subject: Re: [PATCH] power: supply: ucs1002: Fix checking return value of
 devm_regulator_register
To:     Axel Lin <axel.lin@ingics.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org
References: <20190509122636.21885-1-axel.lin@ingics.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <30675991-52ee-7954-ca91-74bd3c39d242@collabora.com>
Date:   Thu, 9 May 2019 14:43:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509122636.21885-1-axel.lin@ingics.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Axel,

Probably makes sense squash the both patches that you sent regarding ucs1002.

On 9/5/19 14:26, Axel Lin wrote:
> Current code checks wrong return value, it should check rdev rather than
> info->charger. Fix it.
> 

That should probably include a Fixes tag.

> Signed-off-by: Axel Lin <axel.lin@ingics.com>

The change itself:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/power/supply/ucs1002_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> index d66b4eff9b7a..33409b13232a 100644
> --- a/drivers/power/supply/ucs1002_power.c
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -592,7 +592,7 @@ static int ucs1002_probe(struct i2c_client *client,
>  
>  	rdev = devm_regulator_register(dev, info->regulator_descriptor,
>  				       &regulator_config);
> -	ret = PTR_ERR_OR_ZERO(info->charger);
> +	ret = PTR_ERR_OR_ZERO(rdev);
>  	if (ret) {
>  		dev_err(dev, "Failed to register VBUS regulator: %d\n", ret);
>  		return ret;
> 
Thanks,
 Enric
