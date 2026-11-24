Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526152;
	b=T78AnCL4oQeF34EM8+x8kM751hthZ2+hQqFf5/8OdnztfFCw5UVTC1WdRAOg17NWX6eb
	 X+FOr5vhRZnGP0sE5MrCodOu8h4XMIP00LZ5aogLtTMpsofGPtLtFs1rlq+v+vZA7yfw2
	 i2MOp0HFrGU+IgQCyvOEg/WU8hIs14E04fnpaCmCD+zShaOx9DUUptIU4/QfvXPl39SDG
	 l1Yisk/5aSC1zi7CsDaHEiUcMGMPOT14vatpYDpczOtLy46SR/FAJuTDmDN8TdUcMeLvR
	 dPvZsJ/pQTfEly2Ud6pyUADR+bvv62rhpufV36stgEn+kIjf9Gct5nf9irRoN9LKDOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526152;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=aVamEKjGtmIT7yRnNtNWQ+dI6BoC4j7+bmZgBFsxNNk=;
	b=IyIJJ5rXSJ03hvZIyUhTq8a9frMARosQ5F4Ovu/qrp2dBNPPp/Kd26M1YiDUeN/ksspS
	 ciQJp12BcjNRnFgRsWInX1ST26z9sLN3mzPlN/8/tehonCLI5yegFdd1Co6Ip0/jZi+yu
	 yLcpM1cY/UQV7eSdhX5ia/k7uTsrPN0OkAtOxpNKNvoA1N9rKznbH0WnuzyAYJ0jBcwsc
	 hMFBo3EQHMiL9CFs9wXmcmyo/R7adEbLJkKXuK2GutXHnYoczxoB6iTIAX03YNQqnOVOl
	 ghJU4EyBBI3j6ui/iUoWrotMJccSRXFi8dd3Ls7eIq37ODVhb6F9b6ZLSzXAMoZNQ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=dEzkMMUv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="w/aZyZqk";
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDE606A322
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 13:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BADDE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=dEzkMMUv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w/aZyZqk
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D0DF1EC0AB4
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 08:15:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 08:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795526150;
	 x=1795612550; bh=aVamEKjGtmIT7yRnNtNWQ+dI6BoC4j7+bmZgBFsxNNk=; b=
	dEzkMMUvWGGyRHwuCbQkHNfx38zG4ZZmADvTzy5Eep7HWf8lmHCKH+Sc/rkPrFgV
	AaAep+uYc9GKB+1PXNRgDDDWbAp7Ze2EubZj3sxDwUHAU2INmiMO0GH4iv5Hg/xI
	Ax775a/7q0h+paZZpjN2XnF+N4rHxuBMKkgeWtwyLJtQ+crZ+VNQ1B7fdan7WW1S
	2fcLRdgvmbU2peJzf+Tues5cY1dZYcQFJseKE5DrBnERKFgFOCW9HNzXM5rJGBBV
	pXLOQKQDKUvcpW0p8Pi7UVDkVUovQf0w09SM+YmRnDr2amzD+O6gu5z+QFIRhHEk
	jscDYK0xevZcTKWNIfaCYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795526150; x=
	1795612550; bh=aVamEKjGtmIT7yRnNtNWQ+dI6BoC4j7+bmZgBFsxNNk=; b=w
	/aZyZqk/YSDlUpGg3fT/Tsp5bfjM5BW/56SQBVHfZJr6+GH84FmA5yXTOeUyNgLq
	7SqUvi4wF1ANpmqDvLEorH1lWhghumc5PJ/aIG3QZDra5GsH5CpRVFLNP48JfEss
	OArnb7OZLCBQVkpzHXYztV0KknGHKmoLReQQ9LrC5YnpRVQVec3W/pVO/IpfOET6
	8Y1S2vBrbwQDIPe1C2Qd6bHReKRKkRtvAJHjqqbmtCqK51P3QFeAVJOyRj9s0wwh
	+f7Xs7Aia4dU9JgOcZJReP4Ktdeq+haNmOhnHoVLbxrdY570WsLMRDJo/Cn3iXQP
	eZmLYEEHREmJnQfreg+tw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795526150; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:NJGBTuSbOu9oUPz53OuHqbdGwBD9AWXQMwpQ2IpU2m2mNv+
	712naZmIl+78QrzJ6YCa6FUbzin2pViJyO4TdREyZcOnEVIMkqzonjO3KTYAKd8P
	iTcf842uwzG1DuxXidAZk5vm4mJOTh1tyuNqy04oq6XHY8r74AUGDLuzCDnRDdug
	WLcMt/bqbCfNWeoQl5s/HQPf+tOAmkEdnXPS5wJfHGBkf0U3k0APEGzxtMLx82u9
	dfBxcj4K4/3SedAYf725aPp+VOjgt/KtBCPI2HzrBfpktvpcnvmhJHdmkeTP4pUT
	N+ci2P6tM/tWWeY76m2OX1kiwdQxvZ4lQOir2jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JPIzaRU0RPD24xhYpH+g2304YB/5/4rHLN6fQWqHtic=:PUzoxzOICq8kfRbfuyeCkCzvlzYK+hVmRTnMGFTmvOY=;
X-ME-Sender: <xms:BY4Fa_9nTaOfps3qouT24SWpbZ62UX1wQwEgp3blxhwOmZHMQCPPsw>
    <xme:BY4Fa8IXGiaZhMp7Q07mJZFkScl5xP-IeC2DExNsFTHVcqNQAFirwEy7-nS2RsHN2
    cb5iLwltaaDvgcYzNJr-RL3auC4NqqnCtrjx3TYHQPPukCEBXFlWNga>
X-ME-Received: <xmr:BY4Fa9tlU5Zl8bOXKxPuJqZY3WaXv4ng6_H39oPdUyyPWwX3SllLVcoTkN2aWAzZFDtgp94bODIudB9UPRxyfC6f7Sxi2eg>
X-ME-Proxy-Cause: dmFkZTFrJFsw3Ege2Uj5arsxtTNJaBTBul296UB2io5A6CESSkqbdfdZ1GFQsUQHkREpe1
    tUr0V5+X/sjXWyvVC/oBDoc5GHHakUhRY5gLXqhWJDndfRFfmBP1Hakoe+RxT0sRfVNeQU
    Pnn+hj11+iEBIdbzUGTze5pYm4MuLuvJbovc9cxYQilAmZEPt+hDpyFDZNWa8aYbyCvXzN
    I2zroZ5OcQ4sl6QkI6LpUTXv3CZtoxiyeEst9EY4RQwBSqsrn040Y1Ob4beFtwtoXWli03
    mJuuLNqqGYLlD3XDG2Adh+F5tuwCwhrbRgfJhHszuYl1jC5TklIk38yHbG6XmLN1Uz12L1
    HXnhGdbnuj+/E3fq8UJtZIyMLkoVVrcqJJfoLaiEynHdc+ouoaZh9HICIJQEqvk13lUZ7f
    MSlJi0VQfZ3n/UTX3k0G7l1I3xA4Xenh4g8AZBTqUmGNFT75Jz0/eJMurT/ywvUaqJwbOU
    NMk30GrcLcQdVSeLDKhAcKVW0CLeLxEhrWBIkj9yBuKM3SqM9cVtWWlqm8iDBzLhDFANhY
    Y2pzxznyOb1ldZSsBjJu0XiPLArGlZ++UzIG1252I88r1hHubt/OYKiIivXeiHd/SOOBr4
    bdKppVkbCPHcbcilaNNDj+astyxCT2sMc929od1G5peZZdcjCXIt7qxzF7oQ
X-ME-Proxy: <xmx:BY4FazAHtTZekxen4-DcsylcinC_W6p5rw6R7GVHoApyRDPe0JvdCg>
    <xmx:BY4Fa1Nob6NluIZNkd9UWfyjBATnysvMrvuRimoohDRMsgAQPRLh_A>
    <xmx:BY4Fa7D-IgUxY042sSi-itT7qExAlQRblxJjTeqybOadaXLLJvH4ig>
    <xmx:BY4Fa-5oFme7Y5o5Icgr4AClJAQkyYqoIy62-6pWz27vQG7xTTl5-g>
    <xmx:Bo4Fa5nydV3NY_NNhCG5BuQf6-6ngLctKbAOAOPTj2bA9evkPT0B66yh>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 08:15:49 -0500 (EST)
Date: Tue, 24 Nov 2026 14:15:47 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thermal: rcar_gen3: register the interrupt handlers
 after the zones
Message-ID: <20261124131547.GI3898744@ragnatech.se>
References: <20261119022926.1493582-1-shunsheng1218@gmail.com>
 <20261124095110.131258-1-shunsheng1218@gmail.com>
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
In-Reply-To: <20261124095110.131258-1-shunsheng1218@gmail.com>

Hi Yaohan,

This is a very large patch doing lots of different things and needs to 
be broken up. And I'm concerned about removing the remove() function in 
favor of devm_add_action_or_reset() design.

When I suggested altering the probe order I had in mind moving the init 
order of things to make sure it was cleaned up in the right order not 
making it depend on devm. Maybe that is not possible, but if this is the 
only solution it needs to be broke apart in discreet steps that can be 
reviewed.

On 2026-11-24 17:51:10 +0800, Yaohan Li wrote:
> The interrupt handlers are requested before the thermal zones are
> registered, and devres releases resources in the reverse order.  That
> leaves the same object exposed at both ends: during probe the handler
> exists while part of the sensors and zones are not initialised yet, and
> during teardown it outlives the zones it reports to.  The handler walks
> every sensor and calls thermal_zone_device_update() through tsc->zone,
> which is never cleared when the zone is unregistered.
> 
> Fix the order rather than the removal path.  Look the interrupts up
> first, keep the source masked while the sensors are initialised, and
> register the handlers only once every zone exists.  A devres action
> registered after the handlers masks the source again, and the source is
> enabled last, so the teardown order comes from devres itself: source
> off, handlers, hwmon, zones, MMIO mappings, runtime PM.  ->remove() has
> nothing left to do and is gone.
> 
> The thermal core copies the zone operations when a zone is registered,
> so whether set_trips() is available has to be decided before the zones
> are created.  Registering the handlers last moves that decision after
> the zones exist, so when the interrupts cannot be requested the zones
> are released and registered again without set_trips(): the driver keeps
> the polling configuration it had before instead of failing the probe.
> The zones are created and dropped once more in that path only.
> 
> rcar_gen3_thermal_init() clears REG_GEN3_IRQEN as well.  Nothing but
> rcar_gen3_thermal_enable_irqs() writes the register again, at the end of
> the probe and from ->resume(), so a source that the firmware or an
> earlier bind left enabled does not stay on while the zones are being
> created.
> 
> Check the sensor count before reading the fuses, because the fuse
> reader dereferences tscs[0].  Return -ENODEV when no sensor resources
> are present.
> 
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> 
> ---
> Prepared against v7.4-rc1-1969-g666539eecdf4.
> 
> Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
> CONFIG_ARCH_RENESAS, CONFIG_ARCH_RCAR_GEN3 and CONFIG_RCAR_GEN3_THERMAL.
> No board was available, so probe, the polling fallback, resume and
> teardown were not exercised on hardware, and there was no way to make an
> interrupt request fail on a real device.
> 
> Changes in v3:
>  - Register the interrupt handlers after the thermal zones and let devres
>    own the whole teardown, as suggested; ->remove() is gone.
>  - Look the interrupts up before the zones are registered, because the
>    thermal core copies the zone operations at registration time.
>  - Split the sensor initialisation from enabling the interrupt source and
>    re-enable it from ->resume().
>  - Clear REG_GEN3_IRQEN in the sensor initialisation, so that the source
>    stays masked until it is enabled on purpose.
>  - Keep the polling fallback when the handlers cannot be requested:
>    release the zones through a devres group and register them again
>    without set_trips().
>  - Check for a device without sensors before the fuses are read.
>  - Drop the has_irqs() helper.
> 
> AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
> author reviewed the reasoning and takes responsibility for the content.
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 197 ++++++++++++++------
>  1 file changed, 145 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 9c64cbc2ee67..7e4d6aa6e5dd 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -103,6 +103,8 @@ struct rcar_gen3_thermal_tsc {
>  	int thcode[3];
>  };
>  
> +#define RCAR_GEN3_THERMAL_MAX_IRQ	2
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
> @@ -324,8 +327,7 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
>  	return true;
>  }
>  
> -static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
> -				   struct rcar_gen3_thermal_tsc *tsc)
> +static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>  {
>  	u32 reg_val;
>  
> @@ -335,11 +337,9 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
>  
>  	usleep_range(1000, 2000);
>  
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, 0);
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> -	if (priv->ops.set_trips)
> -		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
> -					IRQ_TEMPD1 | IRQ_TEMP2);
>  
>  	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
>  	reg_val |= THCTR_THSST;
> @@ -466,9 +466,9 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  
> -static void rcar_gen3_thermal_remove(struct platform_device *pdev)
> +static void rcar_gen3_thermal_pm_put(void *data)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = data;
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> @@ -481,25 +481,66 @@ static void rcar_gen3_hwmon_action(void *data)
>  	thermal_remove_hwmon_sysfs(zone);
>  }
>  
> -static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
> -					  struct platform_device *pdev)
> +static int rcar_gen3_thermal_register_zones(struct rcar_gen3_thermal_priv *priv,
> +					    struct device *dev)
>  {
> -	struct device *dev = &pdev->dev;
>  	unsigned int i;
> -	char *irqname;
> -	int ret, irq;
> +	int ret;
> +
> +	for (i = 0; i < priv->num_tscs; i++) {
> +		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> +		struct thermal_zone_device *zone;
>  
> -	for (i = 0; i < 2; i++) {
> +		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
> +		if (IS_ERR(zone)) {
> +			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
> +			return PTR_ERR(zone);
> +		}
> +		tsc->zone = zone;
> +
> +		ret = thermal_add_hwmon_sysfs(zone);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(dev, rcar_gen3_hwmon_action, zone);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcar_gen3_thermal_get_irqs(struct rcar_gen3_thermal_priv *priv,
> +				      struct platform_device *pdev)
> +{
> +	unsigned int i;
> +	int irq;
> +
> +	for (i = 0; i < RCAR_GEN3_THERMAL_MAX_IRQ; i++) {
>  		irq = platform_get_irq_optional(pdev, i);
>  		if (irq < 0)
>  			return irq;
>  
> +		priv->irqs[i] = irq;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
> +					  struct device *dev)
> +{
> +	unsigned int i;
> +	char *irqname;
> +	int ret;
> +
> +	for (i = 0; i < RCAR_GEN3_THERMAL_MAX_IRQ; i++) {
>  		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
>  					 dev_name(dev), i);
>  		if (!irqname)
>  			return -ENOMEM;
>  
> -		ret = devm_request_threaded_irq(dev, irq, NULL,
> +		ret = devm_request_threaded_irq(dev, priv->irqs[i], NULL,
>  						rcar_gen3_thermal_irq,
>  						IRQF_ONESHOT, irqname, priv);
>  		if (ret)
> @@ -509,14 +550,34 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
>  	return 0;
>  }
>  
> +static void rcar_gen3_thermal_enable_irqs(struct rcar_gen3_thermal_priv *priv)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < priv->num_tscs; i++)
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN,
> +					IRQ_TEMPD1 | IRQ_TEMP2);
> +}
> +
> +static void rcar_gen3_thermal_disable_irqs(void *data)
> +{
> +	struct rcar_gen3_thermal_priv *priv = data;
> +	unsigned int i;
> +
> +	for (i = 0; i < priv->num_tscs; i++) {
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN, 0);
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
> +	}
> +}
> +
>  static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  {
>  	struct rcar_gen3_thermal_priv *priv;
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> -	struct thermal_zone_device *zone;
>  	unsigned int i;
>  	int ret;
> +	void *group;
>  
>  	priv = devm_kzalloc_obj(dev, *priv);
>  	if (!priv)
> @@ -525,14 +586,25 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	priv->ops = rcar_gen3_tz_of_ops;
>  
>  	priv->info = of_device_get_match_data(dev);
> +
>  	platform_set_drvdata(pdev, priv);
>  
> -	if (rcar_gen3_thermal_request_irqs(priv, pdev))
> +	/*
> +	 * The interrupts are looked up here but their handlers are registered
> +	 * only once the thermal zones exist.  The thermal core copies the zone
> +	 * operations when a zone is registered, so whether set_trips() is
> +	 * available has to be decided before the zones are created.
> +	 */
> +	if (rcar_gen3_thermal_get_irqs(priv, pdev))
>  		priv->ops.set_trips = NULL;
>  
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> +	ret = devm_add_action_or_reset(dev, rcar_gen3_thermal_pm_put, dev);
> +	if (ret)
> +		return ret;
> +
>  	for (i = 0; i < TSC_MAX_NUM; i++) {
>  		struct rcar_gen3_thermal_tsc *tsc;
>  
> @@ -541,22 +613,20 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  			break;
>  
>  		tsc = devm_kzalloc_obj(dev, *tsc);
> -		if (!tsc) {
> -			ret = -ENOMEM;
> -			goto error_unregister;
> -		}
> +		if (!tsc)
> +			return -ENOMEM;
>  
>  		tsc->priv = priv;
>  		tsc->base = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(tsc->base)) {
> -			ret = PTR_ERR(tsc->base);
> -			goto error_unregister;
> -		}
> +		if (IS_ERR(tsc->base))
> +			return PTR_ERR(tsc->base);
>  
>  		priv->tscs[i] = tsc;
>  	}
>  
>  	priv->num_tscs = i;
> +	if (!priv->num_tscs)
> +		return -ENODEV;
>  
>  	if (!rcar_gen3_thermal_read_fuses(priv))
>  		dev_info(dev, "No calibration values fused, fallback to driver values\n");
> @@ -564,40 +634,64 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	rcar_gen3_thermal_shared_coefs(priv);
>  
>  	for (i = 0; i < priv->num_tscs; i++) {
> -		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> +		rcar_gen3_thermal_init(priv->tscs[i]);
> +		rcar_gen3_thermal_tsc_coefs(priv, priv->tscs[i]);
> +	}
>  
> -		rcar_gen3_thermal_init(priv, tsc);
> -		rcar_gen3_thermal_tsc_coefs(priv, tsc);
> +register_zones:
> +	group = devres_open_group(dev, NULL, GFP_KERNEL);
> +	if (!group)
> +		return -ENOMEM;
>  
> -		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
> -		if (IS_ERR(zone)) {
> -			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
> -			ret = PTR_ERR(zone);
> -			goto error_unregister;
> +	ret = rcar_gen3_thermal_register_zones(priv, dev);
> +	if (ret)
> +		goto release_group;
> +
> +	/*
> +	 * Handlers last and the source enabled after them, so devres runs the
> +	 * teardown in the opposite order: source off, handlers, hwmon, zones,
> +	 * MMIO mappings, runtime PM.
> +	 */
> +	if (priv->ops.set_trips) {
> +		ret = rcar_gen3_thermal_request_irqs(priv, dev);
> +		if (ret) {
> +			dev_info(dev, "Failed to request interrupts (%d), polling instead\n",
> +				 ret);
> +
> +			/*
> +			 * The thermal core copies the zone operations when a
> +			 * zone is registered, so the zones above cannot be
> +			 * switched to polling afterwards.  Release them and
> +			 * register them again without set_trips().
> +			 */
> +			devres_release_group(dev, group);
> +
> +			for (i = 0; i < priv->num_tscs; i++)
> +				priv->tscs[i]->zone = NULL;
> +
> +			rcar_gen3_thermal_disable_irqs(priv);
> +			priv->ops.set_trips = NULL;
> +			goto register_zones;
>  		}
> -		tsc->zone = zone;
>  
> -		ret = thermal_add_hwmon_sysfs(tsc->zone);
> +		ret = devm_add_action_or_reset(dev,
> +					       rcar_gen3_thermal_disable_irqs,
> +					       priv);
>  		if (ret)
> -			goto error_unregister;
> +			goto release_group;
>  
> -		ret = devm_add_action_or_reset(dev, rcar_gen3_hwmon_action, zone);
> -		if (ret)
> -			goto error_unregister;
> -
> -		dev_info(dev, "Sensor %u: Loaded\n", i);
> +		rcar_gen3_thermal_enable_irqs(priv);
>  	}
>  
> -	if (!priv->num_tscs) {
> -		ret = -ENODEV;
> -		goto error_unregister;
> -	}
> +	devres_remove_group(dev, group);
>  
> -	return 0;
> +	for (i = 0; i < priv->num_tscs; i++)
> +		dev_info(dev, "Sensor %u: Loaded\n", i);
>  
> -error_unregister:
> -	rcar_gen3_thermal_remove(pdev);
> +	return 0;
>  
> +release_group:
> +	devres_release_group(dev, group);
>  	return ret;
>  }
>  
> @@ -606,11 +700,11 @@ static int rcar_gen3_thermal_resume(struct device *dev)
>  	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
>  	unsigned int i;
>  
> -	for (i = 0; i < priv->num_tscs; i++) {
> -		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> +	for (i = 0; i < priv->num_tscs; i++)
> +		rcar_gen3_thermal_init(priv->tscs[i]);
>  
> -		rcar_gen3_thermal_init(priv, tsc);
> -	}
> +	if (priv->ops.set_trips)
> +		rcar_gen3_thermal_enable_irqs(priv);
>  
>  	return 0;
>  }
> @@ -625,7 +719,6 @@ static struct platform_driver rcar_gen3_thermal_driver = {
>  		.of_match_table = rcar_gen3_thermal_dt_ids,
>  	},
>  	.probe		= rcar_gen3_thermal_probe,
> -	.remove		= rcar_gen3_thermal_remove,
>  };
>  module_platform_driver(rcar_gen3_thermal_driver);
>  
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
