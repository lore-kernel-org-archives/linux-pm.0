Return-Path: <SRS0=kGmN=SL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7087C10F0E
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 22:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A8420857
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554849899;
	bh=OqhEf3UB+0oMYRCjm5+7/ZwXufYoizBSjFKPxSfILI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WPi+xe+aGh7t7k67REmhj1sgC/JclNkAWMw2ySGHYM+z8NyofeqWJxQwwpUuMrnfn
	 KYN5/Vuy/gA4AkeiD/3tDMerXnq4MA/T+LMmcQ/nx7C2vHoMToDuuPVByNcNn8zLUt
	 sodL5MGjC8QI+sBY7zQmXKlD9JbBrou3UH5CYxTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDIWo6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfDIWo6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Apr 2019 18:44:58 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC4820820;
        Tue,  9 Apr 2019 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554849897;
        bh=OqhEf3UB+0oMYRCjm5+7/ZwXufYoizBSjFKPxSfILI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6kj+OFk1FtJDSV8rIbIPWnCfmuBVkWc7aie7qUnnkXQQQrrs02Yd9YG7V/6b9r9D
         8HaXO269K1VjlP8+jX7n1rdszVcwBQ8EAyZCBxQPnLZG3qVBjt4q5nLFSGe/m/0n68
         rivZ/uANeCG+5DBJ60vUGNdZlBg/FArqfiEGWRw8=
Received: by earth.universe (Postfix, from userid 1000)
        id 2B76D3C08D4; Wed, 10 Apr 2019 00:44:54 +0200 (CEST)
Date:   Wed, 10 Apr 2019 00:44:54 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     michael.hennerich@analog.com
Cc:     mike.looijmans@topic.nl, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        robin.getz@analog.com
Subject: Re: [PATCH v3 1/2] power: supply: ltc3651-charger: Fix device name
Message-ID: <20190409224454.gbz5cn7vsylucyls@earth.universe>
References: <1554791081-10950-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qal5jvmuwiddl6s4"
Content-Disposition: inline
In-Reply-To: <1554791081-10950-1-git-send-email-michael.hennerich@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qal5jvmuwiddl6s4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 09, 2019 at 08:24:40AM +0200, michael.hennerich@analog.com wrot=
e:
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> There never was a device called LTC3651, it always was just LT3651.
> This circumstance makes it pretty difficult to identify what this
> driver is meant to control.channges since
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>=20
> ---

Thanks, queued.

-- Sebastian

> Changes in v2:
>  - Mark erroneous compatible strings as deprecated
>  - Change patch title
>  - Rename all occurrences of ltc3651
>  - Rename kconfig name
>  - Rename files
>=20
> Changes in v3:
>  - Regenerate patchset with rename detection
> ---
>  .../bindings/power/supply/ltc3651-charger.txt      |  10 +-
>  drivers/power/supply/Kconfig                       |   8 +-
>  drivers/power/supply/Makefile                      |   2 +-
>  drivers/power/supply/ltc3651-charger.c             | 123 ++++++++++-----=
------
>  4 files changed, 71 insertions(+), 72 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charg=
er.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> index 71f2840..40811ff 100644
> --- a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> @@ -1,14 +1,16 @@
> -ltc3651-charger
> +Analog Devices LT3651 Charger Power Supply bindings: lt3651-charger
> =20
>  Required properties:
> - - compatible: "lltc,ltc3651-charger"
> +- compatible: Should contain one of the following:
> + * "lltc,ltc3651-charger", (DEPRECATED: Use "lltc,lt3651-charger")
> + * "lltc,lt3651-charger"
>   - lltc,acpr-gpios: Connect to ACPR output. See remark below.
> =20
>  Optional properties:
>   - lltc,fault-gpios: Connect to FAULT output. See remark below.
>   - lltc,chrg-gpios: Connect to CHRG output. See remark below.
> =20
> -The ltc3651 outputs are open-drain type and active low. The driver assum=
es the
> +The lt3651 outputs are open-drain type and active low. The driver assume=
s the
>  GPIO reports "active" when the output is asserted, so if the pins have b=
een
>  connected directly, the GPIO flags should be set to active low also.
> =20
> @@ -20,7 +22,7 @@ attributes to detect changes.
>  Example:
> =20
>  	charger: battery-charger {
> -		compatible =3D "lltc,ltc3651-charger";
> +		compatible =3D "lltc,lt3651-charger";
>  		lltc,acpr-gpios =3D <&gpio0 68 GPIO_ACTIVE_LOW>;
>  		lltc,fault-gpios =3D <&gpio0 64 GPIO_ACTIVE_LOW>;
>  		lltc,chrg-gpios =3D <&gpio0 63 GPIO_ACTIVE_LOW>;
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879..e907521 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -475,12 +475,12 @@ config CHARGER_MANAGER
>            runtime and in suspend-to-RAM by waking up the system periodic=
ally
>            with help of suspend_again support.
> =20
> -config CHARGER_LTC3651
> -	tristate "LTC3651 charger"
> +config CHARGER_LT3651
> +	tristate "Analog Devices LT3651 charger"
>  	depends on GPIOLIB
>  	help
> -	  Say Y to include support for the LTC3651 battery charger which reports
> -	  its status via GPIO lines.
> +	  Say Y to include support for the Analog Devices (Linear Technology)
> +	  LT3651 battery charger which reports its status via GPIO lines.
> =20
>  config CHARGER_MAX14577
>  	tristate "Maxim MAX14577/77836 battery charger driver"
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b731c2a..714c602 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -67,7 +67,7 @@ obj-$(CONFIG_CHARGER_LP8727)	+=3D lp8727_charger.o
>  obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
>  obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
>  obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
> -obj-$(CONFIG_CHARGER_LTC3651)	+=3D ltc3651-charger.o
> +obj-$(CONFIG_CHARGER_LT3651)	+=3D ltc3651-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/suppl=
y/ltc3651-charger.c
> index eea63ff..8de500f 100644
> --- a/drivers/power/supply/ltc3651-charger.c
> +++ b/drivers/power/supply/ltc3651-charger.c
> @@ -1,11 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
> + *  Driver for Analog Devices (Linear Technology) LT3651 charger IC.
>   *  Copyright (C) 2017, Topic Embedded Products
> - *  Driver for LTC3651 charger IC.
> - *
> - *  This program is free software; you can redistribute it and/or modify=
 it
> - *  under  the terms of the GNU General  Public License as published by =
the
> - *  Free Software Foundation;  either version 2 of the License, or (at y=
our
> - *  option) any later version.
>   */
> =20
>  #include <linux/device.h>
> @@ -19,7 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
> =20
> -struct ltc3651_charger {
> +struct lt3651_charger {
>  	struct power_supply *charger;
>  	struct power_supply_desc charger_desc;
>  	struct gpio_desc *acpr_gpio;
> @@ -27,7 +23,7 @@ struct ltc3651_charger {
>  	struct gpio_desc *chrg_gpio;
>  };
> =20
> -static irqreturn_t ltc3651_charger_irq(int irq, void *devid)
> +static irqreturn_t lt3651_charger_irq(int irq, void *devid)
>  {
>  	struct power_supply *charger =3D devid;
> =20
> @@ -36,37 +32,37 @@ static irqreturn_t ltc3651_charger_irq(int irq, void =
*devid)
>  	return IRQ_HANDLED;
>  }
> =20
> -static inline struct ltc3651_charger *psy_to_ltc3651_charger(
> +static inline struct lt3651_charger *psy_to_lt3651_charger(
>  	struct power_supply *psy)
>  {
>  	return power_supply_get_drvdata(psy);
>  }
> =20
> -static int ltc3651_charger_get_property(struct power_supply *psy,
> +static int lt3651_charger_get_property(struct power_supply *psy,
>  		enum power_supply_property psp, union power_supply_propval *val)
>  {
> -	struct ltc3651_charger *ltc3651_charger =3D psy_to_ltc3651_charger(psy);
> +	struct lt3651_charger *lt3651_charger =3D psy_to_lt3651_charger(psy);
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
> -		if (!ltc3651_charger->chrg_gpio) {
> +		if (!lt3651_charger->chrg_gpio) {
>  			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>  			break;
>  		}
> -		if (gpiod_get_value(ltc3651_charger->chrg_gpio))
> +		if (gpiod_get_value(lt3651_charger->chrg_gpio))
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  		else
>  			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		break;
>  	case POWER_SUPPLY_PROP_ONLINE:
> -		val->intval =3D gpiod_get_value(ltc3651_charger->acpr_gpio);
> +		val->intval =3D gpiod_get_value(lt3651_charger->acpr_gpio);
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		if (!ltc3651_charger->fault_gpio) {
> +		if (!lt3651_charger->fault_gpio) {
>  			val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
>  			break;
>  		}
> -		if (!gpiod_get_value(ltc3651_charger->fault_gpio)) {
> +		if (!gpiod_get_value(lt3651_charger->fault_gpio)) {
>  			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
>  			break;
>  		}
> @@ -74,11 +70,11 @@ static int ltc3651_charger_get_property(struct power_=
supply *psy,
>  		 * If the fault pin is active, the chrg pin explains the type
>  		 * of failure.
>  		 */
> -		if (!ltc3651_charger->chrg_gpio) {
> +		if (!lt3651_charger->chrg_gpio) {
>  			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>  			break;
>  		}
> -		val->intval =3D gpiod_get_value(ltc3651_charger->chrg_gpio) ?
> +		val->intval =3D gpiod_get_value(lt3651_charger->chrg_gpio) ?
>  				POWER_SUPPLY_HEALTH_OVERHEAT :
>  				POWER_SUPPLY_HEALTH_DEAD;
>  		break;
> @@ -89,59 +85,59 @@ static int ltc3651_charger_get_property(struct power_=
supply *psy,
>  	return 0;
>  }
> =20
> -static enum power_supply_property ltc3651_charger_properties[] =3D {
> +static enum power_supply_property lt3651_charger_properties[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_HEALTH,
>  };
> =20
> -static int ltc3651_charger_probe(struct platform_device *pdev)
> +static int lt3651_charger_probe(struct platform_device *pdev)
>  {
>  	struct power_supply_config psy_cfg =3D {};
> -	struct ltc3651_charger *ltc3651_charger;
> +	struct lt3651_charger *lt3651_charger;
>  	struct power_supply_desc *charger_desc;
>  	int ret;
> =20
> -	ltc3651_charger =3D devm_kzalloc(&pdev->dev, sizeof(*ltc3651_charger),
> +	lt3651_charger =3D devm_kzalloc(&pdev->dev, sizeof(*lt3651_charger),
>  					GFP_KERNEL);
> -	if (!ltc3651_charger)
> +	if (!lt3651_charger)
>  		return -ENOMEM;
> =20
> -	ltc3651_charger->acpr_gpio =3D devm_gpiod_get(&pdev->dev,
> +	lt3651_charger->acpr_gpio =3D devm_gpiod_get(&pdev->dev,
>  					"lltc,acpr", GPIOD_IN);
> -	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
> -		ret =3D PTR_ERR(ltc3651_charger->acpr_gpio);
> +	if (IS_ERR(lt3651_charger->acpr_gpio)) {
> +		ret =3D PTR_ERR(lt3651_charger->acpr_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
>  		return ret;
>  	}
> -	ltc3651_charger->fault_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +	lt3651_charger->fault_gpio =3D devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,fault", GPIOD_IN);
> -	if (IS_ERR(ltc3651_charger->fault_gpio)) {
> -		ret =3D PTR_ERR(ltc3651_charger->fault_gpio);
> +	if (IS_ERR(lt3651_charger->fault_gpio)) {
> +		ret =3D PTR_ERR(lt3651_charger->fault_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
>  		return ret;
>  	}
> -	ltc3651_charger->chrg_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +	lt3651_charger->chrg_gpio =3D devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,chrg", GPIOD_IN);
> -	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
> -		ret =3D PTR_ERR(ltc3651_charger->chrg_gpio);
> +	if (IS_ERR(lt3651_charger->chrg_gpio)) {
> +		ret =3D PTR_ERR(lt3651_charger->chrg_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
>  		return ret;
>  	}
> =20
> -	charger_desc =3D &ltc3651_charger->charger_desc;
> +	charger_desc =3D &lt3651_charger->charger_desc;
>  	charger_desc->name =3D pdev->dev.of_node->name;
>  	charger_desc->type =3D POWER_SUPPLY_TYPE_MAINS;
> -	charger_desc->properties =3D ltc3651_charger_properties;
> -	charger_desc->num_properties =3D ARRAY_SIZE(ltc3651_charger_properties);
> -	charger_desc->get_property =3D ltc3651_charger_get_property;
> +	charger_desc->properties =3D lt3651_charger_properties;
> +	charger_desc->num_properties =3D ARRAY_SIZE(lt3651_charger_properties);
> +	charger_desc->get_property =3D lt3651_charger_get_property;
>  	psy_cfg.of_node =3D pdev->dev.of_node;
> -	psy_cfg.drv_data =3D ltc3651_charger;
> +	psy_cfg.drv_data =3D lt3651_charger;
> =20
> -	ltc3651_charger->charger =3D devm_power_supply_register(&pdev->dev,
> +	lt3651_charger->charger =3D devm_power_supply_register(&pdev->dev,
>  						      charger_desc, &psy_cfg);
> -	if (IS_ERR(ltc3651_charger->charger)) {
> -		ret =3D PTR_ERR(ltc3651_charger->charger);
> +	if (IS_ERR(lt3651_charger->charger)) {
> +		ret =3D PTR_ERR(lt3651_charger->charger);
>  		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
>  			ret);
>  		return ret;
> @@ -152,59 +148,60 @@ static int ltc3651_charger_probe(struct platform_de=
vice *pdev)
>  	 * support IRQs on these pins, userspace will have to poll the sysfs
>  	 * files manually.
>  	 */
> -	if (ltc3651_charger->acpr_gpio) {
> -		ret =3D gpiod_to_irq(ltc3651_charger->acpr_gpio);
> +	if (lt3651_charger->acpr_gpio) {
> +		ret =3D gpiod_to_irq(lt3651_charger->acpr_gpio);
>  		if (ret >=3D 0)
>  			ret =3D devm_request_any_context_irq(&pdev->dev, ret,
> -				ltc3651_charger_irq,
> +				lt3651_charger_irq,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -				dev_name(&pdev->dev), ltc3651_charger->charger);
> +				dev_name(&pdev->dev), lt3651_charger->charger);
>  		if (ret < 0)
>  			dev_warn(&pdev->dev, "Failed to request acpr irq\n");
>  	}
> -	if (ltc3651_charger->fault_gpio) {
> -		ret =3D gpiod_to_irq(ltc3651_charger->fault_gpio);
> +	if (lt3651_charger->fault_gpio) {
> +		ret =3D gpiod_to_irq(lt3651_charger->fault_gpio);
>  		if (ret >=3D 0)
>  			ret =3D devm_request_any_context_irq(&pdev->dev, ret,
> -				ltc3651_charger_irq,
> +				lt3651_charger_irq,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -				dev_name(&pdev->dev), ltc3651_charger->charger);
> +				dev_name(&pdev->dev), lt3651_charger->charger);
>  		if (ret < 0)
>  			dev_warn(&pdev->dev, "Failed to request fault irq\n");
>  	}
> -	if (ltc3651_charger->chrg_gpio) {
> -		ret =3D gpiod_to_irq(ltc3651_charger->chrg_gpio);
> +	if (lt3651_charger->chrg_gpio) {
> +		ret =3D gpiod_to_irq(lt3651_charger->chrg_gpio);
>  		if (ret >=3D 0)
>  			ret =3D devm_request_any_context_irq(&pdev->dev, ret,
> -				ltc3651_charger_irq,
> +				lt3651_charger_irq,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -				dev_name(&pdev->dev), ltc3651_charger->charger);
> +				dev_name(&pdev->dev), lt3651_charger->charger);
>  		if (ret < 0)
>  			dev_warn(&pdev->dev, "Failed to request chrg irq\n");
>  	}
> =20
> -	platform_set_drvdata(pdev, ltc3651_charger);
> +	platform_set_drvdata(pdev, lt3651_charger);
> =20
>  	return 0;
>  }
> =20
> -static const struct of_device_id ltc3651_charger_match[] =3D {
> -	{ .compatible =3D "lltc,ltc3651-charger" },
> +static const struct of_device_id lt3651_charger_match[] =3D {
> +	{ .compatible =3D "lltc,ltc3651-charger" }, /* DEPRECATED */
> +	{ .compatible =3D "lltc,lt3651-charger" },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
> +MODULE_DEVICE_TABLE(of, lt3651_charger_match);
> =20
> -static struct platform_driver ltc3651_charger_driver =3D {
> -	.probe =3D ltc3651_charger_probe,
> +static struct platform_driver lt3651_charger_driver =3D {
> +	.probe =3D lt3651_charger_probe,
>  	.driver =3D {
> -		.name =3D "ltc3651-charger",
> -		.of_match_table =3D ltc3651_charger_match,
> +		.name =3D "lt3651-charger",
> +		.of_match_table =3D lt3651_charger_match,
>  	},
>  };
> =20
> -module_platform_driver(ltc3651_charger_driver);
> +module_platform_driver(lt3651_charger_driver);
> =20
>  MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> -MODULE_DESCRIPTION("Driver for LTC3651 charger");
> +MODULE_DESCRIPTION("Driver for LT3651 charger");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:ltc3651-charger");
> +MODULE_ALIAS("platform:lt3651-charger");
> --=20
> 2.7.4
>=20

--qal5jvmuwiddl6s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlytIGAACgkQ2O7X88g7
+ppXig//bMX9eo4niax0f9YlWPpNXOXxZSfPeIGeEjBiPdpmZsS9DNOesvmEiKXn
+9YtQF9ZQJnnOjbAk4OUMfhiEcux+oj1E+MxkMvpS+9by/UREJZccfqxDalYbm0D
cXKGxly2EUVmupcU5m8G8hTn0dcqXwGE4L/DUFdNEDDmgexxwZCr2KPQbs5KYiSi
T+pJVNoQ7yhRRaUNbIqRzUhHYOKdTTD85Wsg7sng8yCwk7T+uGqEZHRxh9lPnOZx
zzWhg7CUBo+MZeTEHPaKl1UWDf3+W0ehKsMJJV8juJhkGTrgz8XXNzk0k9dWY+r+
18+IM/uzwrsyDx+doNSKexqc6D5YUm87Tl4dWv4dIb77qOIqig/F31JksE4Bq8ec
zXjKV1uAQL1eZI6dKXbvdEglarDJ0k3Yotq1v78JZ8i3mZUjpla/mEdV/7hPAISO
PsZWzJQbi6QkkpvNcQEYO8L9fFVXT3qLkbmNhsITiFJUjh7S7j0gFT5PneAi6PdY
JmQpm069A/aWHTqAXkrt3CCWnqJ8P+GIUc6LgLFHAkuslsIlu8Io+kQSkS8EAdMH
h/RtfqywHnan0ucBV8EaZTryT99CyqQvmJTKUZw2dTtKyXCxTJaZSjHBQd7SEKi/
tFIFNp5MGaL2p4vSBc37CGUVJ3fVGebaTlxuTNPV3cu+gT+XH2Y=
=8ooT
-----END PGP SIGNATURE-----

--qal5jvmuwiddl6s4--
