Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A6C282DD
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1452183E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="UVpcmRab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfDRIxu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:53:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37380 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRIxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 04:53:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so1024444lfl.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 01:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uynYQrHQ9VKE+Hszzp/XNIE6bwIb6ne5eqCgUQiYX7c=;
        b=UVpcmRabaEbAOO3CLDUCJFjAKex9CZboPx7botwHTRx3P+WbAZ5PaQmM1JxyolLIP3
         p9cY4zzbX3cSeY3UNV0Oq54VW6TMxTXrg3BjPZv3XwLHI8APYhX4urJctu4ROLKd2SpX
         8T9zD0IAZt7M6CobE8PPpNHMrpMN3ZpaCR7BvodwG83tscCPSb2cpQP+SyaKPQUomvqJ
         BM2XrwkCWfnvC1w1ZwlJvZaM3HaKsst4B6AFBUxsAiBpnDgluR6mXMGxz0H98Yeah8pZ
         G1ctS8T4ZUlBvmHZn5T06Ukq4FXzF99OCnvrHH0lr5cgg1eRLdZh2RVKVUOUtISLyfr8
         Nksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uynYQrHQ9VKE+Hszzp/XNIE6bwIb6ne5eqCgUQiYX7c=;
        b=fHoyIIOeGSOLK9Ajm/V4wc47sx551DmQeWE2+3Dl6LGWcf/nePBEzUc1D0pSTRNhNF
         suvRIXrJ04102qmxFUCNqphZg4vldVT2rz16LbbHigOqVtzxVuDONLUI9JZffPB+7Kgw
         60unHH9iC+RfXF2A+NMEDrOc+qJ6ntj54t6Kr2znle0ud9Izk4u0J9Z0PB78fnHxB6Zo
         zWVOaQGrGvJj1Zxl04FqfKuzgu8O1X3CmhaoBMp8k0AE1lwR8SF/1fy+51jcEYWmhjrG
         WAhMWgIbvH/NzdQCM09VB3sHRHBDJyGsTedLxdq2VImcNNyBRVDgEjE0CxX3hTIsk+NP
         quRA==
X-Gm-Message-State: APjAAAUZfkPlAt7KckUQVvlLkc9D5DKVh7sDnsYJaQcynQG5zNuhXl3O
        aeA/7uRu0ffPIUTHZva2bCecug==
X-Google-Smtp-Source: APXvYqz1El7LPujk7cUx3dXvzNVGnVsz5Us5CEferqfhNP5At7Vr6dxO/3/aSswRZFScXUlzS4726w==
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr7843961lfm.86.1555577627214;
        Thu, 18 Apr 2019 01:53:47 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id d1sm311909lfa.49.2019.04.18.01.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:53:46 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:53:46 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH/RFT v2 2/3] thermal: rcar_gen3_thermal: Update
 calculation formula of IRQTEMP
Message-ID: <20190418085346.GX28515@bigcity.dyn.berto.se>
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
 <1555436655-5262-3-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555436655-5262-3-git-send-email-ykaneko0929@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kaneko-san,

Thanks for your work.

On 2019-04-17 02:44:14 +0900, Yoshihiro Kaneko wrote:
> Update the formula to calculate CTEMP:
> Currently, the CTEMP is average of val1 (is calculated by
> formula 1) and val2 (is calculated by formula 2). But,
> as description in HWM (chapter 10A.3.1.1 Setting of Normal Mode)
> 
> If (STEMP < Tj_T) CTEMP value should be val1.
> If (STEMP > Tj_T) CTEMP value should be val2.
> 
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index a2fd0fd..97cf3cd 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -77,6 +77,7 @@ struct rcar_gen3_thermal_tsc {
>  	struct equation_coefs coef;
>  	int low;
>  	int high;
> +	int tj_2;
>  };
>  
>  struct rcar_gen3_thermal_priv {
> @@ -126,28 +127,27 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
>  /* no idea where these constants come from */
>  #define TJ_3 -41
>  
> -static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
> +
> +static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
>  					 int *ptat, int *thcode,
>  					 unsigned int ths_tj_1)
>  {
> -	int tj_2;
> -
>  	/* TODO: Find documentation and document constant calculation formula */

Maybe you cold also fix this todo now that the datasheet have been 
updated with 10A.3.1.1 ? This might also impact the equation_coefs 
structure.

>  
>  	/*
>  	 * Division is not scaled in BSP and if scaled it might overflow
>  	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
>  	 */
> -	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> -		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
> +	tsc->tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> +		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);

I think tj_2 should be renamed to match the names in the datasheet, it's 
Tj_T from 10A.3.1.1 right?

>  
> -	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> -			     tj_2 - FIXPT_INT(TJ_3));
> -	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
> +	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> +				 tsc->tj_2 - FIXPT_INT(TJ_3));
> +	tsc->coef.b1 = FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
>  
> -	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> -			     tj_2 - FIXPT_INT(ths_tj_1));
> -	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
> +	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> +				 tsc->tj_2 - FIXPT_INT(ths_tj_1));
> +	tsc->coef.b2 = FIXPT_INT(thcode[0]) - tsc->coef.a2 * ths_tj_1;
>  }
>  
>  static int rcar_gen3_thermal_round(int temp)
> @@ -186,13 +186,15 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
>  static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
>  					      int mcelsius)
>  {
> -	int celsius, val1, val2;
> +	int celsius, val;
>  
>  	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
> -	val1 = celsius * tsc->coef.a1 + tsc->coef.b1;
> -	val2 = celsius * tsc->coef.a2 + tsc->coef.b2;
> +	if (celsius <= INT_FIXPT(tsc->tj_2))
> +		val = celsius * tsc->coef.a1 + tsc->coef.b1;
> +	else
> +		val = celsius * tsc->coef.a2 + tsc->coef.b2;
>  
> -	return INT_FIXPT((val1 + val2) / 2);
> +	return INT_FIXPT(val);
>  }
>  
>  static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> @@ -440,7 +442,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		priv->tscs[i] = tsc;
>  
>  		priv->thermal_init(tsc);
> -		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
> +		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcode[i],
>  					     *rcar_gen3_ths_tj_1);
>  
>  		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
> -- 
> 1.9.1
> 

-- 
Regards,
Niklas Söderlund
