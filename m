Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82675C282CE
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8E0218FC
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfDXOyq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:54:46 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46214 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbfDXOyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 10:54:45 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8AA5725AE8A;
        Thu, 25 Apr 2019 00:54:43 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 7B9DB94041B; Wed, 24 Apr 2019 16:54:41 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:54:41 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH/RFT v2 1/3] thermal: rcar_gen3_thermal: Update value of
 Tj_1
Message-ID: <20190424145436.camftb32c7v2ya2f@verge.net.au>
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
 <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kaneko-san,

On Wed, Apr 17, 2019 at 02:44:13AM +0900, Yoshihiro Kaneko wrote:
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

While testing I found that the type of ths_tj_1 needs to be int
rather than unsigned int, in order for the FIXPT logic to work correctly.

And with that change in place the entire series appears to work correctly.

My suggestion is to change the types of ths_tj_1 here, rcar_gen3_ths_tj_1
in rcar_gen3_thermal_probe(), and rcar_gen3_ths_tj_1 and
rcar_gen3_ths_tj_1_m3_w, which are gloabl to this file accordingly.

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
