Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069329;
	b=CV6H7GNoZNHsrXkz7rTBQ8OBf3L0nUTAaRd7GxX9BgPqLnUAFsHhsPqBxBqgh5385EVQ
	 N5etlZHnP+gPcjbx0zuYKkkXadfcVOxsCJ3neWNtFwT+tdhC/Z3QsLfiPnKFg43LgO+XU
	 g07PRqFCBMgktEtD3DlLyAL8N19i+Y7pJK361CphIHf/XunAPr0OuQXmpytkPRyrz2hnG
	 +3IboqThcgK6M8ic+sbShNJt66ClVvBQ/+SUFrEgAJMI6tgRoQfLxLRHWIIkvH+tQSvhU
	 JSMc07Czm/Qiwhpo9LCDQ0saPSJxsC2y6E8zuCjIMafqotdG4bYHsQQoXmU6Lfm3bdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069329;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Ao9DeZ00W1Ha8SrPgtgKIsZ+z4rQpKJ/lpe4GpJWBWw=;
	b=az1mEdNVMKQ0e6B1TnatWNtNPzJYt2q9xTz8l4latvHHHWZdEeK30zAAhbfPznyLWsN8
	 UIoOQxnLoNdHCJXMiflkJmeiBVVjsGs/hmLXqcsue0K7C8BTwm3e/BSm0dawjPtH7F3t4
	 okdl5Uc+jilaTKuDNUoRwdqcbJl9EXniasHSzQVMdOi5MXS3o/TCVm7ZEnB/MP+Eudqi1
	 qSlVKqvPIRSxCUMb8V/77W+Xn11IQChNnsxOaI1997STIzJZPoN/tvntVw15aI+NEBxkB
	 KngBQYJbBVHaA9Oi/QJHZeDhwzlD9kHS/6fTKRBOd9ecskUv7N7y26N8YVDVifXFbyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=TWjGzZTa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lcOephla;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DA606A339
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 06:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E9DA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=TWjGzZTa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lcOephla
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D96ECEC0008
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:22:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 01:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795069326;
	 x=1795155726; bh=Ao9DeZ00W1Ha8SrPgtgKIsZ+z4rQpKJ/lpe4GpJWBWw=; b=
	TWjGzZTayvGpDTkOTyxAMxTQml2VKD5NoBIVs2ZVUXoOISYaA3Uc1LxG+dXllhYe
	J8FxZsBsdvL6tFO56+d7HUXPzKgi7IAmgs6o/cm/15Jka4G+tfW8HRtGFX4GIjyB
	lZ5vRV85egHGbxXBKii+j+pzNZEkGZA0caU8pwv50zf/hZMXkvrGK+19K8rROrHL
	YHc1wturLPZzyL+fhyxeP1rPMvW3j1/wHAVDiovnXcibtM0N2Kvm3tPwH0yFDZXc
	3s1Wf6CQjtnsU+buz0OMiJulwT9v8/9vdNXTaCy0NFs5D/pM+pRWzNS292Nj6zoB
	AgmT9AcQSU2LUhLgWL0opw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795069326; x=
	1795155726; bh=Ao9DeZ00W1Ha8SrPgtgKIsZ+z4rQpKJ/lpe4GpJWBWw=; b=l
	cOephlaTHHsTmFyYdCBarj12KrWZh1ErZD47QUWRBMVJQHRfyGAfeCgckDcmDfMx
	lwItmwwZD3exyzG2ZlFwSyBbAEuUBWaqLf/WMkk1NCvDrC4RVG4AFbEqowlX5giT
	Iz0dri6yfXj1yKeNjSOU3areLB5YT0uOThBeHwSRyn/Pdb3yktdi3kRhcGFSABRz
	R5QkwH2B22KyKKQS5EJidcBYobWfh4mEFpEK8pnuNK0i3W3o7LS6dWEI4xw4Hfl/
	8escvIj1iduDwB/Mudh0k6CU7skSRGR7bPFOof1K1fs5fKmSES8pkLTGMDNilCxY
	6ssyyc74sIMXxWxTeZVVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795069326; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:aBDsz/W8BORywdPQ1DQdSixFasnnV9Vwua07MmVk1F3iw1G
	t7RSHX1liN0MXKzL9dtldCQtDustzutrKIewpC+VTUWSGIvOEtahwrP+P5l8pT+U
	ZSi8KijfTSinaghnZyyyma2DkSjBXFbw7q33AO35rUzmtIuhf7XgS5JUV8IZLrPV
	Zb3gZfmMsuz1thOq6S1WQirbBKpYOLBzV9Cfne1kHqdSZCI8RH408K7FzXH2y9Cm
	xqIEv8qXPvspkc4Cn98jLW9qpJXMUY6KgQ6wnc50vw5Bt651+gurLfO+rPXB07Os
	6xIxfD4hROX6uzVDR1gCMb1eqW3xkp6H/2oWH0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3XkK0W35CgOH/ZKPpusMqfDFNQ2k6j18tYK4xGXexXE=:OYBDagLCE9VvBKeXfkcgoMdANKiUxPGnsTXCyxnNgpU=;
X-ME-Sender: <xms:jpX-avr6WfwOaKp5-CrTkbIiwg4maxTIUS_vQEGJWEYV7uDSAU9rIg>
    <xme:jpX-alhLKWuI-Jy6crLHmRN7U6VJ1DpCgo44gSJzEQ1b14aoa2rh28cNRk42C9eYl
    pd5wpuyJ8OcZJ9_WRqctxdUOkSwIckazz8MYXRCyVXQGiw-2DExEIuK>
X-ME-Received: <xmr:jpX-apM_MU8rJFz7JdA5m7AjT4n3r2V1YOm3uT5I-bh7Qi-djzTfFhlacZ3RGB04dDi5RNAAKnRlDZM7JNcxjy0U0gr6Bdc>
X-ME-Proxy-Cause: dmFkZTEr95tSe0kNh6fNcC5bhVppNT54ROS1KzDK27rEScZTj0CiDDhAyE11Awns4Ey0B9
    qHzt1YKEmltWC2LNLmlF2H7jBw6N9O/U0Mehub4MnUYFmd8MXWqxgD/gnfqXeGDPviTjE6
    7AFDcBirkYMwrJ+33dS9TLg0sT6pNCsY34FbAFHriDmay+kg16sXd95o9IddWnMexW+DMx
    Eswel8V7dM5fpdTdBBDM+dfI9FZ7P8MGsXFEJliPVUDSFnUDz1mnyB7vOWxp/j2HxcpgrW
    LtmmbBP+ZKsh+8zyPukLfBKo8USZ+7c9+KZUi7mRPkhKC6wUGbkqFH+feU3XKIfUu/rdFN
    UIEQyyseZte0Ip3Z0avPDf9G3iSad95WuoHwMQ3tLtO3GsZYz5TGCbp2z7WCSUNKQRHIPC
    MZk32fhhaZbNbA0DSaF+XB48FdnGxQ5H+sn9Y3vjDEUO2M9MKnspKj4kJwaAyLGUWbP36w
    rpfaXKtL9Kuvu0jaNBouHIBw69N0uoaYYJCPoSi7UHMHu05oitgCYLP06/8SdJIECOBgm+
    abvytkYTadp/EgXJi24ADPBWJkzJEVv6gtTzeE3Lj0F4JiDmSwZVvKD+nB5rxM/Ao+jRNT
    Qk93dlGlf34nUcdtfMxYVtuPm1VsqXyzxoKe6OxCTt4FaVm6067ta88V8DzQ
X-ME-Proxy: <xmx:jpX-anyOy8nHWpG9B1jshvHE1Y-x9qIKWeN8Snlq4Wa1V-egfUIE8Q>
    <xmx:jpX-ajpMUHgMC8u7xylUrAP5l78eb4vV0WBJ6lYZAZ8qgcHT_IjFxA>
    <xmx:jpX-avPN0iI9JLjDZRVdZYSVaSGrYWOQrSRXAhBw1Y5TGSHvqLczcA>
    <xmx:jpX-aveYWBX8zQ5w-OAw4prvIuIAkLaCm09NpHtDe4QuKITXBKeZZA>
    <xmx:jpX-ar-SlIw2jrk4tj-DQVQzslSUB-B_dvegZH4ouZl2Zxjs0eToXMyc>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 01:22:05 -0500 (EST)
Date: Thu, 19 Nov 2026 07:22:03 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, geert+renesas@glider.be, magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, edubezval@gmail.com
Subject: Re: [PATCH v2] thermal/drivers/rcar_thermal: disable the work before
 masking the interrupt
Message-ID: <20261119062203.GC2300348@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
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
In-Reply-To: <20261119022903.1493494-1-shunsheng1218@gmail.com>

Hi Yaohan,

Thanks for your work.

On 2026-11-19 10:29:03 +0800, Yaohan Li wrote:
> rcar_thermal_remove() masks the interrupt sources and then cancels the
> delayed work of each sensor.  rcar_thermal_irq() drops common->lock before
> it walks the sensors and queues priv->work for those whose status changed,
> so a handler that read the status before the mask was written can still
> queue the work after cancel_delayed_work_sync() has returned.  The work
> then runs after ->remove() has finished and devres has freed common, priv
> and the thermal zone.
> 
> Waiting for the handler alone is not enough either: rcar_thermal_work()
> re-enables its interrupt source once it has updated the temperature, so a
> work that is still running when the removal starts undoes the mask that
> ->remove() has just written.
> 
> Disable the work before the source is masked.  That makes the
> queue_delayed_work() calls in rcar_thermal_irq() no-ops and guarantees
> that the re-enable in rcar_thermal_work() has already happened, so the
> mask that follows cannot be undone.
> 
> The interrupt line is shared, so waiting for the handler once does not keep
> it from running again later; unregister it in ->remove() instead of only
> calling synchronize_irq().  devm_free_irq() waits for a handler that is
> running right now as well, and the slot is marked unused so that the probe
> failure path, which also ends here, cannot release it twice.
> 
> Every sensor that the removal walks has been through INIT_DELAYED_WORK()
> before it is linked into common->head, so no uninitialised work is touched.
> The interrupt numbers are recorded in an array whose unused slots stay
> negative, instead of being counted separately.
> 
> Fixes: 697ee786f15d ("thermal: rcar_thermal: Prevent doing work after unbind")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> 
> ---
> Prepared against v7.4-rc1-1969-g666539eecdf4.
> 
> Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4, CONFIG_RCAR_THERMAL=y.
> No hardware was available, so the removal path was not exercised and no race
> injection was run.

Ohh, could you test this please. It's a rather large change and while it 
looks correct it could behave differently then expected.

> 
> AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
> author reviewed the reasoning and takes responsibility for the content.
> 
> Changes in v2:
>  - Drop the shutdown flag and the separate IRQ count.  Niklas asked for less
>    state, so the removal now disables the delayed work before the source is
>    masked and unregisters the shared IRQ instead of waiting for it once.
>  - Keep the interrupt numbers in an array whose unused slots stay negative.
> ---
>  drivers/thermal/renesas/rcar_thermal.c | 37 ++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index af6d09a75bb6..3310ed4a8bda 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -39,11 +39,15 @@
>  /* THSSR */
>  #define CTEMP	0x3f
>  
> +/* .nirqs of every supported chip is at most this */

.nirqs is not really needed here. Just say something along the line of 
max number of supported interrupts or some such.

> +#define RCAR_THERMAL_MAX_IRQ	2
> +
>  struct rcar_thermal_common {
>  	void __iomem *base;
>  	struct device *dev;
>  	struct list_head head;
>  	spinlock_t lock;
> +	int irqs[RCAR_THERMAL_MAX_IRQ];
>  };
>  
>  struct rcar_thermal_chip {
> @@ -376,10 +380,34 @@ static void rcar_thermal_remove(struct platform_device *pdev)
>  	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
>  	struct rcar_thermal_priv *priv;
> +	int i;

unsigned.

>  
> -	rcar_thermal_for_each_priv(priv, common) {
> +	/*
> +	 * Stop the work from being queued again and wait for a running one to
> +	 * finish before the interrupt source is masked: rcar_thermal_work()
> +	 * re-enables its source when it is done, so it has to be gone before
> +	 * the source is disabled for good.

I think you can make this less verbose and more to the point.

> +	 */
> +	rcar_thermal_for_each_priv(priv, common)
> +		disable_delayed_work_sync(&priv->work);
> +
> +	rcar_thermal_for_each_priv(priv, common)
>  		rcar_thermal_irq_disable(priv);
> -		cancel_delayed_work_sync(&priv->work);
> +
> +	/*
> +	 * The handler is shared, so waiting for it once is not enough: another
> +	 * user of the line can invoke it again after that, when the zones and

line?

> +	 * the sensors it walks are already gone.  Unregister it here; that
> +	 * waits for a handler that is running right now as well.

I don't understand this.

> +	 */
> +	for (i = 0; i < RCAR_THERMAL_MAX_IRQ; i++) {

Please declare the loop variable in the for () statement to reduce 
scope.

> +		if (common->irqs[i] < 0)
> +			continue;
> +		devm_free_irq(dev, common->irqs[i], common);
> +		common->irqs[i] = -ENOENT;
> +	}
> +
> +	rcar_thermal_for_each_priv(priv, common) {
>  		if (priv->chip->use_of_thermal)
>  			thermal_remove_hwmon_sysfs(priv->zone);
>  		else
> @@ -413,6 +441,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	spin_lock_init(&common->lock);
>  	common->dev = dev;
>  
> +	for (i = 0; i < RCAR_THERMAL_MAX_IRQ; i++)

Here you can't declare the loop variable as the function already 
declares it at the function level. This is likely because this function 
pre-dates when it was OK to declare it directly in the loop definition.  

No need to update old tested code en-mass, but lets use the better way 
in new code.

> +		common->irqs[i] = -ENOENT;
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> @@ -449,6 +480,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		if (ret)
>  			goto error_unregister;
>  
> +		common->irqs[i] = irq;
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
