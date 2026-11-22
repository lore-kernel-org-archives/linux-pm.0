Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358899;
	b=QvlTJnN56yVXEwpKbZ+8/YTEfM0Wrmhhx10aDipUHUUnGtOki//bxYWg1nL+Xu3Ivrfg
	 3ISsvvcdLfOYgJl8NoHAHY+0C8a3MGrHr4HN4EFzjCrMj6hSRL4G19JGRbAcDOxLyHRxa
	 LEjXohs3FAvShyCfZ5qzAnyKNWR/v4kdkTCewzDCJ2l3vpHZjH/za9in8WBMT8PDtdPdS
	 MWU+dljqNVZj7HbvkJGvLkF1CWA5wQDhG8fDiDEi4sjwYmidaUaTlkQ7SHnzJPgc1QITc
	 MD9U1/0V9zYBoJMm2iRfhkWVxDxboPD0WaePgOTyUSQPaqW+NtQYRTEYFc1erV022lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358899;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=elhC4BD4VJVXrJtY4vBFvagVyoS1Tt0PnGzh1I+gXQw=;
	b=HvLLgfna1gD18ixqX+9di6GXdeOtP2lr9qL0L0DyLu3yrylQFIXQNQ/ikCBNJBiIN2wX
	 j2y3IJBlVvdVBrAke6nrpisMDUXl6nKyYxB3a3MhJPoMPilihxsuH8g8vLzOgNwIKGtK1
	 YZnwh0hTB+9CGeaR09SM8CZ7ilamH4Wqt8EeDQopNJe/EEBJAmc2zkhZMtJeElegIA9NB
	 8eF4DA1Ex+CuEvagmVBDF/YI3+9jM+8TYD0uB1x58+/tQcNxpCcrlK6n1QWREZFwgNimp
	 /ZQCZolmdyE/VJFKeH74j7HN0olufc4i6c5Smw07NIvfWYYCQDEW2yrMN3FldaXCD0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=HqfMUQft;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cxCU9JlE;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1D606A320
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 14:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E1D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=HqfMUQft;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cxCU9JlE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 022657A04EB
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:48:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 22 Nov 2026 09:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795358896;
	 x=1795445296; bh=elhC4BD4VJVXrJtY4vBFvagVyoS1Tt0PnGzh1I+gXQw=; b=
	HqfMUQftQNO3V7Br4Hc9d0QGlCyszIK2XrdSPzdu50jzypwaJcw833zj9nBBa6/N
	1X5Hb//sTYoHtd2avUNf6g7KhS+sUOONrRV3nKu0tOpwv3vkdLWJwrdqhua0r/yr
	keKWIvhCjEslhPIu257/hLQQh7p4czbaTM3CSecGaLIhvKItFSDXcjwxJN/Th8hT
	+xnJsLcDB2YBQhjcRhWFXj1qOzrXRbfYARBMWJCaRLYGy+yF/iUPcEcPOnbmtHw9
	gsLfAVtM9PrBkcPf6A6Wvb4NC6js6qaMZ2rLQhATe83tSEeh67MTzQ6X1Y7EYEMk
	ukpvjHoJ1+O1sBQ7k5pEUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795358896; x=
	1795445296; bh=elhC4BD4VJVXrJtY4vBFvagVyoS1Tt0PnGzh1I+gXQw=; b=c
	xCU9JlEeemBWFgwN+Wo1uyv+EKPA0a60X1d108RZy/D0QDZGV2goFcKUgTOO4fw0
	fL4fzshJTLN/U8Yf2nn0+yZ7+J9lPqVNYnD8NFOaySW/QO/Re6FFxkG34wjnHGRn
	ASWSKVIT1Fhu7R6a+yBWSLiG8GZ8ER7zGaAop36Fo/mcaY75RFi8ywKXEuD1amxs
	htaDhc96oKtLWHYsshSxei3SHCozaS41c9bqlQu0dzpNuGsiDBzQW7QuZViksUgM
	ylc6JDzCBknQGh8Q4+AioeVBL28BL5YyR+e7ZCHLF4NZvz+/0pXk24vVPsId3ba6
	jzbCGIlZEijHAbWtNtEEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795358896; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:wps6fZH2/NGsuGoae+Fbbs9pS0BeuiicjrELgIoM161VjOo
	ei2hKolqbHWtIRrBfpbGiQtGiH88Ppf8m4Y/ljH7tpihhmwLu2FsqqTwXa49CU86
	oJhwitkFLVCiY6GNwjbrvh1+TtxSzvQUuomYkZM9QAy6CooIp1otTFgJsiDqWbYq
	PpPNM5Vpjhr1InZUi4nwZs16yOKDBpbRfYWOGvMEXOa8cu2B2y66HvD2s+Jmhe/9
	HBPd2F2CohSankwXK/0D/TtWWKDw0nbWYYpcsMhJzjsQySgRuo3V4xbcNgp4KAIz
	Ud7IWVRjWLC8WhliKhQjHknYZA7eWFSWiZxBu5w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:njO+b+bNHzN3aVkdZMXlSVy8yFjO3TnlJmTubb1SwA8=:6MvAiBFSHzwlHJFqIne6aa2kM+8PWa+RIYI+IVX6ot0=;
X-ME-Sender: <xms:sAADa79ruGR_UV60VoggsqJo8-KFyPGtKocmoKAqQitEkEfRg5dOoQ>
    <xme:sAADa9vxaWK--OAjjsnzPkMyl8B26iXXkkdoJHmAQi0pAwhgOP-3VPnH3Iz57FRzZ
    -ZB71cmCf-PEreM9uAHTw1hXqLKu5h77_SnWCzqkiTftrcLLWWz1fU>
X-ME-Received: <xmr:sAADaz0lC4qbSjraRT417gB6yT5vXL5Svs4Gayn0oSXrUaOvDiRM_dYMeXk0Mn76Mo2hJG_0Sfs2aUlTA9-6CuzS5NY5z0E>
X-ME-Proxy-Cause: dmFkZTEd8/RsCIwclJRL1GctxBABK7tF36FDt142j2jKX10XhBtkUztzsr6BWd3tsDhWdR
    VUwE6EhLhtf1ZR4lyCdopIhBDmX9y+ylq049atSeUqjZiNRjgt8HuLQCbyw9p86SoAxmJA
    Z8YfjqLd/9sR8KPntt8mj9LLuNgNhG8zMZ7sbGrxyri40TZoXzYkGx3tJJydzqGfofUagj
    QP58uA+N33dui5OTnfzZiJkPGyzapKnTV69BfPWHAebXUfRWuZG4yEkLQBI2lIDTQ4w2kY
    1uCDx5tU5ep4R9WyUZYWzbPP8+vQQMTHBPWUpmCMfyYC3nJJwxaOM4GP3oKYqGY4PuYsWC
    6LlVTzOOopbkJVvO6gKLUkPO0vWqNvALRqnrFlhAHiNSuSQp48DX5UZZiHRWEQ3x/Z6B2D
    5DbmVF9+xlocFC6DvMAltqMAiCHAZFNnaHxBpudhbqRMVi33x1VJiQ7gKGrOfBF7LB+9TX
    7NWbojEPi4ZUYqmcuXQ4ydeoStq/S8bz6yZGBz30HyH2bK4CGG6kvYgnarRTIlmtuyoYz6
    kGBZ1WnVtSHY4pAroKhd3kMC6081NPBm+dIuv5Xb1Lunt9q/DkqxXZZMZ4dsTVPTuuWSiM
    lFAIoGi8wTp74rfTuRUyAlvDwDxXf5Q1rngZjrpCNipFGgn0+Z6PnDm5gQNQ
X-ME-Proxy: <xmx:sAADa6S54cZMGJOxO-dDb3tEI30b-zCvzDDmMxcGhRpRb2duOj-p8A>
    <xmx:sAADa_ckkF_ZHxF7u7GSi7GTQw1KvC4PtSnf_J-EQlV_jQkGwUqGVw>
    <xmx:sAADazctwtlpeeGZF3AUmPwiMxx0hEsIoQmeRSVHuXf5TpbFDlnGzA>
    <xmx:sAADax3uToR5UDNFIThNH9ScTbk-QQfWBoukr-A52VIT7kCdxClm-Q>
    <xmx:sAADa29Yk76egb2s8xhaBKHeJiXUYfeobuxdn4O3V28uCue04y7uto5p>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:48:15 -0500 (EST)
Date: Sun, 22 Nov 2026 15:48:13 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, geert+renesas@glider.be, magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: rcar_gen3: release the IRQ handlers before
 the zones are freed
Message-ID: <20261122144813.GB3898744@ragnatech.se>
References: <20261117145348.1092528-1-shunsheng1218@gmail.com>
 <20261119022926.1493582-1-shunsheng1218@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119022926.1493582-1-shunsheng1218@gmail.com>

Hi Yaohan,

Thanks for your work.

On 2026-11-19 10:29:26 +0800, Yaohan Li wrote:
> The interrupt handlers are requested before the thermal zones are
> registered, so devres releases the zones first.  When ->remove() returns,
> the zones are gone while the handlers are still installed until devres
> gets to them, and a handler that runs in that window walks priv->tscs[]
> and updates a zone that no longer exists.  The source keeps asserting
> because nothing clears REG_GEN3_IRQEN before the hardware goes away.
> 
> synchronize_irq() alone does not close that window.  It waits for a
> handler that is running at that moment, but the zones are freed before
> the handlers are, so an interrupt that is raised just after the wait, or
> that is still pending in the interrupt controller, runs a handler
> against freed memory.  Removing the handler is what actually closes it,
> so ->remove() masks the source and calls devm_free_irq() for every
> interrupt that was requested, while the device is still runtime
> resumed.
> 
> The interrupt numbers live in an array whose unused slots stay negative,
> so the partial probe path - which also ends in ->remove() - releases
> exactly what was requested without a second counter to keep in sync.
> 
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> 
> ---
> Compile tested only: arm64 defconfig, aarch64-linux-gnu-gcc 11.4.  The
> board was not available, so the removal path was not exercised and no
> race injection was run.
> 
> Changes in v2:
>  - Mask the source and release the handlers in ->remove() instead of
>    relying on devres plus synchronize_irq(), and explain in the message
>    why a single synchronize_irq() cannot close the window.
>  - Keep the interrupt numbers in an array whose unused slots stay
>    negative instead of a separate count.
>  - Use a loop-local index and a named maximum instead of literals.
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 33 ++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 9c64cbc2ee67..2a6890d2a5da 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -103,6 +103,8 @@ struct rcar_gen3_thermal_tsc {
>  	int thcode[3];
>  };
>  
> +#define RCAR_GEN3_THERMAL_MAX_IRQ	2

I like this!

> +
>  struct rcar_gen3_thermal_priv {
>  	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
>  	struct thermal_zone_device_ops ops;
> @@ -110,6 +112,7 @@ struct rcar_gen3_thermal_priv {
>  	int ptat[3];
>  	int tj_t;
>  	const struct rcar_thermal_info *info;
> +	int irqs[RCAR_GEN3_THERMAL_MAX_IRQ];
>  };
>  
>  static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
> @@ -468,8 +471,31 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  
>  static void rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
> +	struct rcar_gen3_thermal_priv *priv = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
>  
> +	/*
> +	 * Disable the interrupt source while the device is still runtime
> +	 * resumed.  REG_GEN3_IRQEN is only ever written by
> +	 * rcar_gen3_thermal_init(); a concurrent set_trips() writes
> +	 * REG_GEN3_IRQMSK alone, so it cannot re-enable the source here.
> +	 */

Is this not a tad verbose? How about just

        /* Disable interrupts. */

> +	for (unsigned int i = 0; i < priv->num_tscs; i++) {
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN, 0);
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
> +	}
> +
> +	/*
> +	 * Release the handlers here instead of leaving that to devres.  They
> +	 * were requested before the thermal zones, so devres would free the
> +	 * zones first, and a handler that runs in between would use a zone
> +	 * that is already gone.  free_irq() also waits for the threaded
> +	 * handler that may be running right now.
> +	 */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(priv->irqs); i++)
> +		if (priv->irqs[i] >= 0)
> +			devm_free_irq(dev, priv->irqs[i], priv);
> +

I don't understand why this explicitly is needed, can't we let devres 
sort this out?

>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  }
> @@ -489,7 +515,7 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
>  	char *irqname;
>  	int ret, irq;
>  
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < RCAR_GEN3_THERMAL_MAX_IRQ; i++) {
>  		irq = platform_get_irq_optional(pdev, i);
>  		if (irq < 0)
>  			return irq;
> @@ -504,6 +530,8 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
>  						IRQF_ONESHOT, irqname, priv);
>  		if (ret)
>  			return ret;
> +
> +		priv->irqs[i] = irq;
>  	}
>  
>  	return 0;
> @@ -525,6 +553,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	priv->ops = rcar_gen3_tz_of_ops;
>  
>  	priv->info = of_device_get_match_data(dev);
> +
> +	for (i = 0; i < ARRAY_SIZE(priv->irqs); i++)
> +		priv->irqs[i] = -ENOENT;
>  	platform_set_drvdata(pdev, priv);
>  
>  	if (rcar_gen3_thermal_request_irqs(priv, pdev))
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
