Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BBC10F0B
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A605021872
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="dkfEkQ8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbfDRIRk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:17:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46093 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388237AbfDRIRk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 04:17:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so916968lfj.13
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvSsqjhshhEc2UeorKO7l/ArDQUOA+Teur6eqypkC9M=;
        b=dkfEkQ8dAU+6aYTITEdONvYeBPkPuVbfhQAxEyDqmPLE6Oj8hdvgrPBrGhidyB1TqK
         D2rPxi+YL414vTQBk8sv0KxZPVtHGgmUblJIO7UOVnBOTYdhfaju8vzR4Sw9yHa5vztv
         kvpbbSA78XLfzuK3kWavbXb+esiBgGAxdXOtwJSGASduHe226cdC/uItsSNjsX2Tes2s
         vzpzGIS1mRAf8WtdybQF4LoA7lg6M6QN8xVLxWWQ3WekJN+lXsOqbb0otrk1MWgnZyZS
         7EnshockQi5z4qB65Y9b3XayIwKQhaAcmRQnT32XW833+QLo0HbjLnMs1hq0ay0lnXHd
         9O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvSsqjhshhEc2UeorKO7l/ArDQUOA+Teur6eqypkC9M=;
        b=SQCuj7de2XZvvfmoXZ100/4lVBBaJfOkW/NCEPXfm65v3wg29/8difMWirhLNImwXZ
         1boE41piR89NMm5u9TbCEz6AxBCjHOIePg2v56in1WmxgMEYRuiPXL8zGdZsX5bDzxhE
         ZC8XFoOQ/5Lo6NOh9byKqDRV6IwDx5I7kagtXWMMhUCdEePUEDzfP4fEqQeG71WdyIxc
         PuVjPLZqc+zeF7c7L2yMnSeU/hUGRPDpT/mFa5Lq73PM91BAw+KFadZp72Nt18SQ64t4
         uqSg1sUrBOecDZVWJbeJmp+jIaihIzkhciQ6sKyBkjDtmrb9YFaQlv6UE8f1KzU9UULM
         Q81A==
X-Gm-Message-State: APjAAAUiflA6dyrkzznVreWCcv7PSLlYuURfGiYApSsznJThlwjw+kVp
        wYvi7QDFbzivRTg9Eu5unrq4Rg==
X-Google-Smtp-Source: APXvYqw+u+RdV1sg2E2wGaQ82ZPXnF8RTdIl081qrKZ1pyOKjGXv5lkAuL6hlqHhg4CZpwm0fMCaAA==
X-Received: by 2002:ac2:5c10:: with SMTP id r16mr8811887lfp.40.1555575458486;
        Thu, 18 Apr 2019 01:17:38 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.81.133])
        by smtp.gmail.com with ESMTPSA id i25sm299208lfc.19.2019.04.18.01.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 01:17:37 -0700 (PDT)
Subject: Re: [PATCH repost] thermal: rcar_thermal: update calculation formula
 for E3
To:     Simon Horman <horms+renesas@verge.net.au>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
References: <20190418071514.13027-1-horms+renesas@verge.net.au>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <bd0c1fc6-782d-36b7-5916-1fda21d54145@cogentembedded.com>
Date:   Thu, 18 Apr 2019 11:17:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418071514.13027-1-horms+renesas@verge.net.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.04.2019 10:15, Simon Horman wrote:

> From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> HW manual changes temperature calculation formula for E3:
> - When CTEMP is less than 24
>     T = CTEMP[5:0] * 5.5 - 72
> - When CTEMP is equal to/greater than 24
>     T = CTEMP[5:0] * 5 - 60
> 
> This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>
> 
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   drivers/thermal/rcar_thermal.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 97462e9b40d8..11df0cc63bed 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
[...]
> @@ -263,7 +267,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
>   		return ret;
>   
>   	mutex_lock(&priv->lock);
> -	tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> +	if (priv->chip->ctemp_bands == 1)
> +		tmp =  MCELSIUS((priv->ctemp * 5) - 65);
                      ^ stray space?

> +	else if (priv->ctemp < 24)
> +		tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> +	else
> +		tmp = MCELSIUS((priv->ctemp * 5) - 60);
>   	mutex_unlock(&priv->lock);
>   
>   	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {

MBR, Sergei
