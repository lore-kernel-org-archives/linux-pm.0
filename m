Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4040DB5E
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228313; cv=none; b=BLzy5b9pMr7Ar56v0quHW8BiP8twvjARk7UkV5IzsCA4wQPAuLunI+o55b8hcfezfVWTplSuvK5RrkUymkU3/WI1CK2Rk6XRt2JYsQH4bJU2fyw3fewyd5ePvkVQ3YgZwVY5/MmlTL5sBGYYO8/1lc6mxbd6VrUL68NSRGjIv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228313; c=relaxed/simple;
	bh=d98ko6GW4nNVHZNTReRBulpKIT/3cDqdTo7mLtF/Ovg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGJJKWhM3S8lKEFWMMMCn8es078WUXvomNNM3WzfTZlklKIk/skaglFPXEKbiydJykxUdgvObGJVRBv240QWQeCQ3cl/yId4mSGGVQkDuUpGtX4aKPTfMjiFVoFIh4L2CKqMkdj7waebv4OOkJnb+gEfuRlD5uzoiBfh+nzWSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ/+GREL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ/+GREL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901951F000E9
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785228311;
	bh=mgwGnw1LeMBzci1Stejigw1agDkrzH3L3vKTklQqu0Q=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=lJ/+GRELN5p5BIXZGWxhOP+2RkpOhJv24Wk+BSpH++uFx2hzWtuNDV/5Gk1pozYUU
	 vdI4eU9mu5E6cO6qBH00CkTk3hnHrqHSbTimTN2gssEGhpcyA55JMBWz2rZwnq3hFF
	 9+7PvP2EHlrOYX1cECCf1pKiVpV9tjmNgf9fbtZDUiCKxAWYbRT2fTtmYujixtSyzW
	 Oh/9vBCZ4+ZtI6K7HKuGiRuzMuQd3EqzmM+U3p/92620qZyVW0jF5N5rAdOkbJ2AVF
	 w84R8b9Qitxkp6TSXQe0gxj7kTSb+lGr7GdkBwwtyswo058OEMLgWUjLzCtvuxWWTb
	 BlV262DBlv+Jw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b013084dc2so2762704e87.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 01:45:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpnbo7CNJ0JWNG6It/NtSaB5Fib6bJDA7X58PHRFq0Hux67x2dsJWSWZxFSCDHbCh4YdmrhhnErjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNW3pni1GAYQikFfweKRkgm+3uxxm7zKdWA3vvK45F3vupplN
	+lhwl8UknM29ay5An47SkOSMiz90wuA2NfXu+TxNNQdHzsoi+J5nZs6uDWsN8y0jCpHx+f9Fwow
	LM5+I4XMlgRLwiKl5Vky1ThAIOr4fK00e1SSdtsZ/mA==
X-Received: by 2002:a05:6512:238b:b0:5b2:aaa2:1d8d with SMTP id
 2adb3069b0e04-5b2d0106076mr317721e87.2.1785228310309; Tue, 28 Jul 2026
 01:45:10 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 08:45:09 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 08:45:09 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260725123433.162348-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com> <20260725123433.162348-3-biju.das.jz@bp.renesas.com>
Date: Tue, 28 Jul 2026 08:45:09 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
X-Gm-Features: AUfX_mzgkXgviY5xRYVFcqN9ouUjg2z7AvPic1BafteY-WRWusmm3WJ1keIqbkM
Message-ID: <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 14:34:29 +0200, Biju <biju.das.au@gmail.com> said:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
> SoC. The driver binds as an auxiliary device to the parent SYSC driver,
> using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
> {usb,dsi,csi}-pwrrdy pwrseq targets.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/power/sequencing/Kconfig              |   8 +
>  drivers/power/sequencing/Makefile             |   1 +
>  .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 141 ++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index 1c5f5820f5b7..245961cc8123 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -27,6 +27,14 @@ config POWER_SEQUENCING_QCOM_WCN
>  	  this driver is needed for correct power control or else we'd risk not
>  	  respecting the required delays between enabling Bluetooth and WLAN.
>
> +config POWER_SEQUENCING_RENESAS_PWRRDY
> +	tristate "Renesas Power Ready sequencing driver"
> +	depends on SYSC_RZ || COMPILE_TEST
> +	help
> +	  Say Y here to enable the power sequencing driver for the Renesas
> +	  Power Ready signals. This driver handles the power ready signals
> +	  required to power on the various IP's on RZ/G3L platform.
> +
>  config POWER_SEQUENCING_TH1520_GPU
>  	tristate "T-HEAD TH1520 GPU power sequencing driver"
>  	depends on (ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST
> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
> index 0911d4618298..b33d08d82f43 100644
> --- a/drivers/power/sequencing/Makefile
> +++ b/drivers/power/sequencing/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
>  pwrseq-core-y				:= core.o
>
>  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
> +obj-$(CONFIG_POWER_SEQUENCING_RENESAS_PWRRDY) += pwrseq-renesas-pwrrdy.o
>  obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
>  obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
> diff --git a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
> new file mode 100644
> index 000000000000..a3d187dd3247
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G3L Power Ready driver
> + *
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/pwrseq/provider.h>
> +#include <linux/regmap.h>
> +
> +#define SYS_PWRRDY_N		0xd70
> +#define SYS_PWRRDY_N_USB_MASK	BIT(0)
> +#define SYS_PWRRDY_N_DSI_MASK	BIT(1)
> +#define SYS_PWRRDY_N_CSI_MASK	BIT(2)
> +
> +static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mask, u32 val)
> +{
> +	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
> +
> +	return regmap_update_bits(regmap, SYS_PWRRDY_N, mask, val);
> +}
> +
> +static int pwrseq_rzg3l_usb_pwrrdy_enable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_USB_MASK, 0);
> +}
> +
> +static int pwrseq_rzg3l_usb_pwrrdy_disable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_USB_MASK, 1);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_rzg3l_usb_pwrrdy_unit = {
> +	.name = "usb-pwrrdy-power-sequence",
> +	.enable = pwrseq_rzg3l_usb_pwrrdy_enable,
> +	.disable = pwrseq_rzg3l_usb_pwrrdy_disable,
> +};
> +
> +static int pwrseq_rzg3l_dsi_pwrrdy_enable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_DSI_MASK, 0);
> +}
> +
> +static int pwrseq_rzg3l_dsi_pwrrdy_disable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_DSI_MASK, 1);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_rzg3l_dsi_pwrrdy_unit = {
> +	.name = "dsi-pwrrdy-sequence",
> +	.enable = pwrseq_rzg3l_dsi_pwrrdy_enable,
> +	.disable = pwrseq_rzg3l_dsi_pwrrdy_disable,
> +};
> +
> +static int pwrseq_rzg3l_csi_pwrrdy_enable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_CSI_MASK, 0);
> +}
> +
> +static int pwrseq_rzg3l_csi_pwrrdy_disable(struct pwrseq_device *pwrseq)
> +{
> +	return pwrseq_rzg3l_set_pwrrdy(pwrseq, SYS_PWRRDY_N_CSI_MASK, 1);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_rzg3l_csi_pwrrdy_unit = {
> +	.name = "csi-pwrrdy-power-sequence",
> +	.enable = pwrseq_rzg3l_csi_pwrrdy_enable,
> +	.disable = pwrseq_rzg3l_csi_pwrrdy_disable,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_rzg3l_usb_pwrrdy_target = {
> +	.name = "usb-pwrrdy",
> +	.unit = &pwrseq_rzg3l_usb_pwrrdy_unit,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_rzg3l_dsi_pwrrdy_target = {
> +	.name = "dsi-pwrrdy",
> +	.unit = &pwrseq_rzg3l_dsi_pwrrdy_unit,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_rzg3l_csi_pwrrdy_target = {
> +	.name = "csi-pwrrdy",
> +	.unit = &pwrseq_rzg3l_csi_pwrrdy_unit,
> +};
> +
> +static const struct pwrseq_target_data *pwrseq_rzg3l_pwrrdy_targets[] = {
> +	&pwrseq_rzg3l_usb_pwrrdy_target,
> +	&pwrseq_rzg3l_dsi_pwrrdy_target,
> +	&pwrseq_rzg3l_csi_pwrrdy_target,
> +	NULL
> +};
> +
> +static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
> +				     struct device *dev)
> +{
> +	return PWRSEQ_MATCH_OK;

When I see an always-tru match() callback, it always raises an alarm bell.
Typically, I'd expect there to be some validation of the consumer happening.

Please at least provide an explanation of why it's ok.

> +}
> +
> +static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
> +				     const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &adev->dev;
> +	struct pwrseq_config config = {};
> +	struct pwrseq_device *pwrseq;
> +	struct regmap *regmap;
> +
> +	regmap = dev_get_regmap(adev->dev.parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "Failed to retrieve parent regmap\n");
> +
> +	config.parent = dev;
> +	config.owner = THIS_MODULE;
> +	config.drvdata = regmap;
> +	config.match = pwrseq_rzg3l_pwrrdy_match;
> +	config.targets = pwrseq_rzg3l_pwrrdy_targets;

Add newline here.

It wouldn't also hurt to use a compound literal like so:

	config = (struct pwrseq_config){
		.parent = dev,
		...
	};

> +	pwrseq = devm_pwrseq_device_register(dev, &config);
> +	if (IS_ERR(pwrseq))
> +		return dev_err_probe(dev, PTR_ERR(pwrseq), "Failed to register power sequencer\n");
> +

I'd just return devm_pwrseq_device_register() here.

> +	return 0;
> +}
> +
> +static const struct auxiliary_device_id pwrseq_rzg3l_pwrrdy_id_table[] = {
> +	{ .name = "rz_sysc.pwrseq-pwrrdy" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, pwrseq_rzg3l_pwrrdy_id_table);
> +
> +static struct auxiliary_driver pwrseq_rzg3l_pwrrdy_driver = {
> +	.driver = {
> +		.name = "pwrseq-rzg3l-pwrrdy",
> +	},
> +	.probe = pwrseq_rzg3l_pwrrdy_probe,
> +	.id_table = pwrseq_rzg3l_pwrrdy_id_table,
> +};
> +module_auxiliary_driver(pwrseq_rzg3l_pwrrdy_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G3L Power Ready Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>
>
