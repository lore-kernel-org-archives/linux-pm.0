Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34A455633
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551006; cv=none; b=RDYjS1+WmZ4YVGbkTHi7DLDlUFef7T5E+3SO6JvtY6mEYXbSAlijG+nVLXdKjhuEZLd7tW2t/kI1ddxk9bg6yRe1d+JJrtOvn6By4yn88zb/dEuT1BY1w2lrl7Sin2jMBvNLyGsbWFyfHtIjoAkhrBEjMxwIJHdcJxykTEGVrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551006; c=relaxed/simple;
	bh=KcHEfI9rixpKBPc2Zf2uhft6io/djkgQNFyeA0Lvo8Q=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5EZoeiCSAlPp584Q/IjGeQ9vYx51v6SrwDulhJGc2A9DoqWQIOKvRLAINicGmPic1OQSr6z3Mi/9xw7wu+lU3gPZlSyCUl1vbKM+ATiVjziGM0udu4eqeD7ESJb1pu8xWWrDZTTI5W3m8ZskbXSVv/UlvLal5oauF2PPWTAFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXGN6Q6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXGN6Q6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6FB1F00921
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789550993;
	bh=HbNOQo+fITL/YezhDRnlIYKOUp70KJL8OxpPSgtnAR4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=RXGN6Q6OG3ZqmOA+EqOmYMjzyXsouT9/duqse6VVDy6txHKqr4rsi+IwqT7Nbrz47
	 k8Z51jWHxL/XUhmUR7t+S3foO9mlS/tSggJOpQVFfcHqXbWS8CpBwCWxmcACeDF2aj
	 BxpkRO7bmpj1nhb4WegvhExiNrSZqAnhu0H3xjIBcZ2dzHV6+ceLNSmsoGa/aEjwKD
	 OgoAUxAUzLHvJjUOF9Tbh1Ox/3/knMWDyVQT600LmsSKHRFcZZFAgL1BSh+RJrSl7I
	 om2+u+TJVVTY7GeNqPDsgFptzqcmTTynlhkkxA1JfsslXkuVOGr50PDDnKikS1vCh1
	 Dazs1KLksmMIA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a30521ef15so5273581fa.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 02:29:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwe3JUFup8TfKecLppOSkJa9Cnx7w8sEplF0ZGPGzO4QcAoNujDQNiykg/wsmrGVHsBJJUe0bVl4Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kpb8LV12XMo0KE/IuNzNWRL2Z6J3/DMxJjXvZLGJZY65FSmnoi
	HXFAMroGjZV2feQBYP2E8oMqVSCYVrBXQpFf5cGobwPGnARS5bj/AIgEtbcu+s//aDq+xPaqBs9
	O6j0egW3Nq0gD2QqUU7b9VxtSKrIV4pk5jAHG9lY3TQ==
X-Received: by 2002:a05:651c:2107:b0:3a5:a106:ee0 with SMTP id
 38308e7fff4ca-3a5dca17909mr3885151fa.24.1789550992173; Wed, 16 Sep 2026
 02:29:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 04:29:50 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 04:29:50 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260914-arm-psci-system_reset2-vendor-reboots-v25-4-4aaf5c09b5c2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
 <20260914-arm-psci-system_reset2-vendor-reboots-v25-4-4aaf5c09b5c2@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 04:29:50 -0500
X-Gmail-Original-Message-ID: <CAMRc=MdCWHQZ+CgW05jYA1GGJdMUwKJEBAiAvRCvx=UqvjLiUg@mail.gmail.com>
X-Gm-Features: AcwNN1XQMfOQSPN80c7M_tcu2-hP7ZzKFwZrSM1EUb4ujYz2zvehzw9bQteJEXc
Message-ID: <CAMRc=MdCWHQZ+CgW05jYA1GGJdMUwKJEBAiAvRCvx=UqvjLiUg@mail.gmail.com>
Subject: Re: [PATCH v25 04/10] firmware: psci: Add support for PSCI auxiliary devices
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>, 
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sep 2026 16:59:08 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
> Currently, both the PSCI core driver and cpuidle-psci-domain bind
> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
> introduced, would also need to bind in the same way, leading to multiple
> drivers attached to a single device node.
>
> Introduce a PSCI auxiliary-device provider that binds to "arm,psci-1.0"
> and registers PSCI child devices on the auxiliary bus. As the first
> user, register cpuidle-psci-domain as an auxiliary device.
>
> Update cpuidle-psci-domain to probe as an auxiliary driver and use
> the PSCI device node for power-domain traversal.
>
> Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Suggested-by: Lee Jones <lee@kernel.org>
> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  MAINTAINERS                           |  1 +
>  drivers/cpuidle/Kconfig.arm           |  1 +
>  drivers/cpuidle/cpuidle-psci-domain.c | 31 +++++++++++++++-----------
>  drivers/firmware/psci/Kconfig         | 14 ++++++++++++
>  drivers/firmware/psci/Makefile        |  1 +
>  drivers/firmware/psci/psci-devices.c  | 41 +++++++++++++++++++++++++++++++++++
>  6 files changed, 76 insertions(+), 13 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 207a6e2db70c..9c0334ee2ed2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21932,6 +21932,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/psci.yaml
>  F:	drivers/firmware/psci/
> +F:	drivers/firmware/psci/psci-devices.c
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index b88b01aa5829..f22e18b05053 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -36,6 +36,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
>  	bool "PSCI CPU idle Domain"
>  	depends on ARM_PSCI_CPUIDLE
>  	depends on PM_GENERIC_DOMAINS_OF
> +	depends on ARM_PSCI_DEVICES
>  	select DT_IDLE_GENPD
>  	default y
>  	help
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b9e4ad7d43a3..0ce6a83f6588 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -9,10 +9,11 @@
>
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>
> +#include <linux/auxiliary_bus.h>
>  #include <linux/cpu.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/platform_device.h>
> +#include <linux/module.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/psci.h>
> @@ -122,14 +123,10 @@ static void psci_pd_remove(void)
>  	}
>  }
>
> -static const struct of_device_id psci_of_match[] = {
> -	{ .compatible = "arm,psci-1.0" },
> -	{}
> -};
> -
> -static int psci_cpuidle_domain_probe(struct platform_device *pdev)
> +static int psci_cpuidle_domain_probe(struct auxiliary_device *auxdev,
> +				     const struct auxiliary_device_id *id)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = auxdev->dev.of_node;
>  	bool use_osi = psci_has_osi_support();
>  	int ret = 0, pd_count = 0;
>
> @@ -177,16 +174,24 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  	return ret;
>  }
>
> -static struct platform_driver psci_cpuidle_domain_driver = {
> -	.probe  = psci_cpuidle_domain_probe,
> +static const struct auxiliary_device_id psci_cpuidle_domain_id_table[] = {
> +	{ .name = "arm-psci.psci-cpuidle-domain" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, psci_cpuidle_domain_id_table);
> +
> +static struct auxiliary_driver psci_cpuidle_domain_driver = {
> +	.probe = psci_cpuidle_domain_probe,
>  	.driver = {
> -		.name = "psci-cpuidle-domain",
> -		.of_match_table = psci_of_match,
> +		.suppress_bind_attrs = true,
>  	},
> +	.id_table = psci_cpuidle_domain_id_table,
>  };
>
>  static int __init psci_idle_init_domains(void)
>  {
> -	return platform_driver_register(&psci_cpuidle_domain_driver);
> +	return __auxiliary_driver_register(&psci_cpuidle_domain_driver,
> +					   THIS_MODULE,
> +					   "psci-cpuidle-domain");
>  }
>  core_initcall(psci_idle_init_domains);
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> index 97944168b5e6..68e381f1a618 100644
> --- a/drivers/firmware/psci/Kconfig
> +++ b/drivers/firmware/psci/Kconfig
> @@ -2,6 +2,20 @@
>  config ARM_PSCI_FW
>  	bool
>
> +config ARM_PSCI_DEVICES
> +	bool "PSCI auxiliary device support"
> +	depends on ARM_PSCI_FW
> +	depends on OF
> +	select AUXILIARY_BUS
> +	default y
> +	help
> +	  Say Y here to enable auxiliary device support for PSCI.
> +
> +	  This creates auxiliary devices for PSCI functionality implemented
> +	  outside the core PSCI firmware driver. These devices allow PSCI
> +	  child drivers to bind through the auxiliary bus while sharing the
> +	  PSCI firmware device as their parent.
> +
>  config ARM_PSCI_CHECKER
>  	bool "ARM PSCI checker"
>  	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> index 1956b882470f..8e75a0ed6f74 100644
> --- a/drivers/firmware/psci/Makefile
> +++ b/drivers/firmware/psci/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> +obj-$(CONFIG_ARM_PSCI_DEVICES)	+= psci-devices.o
>  obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci/psci-devices.c
> new file mode 100644
> index 000000000000..f1eca61e3269
> --- /dev/null
> +++ b/drivers/firmware/psci/psci-devices.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/init.h>

I think you need module.h not init.h.

> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static int arm_psci_probe(struct platform_device *pdev)
> +{
> +	struct auxiliary_device *auxdev;
> +
> +	auxdev = __devm_auxiliary_device_create(&pdev->dev, "arm-psci",
> +						"psci-cpuidle-domain", NULL, 0);
> +	if (!auxdev)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

I would prefer you to move the code between the patches a bit. This patch
should already be introducing the full, future-proof infrastructure for
registering multiple auxiliary devices, so maybe add a static table with device
info? Then in patch 10/10 you'd just extend it for reboot modes.

I'd also not add any ifdef guards here and lesses the build-time dependencies.
You can register the device alright, it just won't get probed if the reboot-mode
support is not there.

Bart

> +
> +static const struct of_device_id arm_psci_of_match[] = {
> +	{ .compatible = "arm,psci-1.0" },
> +	{ }
> +};
> +
> +static struct platform_driver arm_psci_driver = {
> +	.probe = arm_psci_probe,
> +	.driver = {
> +		.name = "arm-psci",
> +		.of_match_table = arm_psci_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +static int __init arm_psci_init(void)
> +{
> +	return platform_driver_register(&arm_psci_driver);
> +}
> +core_initcall(arm_psci_init);
>
> --
> 2.34.1
>
>
