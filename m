Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3298409632
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475347; cv=none; b=BMgD5OPK+bHLt8pmxVUg+HjqmGZGquGv8zQZHqCMF9pHy/AewPFtKWk5WDONsyL9l6BV9453FdCi3RwGo8qc2uNq64NpMfmfkKgZMUM7zNYeBT5UcMJyzAXtexMXTKroXvem5RPXmSuldM8uNUUQG84hymHA6CJMzk6QFDhXOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475347; c=relaxed/simple;
	bh=bloimK55FpfGsQLgS/eRSYfIoH0XLCbUnwSE5SJK4mA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GessjhAzB3zpHyEx1OUAmBliH8HbrgaATC7wfAwYmKTyaPrtWb1S34UeSg4WqgoytcwQlWk1Tu6rTEUBBdTsm3RtIybS7pag7Lmc2XRuETBhTMQCVYEwRnVKclu7McdeqldAGUvvJVyNCsbZx7DRjUo5NwjT24s3NKGZ0UtKliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWNcTRTN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWNcTRTN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4940664f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780475344; x=1781080144; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UFR5yeANXS1ym7dwBfhF3G3wNluixUtSkJDeWkxZK0=;
        b=EWNcTRTNT7pDA05mXrH769q8zlWlrxXDTZsceI7a+eI2mwvm/CFjPvFhngCqQpnf29
         srTGnAkEzRHnZOFVbZ9wDjyA7NnuXxjwwwzJwh5gpuDRaIkoiCdV5KYCK6LDcL79g08Y
         SVCOhIlhpcKFLOo+UZXyLH6MUeCm2tgyZiSYeiipUZ4lSA/pSGTwGXh01+fS3+O77lI6
         tJ6tKef1JgE2i3o+3EH7AmaQjcwlZ75A0qToc7AlQHCAIaN8jQjoRM03pZ1nbGHiBvlD
         h1YRCm5+oawq2kj0/711nznw/tEUAc+0K1I0msDkv8f/ELYR8JirQYzP6dFdVWiIqIMv
         +E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780475344; x=1781080144;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UFR5yeANXS1ym7dwBfhF3G3wNluixUtSkJDeWkxZK0=;
        b=WNDQdCEtS0cT0JESzAYfK2PKXmywZXmxzhfy1ZuigFVQepDX8iWu7CWtqK5xeDAtMD
         SGcEe76flA25hKswnRYQBk3rVLaBQHXjYm9SnBqn9fkYjP21Di6a7pLO9W99czLx6VrB
         Mu+ICyQXcaFG4pPK53W+VBs2oBa5ncnp3Z2DQAdnLaUcSufY5DQ9+J2ctbdbGwchGMhE
         xjvA4Wo7jM9OErhhjdsjpq83nCmEyQk4fZc9IKnCOUm6KRiMFZEyKswtyiVNIUjlBQAk
         yIgPwEPYB7q/cgQgca11eXuu4hZlj+E7F4xTEjpoOPcPUWeh4lZ2UKDmpWBFa4on6Sze
         qynA==
X-Forwarded-Encrypted: i=1; AFNElJ8uPtcva36+EbaSVA7JqxODGS7715+JPZGDkyp3GvgaoLpnkT4Ddl0arbsM0GisGUa4kZt5uUdDrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86UTjpEa0rcDXoPtH2a+tb/WnZ4YnEBIJ/uqNe/QVvl7IYiCR
	agWJB9aT1RM7cF8JVuUw/BuuPy/nQVrA2P5zWI4VsUVLc6GpPGHNmnp+3/OIp0gvskQ=
X-Gm-Gg: Acq92OHOX/v40yzfas385bXqP4Aot1u95RrxcE/XuQQlwPO+slaNX7X7pqxScSIWbUN
	MGl1IwabluzYB0yIyLgjbk4y0mf2ei0Fm4gRkExVzYOsChYzEKdqoWQr0y5iYnyHUjEl+wqun9d
	U3ACDNCWvM3cRLYhFSr0tBxlpngy5AONsvbroHMRos9nr97Ejx4ENB1833T+m+sYUuBdS41DQ4E
	AI+daJuWyertBPK/qEVDWlveR5G64D9mni+zRSuYv/dW9wSQAl4DktmLWuzz30Qnc+0W6+zxl0/
	ZNsGF3uOabug8X4LOoQGijYwIEuFoYmBDiLt+u44KYPy9MpVOxgczY1QZdSyRQE6d0fYdIXRtRT
	/Cbf1BHnxsa1T+mdSh/40r3o5cLA9CytwIVhDp5yvfjsd90bslQ2lhFibJeLZYAtN77KAwwods4
	URp3s3qevYlkqBSt7A/1WUAjlCqT6/rdcA72pWax/b53aimagoy/gkJWZJ9rdlQ4UjWcNFcMPdZ
	vLecZyoK7lkPjsmqtPnxQYW+zpw7TtHoUm+cHc=
X-Received: by 2002:a5d:5389:0:b0:45e:f2bd:2b16 with SMTP id ffacd0b85a97d-4602182dbb8mr2455986f8f.18.1780475344302;
        Wed, 03 Jun 2026 01:29:04 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:9b1c:c9e0:4645:9af0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm6191614f8f.36.2026.06.03.01.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 01:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 09:29:02 +0100
Message-Id: <DIZ9U0RE11CQ.3QJET21NQ2QJL@linaro.org>
Cc: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>,
 "Lukasz Luba" <lukasz.luba@arm.com>, "Peter Griffin"
 <peter.griffin@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>, "open
 list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/exynos: fix clock ordering race and
 shared IRQ handling
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Rosen Penev" <rosenp@gmail.com>, <linux-pm@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260603013018.239703-1-rosenp@gmail.com>
In-Reply-To: <20260603013018.239703-1-rosenp@gmail.com>

On Wed Jun 3, 2026 at 2:30 AM BST, Rosen Penev wrote:
> Fix two pre-existing issues in exynos_tmu_probe/remove:
>
> 1. Clock ordering race: The driver manually unprepares clocks in
>    exynos_tmu_remove() and the probe error path, but the IRQ handler and
>    thermal zone are devm-managed and remain active until after the manual
>    cleanup.  If the shared IRQ fires or the thermal zone is polled in tha=
t
>    window, clk_enable() is called on an unprepared clock, which is illega=
l.
>    Replace devm_clk_get() + manual clk_prepare() with devm_clk_get_prepar=
ed(),
>    and devm_clk_get() + manual clk_prepare_enable() with
>    devm_clk_get_enabled(), so clock unprepare is tied to the devm lifetim=
e
>    and happens after the IRQ and thermal zone are released.  Remove the
>    now-redundant manual cleanup from the error path and remove function.
>
> 2. Shared IRQ handling: The driver requests a shared IRQ (IRQF_SHARED) wi=
th
>    NULL as the hardirq handler, causing the kernel to wake the threaded
>    handler for every interrupt on the shared line.  The threaded handler
>    unconditionally returned IRQ_HANDLED without verifying that the TMU
>    actually generated the interrupt, which could cause other shared-IRQ
>    devices to be starved.  Change tmu_clear_irqs to return the interrupt
>    status register value, and return IRQ_NONE from the handler if no TMU
>    interrupt was pending.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 81 +++++++++-------------------
>  1 file changed, 24 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 47a99b3c5395..5dc22006d7f8 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -196,7 +196,7 @@ struct exynos_tmu_data {
>  	void (*tmu_control)(struct platform_device *pdev, bool on);
>  	int (*tmu_read)(struct exynos_tmu_data *data);
>  	void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
> -	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
> +	u32 (*tmu_clear_irqs)(struct exynos_tmu_data *data);
>  };
> =20
>  /*
> @@ -760,24 +760,28 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq,=
 void *id)
>  {
>  	struct exynos_tmu_data *data =3D id;
> =20
> -	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
> -
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);
> =20
> +	if (!data->tmu_clear_irqs(data)) {
> +		clk_disable(data->clk);
> +		mutex_unlock(&data->lock);
> +		return IRQ_NONE;
> +	}
> +
>  	/* TODO: take action based on particular interrupt */
> -	data->tmu_clear_irqs(data);

After that change the TODO comment now feels misplaced.
From a quick glance, it seems it should be moved as well to just
before if (!data->tmu_clear_irqs(data))

> =20
> +	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
> +
>  	return IRQ_HANDLED;

Best regards,
Alexey

