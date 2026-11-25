Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592028;
	b=xSkUZ4TnloF/FJEUPRcZ9Uy35Hj7IBHmbzdXwviO49zOiuOXhvT/bBRYTLSlPSa3IkNp
	 rd0TM7cX51s59nOGNkqqU3K+hZc4koYR3xaBZ5C5asqzZ2e29U/x3yARzDXTrI1qA+5y+
	 LiwFD33BQyXIlCd+WdxizdA0vR+GJjfbJ93nxsk12X1t5tPu2T9C8KRSpC2Bg45HBJZuS
	 5bChz0IGcutSz9nuVdWAipYB74PSAAAn6J3L1Fi1xPcPXm18QYyrAKEhy9ls6hYI2/13F
	 fhqY2X6/fdx+i0fxeGs1TufOhbAs0LGox2VBNMHH+ZNDVFommT98+ZJUNboI9xUVMPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592028;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=QIQIM4jf+UKzAvy4/TzOA2OrPZIwZTYg25OwSeeP9xA=;
	b=2s9E7KYlMWw5cckGX+9IaaDuE+7t+tZPrD5AbzziOuifShCv0DiZytia42b02mRJ/+QG
	 zPyfH+B3HjnEAgw25zLzrZSWEMo/bys7AwA+mAexRt4DsXd5w2wZF38CCONNBfPT0+N3C
	 t8mEtKjQBDdf/7WFKT4m4ckc4ffUHuFi8UqsguepaFFcFXrlNQYb8uYRgzCjobESkakiE
	 DPjmHY4YI+RrFZPySVuKejRE03KqzDM+f9QLFy9d5UCmeIOtC6YCkkjwWpiDmCZcGBnOM
	 DKSkxK6faNxrsXvBt0Yp4RFteuK/ze9gefjFjQqUjre3z1pvZOJz8ePjRL+BAa/eWHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=UiOhYkYU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l+4ScMDL;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B775606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B775606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=UiOhYkYU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l+4ScMDL
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ACD37A05B7
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 02:33:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 25 Nov 2026 02:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795592025;
	 x=1795678425; bh=QIQIM4jf+UKzAvy4/TzOA2OrPZIwZTYg25OwSeeP9xA=; b=
	UiOhYkYUOQOclClulR8GTZMk8oLVRE0OhwXkBcR0TBOeypeXNcOSOWnZeXRBASe5
	tkPVnDWMasTTQnjUYJnT7lZL90mZME3vuGG7VM/39ACvES6Y4hOYAKx5nP8jsrSx
	X9fqLhyEjrCZnCR5RXN8+1jE3NpRt4+CvjIkVA3m1IVzcheLIxFby8A8ATrl9bvH
	nklN8s8pQ2Rk/dzan7U+/pVyOa+qG8LWUsXd7jVLR9VEYCECjqHFhjWPDa2nE0Lf
	7aGSh9bpOau3KYC2rq5oDJKJDC0ofvOX6WQaDD0IL5e8HEOAljMToFW7NbhKQ10N
	4dQ/qZARNaXoZYaecsGlMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795592025; x=
	1795678425; bh=QIQIM4jf+UKzAvy4/TzOA2OrPZIwZTYg25OwSeeP9xA=; b=l
	+4ScMDLX/0aXKO4hPcjBLp2Y/Zc76B9zo6rB6lAiemeK7dr9T4Enk8785yuVB3hI
	KJvi8Yt7ftpugvC2oMoTN+wyUjdOq8jjMokyIpYNUMBNIoFOlqdMW+f1IE46EGth
	atniSYdsZAsrVbwAq57ZbFk9IoOGBs5i+tZZoBfHU5JkzUTmJb3O/t/h7VsXrJex
	zg6P9g7yBP5XOsRGtIuRlQ0FTCORVGuSuNLkbkT+Ni+GSHoWWwttCGb+fD1l4iPo
	wX4N/7LsmwKHk0lUX53GfshnvWPW7WENt1VYAwUOqcJ3KNNzT2NLdJnUCJTxkAz6
	5yhepqD1vUPYIdGUsF5ug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795592025; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:uJEmrQYvV5v7QO+6ywC04JxWtZ0JFNrQBHocKgIyKy6x9w6
	QrtKwgbx4tC6YQCWlFFoiWGg+a4WtciIdjn463AuyP7ZUqy1g+SGvs8eUEbKKi2o
	PnAn8BzD5eEWzziUuqC4YG+xSytvVuIeV07zzhrNNe5nyniqyqtbzNTOm4Wsza57
	bo3QcI8OFQ9E+uSfiIFrB5X3PEx8iVixT+tFZ59gC19nLFrbFMQDMiepNkiMUXZ7
	6xHc91DU/TyYQj7B1qpo1f5C3x5LRJuWfA6oez/O8QAkyzQ43/gyhvh6pKJHx6Pw
	YRgr0TtMp1gz/5Oao6uP8tfPcVQW5V1xUAjnPxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TPEOdPqsdpgtXCMuNSqLZwFV7Dq/Y1DEWtwyw2QZ5so=:ga7c1mSDQfL4iygW6J1H/FKDKn7XMneB905H22Qv13g=;
X-ME-Sender: <xms:WY8Ga1ybx5sbKTVFq_CGhrD8a5bjHDsffm6j0ig5wQc87YBVXYQroA>
    <xme:WY8Ga1uEA7yKOzLJCZmoRcbwYGYrTpFrKYtW_-3osUGZ9W8-TadHdtX-oJHeSO1cb
    upkyCJSk2LlAYFT8Z_OM7qEeeic7e3496R8PHdoQIlK3d3S-0O_zxBP>
X-ME-Received: <xmr:WY8GawAZVO0BKm9S7YYIbjqAWyp5rSTU3hgbVYhFvn9_enQffMwMcBCyfUL-D_bvvj8oPFaWjNzrKyxUrqIgdbcS4E5-UG8>
X-ME-Proxy-Cause: dmFkZTEXiLueWkxcI8+h9XZgh6kPRJIK7XBtELEzKJ5EWor48YtGp57CY5g2+dFGu6VxTB
    eh+sQVJiTfWJO1HvN87UintlzVKQy5l35VyBTXN6vwexsqAXnExvFTCFRER+2Sedg/viN3
    LRPOKGNMXOJfi5wMCoO/7fomP7Fa1Kx5bZ/1tuER0jSv4cDub140Gd3iMToPV/xO4HoVWs
    imtY6hkSO23b/ZYQ36YJgfecspRYO1bV5UOTtv9JSY5n/w7qNG3sh5sa+ZFyAPdEAiAyQ6
    soI8LgtkeYgJSKNFVBRRbPbE0O9DX7fSIF92Rb3dD04uPxYcbge57Z2O3Fkaqb6JtCC+hc
    uW/NTm/d31+Ttv2SFZN6hbK6CtkTBqPMlv7wns726ZwW/3YATxsKamjUY0MZKSDkfCnDsX
    uSgg+ex69jj2hasW+VclpBvNc1daDQAbg8e4Pd6Wyq3ifOjzwaZ56K9dQFxd8PYh1Gb9Q2
    pZNXz168oUeEfuTnpHYWo+eSqM/24+3jCD/2tVZ14vOXC89pHjP0J+De/bXstNgqQk9LP4
    x6faXrDRGkSZ36vxKosia6K1WnYzRPCtqm2WYgXy1IkQvLtMzmeFGxS25m5qleahKGoGMF
    CKkEmsmAdg/AAUfzFZiObDPUX16cWRNDPkH0tSkKRcOI+JOGKKisb5A8sg7g
X-ME-Proxy: <xmx:WY8Ga_GLEB-yWU-uyukQ0zTnpINL3WpGKAq-b7B2TDtHCvJ3rnSiSw>
    <xmx:WY8Ga4BUmIu4_W2IAvP4C4ucU-L9VW3YF9GOLUxWSfuZJuMsnDcIZA>
    <xmx:WY8Ga9n7O2LrFiFwQ0Q_CcMjveQSLpz_2PPxJq-gBdA5Fg4kFJZtiA>
    <xmx:WY8Ga2MJ-W3RqG1KliIXL9wrpNyJWHp-zofgeATjsGKC1cjU2DOyCA>
    <xmx:WY8GawrRlJhY84huchTiQNkPg7iZ3oM0HKn6sWh_txwHwuHyyuzT0mA6>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 02:33:44 -0500 (EST)
Date: Wed, 25 Nov 2026 08:33:42 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] thermal: rcar_gen3: release the interrupt
 handlers from ->remove()
Message-ID: <20261125073342.GL3898744@ragnatech.se>
References: <20261124095110.131258-1-shunsheng1218@gmail.com>
 <20261125030327.953450-1-shunsheng1218@gmail.com>
 <20261125030327.953450-3-shunsheng1218@gmail.com>
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
In-Reply-To: <20261125030327.953450-3-shunsheng1218@gmail.com>

Hi Yaohan,

Thanks for your work.

On 2026-11-25 11:03:26 +0800, Yaohan Li wrote:
> The interrupt handlers are requested before the thermal zones, and
> devres releases the managed resources in the reverse order, so the
> handlers outlive the zones they report to.  The handler walks every
> sensor and calls thermal_zone_device_update() through tsc->zone, which
> is not cleared when the zone is unregistered.  Masking the interrupt
> sources neither waits for a threaded handler that is already running
> nor removes the action.
> 
> Release the handlers from ->remove(), which runs before the runtime PM
> reference is dropped and before devres unregisters the zones.
> free_irq() also waits for a running handler, and after it returns the
> handler cannot be invoked again.
> 
> Record the interrupt numbers as they are requested, so that a partial
> request is undone as well: if the second handler cannot be registered,
> the first one is released and the driver falls back to polling, as
> before.
> 
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> 
> ---
> Prepared against v7.4-rc1-1969-g666539eecdf4.
> 
> Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
> CONFIG_ARCH_RENESAS and CONFIG_RCAR_GEN3_THERMAL.
> 
> AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
> author reviewed the reasoning and takes responsibility for the content.
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 38 ++++++++++++++++++---
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index a96f02d4a8ad..37348f4413b6 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -107,6 +107,8 @@ struct rcar_gen3_thermal_priv {
>  	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
>  	struct thermal_zone_device_ops ops;
>  	unsigned int num_tscs;
> +	int irqs[2];

What happened to RCAR_GEN3_THERMAL_MAX_IRQ ?

Please stop thorowing this code at an LLM it comes up with new code 
ignore past ideas.

> +	unsigned int num_irqs;
>  	int ptat[3];
>  	int tj_t;
>  	const struct rcar_thermal_info *info;
> @@ -466,9 +468,25 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  
> +static void rcar_gen3_thermal_free_irqs(struct device *dev,
> +					struct rcar_gen3_thermal_priv *priv)
> +{
> +	while (priv->num_irqs)

Please use a for loop not modifyig priv->num_irqs, this looks dangerous.

> +		devm_free_irq(dev, priv->irqs[--priv->num_irqs], priv);
> +}
> +
>  static void rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
> +	struct rcar_gen3_thermal_priv *priv = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
> +	unsigned int i;
> +
> +	for (i = 0; i < priv->num_tscs; i++) {

Declare loop variable in for loop, where possible.

> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN, 0);
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
> +	}
> +
> +	rcar_gen3_thermal_free_irqs(dev, priv);
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> @@ -491,22 +509,32 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
>  
>  	for (i = 0; i < 2; i++) {
>  		irq = platform_get_irq_optional(pdev, i);
> -		if (irq < 0)
> -			return irq;
> +		if (irq < 0) {
> +			ret = irq;
> +			goto release;
> +		}

This changes the behavior of the driver...

Please stop using an LLM to code this. As you don't have hardware to 
test with throwing LLM spaghetti over the wall and see if it sticks is 
getting tedious. Please read, understand and write the code yourself as 
coding for gear you can't test is hard.

I will not review another set of LLM slop, especially as the good parts 
like RCAR_GEN3_THERMAL_MAX_IRQ are dropped between revisions.

Nacked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  
>  		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
>  					 dev_name(dev), i);
> -		if (!irqname)
> -			return -ENOMEM;
> +		if (!irqname) {
> +			ret = -ENOMEM;
> +			goto release;
> +		}
>  
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
>  						rcar_gen3_thermal_irq,
>  						IRQF_ONESHOT, irqname, priv);
>  		if (ret)
> -			return ret;
> +			goto release;
> +
> +		priv->irqs[priv->num_irqs++] = irq;
>  	}
>  
>  	return 0;
> +
> +release:
> +	rcar_gen3_thermal_free_irqs(dev, priv);
> +	return ret;
>  }
>  
>  static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
