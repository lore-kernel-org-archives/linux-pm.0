Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F344480333;
	Thu,  4 Jun 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592521; cv=pass; b=tKD68Exg9QjMl5AB1hPappX61iC/bXpXPxw1X/PK9lt36NJM4fPLpTxPo4Eiwhl4SKeHNiEqs5AyGBRAz4ps9UqW1uoTRksj/xSRNhme3fNCti2VqfVVLC+R000SLzcYByrb/1zeHHtCX7pdm9vpjF72g69Q++V8qYMvE/yv0Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592521; c=relaxed/simple;
	bh=ulw4bYxl7A4dnEUGReRqHL4Dx19seTlEFvgiUAX9nhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+ygmVouk2kmqTyZLYb1hUXB5k3dXGC4b/Pe8srLnqCgGM+0raApjAMtvsJCerUYOF10+NHR+QP0m1LhP0S4EM0C+tc11BeFt28GBSlGyb8tc8lxkn+BltsoguRPk9CK/ecII7pFttz0xd5+uPtbg8Fj/JqcXSgZDGac2SXdUJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=BuAIj3rR; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="BuAIj3rR"
ARC-Seal: i=1; a=rsa-sha256; t=1780592506; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lUhS9b/Ur/EfEu7aC60bEkCAQ1b0pLqUYQf3OSGM+ASx0Dlz7MkmpteDgOI+pxSk/2aZFknRfZiUzVDiG++66Sv014vn2HWngYVqR/LOCkIrIy//A4AsxtPZL5IzTtad2oZsnAXAPbEZhY0WZanyxf7JPuARR3CAU8TeQg9RpAE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780592506; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+0J34Rp7ODzpOZH+ghPY3PieFCy8fxn1AB+uMTKMrIA=; 
	b=NpffucHUPuf0RTloBGP8mptYighx9n2JrkejNuWx2kI4yDH3PBHBA4jQSn056nZSARDM2YK4szajqgKKnHwfJIhRiu+SrWEjSUV0LwTKi8wyalXCUf6LAKhx5uVKFzuIAP1qFLhuJTlucZAuOxrdLcvAqOKk/Ww6jss7NNefODY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780592506;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+0J34Rp7ODzpOZH+ghPY3PieFCy8fxn1AB+uMTKMrIA=;
	b=BuAIj3rRip8HOuRyFIpmMbfrHsk9Z80m4bT/ZGF26/z+1ikiS5fO0y5wO9F3rrdb
	ZExk6HAoAmdvZHoKWDWRPtUO7B3Y/k594kJ9JzF5x6TCCK9IK/UwXvrpf04BIW6Adxc
	f3zQbPd5k82kh3WvcS1R/daY1YCAQKusk3Et1ULk=
Received: by mx.zohomail.com with SMTPS id 1780592503928741.7148016284211;
	Thu, 4 Jun 2026 10:01:43 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id C90B6181D80; Thu, 04 Jun 2026 19:01:40 +0200 (CEST)
Date: Thu, 4 Jun 2026 19:01:40 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] power: reset: add MCF5441x RCM power-on reason driver
Message-ID: <aiGseFwWJkjCZrfB@venus>
References: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
 <20260602-coldfire-rcm-power-on-reason-v1-2-fbc3eab0c016@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="weaaxdxhy55xrgky"
Content-Disposition: inline
In-Reply-To: <20260602-coldfire-rcm-power-on-reason-v1-2-fbc3eab0c016@yoseli.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.581.16
X-ZohoMailClient: External


--weaaxdxhy55xrgky
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] power: reset: add MCF5441x RCM power-on reason driver
MIME-Version: 1.0

Hi,

On Tue, Jun 02, 2026 at 11:21:22AM +0200, Jean-Michel Hautbois wrote:
> Add a driver that decodes the Reset Status Register (RSR) of the
> Freescale ColdFire MCF5441x Reset Controller Module at probe time
> and exposes the cause via the power_on_reason sysfs ABI.
>=20
> The RSR can latch several cause bits simultaneously (Reference
> Manual chapter 12.3.2); the driver picks one cause per a priority
> that favours the most explanatory diagnostic.
>=20
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  MAINTAINERS                         |   6 ++
>  drivers/power/reset/Kconfig         |  12 ++++
>  drivers/power/reset/Makefile        |   1 +
>  drivers/power/reset/mcf-rcm-reset.c | 109 ++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 128 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 461a3eed6129..1109bff23ec1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10195,6 +10195,12 @@ S:	Maintained
>  F:	drivers/mmc/host/sdhci-esdhc-mcf.c
>  F:	include/linux/platform_data/mmc-esdhc-mcf.h
> =20
> +FREESCALE COLDFIRE M5441X RCM POWER-ON REASON DRIVER
> +M:	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> +L:	linux-m68k@lists.linux-m68k.org
> +S:	Maintained
> +F:	drivers/power/reset/mcf-rcm-reset.c
> +
>  FREESCALE DIU FRAMEBUFFER DRIVER
>  M:	Timur Tabi <timur@kernel.org>
>  L:	linux-fbdev@vger.kernel.org
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 124afb99febe..003638f652fa 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -128,6 +128,18 @@ config POWER_RESET_LINKSTATION
> =20
>  	  Say Y here if you have a Buffalo LinkStation LS421D/E.
> =20
> +config POWER_RESET_MCF_RCM
> +	tristate "Freescale ColdFire RCM power-on reason driver"
> +	depends on M5441x

If you describe the register layout in the driver, you
could add "|| COMPILE_TEST" resulting in much better
test coverage.

> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the cause of the last reset on Freescale
> +	  ColdFire 5441x SoCs through the standard power_on_reason sysfs
> +	  ABI. It reads the Reset Status Register (RSR) of the Reset
> +	  Controller Module once at probe time and reports a normalised
> +	  string (regular power-up, reset button action, software reset
> +	  or unknown reason).
> +
>  config POWER_RESET_MACSMC
>  	tristate "Apple SMC reset/power-off driver"
>  	depends on MFD_MACSMC
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index d7ae97241a83..e31cab4ba78e 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_LINKSTATION) +=3D linkstation-poweroff.o
> +obj-$(CONFIG_POWER_RESET_MCF_RCM) +=3D mcf-rcm-reset.o
>  obj-$(CONFIG_POWER_RESET_MACSMC) +=3D macsmc-reboot.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
> diff --git a/drivers/power/reset/mcf-rcm-reset.c b/drivers/power/reset/mc=
f-rcm-reset.c
> new file mode 100644
> index 000000000000..666ae1455be1
> --- /dev/null
> +++ b/drivers/power/reset/mcf-rcm-reset.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Freescale ColdFire MCF5441x RCM power-on reason driver
> + *
> + * Copyright (C) 2026 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.o=
rg>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power/power_on_reason.h>
> +
> +#include <asm/m5441xsim.h>
> +
> +#define MCF_RSR_KNOWN_CAUSES	(MCF_RSR_POR | MCF_RSR_EXT | MCF_RSR_WDRCOR=
E | \
> +				 MCF_RSR_LOC | MCF_RSR_LOL | MCF_RSR_SOFT)
> +
> +struct mcf_rcm {
> +	const char *reason;
> +};
> +
> +/*
> + * Decode RSR into a power_on_reason string.
> + *
> + * The MCF5441x Reset Status Register can latch several cause bits at the
> + * same time (Reference Manual chapter 12.3.2: "one or more status bits
> + * may be set at the same time"). A power-on, for example, also resets
> + * the PLL and may co-flag LOC and LOL during the boot sequence. The
> + * power_on_reason ABI carries a single string, so this routine picks
> + * one cause; the chosen priority surfaces the most explanatory one for
> + * diagnostics:
> + *
> + *   POR              cold boot dominates any spurious co-flagged cause
> + *   EXT              operator action via the RESET pin
> + *   WDRCORE          core watchdog timeout, a fault to investigate
> + *   LOC, LOL         PLL clock or lock failure, hardware fault
> + *   SOFT             explicit software-requested reset
> + */
> +static const char *mcf_rcm_decode(u8 rsr)
> +{
> +	if (rsr & MCF_RSR_POR)
> +		return POWER_ON_REASON_REGULAR;
> +	if (rsr & MCF_RSR_EXT)
> +		return POWER_ON_REASON_RST_BTN;
> +	if (rsr & MCF_RSR_WDRCORE)
> +		return POWER_ON_REASON_WATCHDOG;
> +	if (rsr & (MCF_RSR_LOC | MCF_RSR_LOL))
> +		return POWER_ON_REASON_CPU_CLK_FAIL;
> +	if (rsr & MCF_RSR_SOFT)
> +		return POWER_ON_REASON_SOFTWARE;
> +	return POWER_ON_REASON_UNKNOWN;
> +}
> +
> +static ssize_t power_on_reason_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct mcf_rcm *rcm =3D platform_get_drvdata(to_platform_device(dev));
> +
> +	return sysfs_emit(buf, "%s\n", rcm->reason);
> +}
> +static DEVICE_ATTR_RO(power_on_reason);
> +
> +static struct attribute *mcf_rcm_attrs[] =3D {
> +	&dev_attr_power_on_reason.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(mcf_rcm);
> +
> +static int mcf_rcm_probe(struct platform_device *pdev)
> +{
> +	struct mcf_rcm *rcm;
> +	void __iomem *base;
> +	u8 rsr;
> +
> +	rcm =3D devm_kzalloc(&pdev->dev, sizeof(*rcm), GFP_KERNEL);
> +	if (!rcm)
> +		return -ENOMEM;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rsr =3D readb_relaxed(base);
> +	rcm->reason =3D mcf_rcm_decode(rsr);
> +
> +	platform_set_drvdata(pdev, rcm);
> +
> +	if (!(rsr & MCF_RSR_KNOWN_CAUSES))
> +		dev_warn(&pdev->dev, "Unknown reset cause (RSR=3D0x%02x)\n", rsr);
> +	else
> +		dev_info(&pdev->dev, "Starting after %s (RSR=3D0x%02x)\n",
> +			 rcm->reason, rsr);
> +
> +	return 0;
> +}

static const struct platform_device_id mcf_rcm_id[] =3D {
    { "mcf-rcm-reset", 0, },
    { }
};
MODULE_DEVICE_TABLE(platform, mcf_rcm_id);

> +static struct platform_driver mcf_rcm_driver =3D {
> +	.probe =3D mcf_rcm_probe,
> +	.driver =3D {
> +		.name =3D "mcf-rcm-reset",
> +		.dev_groups =3D mcf_rcm_groups,
> +	},

=2Eid_table =3D mcf_rcm_id,

> +};
> +module_platform_driver(mcf_rcm_driver);
> +
> +MODULE_AUTHOR("Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>");
> +MODULE_DESCRIPTION("Freescale ColdFire RCM power-on reason driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mcf-rcm-reset");

You can drop the MODULE_ALIAS with the platform ID table being
done properly.

Otherwise LGTM.

-- Sebastian

--weaaxdxhy55xrgky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmohr2gACgkQ2O7X88g7
+prA3xAAhtx7s9ZMrDvndLLu4dNHrOT72Dd8tdogegErykWXaQIf7Q83yb78wLG/
kjXnJqnmzS8Fv25syQPWIgQbxfzQzr4Y4wCMo0FFSGfN0fAezhokxJ1H/rxJ53h3
ZpiRaTGfwae4rfm/xaKaFabZoj2mSJYN4aZKQrqmg/3+73p8QZsWyInQViI0/Gah
eQ3c6i0oX3bkePnyx2wVMSUxLAifTxJG2/tj2q87D1QAcgnQm9xXiyd6A+uqxGIs
m6V9Xa6m5eIbSk6gD8LE9dHhGa2gpjeZpIjaMLKJhwqkQpWWUrplgOlSZRqc0xcl
ssFbSWvkUNJepZlD54z4pvHTvQLw2l3gtUjObzYSZEkaP0mPq/c+s3VFCl/DmnNX
evrH3hGaZUc7TJnk+6SDiyuk6sT7YbAsygcZKxeK783evgC+ZKy5TIlJ+NWAGTMu
g/KcvecrUEtINz7VJEtYwMqIZHCMb8wAzqcTd8KhWj4KlEqR9FiIVSGmBPVJ/L63
0a9AfnOgGWK0DpVzs0J2wFRo3EP0J3OXx1QQsZ8SkhigmGY0sxbeme8dHhpbjGPQ
wxrXKLUggFtaXze0qAApT+mtKOXwfTi6n5oNOikPOAlIUrYDqEyQ6Z7Z6+QuKcAJ
QkyqUKAmrSdGHfjfbLDvs/ck8mC2PjthApW+bR5gFxP10y1sElY=
=Eg/S
-----END PGP SIGNATURE-----

--weaaxdxhy55xrgky--
