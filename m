Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA9357CEB
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351253; cv=none; b=IugoC5+wghYZcM4mOlCo0e4kMC1AcpxTOiv01BuZTrcpTckWjOIj7yihsgU3QpV1SzHqzHSVqtXCqrOnlZCWGkIVGR78RFhzPAJwJxxlHS8FNwTNfCHGqYB/ZqCEih8eMZHjmegH1i+47ycmMbDTcsmvy+SgNChaUxmbOOWtZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351253; c=relaxed/simple;
	bh=5RAQ/vzRARHcaE/i0yXQNhBm4ZYZtzy48qsvVQTE/JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMrEMxiKnsqfTDlNcial8xB1HmAhmArQtq/aYNWJJ5QW7e2zsHrJ6RiaKo7C/4RLOqoape5xWDskFLtR1djj6G8l9MZ2nnkQIQLkT9fQq7umIw/u9u7sWyhOwsgHIelUsa1FuMZaOiCr/tSNipPldAA2H3LXhLMYVgMZMh+JKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ehfflhrQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ehfflhrQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so28566205e9.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783351250; x=1783956050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jA188Me9AgAO7O1Is8f9n+gtNtSnCCBgUgpsHEqHR9Q=;
        b=ehfflhrQkCJPCF4Ye6McnXgQVlGPP9Bj79W8wfMFil05k248FAzhge187g77s5mMWG
         +Q7HdYGNVm6rg4ueacksvJDrRmxwmKwKYy2CF9qoLLW6amGZAI8m2ygz5s/lLdhjNElQ
         86RwavNzy9CBoueHtdxoNGiuu3yMOl5KyhI8UnYB3oFqi5boktVK2BuOQppZ8E+EU7nN
         PUhS2QoHLYsQEFgUXGi/Trjyj12UQd6CRNQPU/YvfwuqfmtL4776C27CX+bi64y8ZbIe
         Y7DdjbckLwqyTr7kXp5QgqRWmblsyEm2kRyXBRHY7QWBIhEv9MWMiV+HiXX5avM/QuSr
         sKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351250; x=1783956050;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jA188Me9AgAO7O1Is8f9n+gtNtSnCCBgUgpsHEqHR9Q=;
        b=Xe4K/ksAEmVWXaAAX6i3aZdpsuktLyen5DnyEjZBxOtk8c4DUKS49d2tTEiB2XO8XW
         ZyMDPvceLmBU4cKpjBoyO+DiRwbuHimKJ+PorZRJ9egBhNR+6fh6DQjeIqjhXofy+IED
         8oEq+Fz2YwOYFWNM4hqps9/aqn+/qjVCAMxTmisE0ZfD9CNas6gJugOwGtZZ2VH9qD0H
         rQqyPOWa3zPyxhfocKzRhCZICO06+MaD+3PbRNKBponvZROaS761+T54s+21uKI3Z6az
         taEZKg7ny2N2E+Tg9LMp+PlwezRWTK4VwZPuWXJS6yCs0SkB9rDQlzDyQHwvOjNEOksf
         4QKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGY47Od2L39Q4pFvC/+H859YJm2vBHXkidkc8jw8ZIB/W4SolSAmeoaR5vFp3PsvL9YZjE44K6ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24yFC4jExhhm0uPMZgL+/rio3cmbdF6GCXgbyhiU2y2CXjkJm
	ltC1VSsi46IA6kENnTLowBKFHMoraIjK+J2f+QbiE1LPULGu/3j+Nd/ZQBVpzmoZMGg=
X-Gm-Gg: AfdE7cmN7iRfWb5dmtLvTN3zyK8ZMgtJ/jymGbeJnmg1VNHjXVyu+foBtJp9Wgrz31Y
	ZbPgDh2QLGKiBJP/cVcxttZQlDZmFvpzBWXFajGIHGMoGugr0Ap/WSO6eDvDCE1fvihUxK501ix
	dHOKMonN/4ZtPffKIx4vzgWPc3JpjHzaXSGKdFYogmVZGRds85sDLT93+RVwWmp6V77jUW7iJKc
	gDt+HxzXw4yNqhd8AmDAYtT4r0WGKePBmfH1B0fwZAmcleQhC8wADcOToBoxXWkEeD4OyCjW7vv
	JRO0XRLpX90fGQRyJLDI0qRI5gKSBO1A0ka5kX4kQVAh1AuVddsFXLu+OmRmkDW5kUjAKhse2ww
	pIdp5xPhVuDRVuCmA+0BUFo2dCmVHIG9k9G3rrgdzzZaid0uRkNzgxBV7elwqA8r2zriTQTrvq/
	xkcAonF1hiUzk1T8x+tSDnjmnxvI9ASHBLuYzUjhTTHjsqyJzL4Rm4WV1RC579
X-Received: by 2002:a05:600c:19cc:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-493df0930a6mr12030995e9.26.1783351249504;
        Mon, 06 Jul 2026 08:20:49 -0700 (PDT)
Received: from [192.168.1.136] (48.85-85-171.dynamic.clientes.euskaltel.es. [85.85.171.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm27008175f8f.26.2026.07.06.08.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:20:48 -0700 (PDT)
Message-ID: <42e9c942-5b96-4cd4-a25b-51d1a7e8eff7@suse.com>
Date: Mon, 6 Jul 2026 17:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] pmdomain: mediatek: Add support for Direct CTL simple
 power sequence
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 ulfh@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, nfraprado@collabora.com, irving-ch.lin@mediatek.com,
 macpaul.lin@mediatek.com, aford173@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 justin.yeh@mediatek.com, kernel@collabora.com
References: <20260701121920.19347-1-angelogioacchino.delregno@collabora.com>
 <20260701121920.19347-4-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260701121920.19347-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2026 14:19, AngeloGioacchino Del Regno wrote:
> Some new SoCs like MT8196, MT6991, and others, have got one
> additional power controller (usually in the HFRP Multimedia
> block) which needs a simplified power on/off sequence while
> using Direct Control strategy.
> 
> Domains using the "simple power sequence" are not backed by
> the RTFF hardware, have no Bus Protection mechanism, lacks
> the ISO, PWR_ON, PWR_ON_2ND bits, and therefore get enabled
> automatically after getting out of reset.
> 
> This simple power sequence is then a subset of the full one
> as only needs the enablement of the specific power domain's
> clock input and reset (where, again, after getting out of
> reset, the ISO and PWR_ON bits are automatically internally
> getting flipped) to enable or disable (power on or off).
> 
> Moreover, the simple power sequence power domains guarantee
> that they always get enabled/disabled after executing the
> relevant power sequence (on/off) so, differently from the
> others, there is also no need to poll for a PWR_ACK.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 87 ++++++++++++++++++----
>   drivers/pmdomain/mediatek/mtk-pm-domains.h |  1 +
>   2 files changed, 72 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index db543d4b1813..5276adea1d04 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -549,9 +549,11 @@ static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
>   	return 0;
>   }
>   
> -static void scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
> +static int scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
>   {
>   	struct scpsys *scpsys = pd->scpsys;
> +	bool tmp;
> +	int ret;
>   
>   	switch (pd->data->rtff_type) {
>   	case SCPSYS_RTFF_TYPE_GENERIC:
> @@ -583,6 +585,41 @@ static void scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
> +
> +	/* wait until PWR_ACK = 0 */
> +	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
> +				 MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int scpsys_simple_pwrseq_on(struct scpsys_domain *pd)
> +{
> +	struct scpsys *scpsys = pd->scpsys;
> +
> +	/* Enable subsys clock input and trigger power domain reset state */
> +	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
> +	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> +
> +	/* Wait for the hardware to stabilize */
> +	udelay(1);
> +
> +	/* Get out of reset: set power on */
> +	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> +
> +	return 0;
> +}
> +
> +static int scpsys_simple_pwrseq_off(struct scpsys_domain *pd)
> +{
> +	struct scpsys *scpsys = pd->scpsys;
> +
> +	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> +	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
> +
> +	return 0;
>   }
>   
>   static int scpsys_modem_pwrseq_on(struct scpsys_domain *pd)
> @@ -605,14 +642,24 @@ static int scpsys_modem_pwrseq_on(struct scpsys_domain *pd)
>   	return 0;
>   }
>   
> -static void scpsys_modem_pwrseq_off(struct scpsys_domain *pd)
> +static int scpsys_modem_pwrseq_off(struct scpsys_domain *pd)
>   {
>   	struct scpsys *scpsys = pd->scpsys;
> +	bool tmp;
> +	int ret;
>   
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
>   
>   	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SKIP_RESET_B))
>   		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> +
> +	/* wait until PWR_ACK = 0 */
> +	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
> +				 MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>   }
>   
>   static int scpsys_power_on(struct generic_pm_domain *genpd)
> @@ -635,6 +682,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   
>   	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
>   		ret = scpsys_modem_pwrseq_on(pd);
> +	else if (MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ))
> +		ret = scpsys_simple_pwrseq_on(pd);
>   	else
>   		ret = scpsys_ctl_pwrseq_on(pd);
>   
> @@ -662,9 +711,11 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   			goto err_pwr_ack;
>   	}
>   
> -	ret = scpsys_sram_enable(pd);
> -	if (ret < 0)
> -		goto err_disable_subsys_clks;
> +	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ)) {
> +		ret = scpsys_sram_enable(pd);
> +		if (ret < 0)
> +			goto err_disable_subsys_clks;
> +	}
>   
>   	ret = scpsys_bus_protect_disable(pd, 0);
>   	if (ret < 0)
> @@ -682,7 +733,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   err_enable_bus_protect:
>   	scpsys_bus_protect_enable(pd, 0);
>   err_disable_sram:
> -	scpsys_sram_disable(pd);
> +	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ))
> +		scpsys_sram_disable(pd);
>   err_disable_subsys_clks:
>   	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION))
>   		clk_bulk_disable_unprepare(pd->num_subsys_clks,
> @@ -698,16 +750,17 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   {
>   	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
>   	struct scpsys *scpsys = pd->scpsys;
> -	bool tmp;
>   	int ret;
>   
>   	ret = scpsys_bus_protect_enable(pd, 0);
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = scpsys_sram_disable(pd);
> -	if (ret < 0)
> -		return ret;
> +	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ)) {
> +		ret = scpsys_sram_disable(pd);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
>   		regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs,
> @@ -721,15 +774,11 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   
>   	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
>   		scpsys_modem_pwrseq_off(pd);
> +	else if (MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ))
> +		ret = scpsys_simple_pwrseq_off(pd);
>   	else
>   		scpsys_ctl_pwrseq_off(pd);
>   
> -	/* wait until PWR_ACK = 0 */
> -	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
> -				 MTK_POLL_TIMEOUT);
> -	if (ret < 0)
> -		return ret;
> -
>   	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>   
>   	scpsys_regulator_disable(pd->supply);
> @@ -1083,6 +1132,12 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>   		regmap[2] = NULL;
>   	}
>   
> +	/* If no access controllers are needed, don't allocate and don't fail */
> +	if (num_regmaps == 0) {
> +		scpsys->bus_prot = NULL;
> +		return 0;
> +	}
> +
>   	scpsys->bus_prot = devm_kmalloc_array(dev, num_regmaps,
>   					      sizeof(*scpsys->bus_prot), GFP_KERNEL);
>   	if (!scpsys->bus_prot)
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> index a5dca24cbc2f..092403de66fa 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> @@ -17,6 +17,7 @@
>   #define MTK_SCPD_MODEM_PWRSEQ		BIT(10)
>   #define MTK_SCPD_SKIP_RESET_B		BIT(11)
>   #define MTK_SCPD_INFRA_PWR_CTL		BIT(12)
> +#define MTK_SCPD_SIMPLE_PWRSEQ		BIT(13)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data ?		\
>   					 (_scpd)->data->caps & (_x) :	\
>   					 (_scpd)->hwv_data->caps & (_x))

