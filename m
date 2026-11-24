Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526725;
	b=K03g7xGTpnKuTw7SexRXA9/OxEElni4JQa0cSP7BAcKY/OF5YCsvoOV+JdZowV5Lif8r
	 cShlNoL12a7LL64wmARCsCQrdmZpdJUo3fXD3ExEvf+IqyNzTJLLMDciLoQR6vikUH0md
	 LNRAEDW9Fgi3RHb15YHQuVdNKsbD8ggLzbxEZqYVZmjKhlHKH1Ky49rp7Z+792wQRfUTY
	 mv9p7n0f24n4Twy3adHN9frsGEA0M9kGKHs3OiWs96xCV4IFkAmyAM1yw2PEHxAk6u+WY
	 5lOoEApkgZVVqPKD/hkEGR6Nt6JhdhQlwoW4fNa+c90UhgUQfMtIQthHtuVhnt6ueMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526725;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=jdq4s1rM/+IIWlMrD0ixYWk6dj9CdCeQpp/eseYFAYg=;
	b=mEASpir+tckzPl5D271wfaS57vY8LDiEi8GBT+P+qctHkxP2xj/zIRmx6EF/0veXW87N
	 HWB4coAA5xrSrZEdBoByDsoI5eDnL/19Ql6pbiDmARjYT+QXr2toieJIpqlD8THrVcZ7p
	 aJpAPeRPGmJh9KTHMQhvOZm1pgOSC1Ea8psW+vmhKxSET/hTsEMR9wEmWRJFVBuryYEs2
	 bDjafI023O3vIAOimb0aaRWj5nkgCZ+nfiCd5FA/he4nzOYVa1MHayknJ8uqImNaG8J/B
	 XVcR2/M5W6OlwAm9ldNPn3iTSqqMVZUoZ+8MNefwQry1L0kjGezDY6X3x13Jg1ie+PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b="S57i3/C2";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pyNczjJS;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF3606A322
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 13:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9FF3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=S57i3/C2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pyNczjJS
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BB842EC0ADB
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 08:25:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 24 Nov 2026 08:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795526723;
	 x=1795613123; bh=jdq4s1rM/+IIWlMrD0ixYWk6dj9CdCeQpp/eseYFAYg=; b=
	S57i3/C2hli5Y4g6kC5QTHF2UkmPKOrT+f+AfdQg/oRB+C2cTxSNAaBLUsqlbTMA
	pS6rP/G9qneWeNGuyhoj/Mg7tFDa68kvewHWLP/GQ1LnoG+KfR1TV4SaaWrIab6z
	18z7587oTQ6ZYL+W5ncADvZErgp3+XeHo//5Pnr9xr8/725xxpjcNEPJoaffLoXK
	VpXyI7Ajb84WPM5R/2vEDhMaMgNw7tlDuxBPw3yT0uoMYEB80+CbsrRNBlMKQDlI
	oznkrqfbL2YA+5R8YHEirq4oEC++TtIQcerovyiTVhpaR+u+uOGQJ2yIA3Ph7bcd
	YlagbCe1cgXAb8N4CGXRNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795526723; x=
	1795613123; bh=jdq4s1rM/+IIWlMrD0ixYWk6dj9CdCeQpp/eseYFAYg=; b=p
	yNczjJS8BaFOQ3JT8+5LhsFkwcLHW6Xgt0ROJ8bUgJyZD0ruTOgaMKd6X2jdjWhD
	7sANQuowWaL+0Lt1lIt6gb+LY+UViX574qO3Y6TzuuDzStb3dt0lXh54w/T14pVT
	VBm4tpiJGy6eAnK2ei9/ttI2uvmIO+IduQHwSXOFLOAcGkrjptpvBnkOYUjZokfo
	/tJ67p5X/mmPX09Yxgt681Z/e/whpIXycrmZFgOhYf6hCWzlwDcq8r3A/E+itP+6
	b7JCOILLHqEXpyI3xEXA1prmqlQvew+kHrTqq1BSlWGZyDUAvhvOWwXKP8a6Ie6s
	mto3PgDW3igmIuvNW4O+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795526723; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:V0fCQ/kUZkY1UmypL2QEE9/cHqGeQUhjMu8+YkY9FV0pa0N
	PwzUymNSNHmw6sEAs4CnLL4O/9a1KnwFDOt3MInPbsuYbUGuLM1WDM5VabABzwW2
	r0lD2uIQyfwmbtXDOfvTzR5bMsv171N2/iE+/j2EPtHNmD3bIOyAXMp9Pkge/f9I
	tWcSgEEoxCJUHz0aYr3BKe3H61zBn0XxBW4S0ogZJvQ4PB6wKnX9iUVYW/n3sMGE
	OH8N73cQBI49rHZbK/Sf+EeLOKa867d4Fh+N49GMVz5wtkLVgU/qTg6Ph6WwRfLg
	R1+BLaaUvgvvKXdT+/vs54WnPHDyzm/5bOzwkzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jNqAHpbPGF0RZ20YBwX2yaE3LGvWARrKs4sVphlURsg=:M+1RSArcSqZQME3jhwvP4dHhKFgkOIHh2mNiLMU/xOE=;
X-ME-Sender: <xms:Q5AFa5wK6vmw-kZkTASCBAK6BeAVE34A7_x2kQYwZxqlKWXsyzhBbA>
    <xme:Q5AFa_QjAZeQ_my4MEyNZaP7zopaKoSXKUgNIc0xdibgOceLc6Zd81ezBBpSdJfaV
    VPsLjwnpgy4hdfSy2fQwj9HcuA7iJJOTS_4H_mXtpzanTmOejw4uQ01>
X-ME-Received: <xmr:Q5AFa-LveaI2DwHdffgw5zO1Fbj8DF4t8p8Yk663eW39Ektnp2dzoT1Op0nRal8xFZjFRtLskBPL8ouHcTeQjONd45EXZZg>
X-ME-Proxy-Cause: dmFkZTFySws+Sggi7EtN2kUyu9Nbs/Yyb1QeohUfHeH3cD3BRt4ruZaDl5/caqpX7JRW7U
    M5pLLxqkHcGx3KPNeFriFAcbfFccXKJdjVW6M/1bl9TaM2FuRguFDjM2zn2Wotxce5VVjk
    h/6Qzl+zs7DZAOivB+qoWX+Ud9xfEGfHqcOhnE6cS9htncwutIlb7gL5BwLKFqM/vpfiTI
    g28xMvMtTYKNsoZ1SzGWyOc5zUxG4Rk5S3y+ztaP2XMEnHVE6Q4lq+H1orCPcOabpuss0G
    VbBSfuIqMTid93ILgAfW/h61ZurU9InnjkHcYlqCAbGqfGCOXh1n7KxQvuF2EynOji8cLc
    /vcuL+B4yKLkqqW7o44ILL7XP/wccvywMsYqdOD+bIRTLy1A9IyJExuzUlvQYqBJklaPX1
    wfwPaFLBV8hCEiRtbT0pGy4AFCU91wDmO/XiXvCBtQg2dWIbR3i5dqDhccWIEkOY5U0Npm
    fJ/D0mxUnJKKhZ6xroE22LhF3wzwK12fF6VviDr/z4HTmAFeXstX+zwUc3YMPPs6j5o9At
    qYzdXBZfBj72Yn07b1hklOb+6UojMirZiG6PorjHVa6p8u4GIKABcBDtCaJygExVjB6dOK
    idjf1i/mqIjE4jztnnIWHffB/8wXAb3ucSgM+y7967fuPh340fC40yTWfYQg
X-ME-Proxy: <xmx:Q5AFa-U_Op78pb6Yv0MnYnzclr2JoMzmueud5FMPKUPkXP2E1vF46A>
    <xmx:Q5AFa6S0y7oOX5XWLrHxKPqAGGPgYx_ORF9EcOuZeqKNfyqrJS5egg>
    <xmx:Q5AFa-DHr65AYFeJ0IqosPiTHFes6vB7iL42Gaa_ED--0Cqqj-vh-A>
    <xmx:Q5AFaxKeOchTCQnFP7u4FhWkmxBJKHjtVFYHqN9RuJt0WQ_EK_bhLQ>
    <xmx:Q5AFa-h8RFp10GxAy7SBejdCssvN9U6tU6-qQmmNvJiBelG5ylMrNwWE>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 08:25:22 -0500 (EST)
Date: Tue, 24 Nov 2026 14:25:21 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thermal/drivers/rcar_thermal: disable the work before
 masking the interrupt
Message-ID: <20261124132521.GJ3898744@ragnatech.se>
References: <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261124022219.1834499-1-shunsheng1218@gmail.com>
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
In-Reply-To: <20261124022219.1834499-1-shunsheng1218@gmail.com>

Hi Yaohan,

Thanks for your work.

On 2026-11-24 10:22:19 +0800, Yaohan Li wrote:
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
> For the handler itself, synchronize_irq() is not enough on a shared line:
> it waits for the invocation that is running, but the line stays registered
> and another user of it can take the interrupt again afterwards, which calls
> our handler once more - with the sensors and the zone already unregistered.
> devm_free_irq() removes the handler from the shared descriptor first and
> waits for the invocation that is in progress second, so after it returns
> neither a running nor a new invocation can touch the driver state.
> 
> Every sensor that the removal walks has been through INIT_DELAYED_WORK()
> before it is linked into common->head, so no uninitialised work is touched.
> 
> Fixes: 697ee786f15d ("thermal: rcar_thermal: Prevent doing work after unbind")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> 
> ---
> Prepared against v7.4-rc1-1969-g666539eecdf4.
> 
> Compile tested: arm64, aarch64-linux-gnu-gcc 11.4, CONFIG_RCAR_THERMAL=y.
> 
> The ordering was exercised by a controlled test on a KASAN kernel built from
> this tree (x86_64, QEMU/KVM; 17 checks, all passing).  The test uses the real
> delayed work, workqueue, wait and signal machinery and a simulated interrupt
> line shared by two handlers (irq_sim):
> 
>  - a work queued after cancel_delayed_work_sync() has returned is accepted
>    and runs; the same queue attempt after disable_delayed_work_sync() is
>    rejected and the work never runs;
>  - a work that is running when the mask is written re-enables its source
>    afterwards, so the mask is undone; disabling the work first and masking
>    afterwards leaves the mask in place;
>  - after synchronize_irq() returns, another user of the shared line raises
>    it again, our handler is invoked and queues the work, which then runs;
>    after devm_free_irq() the handler is not invoked again, while the other
>    user still receives the line.
> 
> The test re-implements this removal ordering rather than compiling the
> driver, which would need a real platform device, MMIO and a thermal zone, so
> rcar_thermal's own removal path was not executed.  No rcar hardware was
> available and no race injection beyond those constructed interleavings was
> run.
> 
> AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
> author reviewed the reasoning and takes responsibility for the content.
> 
> Changes in v3:
>  - Reword the RCAR_THERMAL_MAX_IRQ comment without referring to .nirqs.
>  - Declare the loop index in the for statement and make it unsigned.
>  - Reduce both comments in rcar_thermal_remove() to one line each.
>  - Explain in the commit message why a shared line needs devm_free_irq()
>    and not synchronize_irq(), and point at the test that exercises it.
> 
> Changes in v2:
>  - Drop the shutdown flag and the separate IRQ count.  Niklas asked for less
>    state, so the removal now disables the delayed work before the source is
>    masked and unregisters the shared IRQ instead of waiting for it once.
>  - Keep the interrupt numbers in an array whose unused slots stay negative.
> ---
>  drivers/thermal/renesas/rcar_thermal.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index af6d09a75bb6..374c953471e0 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -39,11 +39,15 @@
>  /* THSSR */
>  #define CTEMP	0x3f
>  
> +/* Maximum number of interrupts supported by any of the chips */
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
> @@ -377,9 +381,22 @@ static void rcar_thermal_remove(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct rcar_thermal_priv *priv;
>  
> -	rcar_thermal_for_each_priv(priv, common) {
> +	/* Drain the work before masking the source it can re-enable. */
> +	rcar_thermal_for_each_priv(priv, common)
> +		disable_delayed_work_sync(&priv->work);
> +
> +	rcar_thermal_for_each_priv(priv, common)
>  		rcar_thermal_irq_disable(priv);
> -		cancel_delayed_work_sync(&priv->work);
> +
> +	/* Unregister shared IRQ handlers before releasing the zones. */
> +	for (unsigned int i = 0; i < RCAR_THERMAL_MAX_IRQ; i++) {
> +		if (common->irqs[i] < 0)
> +			continue;
> +		devm_free_irq(dev, common->irqs[i], common);
> +		common->irqs[i] = -ENOENT;
> +	}

I don't understand why this last loop with devm_free_irq() is needed.

First we disable drain and prevent any new work being scheduled on the 
interrupt top-half with disable_delayed_work_sync(). Then we disable the 
the interrupts with rcar_thermal_irq_disable(). So why do we need to 
explicitly call devm_free_irq()?

If it is to sync that we have no pending interrupts for the bottom half?  
If so would it not be cleaner to add a call to sync the interrupts in 
the loop calling rcar_thermal_irq_disable() ?

> +
> +	rcar_thermal_for_each_priv(priv, common) {
>  		if (priv->chip->use_of_thermal)
>  			thermal_remove_hwmon_sysfs(priv->zone);
>  		else
> @@ -413,6 +430,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	spin_lock_init(&common->lock);
>  	common->dev = dev;
>  
> +	for (i = 0; i < RCAR_THERMAL_MAX_IRQ; i++)
> +		common->irqs[i] = -ENOENT;
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> @@ -449,6 +469,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
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
