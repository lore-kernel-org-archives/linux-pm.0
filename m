From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: add poodle battery driver
Date: Mon, 6 Apr 2015 18:44:28 +0200
Message-ID: <20150406164428.GB18145@earth>
References: <1427714679-27472-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38667 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbbDFQo7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Apr 2015 12:44:59 -0400
Content-Disposition: inline
In-Reply-To: <1427714679-27472-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrea Adami <andrea.adami@gmail.com>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

On Mon, Mar 30, 2015 at 02:24:39PM +0300, Dmitry Eremin-Solenikov wrote:
> Add a driver supporting battery charging on Sharp SL-5600 (poodle).
> Voltage and temperature readings are provided through add7846 hwmon
> interface. Battery voltage is in1_input (mV) and temp in in0_input
> (values unknown, but should be less than 2441).

You may want to convert add7846 to iio interface, which can be
exposed via hwmon and requested by other kernel drivers (e.g. this
one).

> [...]
> +struct poodle_bat {
> +	int status;
> +	struct power_supply psy;
> +
> +	struct mutex work_lock; /* protects data */
> +
> +	bool (*is_present)(struct poodle_bat *bat);
> +	int technology;

why do you need this for a static type? You can simply set the type
directly in the get_property function?

> +};

> [...]

> +static struct gpio poodle_batt_gpios[] = {
> +	{ POODLE_GPIO_BAT_COVER,    GPIOF_IN,		"main battery cover" },
> +	{ POODLE_GPIO_CHRG_FULL,    GPIOF_IN,		"main battery full" },
> +	{ POODLE_GPIO_JK_B,	    GPIOF_OUT_INIT_LOW,	"main charge on" },
> +	{ POODLE_GPIO_CHRG_ON,	    GPIOF_OUT_INIT_LOW,	"main charge on" },
> +	{ POODLE_GPIO_BYPASS_ON,    GPIOF_OUT_INIT_LOW,	"main charge bypass" },
> +	/* on for now */
> +	{ POODLE_GPIO_ADC_TEMP_ON,  GPIOF_OUT_INIT_HIGH, "main battery temp" },
> +};

I would prefer if you use the "new" gpiod interface, see
include/linux/gpio/consumer.h

This obviously refers to the whole driver.

> [...]

> +static int poodle_battery_probe(struct platform_device *dev)
> +{
> +	int ret;
> +
> +	ret = gpio_request_array(poodle_batt_gpios,
> +				 ARRAY_SIZE(poodle_batt_gpios));
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&poodle_bat_main.work_lock);
> +
> +	INIT_WORK(&bat_work, poodle_bat_work);
> +
> +	ret = power_supply_register(&dev->dev, &poodle_bat_main.psy);
> +	if (ret)
> +		goto err_psy_reg_main;

we have devm_power_supply_register() now.

> +	ret = devm_request_irq(&dev->dev, gpio_to_irq(POODLE_GPIO_CHRG_FULL),
> +				poodle_bat_gpio_isr,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				"main full", NULL);
> +	if (ret)
> +		goto err_psy_irq;
> +
> +	ret = devm_request_irq(&dev->dev, gpio_to_irq(POODLE_GPIO_BAT_COVER),
> +				poodle_bat_gpio_isr,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				"battery cover", NULL);
> +	if (ret)
> +		goto err_psy_irq;
> +
> +	return 0;
> +
> +err_psy_irq:
> +	power_supply_unregister(&poodle_bat_main.psy);
> +
> +	cancel_work_sync(&bat_work);
> +err_psy_reg_main:
> +	gpio_free_array(poodle_batt_gpios, ARRAY_SIZE(poodle_batt_gpios));
> +
> +	return ret;
> +}

> [...]

-- Sebastian

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVIrfqAAoJENju1/PIO/qaAeAP/36h5qiD1IC9qpTDBRJT3ZJw
NB39vhY9o6opQE1dAHEmjxH+plHqO1imHxBqkCZ3aonZzyIpSEdPor3JgHpRrOyW
/0SrWO9WGjnDwWzgFu+Z649QyfxT4R8PTwAkdl4Um5cKd1ysiz2QUq8i4zpVQkp/
dCsObNatutqtsXPekuiyNQzIEkr2NUBnvFMv+zIUi1eYRIiANilKzagCfbT/wykJ
Bg4o60dJbkoHTzOOTm8wNIAJjG+5JqrLhl2rDDIuw/zuiwEKkXtRL/I2DaqvwRiW
U03p2r0MXHJg0uhXA9+XRl5tb8o2z9YVXk1VRfM+rUYJP7NsZgRJ1E+wIXLTKXs3
F+KVW/OC9qZtjRVKB+em53FxKn++n3/aCjmlAKKCPuUtI+RXpQ8N9QHenY7igTbl
32ewOSjiGZscVRjhQx4YyylsYnTRqUMsgVvS6sfsa1hnPb0tTSMQQ84JdcgtmVYw
68Kqh88angKaFiLWUkD+qdiLcfC43JIcvaSRcR7E5RWx670KmpTl8+npnBF4EJAW
6LIwj8Z+LQXpJ5ELjkNZOAcPEIxKF5OkTxxqG/ce/mleNvj7Sw+Egmt8knjr3+Fu
tnLoshJ2N8KgHFucNLDyM8gRFz5/B6TsHhGfjod/5Xm3DgzSnd+1wV1+r7gZ86iI
Dea68BsbYwfx3an+F7dh
=7NMa
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
