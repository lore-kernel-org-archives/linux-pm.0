Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD436167B;
	Fri, 18 Sep 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722065; cv=pass; b=e9aCWcYaiXOXradAXT8nstoteltyK0MWJOtjUAJMr3k74af7N1wAWoc1Mgb+DbUZi3DTVI/rmR8U+UxGc0/w+Qb9BWnb5+2I21/MYPuX0eAwKdwTiWUFwRQAr/EYXZbQU8Tv893rvSZxEyRZlULnzEw8pMR1Prlm768bhTSuB0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722065; c=relaxed/simple;
	bh=/d0SKhnC8hr5GRW42c3XVaWi18HMqbdYu72djCO1SXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COvdAgsMNxOZEXhyM1f3Io4wOlAMgYvKHiNoxI9r4xBqIOS4k+TInyI1wbhcKpoHQhEhro38yV00H1zLI5ut9qHVV+BtwOSbsdAnj0m0bWeHrGarlmhR38HgJM9tV9S/NR8b4qIgOXcFdJ1ntQL8pXgDBnZI4Ok24nekmMQFisY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=MhdgnxWJ; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="MhdgnxWJ"
ARC-Seal: i=1; a=rsa-sha256; t=1789722014; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TSUYg1tsIlaR0q1oqihzK+5VecJZfnQR7o8ty+dhNbm3rCbcGiFUi6r6fk/iFGLrVqB7JXvBhAMNqtdmekfn+5sYVDo+DoY68az6k1+ef61dxBTFu43UaKnQW7eRqWIcsiO0zwIYTMFt2KlLrSi+QpyI8Pts4CIbr3J7I3cDbz0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789722014; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tKU5PGY3GjfsKNtM9294AKz3n+ep9Fo8PM/k6/HdFSg=; 
	b=l+RfpEKASI2aT9JMs1vWAn0oLRtUAKk2B62ROZ4L8EjUKHg+6JW1f1mEq0q9S5/6D6A5z3VSV+dacaFTbHAfQxCO+67iiFjhI+FuC0B2qJyUYCpawpeQ3DCc4/fYwg21P12APhKdg3ZAfe9ZnkE0usg1iiZ7r8UiUVv0lf7CChg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789722014;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=tKU5PGY3GjfsKNtM9294AKz3n+ep9Fo8PM/k6/HdFSg=;
	b=MhdgnxWJLLHyAjllDb4hNfNGca5J6WUaxWA5WilLugsrtpnlNwul8oqTSku0SMRD
	0JOLPwRNKU8cS+afIbIp0Cpw3+eJXRZcsegHd8XrmpsTVXcidrBvajSd1Yj4dUlsx4l
	D0yj6fsV/QHKAVsqDNfytnorl5T4FHO1tFCVe/H/ucZzSQLOyTiYAySzdo5bHrY2w73
	4P3LHbLmVnCuDlxZ8dAclsDDEqog3HfQiCMuW+OYiOHHCW524+7v1FYsFM3noe6FDI+
	LwEP0AhiOe82TkmpbF1MR1t7jpZ3SqjT8OQ+6NE5AieZa+r3FUJKgsZVqEf4wCviOsf
	DOdXNprZpg==
Received: by smtp.zohomail.com with SMTPS id 1789722013037290.91804390297057;
	Fri, 18 Sep 2026 02:00:13 -0700 (PDT)
Message-ID: <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
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
Date: Fri, 18 Sep 2026 17:00:06 +0800
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

I think there also exists solutions for K3 that uses RPMI power
domains, and let their ESOS firmware to access the hardware.

What's the relationship of this implementation with the ESOS
implementation? Should the ESOS part be disabled to use this
implementation?

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
