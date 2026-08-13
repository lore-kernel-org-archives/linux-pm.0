Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F5480DC4
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629024; cv=none; b=eYxivu9buUoq6NcKhqPG+QehC+AiVUNl69sJGzr+RuU5MADpFheFBODeTOuGh+g/1Rd+1ZKmxWrGVD157WOWjAi3tWEP3QXkYotDdfn9HqQ5DwFxq8e6XZlPv+NE+c+Fou4sG1KIocB608c7pGVVmD8ZT9jD2vJsoumtTQRWI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629024; c=relaxed/simple;
	bh=jtT+bJnq8ZSja0HD3NFV6/xujMDltjzrjhyWVL+255I=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEB7iqem5RThvpsi3bt55jWcJviRfie1xQehag41w9SgRBorCYZKUtBn2kwNNoPs/VzRIC2g8lCH3QL9yco9R0bXZ0DrlJytroBwk+ZYfiDjdH+r9NC7BspbaQYTxCiY3n4nVre7YjgTCzzrdvoN2ruoT5CH0cC/yrrfIExIdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYAbdnB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYAbdnB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8897E1F000E9
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629022;
	bh=51G8SAV3RFtwWC/nx+kTTThhMuclvLczvqYy+E9IdVo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=EYAbdnB3aEdIJTLxjoQtOa0EBrdV6jTxzxRaafKyd+kSzaVDz8m6LZ4ps1cLCiHZh
	 a4t09xC3GoMVjUvvvuVDIznbFTHiPjO0bfOOvrP5otJliJhRbEQe+IRSaqXHPnj7hE
	 vp1hmZmkd5u/Z8EktEGJfoF/Y03mCzIou9df5k76/3AZ2k6W6qc0zRKEjfh+hEBJUi
	 snyKgtpBe6j6yJW5EPgKumNCtoJ+Gkzrmfc0KYJ0PzJAlFijqlJ7JHtI7n+l0jOkbe
	 BH1PqprVl3BIk7IdRmECFf8CWLASlZxaCm5Z1Io15bOEiw0zwxSFwCV9yXdYQhQE41
	 8Owfb8cs+fMtQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so8270391fa.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 06:50:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrU1WM4l94IEX8tFFiwx4OhdmbvYs+ZrFH/ZmeNMDKSsbgu6IcLKIXJOPkg9TOSQeYMdWKBqVaTyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFogNsgNegTdJc0R2Y9Scij+guiRaqDSylwRozx/1Ht2s6CfsR
	isKNisXJ5CeoJ8y9bkr4KtaxHuTHriIiXqH+rld8jAVgOEumPkXtorMKPLs4NhLWO+hTdz7ScGX
	YAJun9wDPlPLcisrN3YiRGv2xgAc+ZgpONVTFNXpeZQ==
X-Received: by 2002:a2e:be87:0:b0:39f:bc94:eba5 with SMTP id
 38308e7fff4ca-3a11a776fa2mr7639151fa.16.1786629021252; Thu, 13 Aug 2026
 06:50:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 13:50:19 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 13:50:19 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260812115010.108322-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812115010.108322-1-biju.das.jz@bp.renesas.com> <20260812115010.108322-3-biju.das.jz@bp.renesas.com>
Date: Thu, 13 Aug 2026 13:50:19 +0000
X-Gmail-Original-Message-ID: <CAMRc=McW-ot+KAjBtCt6EXdshQTVLX4-LZE87O-hgVqv5htvQw@mail.gmail.com>
X-Gm-Features: AUfX_mzKxZZb7yqbxIulxQryd1Dq-XAm0tGQIjPolYOrCJCNI8riEStDg1JAPlM
Message-ID: <CAMRc=McW-ot+KAjBtCt6EXdshQTVLX4-LZE87O-hgVqv5htvQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026 13:50:04 +0200, Biju <biju.das.au@gmail.com> said:
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
> v2->v3:
>  * Kconfig selects AUXILIARY_BUS to avoid compilation issues.
>  * Added match for consumer device and added of_device.h header file.
>  * Replaced regmap_update_bits()->regmap_assign_bits() and updated
>    the function parameter of pwrseq_rzg3l_set_pwrrdy().
>  * Simpilfied probe() return with PTR_ERR_OR_ZERO macro.
> v1->v2:
>  * Added a comment in pwrseq_rzg3l_pwrrdy_match().
>  * Dropped dev_get_regmap() from probe as regmap is now part of platform
>    data.
>  * Added a blank line before devm_pwrseq_device_register() in probe.
>  * Dropped the error message devm_pwrseq_device_register() as probe prints
>    failure message.
>  * Dropped local variables dev and regmap from probe().
> ---
>  drivers/power/sequencing/Kconfig              |   9 ++
>  drivers/power/sequencing/Makefile             |   1 +
>  .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 147 ++++++++++++++++++
>  3 files changed, 157 insertions(+)
>  create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index 1c5f5820f5b7..286d4e300845 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -27,6 +27,15 @@ config POWER_SEQUENCING_QCOM_WCN
>  	  this driver is needed for correct power control or else we'd risk not
>  	  respecting the required delays between enabling Bluetooth and WLAN.
>
> +config POWER_SEQUENCING_RENESAS_PWRRDY
> +	tristate "Renesas Power Ready sequencing driver"
> +	depends on SYSC_RZ || COMPILE_TEST
> +	select AUXILIARY_BUS
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
> index 000000000000..8dfc65034a1c
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G3L Power Ready driver
> + *
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwrseq/provider.h>
> +#include <linux/regmap.h>
> +
> +#define SYS_PWRRDY_N		0xd70
> +#define SYS_PWRRDY_N_USB_MASK	BIT(0)
> +#define SYS_PWRRDY_N_DSI_MASK	BIT(1)
> +#define SYS_PWRRDY_N_CSI_MASK	BIT(2)
> +
> +static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mask,
> +				   bool val)
> +{
> +	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
> +
> +	return regmap_assign_bits(regmap, SYS_PWRRDY_N, mask, val);
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
> +	static const struct of_device_id pwrseq_rzg3l_consumer_match[] = {
> +		{ .compatible = "renesas,r9a08g046-mipi-dsi" },
> +		{ .compatible = "renesas,r9a08g046-usbphy-ctrl" },
> +		{ /* sentinel */ }
> +	};
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(pwrseq_rzg3l_consumer_match, dev);
> +	if (!match)
> +		return PWRSEQ_NO_MATCH;
> +

What about the common parent of sysc and the consumers? Is there any reason we
can't verify it?

> +	return PWRSEQ_MATCH_OK;
> +}
> +
> +static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
> +				     const struct auxiliary_device_id *id)
> +{
> +	struct pwrseq_device *pwrseq;
> +	struct pwrseq_config config = {
> +		.parent = &adev->dev,
> +		.owner = THIS_MODULE,
> +		.drvdata = adev->dev.platform_data,
> +		.match = pwrseq_rzg3l_pwrrdy_match,
> +		.targets = pwrseq_rzg3l_pwrrdy_targets,
> +	};
> +
> +	pwrseq = devm_pwrseq_device_register(&adev->dev, &config);
> +
> +	return PTR_ERR_OR_ZERO(pwrseq);

Just do return PTR_ERR_OR_ZERO(devm_pwrseq_...

Bart

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
