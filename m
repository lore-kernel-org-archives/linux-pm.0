Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086689;
	b=VHB3/IDloHccOlXTlxXlNYD0MVHFsfi3nqgXlzyaDsct5pHLHk4yBQ0pJKP5JEXbdJh8
	 mqaWYCAHhwuAziPB6kLxQre51twtShr9CM7a9/ljsP4Rj/bujvpFrr8y8zXG45YXSTTcR
	 x4KieWN+vaKR0dF3yhc5Ipt58vVIApPdgmB45bPVirtmKvQpexiBplJob5f0yyMDIi45Y
	 5Xja81kbsQXzcRhJcFHuMH2nWxNB83mXdfNo7h9I9WRULY74/+Ci50T7fE4oq/ZaDbDXf
	 CyzfKznA5k+oDow7rz9xeA2VnoYSVN1DaxKqsGsXOYvLpCWwflWlVY/IpuffKBPIYnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086689;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=YmbEHFug4FIwW3HPr1ci4rIIr7KsGTyH+5Y2MmZBdp4=;
	b=uvQjzvmUfulB3zW314TNbyg2Qpr6NAyUa6a1q5reLOERno0LhmAAINCar6FRO3TOgC5W
	 R7SVauMfugCCNRE2Q3WzPIxtCn/lEv3H1ZK15fH7IaV9dp/yMoOoavlx4sZanFIXjfAix
	 bWtXTwXqXyFKnio7jWCVfiwxeja/JGE9rli9HIkF0wJ85WigrB+4Pg4Dq2wppajnZx+dh
	 uUTiScqEuVAvwvzezsXV599qgA/TIts+J8LsoaZs/VSahm7JW4s2aVxwgZFChm1KAj9vY
	 HJtXWtlGcHUo+pIz++DMUqPuwuww2bW5R6hL9GG35HkEEJXMzqlrBeWQDxGBX5RWWBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RQ6fXOKF;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA6606A325
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABBA6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RQ6fXOKF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0E0B5C4CBF1;
	Thu, 19 Nov 2026 11:11:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBD1560237;
	Thu, 19 Nov 2026 11:11:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B0F911BC1049;
	Thu, 19 Nov 2026 12:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795086686; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YmbEHFug4FIwW3HPr1ci4rIIr7KsGTyH+5Y2MmZBdp4=;
	b=RQ6fXOKFEuWz4Hww+VtCt3D3s/VCU4OjzpyHSDGbl+hAlasQwhe8k0W8rk5G/x1lfw3f24
	FAsdHBJtMWXPtv2Os6WLmI2M7wgP8pmbftC4OA+cT30gjg3kUICucXgBGrbQRVjhovnCUP
	eXlUqnNmg0dy1m0OShCUNpj2PxGPqNGXfkqwJc9C2eo5hYGVJEBy3uHVDzZgdOd4DVniIw
	Et3L74O30DmevpNNUDp5k1qfzwLNbtIMfDf8/vFm457xfqRdUW0YSwV4TW1AYPAZmDgaj0
	BNlvEZpUEL2i4gNrlBUe9omwjigS0IztX9ALSejCMESqPq+iFJbTAB7yJIlrDA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: rafael@kernel.org,  daniel.lezcano@kernel.org,  rui.zhang@intel.com,
  lukasz.luba@arm.com,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  edubezval@gmail.com
Subject: Re: [PATCH v2] thermal/drivers/armada: request the overheat IRQ
 before enabling the source
In-Reply-To: <20261119022911.1493538-1-shunsheng1218@gmail.com> (Yaohan Li's
	message of "Thu, 19 Nov 2026 10:29:11 +0800")
References: <20261118072339.1259719-1-shunsheng1218@gmail.com>
	<20261119022911.1493538-1-shunsheng1218@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 12:11:23 +0100
Message-ID: <87o6bldqjo.fsf@bootlin.com>
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
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 19/11/2026 at 10:29:11 +08, Yaohan Li <shunsheng1218@gmail.com> wrote:

> armada_thermal_probe() requests the overheat interrupt before it registers
> the thermal zones.  Devres releases resources in the reverse order, so the
> zones are unregistered first and the interrupt is freed afterwards: a
> handler that is still running, or that fires in the window between the
> two, passes a zone that has already been destroyed to
> thermal_zone_device_update().
>
> Request the interrupt after the zone loop instead.  The handler is then
> freed before the zones it updates, and the interrupt is only requested
> when a critical trip point was found, which is the only case in which the
> driver has an overheat source to enable.
>
> The interrupt stays optional: a device without one, or with an invalid
> IRQ number, keeps working without overheat detection instead of failing
> to probe.
>
> The source has to be enabled after the handler is registered, so
> armada_configure_overheat_int() only programs the thresholds now and
> armada_thermal_probe() enables the source once the request has succeeded.
> A failed request then cannot leave an interrupt enabled that nobody
> handles.  The source is masked at probe time as well, in case the firmware
> left it on.
>
> The handler polls its sensor once per second until the temperature is back
> below the hysteresis, and devres waits for it in free_irq().  ->remove()
> masks the source and sets a shutdown flag so that the poll gives up
> instead of keeping the removal blocked until the sensor cools down.
>
> Fixes: 879d7362d1d0 ("thermal: armada: add overheat interrupt support")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
>
> ---
> Prepared against v7.4-rc1-1969-g666539eecdf4.
>
> Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
> CONFIG_ARMADA_THERMAL=3Dy and CONFIG_ARCH_MVEBU=3Dy.  No hardware was ava=
ilable,
> so the removal path was not exercised and no race injection was run.
>
> AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
> author reviewed the reasoning and takes responsibility for the content.
>
> Changes in v2:
>  - Request the interrupt after the thermal zones are registered instead of
>    freeing it from ->remove(); Miquel asked for the smaller shape, so the
>    helper and the stored IRQ number are gone.
>  - Enable the source only after the handler is registered, so a failed
>    request cannot leave an interrupt enabled that nobody handles.
>  - Mask the source at probe time, but only on the variants that describe =
the
>    overheat interrupt as a DFX cause.
> ---
>  drivers/thermal/armada_thermal.c | 69 ++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_th=
ermal.c
> index 83672f95b011..23f820415e56 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -68,6 +68,7 @@ struct armada_thermal_priv {
>  	struct thermal_zone_device *overheat_sensor;
>  	int interrupt_source;
>  	int current_channel;
> +	bool shutdown;
>  	long current_threshold;
>  	long current_hysteresis;
>  };
> @@ -297,12 +298,19 @@ static void armada_enable_overheat_interrupt(struct=
 armada_thermal_priv *priv)
>  	regmap_write(priv->syscon, data->syscon_control1_off, reg);
>  }
>=20=20
> -static void __maybe_unused
> -armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
> +static void armada_disable_overheat_interrupt(struct armada_thermal_priv=
 *priv)
>  {
>  	struct armada_thermal_data *data =3D priv->data;
>  	u32 reg;
>=20=20
> +	/*
> +	 * Only the variants that describe the overheat interrupt as a DFX
> +	 * cause have this source; leave the control register alone on the
> +	 * others.
> +	 */
> +	if (!data->dfx_overheat_irq)
> +		return;
> +

That's over defensive. This case is unreachable.

>  	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
>  	FIELD_MODIFY(CONTROL1_TSEN_INT_EN, &reg, 0);
>  	regmap_write(priv->syscon, data->syscon_control1_off, reg);
> @@ -538,7 +546,7 @@ static irqreturn_t armada_overheat_isr_thread(int irq=
, void *blob)
>  		mutex_unlock(&priv->update_lock);
>  		if (ret)
>  			goto enable_irq;
> -	} while (temperature >=3D low_threshold);
> +	} while (temperature >=3D low_threshold && !READ_ONCE(priv->shutdown));
>=20=20
>  	regmap_read(priv->syscon, priv->data->dfx_irq_cause_off, &dummy);
>=20=20
> @@ -802,7 +810,6 @@ static int armada_configure_overheat_int(struct armad=
a_thermal_priv *priv,
>  	armada_set_overheat_thresholds(priv, temperature, 0);
>  	priv->overheat_sensor =3D tz;
>  	priv->interrupt_source =3D sensor_id;
> -	armada_enable_overheat_interrupt(priv);
>=20=20
>  	return 0;
>  }
> @@ -891,20 +898,16 @@ static int armada_thermal_probe(struct platform_dev=
ice *pdev)
>  	drvdata->data.priv =3D priv;
>  	platform_set_drvdata(pdev, drvdata);
>=20=20
> +	/*
> +	 * The firmware may have left the overheat source enabled.  Keep it
> +	 * masked until a handler is in place.
> +	 */
> +	armada_disable_overheat_interrupt(priv);
> +
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq =3D=3D -EPROBE_DEFER)
>  		return irq;
>=20=20
> -	/* The overheat interrupt feature is not mandatory */
> -	if (irq > 0) {
> -		ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> -						armada_overheat_isr,
> -						armada_overheat_isr_thread,
> -						0, NULL, priv);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/*
>  	 * There is one channel for the IC and one per CPU (if any), each
>  	 * channel has one sensor.
> @@ -937,9 +940,29 @@ static int armada_thermal_probe(struct platform_devi=
ce *pdev)
>  			armada_configure_overheat_int(priv, tz, sensor->id);
>  	}
>=20=20
> -	/* Just complain if no overheat interrupt was set up */
> -	if (!priv->overheat_sensor)
> +	/*
> +	 * The overheat interrupt is optional: a device without one keeps
> +	 * working, and an invalid IRQ number must not be requested.

Here you change a bit the behaviour of the driver. ENXIO is a valid
error indeed, but any other negative value may fail the probe. I don't
mind to keep it that way (not failing in case of wrong IRQ), but a line
in the commit log about it is necessary.

> +	 */
> +	if (irq <=3D 0 || !priv->overheat_sensor) {
>  		dev_warn(&pdev->dev, "Overheat interrupt not available\n");
> +		return 0;
> +	}

I personally don't like early returns when everything is fine. I would
prefer that you just keep the whole irq handling inside an if clause.

> +
> +	/*
> +	 * Request the interrupt only now that the thermal zones are
> +	 * registered: devres releases what was registered last first, so the
> +	 * handler is freed before the zones it updates.  The source stays
> +	 * masked until the handler is in place, so the device cannot raise an
> +	 * interrupt that nobody handles.
> +	 */

This comment is not needed, please drop.

> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, armada_overheat_isr,
> +					armada_overheat_isr_thread, 0, NULL,
> +					priv);
> +	if (ret)
> +		return ret;
> +
> +	armada_enable_overheat_interrupt(priv);
>=20=20
>  	return 0;
>  }
> @@ -948,8 +971,20 @@ static void armada_thermal_exit(struct platform_devi=
ce *pdev)
>  {
>  	struct armada_drvdata *drvdata =3D platform_get_drvdata(pdev);
>=20=20
> -	if (drvdata->type =3D=3D LEGACY)
> +	if (drvdata->type =3D=3D LEGACY) {
>  		thermal_zone_device_unregister(drvdata->data.tz);
> +		return;
> +	}
> +
> +	/*
> +	 * devres frees the interrupt before the thermal zones, so the thread
> +	 * is waited for in free_irq().  Mask the source so that no new
> +	 * interrupt is raised for a handler that is about to go away, and let
> +	 * the poll loop give up instead of keeping ->remove() blocked until
> +	 * the sensor cools down.
> +	 */

This paragraph is also not needed in my opinion.

> +	WRITE_ONCE(drvdata->data.priv->shutdown, true);
> +	armada_disable_overheat_interrupt(drvdata->data.priv);
>  }
>=20=20
>  static struct platform_driver armada_thermal_driver =3D {

Thanks,
Miqu=C3=A8l
