Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F9C10F14
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD762183E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 08:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="1VQYdnVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfDRIMM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:12:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36948 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRIMM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 04:12:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so1142066ljk.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dg8rTv2RydN29TYINpu22lef2YLFK3+ZV+G4/aXpMAQ=;
        b=1VQYdnVY/y/LKVYvF5/oR+HTBeVxcWQpxlAiJivGAKWJaZroCCivVfzSe5DPWJu5bX
         nNDWhwGQ7w8EP/1TUXJGnGFwNnuWX4/odcjLtgKDCKAUcDjGJewb8elIhUhVdFIOHCdZ
         i8TWpxpb+5WiNzXNICze2jIEzhbwbxwG3UWE3GXOLvZVAYwTfKqFqqRY5rb0tsBPJ82W
         uatq6lKzP+IiTiMWg3QQIiw7iBwyGj6K3cuC+9QAtDxTkv6/t5nMKvfQ9qZDH7zKcXf4
         +cbWQ1bzErWwS7YVibCJWcbdG0y+WpMCgWE0BjNcDv4kL1ZSj/Xmwtq+PXrgMrHNUgqA
         UjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dg8rTv2RydN29TYINpu22lef2YLFK3+ZV+G4/aXpMAQ=;
        b=Ye3usBXmns62ChtSsxSlwXY/uh3DXeMk/wySZ8xFJjE27ZGC/jXmdQt8vldDeI8syS
         /6XwRq8YKW8+fQ68SDmTLvcNiV9ue5U5oHa5Mr40n1RGElP0DTZiJcKfqKFQbeVsFJnp
         YneXz+js/CfXOwkBWf/1MmDrGFQ9wp+60dZ1EiCpXg9RyfHI5SEC/vX1ARu6vWVmmUAF
         n3qbSTws8EadrL5ChQqvkYo0vBB4tChKtDtOXRb+D50iq2vkNQfabpRD41GkpZshIheV
         b7ZIa697Elmy/Xg/zpq3fF+2PmHb3zhd+egxUkf093Q2dzPVVsY22/pZfIU4QxLUlTiK
         cQig==
X-Gm-Message-State: APjAAAVGiMXG9TikPyPhUIiu9/46qJ0g4OKsCWyCrPF0MDrchJ2JMzjH
        JnSoi4F3Q8EFlrujd6L5sM6SRg==
X-Google-Smtp-Source: APXvYqzgCQV5br5hRx5JnVntZARVU41LPF+a0aeWh7AynGWb0U6F/C1cfNHKBh3PMf7Y9vowgTUilA==
X-Received: by 2002:a2e:29da:: with SMTP id p87mr49326566ljp.33.1555575130327;
        Thu, 18 Apr 2019 01:12:10 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id l79sm292328lfe.92.2019.04.18.01.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:12:09 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:12:09 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH repost] thermal: rcar_thermal: update calculation formula
 for E3
Message-ID: <20190418081209.GT28515@bigcity.dyn.berto.se>
References: <20190418071514.13027-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418071514.13027-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kaneko-san,

On 2019-04-18 09:15:14 +0200, Simon Horman wrote:
> From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> HW manual changes temperature calculation formula for E3:

Is this not also true for V3M and D3?

> - When CTEMP is less than 24
>    T = CTEMP[5:0] * 5.5 - 72
> - When CTEMP is equal to/greater than 24
>    T = CTEMP[5:0] * 5 - 60
> 
> This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>
> 
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/thermal/rcar_thermal.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 97462e9b40d8..11df0cc63bed 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -52,6 +52,7 @@ struct rcar_thermal_chip {
>  	unsigned int irq_per_ch : 1;
>  	unsigned int needs_suspend_resume : 1;
>  	unsigned int nirqs;
> +	unsigned int ctemp_bands;

Would it be possible to rename this to something indicating that this is 
a gen3 thing? Maybe move it to the bit fields above and name it gen3 ?

>  };
>  
>  static const struct rcar_thermal_chip rcar_thermal = {
> @@ -60,6 +61,7 @@ static const struct rcar_thermal_chip rcar_thermal = {
>  	.irq_per_ch = 0,
>  	.needs_suspend_resume = 0,
>  	.nirqs = 1,
> +	.ctemp_bands = 1,
>  };
>  
>  static const struct rcar_thermal_chip rcar_gen2_thermal = {
> @@ -68,6 +70,7 @@ static const struct rcar_thermal_chip rcar_gen2_thermal = {
>  	.irq_per_ch = 0,
>  	.needs_suspend_resume = 0,
>  	.nirqs = 1,
> +	.ctemp_bands = 1,
>  };
>  
>  static const struct rcar_thermal_chip rcar_gen3_thermal = {
> @@ -80,6 +83,7 @@ static const struct rcar_thermal_chip rcar_gen3_thermal = {
>  	 * interrupts to detect a temperature change, rise or fall.
>  	 */
>  	.nirqs = 2,
> +	.ctemp_bands = 2,
>  };
>  
>  struct rcar_thermal_priv {
> @@ -263,7 +267,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
>  		return ret;
>  
>  	mutex_lock(&priv->lock);
> -	tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> +	if (priv->chip->ctemp_bands == 1)
> +		tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> +	else if (priv->ctemp < 24)
> +		tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> +	else
> +		tmp = MCELSIUS((priv->ctemp * 5) - 60);

I confirm that the calculations here are correct, but hard to read ;-) 
With the rename about how about.

    if (priv->chip->gen3) {
        if (priv->ctemp < 24)
                tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
        else
                tmp = MCELSIUS((priv->ctemp * 5) - 60);
    } else {
            tmp =  MCELSIUS((priv->ctemp * 5) - 65);
    }

>  	mutex_unlock(&priv->lock);
>  
>  	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
