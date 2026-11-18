Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992419;
	b=C9uIPzrXdjryBGYXn1LijlfnyGGlqjn6BcE31RflyBgI0BJ4xT6iBgykZyW/rBs5TzrX
	 +kwtBm+y/7LICffNgKMIu+wssDWTh3LOsKKO1OJaN3reqvK+QnIL7BDmEAvqwoyX0fDNy
	 Rt6r1/fwqzP+i/AsyZSZH8kwS6k4kgxGUt52RVcnZ17y2L3S8/pArsD3+pPr+38TFBjOR
	 91HUsa82MSaTZt+NM+C6+ld/CQUVuYedGjUBk6vl/IPu81aeuv4iNJZXQiab+5JNutZ5O
	 LD7UgcZXZmHDHxA7FnSKGteLnrpzlKOf/Uw9Ovr6R1zIiU1L4ji66XJab1AGK6tA4GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992419;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=O1Zuqj1CQ3HIs4OoVPok+NCHeUHpOa6mmQezy5OadJw=;
	b=PiGXHbCyJZtZMQzJHLDJX0s2mdzNzMdtUKthbt/roX14MiJfHYPgX+e6YOwNcMdpyKxM
	 z1vxf+GqJeVPHLlHMVFk3GCKmkCvA42CpDVmHgEATUGC9XFEoHs3d7//THzSbYjutkTuT
	 IvN01LgIqTkkgkNJ4Xmf8YgJn0JhVQ17c62qcpL2aDoOjsE9yZd2mMg1Wg39a/RFDhFSA
	 mUdkCFpI4Wwxs64OY+XtTa0U361IVVciRzackJhbM2mbaiLhEwR/xIU6SFVjjCFH8tp91
	 juA1abhTdy2IyDYBF91j7nRNqa2kiXvDxJNfTQ1axm8IeZXnkv7ywkl7WXg+3wOBSXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=sg7sEvpq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DpXku8Ro;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72584606A32F
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 09:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72584606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=sg7sEvpq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DpXku8Ro
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 584EB140016A
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 04:00:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 18 Nov 2026 04:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794992417;
	 x=1795078817; bh=O1Zuqj1CQ3HIs4OoVPok+NCHeUHpOa6mmQezy5OadJw=; b=
	sg7sEvpqICnS3kyfQ/cKX5szWBswUs8GMsmHk4Q7KgsXQFoqruQsS+fiFqDTz7Gb
	k7qFMn6m2Om5YHaufZH18AWhpNBhvZuRXQADi8/LqpC8V5vu80MHM8FabXyAAX+v
	4Of6zVi72g+GN/DqoiwkqjqFYl/SmR99E6RMoZzAGVjjwG+QtwtsZssOXw3a1KOa
	oV0m+fkmb6MYB5yXdwj0cr4JyFdr82cZYKlYntJOw9nvmHmZ67m3LCK1hHUwnh+Z
	ccDAWikFBRbjfAoBnRXcKlm0kgwNp8mRjSN7nHzxgliV0iArpPragZZ+G0Zk7ewY
	dXHPjWrk7fPbyejGNzk45A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794992417; x=
	1795078817; bh=O1Zuqj1CQ3HIs4OoVPok+NCHeUHpOa6mmQezy5OadJw=; b=D
	pXku8RotRfreHnABoy+hg5PPk7oWl4MdpI8Z9pQu3SebEZa3Xi3c5/gCMSQXj0jP
	ldMRID13V3Bh/v2ugfgdgT+9f0WgEk9froZN2bxP6xf4Orx82iHff8xFtePE8P2Y
	tWPuT+bqGxwFIoPn2FSvKKbV9EPey/7Vm99s6CDU08K1e3hqPAwilc6k4+61RaG4
	fEhku/Ix+GmKLL9gaXGT98WKAc2PTgZ8GH6t0IFsXuXdEulSkkEwDsWCPP7NIKng
	/MvP50PL+J2sXOPaCttLE+E9lNmhlXteI3TGvxwr+phVKHVMgpBR6lvD7T7LDpER
	P/er64oGjAK2p1vuCIeHA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794992417; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:lHsnCzN1WR2x8P8wAXamj3u9L63UqSgFSvk+piu+6C/a+WB
	5CAZ/LVmqUZeM1rwF7Uprr4Vknf5agj5+8937RhseBGV1k+ErNVC+uXzNsZdiqFm
	RFLZrQevSDo36DgmLdpMFdQPgMsBVjtqjbYlNJpAzXDjrjUVau680VaS0otlOnX7
	VtbillQILqFQUoik/DTLv+m+RvnHzBM4hJn4Kr4taEBO/Mx5B+gkc8mSYgCQlQJ/
	fS+FbVsd+vtmzTEqElGJPz9sXT7tH+BGRMc/LPjlVToYA6jOxtd1DtXvgnvNCJdj
	BmfxX7AhGIVvt2rUtb6cBSNJwfWzRyKZUAByrTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WyF0zVptO0hT/Gj/4MO2VJUkm5KNoLN/lp9vy1I+2S8=:9i/Bn9dpE8qY2/dK8JXmacoQYfGAh2dF9Omtlgo4pU8=;
X-ME-Sender: <xms:IGn9ak89ECXRRTTUhv6BtM6ZKyMn-p-xhMp-br3OgAYqhaSj9NEaAw>
    <xme:IGn9aonnt1znlHXO6d7OZpi6x3JNywc98RQe7etuX95BRpv9y2Ok8i9IlaL_TZmyS
    I5FMD8X53JRVSzk5b0XV1cecqsAXwM5bQEvwxqZr00sxyGI7sk5ex1a>
X-ME-Received: <xmr:IGn9anDGacS0VARigPXNEYlu9YinJb2MgUXN_f8pHp2py9CaB5LCcEpqIwLEY-W0O_wqG2vuPCTKThr0LeEWGVM39LN6riE>
X-ME-Proxy-Cause: dmFkZTEGjVb+GMea+ndDFuPfuSMvTDM5F/kwVR+Ek3vZwbQlF6vvu0/3QDyeTFmg91x3+h
    jpc5v98rpqJfDsGwWWbB6TglfKY1GfWp633HCJZKgbGQ8tqQW9B8TQVe8TWIba+J7yucTl
    JzSGzazLpFPAQQ/5qKpWZzQqZdyeJCMHleDcc4MMGm7PI634kb2i3dJSM7OtuIGnom4Ad7
    DVJVo3YEAMev5kqeIMx8dsrGYiNUqvxM2XWaeX6ngZ9MIR0dQeP/gmUS/eWhuPfHbubaIO
    E+zqtdcYhLbQFb0NP1iyr0GJwSagZlAoSCW9Y9/M+RsGK6BXur7bny38cn7T3HRp+LhZQg
    QYkofoomdS1cxnhN05oixijxI7L3jOIHq1XJJlIGwREOU4FmJN/QLXxwV9dQWjpzBu0nX9
    sYXRtWZdScjheMriILH8J5+SbrO0NvRjBtnhJiX2p1a/IFdf61BjdITJqJ/nGTSH3kNDEW
    tOQwdKOPeZOUTCFQscNHSOtvgv0gLwUkD1Kop2dvggx5/Vzjj02UAoTaBFSa/Ea4hvpwca
    Xbgt3+8f2WNZT0Y4ZuirZM5pQDlOWFhx63y/veO+YkuqAe0ih7/rGK7ALWJsK6j8KfX6O4
    fVhBOZOGl0qaefgOCWNepJ/TdazsQNEEXQuqie88K6aZURzU3B2IN9K7FazA
X-ME-Proxy: <xmx:IGn9apWIw3VIKwpsg4EFcVnfhKjGOz6lo44YHdToy9fdotZqlLZbqw>
    <xmx:IGn9at8-pLgpaGPGnOF_b6oQrVRyQIPed-BlYlTupa9pXD0IxZlRrQ>
    <xmx:IGn9ajRcrbhB1YZnIbvoL6HRQWNzhFq-h-LxIkfFf6YCyJR7A4hewQ>
    <xmx:IGn9aqSQIcGBgeaifLXHgSjGTHvvq1_7I2r8HNeZQPkyxY4o7w6k_A>
    <xmx:IWn9avBgwAgtyYNjb-8c-_417f0T30OocxSvZl3qSP4Nuxd-RUXHeBrm>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 04:00:16 -0500 (EST)
Date: Wed, 18 Nov 2026 10:00:14 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, geert+renesas@glider.be, magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, edubezval@gmail.com
Subject: Re: [PATCH] thermal/drivers/rcar_thermal: wait for IRQs before
 cancelling work
Message-ID: <20261118090014.GB2300348@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
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
In-Reply-To: <20261118072321.1259639-1-shunsheng1218@gmail.com>

Hi Yaohan,

Thanks for your work.

On 2026-11-18 15:23:21 +0800, Yaohan Li wrote:
> rcar_thermal_remove() masks the interrupt sources and cancels the
> delayed work of each sensor.  rcar_thermal_irq() reads INTMSK and STR
> under common->lock, drops the lock, and only then walks the sensors and
> queues priv->work for every sensor whose status changed.
> 
> A handler that sampled the status before the mask was written can
> therefore reach queue_delayed_work() after cancel_delayed_work_sync()
> has returned.  The work stays pending past the end of ->remove(), devres
> then frees common, priv and the thermal zone, and rcar_thermal_work()
> runs 300 ms later on freed memory.
> 
> Waiting for the handler is not enough on its own: rcar_thermal_work()
> calls rcar_thermal_irq_enable() once it has updated the temperature, so
> a work that is still running when the removal starts re-enables its
> source and undoes the mask that ->remove() has just written.
> 
> Record the shutdown in rcar_thermal_common under common->lock and make
> _rcar_thermal_irq_ctrl() refuse to enable anything once that state is
> visible.  The removal then publishes the shutdown, masks all sources,
> waits for the handlers with synchronize_irq() and only then cancels the
> work, so neither a source nor a work item can be brought back after it
> returns.
> 
> Fixes: 697ee786f15d ("thermal: rcar_thermal: Prevent doing work after unbind")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---
> Prepared against v7.4-rc1-1969-g666539eecdf4.
> 
> AI assistance: the analysis, the change and its review notes were
> prepared with Claude (Anthropic) as a coding assistant.  The author
> reviewed the reasoning and takes responsibility for the content.
> 
> Testing: compile tested only (arm64, gcc 11.4).  No R-Car hardware was
> available, so the unbind race was not run.
>  drivers/thermal/renesas/rcar_thermal.c | 43 +++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index af6d09a75bb6..1d6ee37968e2 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -39,11 +39,17 @@
>  /* THSSR */
>  #define CTEMP	0x3f
>  
> +/* .nirqs of every supported chip is at most this */
> +#define RCAR_THERMAL_MAX_IRQ	2
> +
>  struct rcar_thermal_common {
>  	void __iomem *base;
>  	struct device *dev;
>  	struct list_head head;
>  	spinlock_t lock;
> +	bool shutdown;
> +	int irqs[RCAR_THERMAL_MAX_IRQ];
> +	int nirqs;
>  };
>  
>  struct rcar_thermal_chip {
> @@ -301,6 +307,15 @@ static void _rcar_thermal_irq_ctrl(struct rcar_thermal_priv *priv, int enable)
>  
>  	spin_lock_irqsave(&common->lock, flags);
>  
> +	/*
> +	 * rcar_thermal_work() re-enables its source when it finishes, so a
> +	 * work that was still running when the device went away would undo
> +	 * the mask that rcar_thermal_remove() writes.  Once the shutdown
> +	 * state is visible nothing may enable the sources again.
> +	 */
> +	if (common->shutdown)
> +		enable = 0;
> +
>  	rcar_thermal_common_bset(common, INTMSK, mask, enable ? 0 : mask);
>  
>  	spin_unlock_irqrestore(&common->lock, flags);
> @@ -376,9 +391,33 @@ static void rcar_thermal_remove(struct platform_device *pdev)
>  	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
>  	struct rcar_thermal_priv *priv;
> +	unsigned long flags;
> +	int i;
>  
> -	rcar_thermal_for_each_priv(priv, common) {
> +	/*
> +	 * Publish the shutdown state before anything else: a work that is
> +	 * still running re-enables its interrupt source on its way out, and
> +	 * has to be prevented from undoing the mask written below.
> +	 */
> +	spin_lock_irqsave(&common->lock, flags);
> +	common->shutdown = true;
> +	spin_unlock_irqrestore(&common->lock, flags);

Adding a shutdown flag seems like a lot of complexity for somehting like 
this. Would not being more clever here avoid that? Maybe something like 
this,

    /* No more work will be able to queued hence the irq can not rearm 
     * itself from the top half.
     */
    disable_work_sync()

    /* Disable any new interrupts in case they currently are enabled. */
    rcar_thermal_irq_disable()

    /* Wait for any bottom half interrupt to complete. */
    synchronize_irq()

    Now there can't be any races!

For this flag,

Nacked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> +
> +	/*
> +	 * Mask the sources, then wait for a handler that sampled the status
> +	 * before the mask was written.  The handler drops common->lock
> +	 * before it queues the work, so without the wait it could queue
> +	 * priv->work after cancel_delayed_work_sync() has returned and leave
> +	 * the work running on a priv that devres frees once ->remove() has
> +	 * finished.
> +	 */
> +	rcar_thermal_for_each_priv(priv, common)
>  		rcar_thermal_irq_disable(priv);
> +
> +	for (i = 0; i < common->nirqs; i++)
> +		synchronize_irq(common->irqs[i]);
> +
> +	rcar_thermal_for_each_priv(priv, common) {
>  		cancel_delayed_work_sync(&priv->work);
>  		if (priv->chip->use_of_thermal)
>  			thermal_remove_hwmon_sysfs(priv->zone);
> @@ -449,6 +488,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		if (ret)
>  			goto error_unregister;
>  
> +		common->irqs[common->nirqs++] = irq;
> +
>  		/* update ENR bits */
>  		if (chip->irq_per_ch)
>  			enr_bits |= 1 << i;
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
