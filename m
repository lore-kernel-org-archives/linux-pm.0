Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24236C592;
	Sun, 20 Sep 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909058; cv=pass; b=raEALq10SenA8eCNjT+xDHZlJTQSBXkgL8UUbmOqjiz+CYAqRAP0+cuUgElRl7Xk9zRv86nItOGlvdJ6/putKhCYo8LIjTDwI7HKH/qrbsyj8ujqkOfL+4+UxTsbWipdu2BObv5pF8x6Ivq5LvOz6J4i3hR79DjfIJROAdpQbuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909058; c=relaxed/simple;
	bh=wBYT1lxyUB1CETsV6ivSEi7HV7zTOEzQ+AeSwPVrmcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CP37bwc9VqVWBZURv9Hgz4xK32gIo6jDRFBgoVic96gzCxzKCc2P3oiPekz2SW48GMbfJBfUsL1eaZ3OYOM57iWKHoTQQ51v9uVsqLCgRA7T3s3qIVGjM7LpWLuCCmsYPNwt//8+BfYJ8hF8haoyV3N98RX8kcsCPK3H+ynMuck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=WuBYqW+4; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="WuBYqW+4"
ARC-Seal: i=1; a=rsa-sha256; t=1789909015; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aq7A9Ku7sPPQETsjMz/bX3oEKPwQdEfvMXRiyo0CpXIfRL4cyHw+nUVT+nQZrGAnCjeBPPXAtPJalrZKZQT7MTI0Xt3F2PlAor6GNCqxnHQBr7HLd0eQ+TSN4/IaArEiDkHf4rd4sYLi8ARsaPqnoBeNKsm2UEw76PGzX2nx4Vs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789909015; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3H8e5lr2CI5Zj1piZtErIUeaQlBLdh6/qN12kvnqJWY=; 
	b=A9FqKxLdxyZaVz69SLLprFLZNjUsgIkZic3cdfg1wQX/lOHKCI/J7zkF0ZvNx64CkUuTvxWuXi2grpeFVEJz+ZAeKGPlU7D9GUFFeVnukpE4dwICWMVh22v8BSlQA5AlLp3pusc91ckIASDyU9qt7TNnpUuYlALg1LTZEpRLhZI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789909015;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=3H8e5lr2CI5Zj1piZtErIUeaQlBLdh6/qN12kvnqJWY=;
	b=WuBYqW+4KysyPzo/LPYQwk43ldX6G3jhawey9f+cF0dxMLWoFq1+BwohJNIZhh5c
	i6BWbf862bvRdtTCskY2j04m5ywWGVwRw+ZKP3F+Wbw1qOqda4FaguPhc4/55Xl7jbh
	hpoGR+krsBFxCOU5PwiXhdOFBYeOjMitdN5nZXqDV/H1QrLN1jf2gDn95LHvZJ/zLhD
	vsukTj5PkvJBW6dQA8mLRXfnaNIe33Dbbp2gR3lHJjfDWbGFWWjjZkFy3gsLg/MOeGG
	KPJSdoXamHeiSf2Kx7LsLvJgMNNtKR6Q3EQOzPfyAv0DlVFIDA891Qn1PA700jkEc+m
	smqUWlZi6w==
Received: by smtp.zohomail.com with SMTPS id 17899090136091008.2562742156387;
	Sun, 20 Sep 2026 05:56:53 -0700 (PDT)
Message-ID: <56e5f32102c67575ded8af9e81a06dc9f1dcf0ee.camel@icenowy.me>
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
From: Icenowy Zheng <uwu@icenowy.me>
To: Yixun Lan <dlan@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>,  Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Date: Sun, 20 Sep 2026 20:56:44 +0800
In-Reply-To: <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
	 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 02:40 +0000=EF=BC=8CYixun Lan=E5=86=
=99=E9=81=93=EF=BC=9A
> =C2=A0 SpacemiT's PMU (Power Management Unit) consist of several power
> domains
> which can be managed independently, depending on different
> application
> scenario, each domain can be powered on/off for saving power.
>=20
> =C2=A0 The driver is implemented based on Linux Generic PM Domain
> framework.
> From a hardware perspective, either of two distinct power-on
> sequences
> are supported, in software mode (SW mode), the driver is responsible
> for
> controlling the states of bits such as sleep1, sleep2, isolation and
> pwr_state, while in hardware mode (HW mode), the PMU hardware will
> complete
> the sequence automatically without requiring software intervention.

This driver is tested to be able to power up the GPU on SpacemiT K3,
however the following warning appears in the kernel log:

```
genpd_provider audio: Fail to power-off domain: 2
```

(BTW I built it as a module to prevent whole kernel being rebuilt)

Thanks,
Icenowy

>=20
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> =C2=A0drivers/pmdomain/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/pmdomain/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/pmdomain/spacemit/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 15 ++
> =C2=A0drivers/pmdomain/spacemit/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> =C2=A0drivers/pmdomain/spacemit/pm_domains.c | 448
> +++++++++++++++++++++++++++++++++
> =C2=A05 files changed, 466 insertions(+)
>=20
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 23076ae90e66..0610acd030f6 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -13,6 +13,7 @@ source "drivers/pmdomain/qcom/Kconfig"
> =C2=A0source "drivers/pmdomain/renesas/Kconfig"
> =C2=A0source "drivers/pmdomain/rockchip/Kconfig"
> =C2=A0source "drivers/pmdomain/samsung/Kconfig"
> +source "drivers/pmdomain/spacemit/Kconfig"
> =C2=A0source "drivers/pmdomain/st/Kconfig"
> =C2=A0source "drivers/pmdomain/starfive/Kconfig"
> =C2=A0source "drivers/pmdomain/sunxi/Kconfig"
> diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
> index ebc802f13eb9..ba25b444e263 100644
> --- a/drivers/pmdomain/Makefile
> +++ b/drivers/pmdomain/Makefile
> @@ -11,6 +11,7 @@ obj-y					+=3D qcom/
> =C2=A0obj-y					+=3D renesas/
> =C2=A0obj-y					+=3D rockchip/
> =C2=A0obj-y					+=3D samsung/
> +obj-y					+=3D spacemit/
> =C2=A0obj-y					+=3D st/
> =C2=A0obj-y					+=3D starfive/
> =C2=A0obj-y					+=3D sunxi/
> diff --git a/drivers/pmdomain/spacemit/Kconfig
> b/drivers/pmdomain/spacemit/Kconfig
> new file mode 100644
> index 000000000000..4b927beedc7c
> --- /dev/null
> +++ b/drivers/pmdomain/spacemit/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "SpacemiT PM Domains"
> +
> +config SPACEMIT_PM_DOMAINS
> +	bool "PM Domain driver for SpacemiT SoC"
> +	depends on PM
> +	depends on OF
> +	depends on MFD_SYSCON
> +	select PM_GENERIC_DOMAINS
> +	help
> +	=C2=A0 PM Domain driver for SpacemiT SoC. Say Y if you want to
> support
> +	=C2=A0 SpacemiT SoCs.
> +
> +endmenu
> diff --git a/drivers/pmdomain/spacemit/Makefile
> b/drivers/pmdomain/spacemit/Makefile
> new file mode 100644
> index 000000000000..5e8a740ba494
> --- /dev/null
> +++ b/drivers/pmdomain/spacemit/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_SPACEMIT_PM_DOMAINS)	+=3D pm_domains.o
> diff --git a/drivers/pmdomain/spacemit/pm_domains.c
> b/drivers/pmdomain/spacemit/pm_domains.c
> new file mode 100644
> index 000000000000..d563e4e4e232
> --- /dev/null
> +++ b/drivers/pmdomain/spacemit/pm_domains.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit Generic power domain support.
> + *
> + * Copyright (c) 2026 SpacemiT Technology Co. Ltd
> + */
> +
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <dt-bindings/power/spacemit,k1-power.h>
> +#include <dt-bindings/power/spacemit,k3-power.h>
> +
> +#define APMU_POWER_STATUS_REG	0xf0
> +#define APMU_POWER_TIMEOUT_US	10000
> +
> +struct spacemit_pm_domain_param {
> +	int reg_pwr_ctrl;
> +	int bit_hw_mode;
> +	int bit_sleep2;
> +	int bit_sleep1;
> +	int bit_isolation;
> +	int bit_auto_pwr_on;
> +	int bit_hw_pwr_stat;
> +	int bit_pwr_stat;
> +	int use_hw;
> +	const char *name;
> +};
> +
> +struct spacemit_pm_domain {
> +	struct generic_pm_domain genpd;
> +	int pm_index;
> +	const struct spacemit_pm_domain_param *param;
> +};
> +
> +struct spacemit_pmu {
> +	struct device *dev;
> +	struct genpd_onecell_data genpd_data;
> +	struct regmap *regmap;
> +	struct spacemit_pm_domain **domains;
> +	int num_domains;
> +};
> +
> +struct spacemit_pm_of_data {
> +	int num_domains;
> +	const struct spacemit_pm_domain_param *param;
> +};
> +
> +static struct spacemit_pmu *gpmu;
> +
> +static int spacemit_pd_power_off(struct generic_pm_domain *domain)
> +{
> +	struct spacemit_pm_domain *spd =3D container_of(domain, struct
> spacemit_pm_domain, genpd);
> +	const struct spacemit_pm_domain_param *p =3D spd->param;
> +	unsigned int val;
> +	int ret;
> +
> +	if (!spd->param->use_hw) {
> +		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl,
> BIT(p->bit_isolation));
> +		fsleep(15);
> +
> +		val =3D BIT(p->bit_sleep1) | BIT(p->bit_sleep2);
> +		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl,
> val);
> +		fsleep(15);
> +
> +		ret =3D regmap_read_poll_timeout(gpmu->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_STATUS_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(val & BIT(p-
> >bit_pwr_stat)),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_TIMEOUT_US);
> +	} else {
> +		val =3D BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
> +		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl,
> val);
> +		fsleep(15);
> +
> +		ret =3D regmap_read_poll_timeout(gpmu->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_STATUS_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(val & BIT(p-
> >bit_hw_pwr_stat)),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_TIMEOUT_US);
> +	}
> +
> +	if (ret) {
> +		dev_err(&domain->dev, "Fail to power-off domain:
> %d\n",
> +				spd->pm_index);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spacemit_pd_power_on(struct generic_pm_domain *domain)
> +{
> +	struct spacemit_pm_domain *spd =3D container_of(domain, struct
> spacemit_pm_domain, genpd);
> +	const struct spacemit_pm_domain_param *p =3D spd->param;
> +	unsigned int val;
> +	int ret =3D 0;
> +
> +	regmap_read(gpmu->regmap, APMU_POWER_STATUS_REG, &val);
> +
> +	if (!p->use_hw && (val & BIT(p->bit_pwr_stat))) {
> +		val =3D BIT(p->bit_isolation);
> +		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl,
> val);
> +		fsleep(15);
> +
> +		val =3D BIT(p->bit_sleep1) | BIT(p->bit_sleep2);
> +		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl,
> val);
> +		fsleep(15);
> +
> +		ret =3D regmap_read_poll_timeout(gpmu->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_STATUS_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(val & BIT(p-
> >bit_pwr_stat)),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_TIMEOUT_US);
> +	}
> +
> +	if (p->use_hw && (val & BIT(p->bit_hw_pwr_stat))) {
> +		val =3D BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
> +		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl,
> val);
> +		fsleep(30);
> +
> +		ret =3D regmap_read_poll_timeout(gpmu->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_STATUS_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(val & BIT(p-
> >bit_hw_pwr_stat)),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_TIMEOUT_US);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&domain->dev, "power-off domain: %d,
> error\n", spd->pm_index);
> +		return -EBUSY;
> +	}
> +
> +	if (!p->use_hw) {
> +		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl,
> BIT(p->bit_sleep1));
> +		fsleep(20);
> +
> +		val =3D BIT(p->bit_sleep2) | BIT(p->bit_sleep1);
> +		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
> +		fsleep(20);
> +
> +		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl,
> BIT(p->bit_isolation));
> +		fsleep(15);
> +
> +		ret =3D regmap_read_poll_timeout(gpmu->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_STATUS_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (val & BIT(p-
> >bit_pwr_stat)),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_TIMEOUT_US);
> +	} else {
> +		val =3D BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
> +		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
> +		fsleep(300);
> +
> +		ret =3D regmap_read_poll_timeout(gpmu->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_STATUS_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (val & BIT(p-
> >bit_hw_pwr_stat)),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> APMU_POWER_TIMEOUT_US);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&domain->dev, "power-on domain: %d,
> error\n", spd->pm_index);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool spacemit_pm_get_state(struct spacemit_pmu *pmu,
> +				=C2=A0 struct spacemit_pm_domain *pd)
> +{
> +	const struct spacemit_pm_domain_param *p =3D pd->param;
> +	u32 reg, bit;
> +
> +	regmap_read(pmu->regmap, APMU_POWER_STATUS_REG, &reg);
> +
> +	bit =3D p->use_hw ? BIT(pd->param->bit_hw_pwr_stat) :
> +		BIT(pd->param->bit_pwr_stat);
> +
> +	return !!(reg & bit);
> +}
> +
> +static int spacemit_pm_add_one_domain(struct spacemit_pmu *pmu, int
> id,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> spacemit_pm_domain_param *param)
> +{
> +	struct spacemit_pm_domain *pd;
> +
> +	pd =3D devm_kzalloc(pmu->dev, sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		return -ENOMEM;
> +
> +	pd->pm_index=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D id;
> +	pd->param=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D param;
> +	pd->genpd.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D param->name;
> +	pd->genpd.power_off =3D spacemit_pd_power_off;
> +	pd->genpd.power_on=C2=A0 =3D spacemit_pd_power_on;
> +
> +	pm_genpd_init(&pd->genpd, NULL, !spacemit_pm_get_state(pmu,
> pd));
> +
> +	pmu->domains[id] =3D pd;
> +
> +	return 0;
> +}
> +
> +static void spacemit_pm_domain_cleanup(struct spacemit_pmu *pmu)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < pmu->num_domains; i++) {
> +		if (pmu->domains[i])
> +			pm_genpd_remove(&pmu->domains[i]->genpd);
> +	}
> +}
> +
> +static int spacemit_pm_domain_probe(struct platform_device *pdev)
> +{
> +	const struct spacemit_pm_of_data *data;
> +	struct device *dev =3D &pdev->dev;
> +	struct spacemit_pmu *pmu;
> +	int err, i;
> +
> +	data =3D device_get_match_data(dev);
> +
> +	pmu =3D devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	pmu->dev =3D dev;
> +	pmu->num_domains =3D data->num_domains;
> +
> +	pmu->regmap =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> "spacemit,apmu");
> +	if (IS_ERR(pmu->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pmu->regmap),
> "failed to get apmu regmap\n");
> +
> +	pmu->domains =3D devm_kcalloc(dev, data->num_domains,
> +				=C2=A0=C2=A0=C2=A0 sizeof(*pmu->domains),
> GFP_KERNEL);
> +	if (!pmu->domains)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < data->num_domains; i++) {
> +		err =3D spacemit_pm_add_one_domain(pmu, i, &data-
> >param[i]);
> +		if (err) {
> +			dev_err(dev, "failed to add domain %d:
> %d\n", i, err);
> +			goto err_out;
> +		}
> +	}
> +
> +	pmu->genpd_data.domains=C2=A0=C2=A0=C2=A0=C2=A0 =3D (struct generic_pm_=
domain
> **)pmu->domains;
> +	pmu->genpd_data.num_domains =3D data->num_domains;
> +
> +	err =3D of_genpd_add_provider_onecell(dev->of_node, &pmu-
> >genpd_data);
> +	if (err) {
> +		dev_err(dev, "failed to add provider: %d\n", err);
> +		goto err_out;
> +	}
> +
> +	gpmu =3D pmu;
> +
> +	return 0;
> +
> +err_out:
> +	spacemit_pm_domain_cleanup(pmu);
> +	return err;
> +}
> +
> +static const struct spacemit_pm_domain_param k1_domain_params[] =3D {
> +	[K1_PMDOMAIN_VPU] =3D {
> +		.reg_pwr_ctrl		=3D 0xa8,
> +		.bit_sleep2		=3D 3,
> +		.bit_sleep1		=3D 2,
> +		.bit_isolation		=3D 1,
> +		.bit_pwr_stat		=3D 1,
> +		.bit_hw_pwr_stat	=3D 9,
> +		.name			=3D "vpu",
> +	},
> +	[K1_PMDOMAIN_GPU] =3D {
> +		.reg_pwr_ctrl		=3D 0xd0,
> +		.bit_sleep2		=3D 3,
> +		.bit_sleep1		=3D 2,
> +		.bit_isolation		=3D 1,
> +		.bit_pwr_stat		=3D 0,
> +		.name			=3D "gpu",
> +	},
> +	[K1_PMDOMAIN_LCD] =3D {
> +		.reg_pwr_ctrl		=3D 0x380,
> +		.bit_hw_mode		=3D 4,
> +		.bit_sleep2		=3D 3,
> +		.bit_sleep1		=3D 2,
> +		.bit_isolation		=3D 1,
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_pwr_stat		=3D 4,
> +		.bit_hw_pwr_stat	=3D 12,
> +		.use_hw			=3D 1,
> +		.name			=3D "lcd",
> +	},
> +	[K1_PMDOMAIN_ISP] =3D {
> +		.reg_pwr_ctrl		=3D 0x37c,
> +		.bit_hw_mode		=3D 4,
> +		.bit_sleep2		=3D 3,
> +		.bit_sleep1		=3D 2,
> +		.bit_isolation		=3D 1,
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_pwr_stat		=3D 2,
> +		.bit_hw_pwr_stat	=3D 10,
> +		.name			=3D "isp",
> +	},
> +	[K1_PMDOMAIN_AUDIO] =3D {
> +		.reg_pwr_ctrl		=3D 0x378,
> +		.bit_hw_mode		=3D 4,
> +		.bit_sleep2		=3D 3,
> +		.bit_sleep1		=3D 2,
> +		.bit_isolation		=3D 1,
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_pwr_stat		=3D 3,
> +		.bit_hw_pwr_stat	=3D 11,
> +		.use_hw			=3D 1,
> +		.name			=3D "audio",
> +	},
> +	[K1_PMDOMAIN_GNSS] =3D {
> +		.reg_pwr_ctrl		=3D 0x13c,
> +		.bit_hw_mode		=3D 4,
> +		.bit_sleep2		=3D 3,
> +		.bit_sleep1		=3D 2,
> +		.bit_isolation		=3D 1,
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_pwr_stat		=3D 6,
> +		.bit_hw_pwr_stat	=3D 14,
> +		.name			=3D "gnss",
> +	},
> +	[K1_PMDOMAIN_HDMI] =3D {
> +		.reg_pwr_ctrl		=3D 0x3f4,
> +		.bit_hw_mode		=3D 4,
> +		.bit_sleep2		=3D 3,
> +		.bit_sleep1		=3D 2,
> +		.bit_isolation		=3D 1,
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_pwr_stat		=3D 7,
> +		.bit_hw_pwr_stat	=3D 15,
> +		.use_hw			=3D 1,
> +		.name			=3D "hdmi",
> +	},
> +};
> +
> +static const struct spacemit_pm_domain_param k3_domain_params[] =3D {
> +	[K3_PMDOMAIN_VPU] =3D {
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_isolation		=3D 1,
> +		.bit_sleep1		=3D 2,
> +		.bit_sleep2		=3D 3,
> +		.bit_hw_mode		=3D 4,
> +		.bit_pwr_stat		=3D 2,
> +		.bit_hw_pwr_stat	=3D 9,
> +		.use_hw			=3D 1,
> +		.reg_pwr_ctrl		=3D 0xa8,
> +		.name			=3D "vpu",
> +	},
> +	[K3_PMDOMAIN_GPU] =3D {
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_isolation		=3D 1,
> +		.bit_sleep1		=3D 2,
> +		.bit_sleep2		=3D 3,
> +		.bit_hw_mode		=3D 4,
> +		.bit_pwr_stat		=3D 0,
> +		.bit_hw_pwr_stat	=3D 8,
> +		.use_hw			=3D 1,
> +		.reg_pwr_ctrl		=3D 0xd0,
> +		.name			=3D "gpu",
> +	},
> +	[K3_PMDOMAIN_AUDIO] =3D {
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_isolation		=3D 1,
> +		.bit_sleep1		=3D 2,
> +		.bit_sleep2		=3D 3,
> +		.bit_hw_mode		=3D 4,
> +		.bit_pwr_stat		=3D 3,
> +		.reg_pwr_ctrl		=3D 0x378,
> +		.name			=3D "audio",
> +	},
> +	[K3_PMDOMAIN_LCD0] =3D {
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_isolation		=3D 1,
> +		.bit_sleep1		=3D 2,
> +		.bit_sleep2		=3D 3,
> +		.bit_hw_mode		=3D 4,
> +		.bit_pwr_stat		=3D 4,
> +		.bit_hw_pwr_stat	=3D 12,
> +		.use_hw			=3D 1,
> +		.reg_pwr_ctrl		=3D 0x380,
> +		.name			=3D "lcd0",
> +	},
> +	[K3_PMDOMAIN_LCD1] =3D {
> +		.bit_auto_pwr_on	=3D 0,
> +		.bit_isolation		=3D 1,
> +		.bit_sleep1		=3D 2,
> +		.bit_sleep2		=3D 3,
> +		.bit_hw_mode		=3D 4,
> +		.bit_pwr_stat		=3D 5,
> +		.bit_hw_pwr_stat	=3D 15,
> +		.use_hw			=3D 1,
> +		.reg_pwr_ctrl		=3D 0x3f4,
> +		.name			=3D "lcd1",
> +	},
> +};
> +
> +static const struct spacemit_pm_of_data k1_of_data =3D {
> +	.num_domains	=3D ARRAY_SIZE(k1_domain_params),
> +	.param		=3D k1_domain_params,
> +};
> +
> +static const struct spacemit_pm_of_data k3_of_data =3D {
> +	.num_domains	=3D ARRAY_SIZE(k3_domain_params),
> +	.param		=3D k3_domain_params,
> +};
> +
> +static const struct of_device_id spacemit_pm_domain_dt_match[] =3D {
> +	{
> +		.compatible =3D "spacemit,k1-power-controller",
> +		.data =3D &k1_of_data,
> +	},
> +	{
> +		.compatible =3D "spacemit,k3-power-controller",
> +		.data =3D &k3_of_data,
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver spacemit_pm_domain_driver =3D {
> +	.probe =3D spacemit_pm_domain_probe,
> +	.driver =3D {
> +		.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"spacemit-pm-domain",
> +		.of_match_table =3D spacemit_pm_domain_dt_match,
> +	},
> +};
> +
> +builtin_platform_driver(spacemit_pm_domain_driver);
> +MODULE_DESCRIPTION("SpacemiT Generic Power Domains driver");
> +MODULE_LICENSE("GPL");
