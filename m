Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D11443C27
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454240; cv=none; b=cKNyGhxB3WpWJCxIkKJZYNvy3nh9T1SGxMY1CPTrRtfnLCiTJfVxtiYqCs5eTq18kS4KdRuZEAjEM51otEiDyAOAHRlSA5iF9g7Z87N4iCrwoFsNGE6Ss9onYkm1qOTxD8ah3jzpaEtJ6t/2R84w0jU6Fp64KJiTe+hnHnxVuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454240; c=relaxed/simple;
	bh=4tbUgFiAvEgxtY8UciHDHSbxyHXMGWw4dIFFQgGN1hI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu+ftn6hqybiJjsRjQU6IR2ICJMHwXAIFDkQZuOGoe6Lp5zMDDhN9sykyEB9hwsVqpUW4pt4r+/UjUNvLkyGVgZAfTy2r8WJ9yzLqHRyvt9JHGzlpCrrKFg3iPZxNVXe93etcFgBpOpZ1VMD4RWayot1v8ahdlxQo/GChipc8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwm3R+L5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwm3R+L5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C931F0089E
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 10:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791454238;
	bh=6Cr87NWtSTumqAI3+lv6BChO3Lye59PnJ7E6aWPgSGU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=hwm3R+L5zS/h87y3KfkxOmQN1SrcOktm1Ml6oJd1pBluYUvH495HVW8N2lZwCPFXm
	 EtW+yEiJnhU2eBkltA7Y4jf11zQ2CzOelGOgJTjejVqKcVJVHYXlp6PF1zFCqYam2s
	 /YexWY1f6TbIA6QocjrcoUni135+VqorizQ+OMBAf1ji+qw/kxLALEarEw3C/8EVHY
	 Css4DE+F/nGfl9uHzFZk3u9C7qKsiHmrR6XZ8fdZ+1c8rwEvnZlNjxYs4F9SJ5pUJE
	 oJKzaypmeKAHEPo3Sx7iOzY6C6zWX96jHCAX/hmEkZ8zIdsL1eTx5RXJd2hBhQBOny
	 hb9wAJHXVcdkw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a20367cf82so46180231fa.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 03:10:38 -0700 (PDT)
X-Gm-Message-State: AFq9FYIF5n1kxRFCiB7/XuxfwlLKcVy11yl/2uvjOKmR+IMHInFgSXcI
	EAqnEO1+6lUbOdyq6leenPLmA21zz/2BqFyXlcITdUwadFCODR+fmKd9NsT536GCEoVEdHLic2T
	DrxEj7bPr3LlWdhriOg6LvU1pHpE66a2EoMXWRiZgjQ==
X-Received: by 2002:a2e:b8cd:0:b0:3a9:926c:c276 with SMTP id
 38308e7fff4ca-3a9a2cbc6c9mr12456541fa.17.1791454236809; Thu, 08 Oct 2026
 03:10:36 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 10:10:34 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 10:10:34 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260929122407.219448-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260929122407.219448-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 8 Oct 2026 10:10:34 +0000
X-Gmail-Original-Message-ID: <CAMRc=MckUuLsgqjphOs=fiyz3wCaGbGWpt_fPKStZRAroPkE3Q@mail.gmail.com>
X-Gm-Features: AclHuK8KhVOCPFFk0C6VCi7XjvWfAzQZ9wqI5WRHeA5xhxr3xFISAjG4IBRvay8
Message-ID: <CAMRc=MckUuLsgqjphOs=fiyz3wCaGbGWpt_fPKStZRAroPkE3Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] power: sequencing: renesas-pwrrdy: Add RZ/V2H(P) and
 RZ/V2N A/D converter support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sep 2026 14:24:06 +0200, Prabhakar <prabhakar.csengg@gmail.com> said:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On RZ/V2H(P) and RZ/V2N, the SYS_ADC_CFG.SY_MSTP_ADA bit controls
> A/D converter power-down. RZ/V2H(P) has a single A/D converter unit,
> while RZ/V2N has three units sharing the same bit.
>
> Add an "adc" power sequencing target for these SoCs and match it to the
> RZ/V2H(P) ADC compatible, which is also used as the fallback compatible
> by RZ/V2N.
>
> Clear SY_MSTP_ADA when the first A/D converter unit is enabled and set it
> again when the last unit is disabled. Wait 20 us after clearing the bit
> before allowing conversion to start, ensuring ADCLK has been running for
> the required time.
>
> Bind the power sequencer to the RZ/V2H(P) and RZ/V2N auxiliary devices
> created by the SYS driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
> index 0190e53913bf..ab20b7ba9b83 100644
> --- a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
> +++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/auxiliary_bus.h>
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pwrseq/provider.h>
> @@ -15,11 +16,68 @@
>  #define SYS_PWRRDY_N_DSI_MASK	BIT(1)
>  #define SYS_PWRRDY_N_CSI_MASK	BIT(2)
>
> +#define RZV2H_SYS_ADC_CFG		0x1600
> +#define RZV2H_SYS_ADC_CFG_SY_MSTP_ADA	BIT(0)
> +/* Minimum time with ADCLK running after leaving power-down mode */
> +#define RZV2H_ADC_POWER_UP_US		20
> +
>  struct pwrseq_rz_info {
>  	int (*probe)(struct auxiliary_device *adev,
>  		     const struct auxiliary_device_id *id);
>  };
>
> +static int pwrseq_rzv2h_adc_enable(struct pwrseq_device *pwrseq)
> +{
> +	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
> +	int ret;
> +
> +	ret = regmap_clear_bits(regmap, RZV2H_SYS_ADC_CFG,
> +				RZV2H_SYS_ADC_CFG_SY_MSTP_ADA);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(RZV2H_ADC_POWER_UP_US);
> +
> +	return 0;
> +}
> +
> +static int pwrseq_rzv2h_adc_disable(struct pwrseq_device *pwrseq)
> +{
> +	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
> +
> +	return regmap_set_bits(regmap, RZV2H_SYS_ADC_CFG,
> +			       RZV2H_SYS_ADC_CFG_SY_MSTP_ADA);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_rzv2h_adc_unit = {
> +	.name = "adc-power-sequence",
> +	.enable = pwrseq_rzv2h_adc_enable,
> +	.disable = pwrseq_rzv2h_adc_disable,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_rzv2h_adc_target = {
> +	.name = "adc-power",
> +	.unit = &pwrseq_rzv2h_adc_unit,
> +};
> +
> +static const struct pwrseq_target_data *pwrseq_rzv2h_targets[] = {
> +	&pwrseq_rzv2h_adc_target,
> +	NULL
> +};
> +
> +static const char * const pwrseq_rzv2h_compats[] = {
> +	"renesas,r9a09g057-adc",
> +	NULL
> +};
> +
> +static int pwrseq_rzv2h_match(struct pwrseq_device *pwrseq, struct device *dev)
> +{
> +	if (of_device_compatible_match(dev->of_node, pwrseq_rzv2h_compats))
> +		return PWRSEQ_MATCH_OK;
> +
> +	return PWRSEQ_NO_MATCH;
> +}
> +
>  static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mask,
>  				   bool val)
>  {
> @@ -127,6 +185,20 @@ static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
>  	return PTR_ERR_OR_ZERO(devm_pwrseq_device_register(&adev->dev, &config));
>  }
>
> +static int pwrseq_rzv2h_probe(struct auxiliary_device *adev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	struct pwrseq_config config = {
> +		.parent = &adev->dev,
> +		.owner = THIS_MODULE,
> +		.drvdata = adev->dev.platform_data,
> +		.match = pwrseq_rzv2h_match,
> +		.targets = pwrseq_rzv2h_targets,
> +	};
> +
> +	return PTR_ERR_OR_ZERO(devm_pwrseq_device_register(&adev->dev, &config));
> +}

This probe variant looks almost exactly the same as pwrseq_rzg3l_pwrrdy_probe().
Can't you not just store the match and targets pointers in OF match
data and keep
the same code in top-level probe()?

Bart

> +
>  static int pwrseq_pwrrdy_probe_common(struct auxiliary_device *adev,
>  				      const struct auxiliary_device_id *id)
>  {
> @@ -140,7 +212,19 @@ static const struct pwrseq_rz_info pwrseq_rzg3l_info = {
>  	.probe = pwrseq_rzg3l_pwrrdy_probe,
>  };
>
> +static const struct pwrseq_rz_info pwrseq_rzv2h_info = {
> +	.probe = pwrseq_rzv2h_probe,
> +};
> +
>  static const struct auxiliary_device_id pwrseq_rzg3l_pwrrdy_id_table[] = {
> +	{
> +		.name = "rz_sysc.r9a09g056-pwrseq",
> +		.driver_data = (kernel_ulong_t)&pwrseq_rzv2h_info,
> +	},
> +	{
> +		.name = "rz_sysc.r9a09g057-pwrseq",
> +		.driver_data = (kernel_ulong_t)&pwrseq_rzv2h_info,
> +	},
>  	{
>  		.name = "rz_sysc.pwrseq-pwrrdy",
>  		.driver_data = (kernel_ulong_t)&pwrseq_rzg3l_info,
> --
> 2.55.0
>
>
