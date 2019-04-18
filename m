Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF507C10F14
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2162183F
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="g3jAm0CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfDRIkp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:40:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36526 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbfDRIkp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 04:40:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so1212692ljg.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cArhEFZGPPfEiTxA7vLvWVzhgIV0UdkNbCdFBxlJ8p8=;
        b=g3jAm0CQJX7KvQJMHtN3pPdt19RkZmcJKlXM0ugKKGDciNDdOlehNqPn7Sdh7zwEKB
         /+vLKgWD9BZ//jpLfYZCSH6CLq5xPK5YkVNjK98X3EtI+6cvYEEvFWjSysDW9s+9gQXN
         lftoo3Gzh4ziuzhNyfPKCvIXWJxOz/G3nqe2rDPEMoqO+ZpPxQj0XJA+YicrwalNIIwe
         c0f0QBuMU16KFmnWs2sJpyaRPvI1m0ecliZB11ZoWQCsjPvWaXRDRglnPlfigQmGP17a
         ptzxnI824vzoM1xQAm7+JGgJjiMGzHnf+PPnTeFtKIaGKTo8lt7MzuYKEqSR+G+0sFaG
         /hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cArhEFZGPPfEiTxA7vLvWVzhgIV0UdkNbCdFBxlJ8p8=;
        b=JYIg1xffuw4Hz60rzCOUyn7AZ62ItWLXs8kmmfJCLvJ+Hz70nsuNAQM/QFzQ7icvGA
         YtmCj71XRt62e94qWFIDi4pY+0DIjjIw41fUgfDQGlk/o67+gQPF+U/gtWPmkMHwj4XL
         vHNkB9PQLVMrlkCnChEu4/1bx4ioRMb2Z0qkXoUir1nvFngkEWzHdhDLsIXLH2Oa93fm
         uVB2kXQFMkr4bR9sj8zN4AY24h/YUKhg3uCvv4GYCIDdqeoXL9MieTJC+I/1EImjRuIs
         mWh93i34aOPIMtP4EvJWq6S7bHa5JVAh1H7nmJZc7YYXZTdku0JY+/QxTgNSvbGeOJy0
         6QTg==
X-Gm-Message-State: APjAAAWssLbkuhbcAAKoN0FDVEiZ5Hng6YgksRdKGgZ4Su5yh20JtPQy
        +Lw4/1moI4Zqj0IVPcaBrAOONg==
X-Google-Smtp-Source: APXvYqwJvH36MBaicmoLveX6F7pqcdLq34gspejubHob7SNZ4AQZ6tGAiIRxDlcjLTO15XfqO3ilQw==
X-Received: by 2002:a05:651c:c3:: with SMTP id 3mr41305346ljr.8.1555576842475;
        Thu, 18 Apr 2019 01:40:42 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id d16sm310417lfi.75.2019.04.18.01.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:40:41 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:40:41 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH/RFT v2 1/3] thermal: rcar_gen3_thermal: Update value of
 Tj_1
Message-ID: <20190418084041.GW28515@bigcity.dyn.berto.se>
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
 <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kaneko-san,

Thanks for your work.

On 2019-04-17 02:44:13 +0900, Yoshihiro Kaneko wrote:
> As evaluation of hardware team, temperature calculation formula
> of M3-W is difference from all other SoCs as below:
> - M3-W: Tj_1: 116 (so Tj_1 - Tj_3 = 157)
> - Others: Tj_1: 126 (so Tj_1 - Tj_3 = 167)
> 
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 41 +++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41c..a2fd0fd 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -124,11 +124,11 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
>  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
>  
>  /* no idea where these constants come from */
> -#define TJ_1 116
>  #define TJ_3 -41
>  
>  static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
> -					 int *ptat, int *thcode)
> +					 int *ptat, int *thcode,
> +					 unsigned int ths_tj_1)

I would move tj_1 inside struce rcar_gen3_thermal_tsc as you in 2/3 move 
tj_2 there. You could still keep the value in .data but init the tj_1 in 
the struct at probe instead of passing it as an argument.

>  {
>  	int tj_2;
>  
> @@ -139,15 +139,15 @@ static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
>  	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
>  	 */
>  	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> -		/ (ptat[0] - ptat[2])) - FIXPT_INT(41);
> +		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
>  
>  	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
>  			     tj_2 - FIXPT_INT(TJ_3));
>  	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
>  
>  	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> -			     tj_2 - FIXPT_INT(TJ_1));
> -	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * TJ_1;
> +			     tj_2 - FIXPT_INT(ths_tj_1));
> +	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
>  }
>  
>  static int rcar_gen3_thermal_round(int temp)
> @@ -318,12 +318,29 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>  	usleep_range(1000, 2000);
>  }
>  
> +static const unsigned int rcar_gen3_ths_tj_1 = 126;
> +static const unsigned int rcar_gen3_ths_tj_1_m3_w = 116;
>  static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
> -	{ .compatible = "renesas,r8a774a1-thermal", },
> -	{ .compatible = "renesas,r8a7795-thermal", },
> -	{ .compatible = "renesas,r8a7796-thermal", },
> -	{ .compatible = "renesas,r8a77965-thermal", },
> -	{ .compatible = "renesas,r8a77980-thermal", },
> +	{
> +		.compatible = "renesas,r8a774a1-thermal",
> +		.data = &rcar_gen3_ths_tj_1_m3_w,
> +	},
> +	{
> +		.compatible = "renesas,r8a7795-thermal",
> +		.data = &rcar_gen3_ths_tj_1,
> +	},
> +	{
> +		.compatible = "renesas,r8a7796-thermal",
> +		.data = &rcar_gen3_ths_tj_1_m3_w,
> +	},
> +	{
> +		.compatible = "renesas,r8a77965-thermal",
> +		.data = &rcar_gen3_ths_tj_1,
> +	},
> +	{
> +		.compatible = "renesas,r8a77980-thermal",
> +		.data = &rcar_gen3_ths_tj_1,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
> @@ -349,6 +366,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  {
>  	struct rcar_gen3_thermal_priv *priv;
>  	struct device *dev = &pdev->dev;
> +	const unsigned int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
>  	struct resource *res;
>  	struct thermal_zone_device *zone;
>  	int ret, irq, i;
> @@ -422,7 +440,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		priv->tscs[i] = tsc;
>  
>  		priv->thermal_init(tsc);
> -		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
> +		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
> +					     *rcar_gen3_ths_tj_1);
>  
>  		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
>  							    &rcar_gen3_tz_of_ops);
> -- 
> 1.9.1
> 

-- 
Regards,
Niklas Söderlund
