Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9943ED3CF;
	Wed, 15 Jul 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107596; cv=none; b=skvxqtmxX8gVeLRtS9J89pTegUe2cHkKrP8pbXhb1g+6rwixWU89/OdXV32mSIdwkQ57uJyDPpJE9GapQL6hq4cQLgWoqtJHgw+g7haIxyjP3Wyq2lLRaTAr0jj2vxj8x64I4P74p1jX+cjt/fJtzxzM6UG30KBBri+oa6XInF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107596; c=relaxed/simple;
	bh=Gw9d+azDSiBHe7zI7M5WDXfQEEpbX27nlNrMMPDaPgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek9ggZ3IjiLCZvEu2/t+rQHocagrVZ3JBJBEmk0EWF2shjzzIo4pDmTJVv5xIbUlFeQxnfbNQE3Rz4sBRkPLvqyMXiKhiuO9Cs9k0EyOChXo1jphNefqQSSu3WtAtNiuVk8mrmH3HyxtPblTEs0S4r+vA3DNILLK3F4Nprp3N+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=QNsAILbF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmSyGTFF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="QNsAILbF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmSyGTFF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26D7C14000CB;
	Wed, 15 Jul 2026 05:26:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 05:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784107591;
	 x=1784193991; bh=RHheL60c0QV2tMAPkrEKcnYFAylqde2oM7O4i68nidI=; b=
	QNsAILbFA97F3JtdVS0gYjZSS9yF12AP80UBjFfoRS3YuhEqejUZkaziEKAVZwsM
	uZ7JL43teuDeXq2KKuTiVuCfxzeYwEi2IixGlKIiRQfTKB4269SV2EFf7hxv8MQ+
	itCh+i0TCNIMmq0LwdnLm6hm8AM2XsUjo+s2YAY9jmIijgTh5b1w3zURjBeqpeSm
	79vMXHowyjmE/Y71mfnP3NrUvSCtPuUdu+PvbM7vPF+J/koL12/qsokkXRejPpjX
	LSHEDdHFc8S4PgRHhjRGNNWt5EgXj5dM0Kijw5bftoqhJdXtgOY7HN6d4s/MSpgB
	VZpTuoYgSlV4sB06vCDAkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784107591; x=
	1784193991; bh=RHheL60c0QV2tMAPkrEKcnYFAylqde2oM7O4i68nidI=; b=F
	mSyGTFFhk1eevGasfNhytFnt1F7xUgHAWGsUSIlizkr3cggdA+aeKq33Ec/4CVQL
	2LyzWNvOzx+0Zr2QXeb0wl1lNom5UjJgvE7j12s5SaKvu3RtmZxB0FbQEORi/dP/
	iVTJbcjqDo5Xp2tcOKJsaSHNRw3JfNuBVQhe9FUaFkn/Q+wJOotyfiFn6WX/cgN6
	nAP4K/4Fr4iUCilVDBgo581c7GitCk/jiNNi4frrHra97VUZI8qjcSK3OBujLftd
	EsHaxUgu2pxrnw/x5Ae0Og1pCKlX73POm7Pii2dKXWzJoOsWpqRRFleb4XShuwdF
	zh023aMZE6v0ojQTTw3dA==
X-ME-Sender: <xms:RlJXagJzJGPRK2_KgZQkz6qLh6oAjQNvVRTamULXpqqa8y261lHq2A>
    <xme:RlJXar8u4nT3tRv7rC2uFGU3557u4h4p9L7E1yZSBDEJcGhKKs2HLrQpPxSLL6cLg
    FzKdyYoiFkeL1JlLQjWjl2qFNBEI4eHUD9G5NXS839Z4RjAg1Of5Co4>
X-ME-Received: <xmr:RlJXasG6snxbTeUxvpgM7CIjLlC2xsFbO7eRyK8SQKhp7OYkSGaXR5xnkFCCAaUxqfIK8Puu0LqnzefJ1Mp16PZmfEvVoRE>
X-ME-Proxy-Cause: dmFkZTEVthRYG87x0RWI7lFO6KZoE6B1uews7yLk+z8qQMXlYp6TA5AvYq2s5o5IKlc4Ou
    Ie6n3sgQCcf1VZ3CeQaVgIQhFAtdEiTV/xgLjh2yuh/E1dSNv7KXwqIxKswtheXWy7rxBN
    xLjmhdTvw3ZVPeirLhFGuaEfSeEauJPrCojDsdERu1eJN/zMIaPJ7KT/pPjxQ2bS3tHbpu
    X4gA5g19ZlAbEVhh6dbFee8fRBr2H1XHayzCSpWA0sUglxSBA+N/ItzLsN+CfXq1hpECmc
    qFWCT6RfY4BqaeFTSO4DkvZF6iHtjUgv/b6MD15GRyk4dkT6nUcpo8gV7qjtnVuLOvdpJl
    apS5SAEMSwDMclo2GTxG+TFXfmP2IStY7zsRxYoMy2VP7x2EBO2iVaIPD0uKRLheX36Osn
    0Luuh7n+zEb/52udRUJqzMcFzp4j9uLix2N9Rz4XfDmZLAw1NIYHAluAiaLJxiu/UL0NJz
    ll/Ziu+FLZJ0NCAMrzv8/9VjvXlpEuDWZgFzktPwQa3D3xPpF2748ztLqnB2Qk4KK3ugMz
    z9ECo7+JzlyE+1mX5ONi6cZL+ILaKKOpdNaAjlMfd75K3G+WQgQVsvYxGReltIM50emKq1
    b3Ec3nCN5iCKFCz0xCu4RqGMw+mAMnMkel8QTsOEEMwiLa1ww3CvUs2OGPZQ
X-ME-Proxy: <xmx:RlJXam4nfWa4gscwE275DjUfffNPOe5tpqrutthZBQ3SfToHlEw9UA>
    <xmx:RlJXalY0qRjTdD86zHiY0ZArQ3pMaLpaTiV6V9t82_vhbIH9bf4kMg>
    <xmx:RlJXakheV4OIUu_5c1_3S9rVYtEe6YrUynKq5Jp7h4fl54rFvGt7TA>
    <xmx:RlJXanfi4I4a-a2Y3qLZ2pNJgr_AKxZ-V_SiG0qRErPun5KxNOJxOw>
    <xmx:R1JXam3tHO3TN2xAf8W-kNQpCfi7yYEZDq-liCN0S82_Q88ngJX0RVlY>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:26:30 -0400 (EDT)
Date: Wed, 15 Jul 2026 11:26:28 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	"open list:RENESAS R-CAR THERMAL DRIVERS" <linux-renesas-soc@vger.kernel.org>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/18] thermal/drivers/renesas: Remove redundant dev_err()
Message-ID: <20260715092628.GF3059211@ragnatech.se>
References: <20260709023048.599150-1-panchuang@vivo.com>
 <20260709023048.599150-15-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709023048.599150-15-panchuang@vivo.com>

Hi Pan,

Thanks for your work.

On 2026-07-09 10:30:17 +0800, Pan Chuang wrote:
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err() calls that previously printed generic messages.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/renesas/rcar_thermal.c  | 4 +---
>  drivers/thermal/renesas/rzg3e_thermal.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index 6e5dcac5d47a..cf80e2655416 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -446,10 +446,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  
>  		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
>  				       IRQF_SHARED, dev_name(dev), common);
> -		if (ret) {
> -			dev_err(dev, "irq request failed\n");
> +		if (ret)
>  			goto error_unregister;
> -		}
>  
>  		/* update ENR bits */
>  		if (chip->irq_per_ch)
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
> index f0e29fe633db..c44f5b8858d0 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -461,10 +461,8 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(dev, irq, rzg3e_thermal_irq,
>  					rzg3e_thermal_irq_thread,
>  					IRQF_ONESHOT, "rzg3e_thermal", priv);
> -	if (ret) {
> -		dev_err(dev, "Failed to request IRQ: %d\n", ret);
> +	if (ret)
>  		goto err_pm_put;
> -	}
>  
>  	/* Add hwmon sysfs interface */
>  	ret = devm_thermal_add_hwmon_sysfs(dev, priv->zone);
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
