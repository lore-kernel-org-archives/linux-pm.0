From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4] thermal: Add QPNP PMIC temperature alarm driver
Date: Mon, 2 Feb 2015 14:14:48 -0400
Message-ID: <20150202181446.GE17425@developer.hsd1.ca.comcast.net>
References: <1422890370-6914-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422890370-6914-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ivan,

On Mon, Feb 02, 2015 at 05:19:30PM +0200, Ivan T. Ivanov wrote:
> Add support for the temperature alarm peripheral found inside
> Qualcomm plug-and-play (QPNP) PMIC chips. The temperature alarm
> peripheral outputs a pulse on an interrupt line whenever the
> thermal over temperature stage value changes.
>=20
> Register a thermal sensor. The temperature reported by this thermal
> sensor device should reflect the actual PMIC die temperature if an
> ADC is present on the given PMIC. If no ADC is present, then the
> reported temperature should be estimated from the over temperature
> stage value.
>=20
> Cc: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>=20
> Changes since v3:
>=20
> - Driver register thermal sensor instead thermal zone. Device thermal zone
>   should be properly described in DT files according thermal.txt document.

Thanks a lot for keeping this up. I believe the driver looks smaller and
cleaner now, don't you agree?

> - Dropped support for software override PMIC shutdown sequence and related
>   bit definitions. If software did not take action for clean device shutd=
own,
>   until critical temperature is reached, PMIC chip will execute internal
>   pre-programed shutdown sequence.
>=20

OK. Let me know if this functionality is crucial and needs further
discussion.

I have two very minor comments as follows.


> v3: http://comments.gmane.org/gmane.linux.ports.arm.msm/10071
>=20
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  57 ++++
>  drivers/thermal/Kconfig                            |  11 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/qcom-spmi-temp-alarm.c             | 311 +++++++++++++++=
++++++
>  4 files changed, 380 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-t=
emp-alarm.txt
>  create mode 100644 drivers/thermal/qcom-spmi-temp-alarm.c
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-ala=
rm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> new file mode 100644
> index 0000000..290ec06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> @@ -0,0 +1,57 @@
> +Qualcomm QPNP PMIC Temperature Alarm
> +
> +QPNP temperature alarm peripherals are found inside of Qualcomm PMIC chi=
ps
> +that utilize the Qualcomm SPMI implementation. These peripherals provide=
 an
> +interrupt signal and status register to identify high PMIC die temperatu=
re.
> +
> +Required properties:
> +- compatible:      Should contain "qcom,spmi-temp-alarm".
> +- reg:             Specifies the SPMI address and length of the controll=
er's
> +                   registers.
> +- interrupts:      PMIC temperature alarm interrupt.
> +- #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
> +
> +Optional properties:
> +- io-channels:     Should contain IIO channel specifier for the ADC chan=
nel,
> +                   which report chip die temperature.
> +- io-channel-names: Should contain "thermal".
> +
> +Example:
> +
> +	pm8941_temp: thermal-alarm@2400 {
> +		compatible =3D "qcom,spmi-temp-alarm";
> +		reg =3D <0x2400 0x100>;
> +		interrupts =3D <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
> +		#thermal-sensor-cells =3D <0>;
> +
> +		io-channels =3D <&pm8941_vadc VADC_DIE_TEMP>;
> +		io-channel-names =3D "thermal";
> +	};
> +
> +	thermal-zones {
> +		pm8941 {
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <1000>;
> +
> +			thermal-sensors =3D <&pm8941_temp>;
> +
> +			trips {
> +				passive {
> +					temperature =3D <1050000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				alert {
> +					temperature =3D <125000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};
> +				crit {
> +					temperature =3D <145000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};
> +	};

Do you have the appropriate DT changes under architecture code too?

I mean, I am fine picking these changes, but should this series include
also a minor inclusion under arch/arm/boot/dts too, given that you
already did the hard part?

> +
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index af40db0..30aee81 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -299,4 +299,15 @@ depends on ARCH_STI && OF
>  source "drivers/thermal/st/Kconfig"
>  endmenu
>=20
> +config QCOM_SPMI_TEMP_ALARM
> +	tristate "Qualcomm SPMI PMIC Temperature Alarm"
> +	depends on OF && SPMI && IIO
> +	select REGMAP_SPMI
> +	help
> +	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
> +	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
> +	  trip points. The temperature reported by the thermal sensor reflects =
the
> +	  real time die temperature if an ADC is present or an estimate of the
> +	  temperature based upon the over temperature stage value.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index fa0dc48..1fe8665 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -22,6 +22,7 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+=3D cpu_cooling.o
>  thermal_sys-$(CONFIG_CLOCK_THERMAL)	+=3D clock_cooling.o
>=20
>  # platform thermal drivers
> +obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+=3D qcom-spmi-temp-alarm.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+=3D rockchip_thermal.o
>  obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
> diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qco=
m-spmi-temp-alarm.c
> new file mode 100644
> index 0000000..7215ec7
> --- /dev/null
> +++ b/drivers/thermal/qcom-spmi-temp-alarm.c
> @@ -0,0 +1,311 @@
> +/*
> + * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +
> +#define QPNP_TM_REG_TYPE		0x04
> +#define QPNP_TM_REG_SUBTYPE		0x05
> +#define QPNP_TM_REG_STATUS		0x08
> +#define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
> +#define QPNP_TM_REG_ALARM_CTRL		0x46
> +
> +#define QPNP_TM_TYPE			0x09
> +#define QPNP_TM_SUBTYPE			0x08
> +
> +#define STATUS_STAGE_MASK		0x03
> +
> +#define SHUTDOWN_CTRL1_THRESHOLD_MASK	0x03
> +
> +#define ALARM_CTRL_FORCE_ENABLE		0x80
> +
> +/*
> + * Trip point values based on threshold control
> + * 0 =3D {105 C, 125 C, 145 C}
> + * 1 =3D {110 C, 130 C, 150 C}
> + * 2 =3D {115 C, 135 C, 155 C}
> + * 3 =3D {120 C, 140 C, 160 C}
> +*/
> +#define TEMP_STAGE_STEP			20000	/* Stage step: 20.000 C */
> +#define TEMP_STAGE_HYSTERESIS		2000
> +
> +#define TEMP_THRESH_MIN			105000	/* Threshold Min: 105 C */
> +#define TEMP_THRESH_STEP		5000	/* Threshold step: 5 C */
> +
> +#define THRESH_MIN			0
> +
> +/* Temperature in Milli Celsius reported during stage 0 if no ADC is pre=
sent */
> +#define DEFAULT_TEMP			37000
> +
> +struct qpnp_tm_chip {
> +	struct regmap			*map;
> +	struct thermal_zone_device	*tz_dev;
> +	long				temp;
> +	unsigned int			thresh;
> +	unsigned int			stage;
> +	unsigned int			prev_stage;
> +	unsigned int			base;
> +	struct iio_channel		*adc;
> +};
> +
> +static int qpnp_tm_read(struct qpnp_tm_chip *chip, u16 addr, u8 *data)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(chip->map, chip->base + addr, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	*data =3D val;
> +	return 0;
> +}
> +
> +static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
> +{
> +	return regmap_write(chip->map, chip->base + addr, data);
> +}
> +
> +/*
> + * This function updates the internal temp value based on the
> + * current thermal stage and threshold as well as the previous stage
> + */
> +static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
> +{
> +	unsigned int stage;
> +	int ret;
> +	u8 reg =3D 0;
> +
> +	ret =3D qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	stage =3D reg & STATUS_STAGE_MASK;
> +
> +	if (stage > chip->stage) {
> +		/* increasing stage, use lower bound */
> +		chip->temp =3D (stage - 1) * TEMP_STAGE_STEP +
> +			     chip->thresh * TEMP_THRESH_STEP +
> +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
> +	} else if (stage < chip->stage) {
> +		/* decreasing stage, use upper bound */
> +		chip->temp =3D stage * TEMP_STAGE_STEP +
> +			     chip->thresh * TEMP_THRESH_STEP -
> +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
> +	}

For my own edification, no change in state means no change in
temperature too, right?

> +
> +	chip->stage =3D stage;
> +
> +	return 0;
> +}
> +
> +static int qpnp_tm_get_temp(void *data, long *temp)
> +{
> +	struct qpnp_tm_chip *chip =3D data;
> +	int ret, mili_celsius;
> +
> +	if (!temp)
> +		return -EINVAL;
> +
> +	if (IS_ERR(chip->adc)) {
> +		ret =3D qpnp_tm_update_temp_no_adc(chip);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret =3D iio_read_channel_processed(chip->adc, &mili_celsius);
> +		if (ret < 0)
> +			return ret;
> +
> +		chip->temp =3D mili_celsius;
> +	}
> +
> +	*temp =3D chip->temp < 0 ? 0 : chip->temp;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops qpnp_tm_sensor_ops =3D {
> +	.get_temp =3D qpnp_tm_get_temp,
> +};
> +
> +static irqreturn_t qpnp_tm_isr(int irq, void *data)
> +{
> +	struct qpnp_tm_chip *chip =3D data;
> +
> +	thermal_zone_device_update(chip->tz_dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * This function initializes the internal temp value based on only the
> + * current thermal stage and threshold. Setup threshold control and
> + * disable shutdown override.
> + */
> +static int qpnp_tm_init(struct qpnp_tm_chip *chip)
> +{
> +	int ret;
> +	u8 reg;
> +
> +	chip->thresh =3D THRESH_MIN;
> +	chip->temp =3D DEFAULT_TEMP;
> +
> +	ret =3D qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->stage =3D reg & STATUS_STAGE_MASK;
> +
> +	if (chip->stage)
> +		chip->temp =3D chip->thresh * TEMP_THRESH_STEP +
> +			     (chip->stage - 1) * TEMP_STAGE_STEP +
> +			     TEMP_THRESH_MIN;
> +
> +	/*
> +	 * Set threshold and disable software override of stage 2 and 3
> +	 * shutdowns.
> +	 */
> +	reg =3D chip->thresh & SHUTDOWN_CTRL1_THRESHOLD_MASK;
> +	ret =3D qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable the thermal alarm PMIC module in always-on mode. */
> +	reg =3D ALARM_CTRL_FORCE_ENABLE;
> +	ret =3D qpnp_tm_write(chip, QPNP_TM_REG_ALARM_CTRL, reg);
> +
> +	return ret;
> +}
> +
> +static int qpnp_tm_probe(struct platform_device *pdev)
> +{
> +	struct qpnp_tm_chip *chip;
> +	struct device_node *node;
> +	u8 type, subtype;
> +	u32 res[2];
> +	int ret, irq;
> +
> +	node =3D pdev->dev.of_node;
> +
> +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&pdev->dev, chip);
> +
> +	chip->map =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!chip->map)
> +		return -ENXIO;
> +
> +	ret =3D of_property_read_u32_array(node, "reg", res, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* ADC based measurements are optional */
> +	chip->adc =3D iio_channel_get(&pdev->dev, "thermal");
> +	if (PTR_ERR(chip->adc) =3D=3D -EPROBE_DEFER)
> +		return PTR_ERR(chip->adc);
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	chip->base =3D res[0];
> +
> +	ret =3D qpnp_tm_read(chip, QPNP_TM_REG_TYPE, &type);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not read type\n");
> +		goto fail;
> +	}
> +
> +	ret =3D qpnp_tm_read(chip, QPNP_TM_REG_SUBTYPE, &subtype);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not read subtype\n");
> +		goto fail;
> +	}
> +
> +	if (type !=3D QPNP_TM_TYPE || subtype !=3D QPNP_TM_SUBTYPE) {
> +		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
> +			type, subtype);
> +		ret =3D -ENODEV;
> +		goto fail;
> +	}
> +
> +	ret =3D qpnp_tm_init(chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "init failed\n");
> +		goto fail;
> +	}
> +
> +	chip->tz_dev =3D thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> +							&qpnp_tm_sensor_ops);
> +	if (IS_ERR(chip->tz_dev)) {
> +		dev_err(&pdev->dev, "failed to register sensor\n");
> +		ret =3D PTR_ERR(chip->tz_dev);
> +		goto fail;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
> +					IRQF_ONESHOT, node->name, chip);

What if we request this IRQ before registering the of thermal zone
sensor? I believe it makes more sense conceptually, as you mean, you
register into upper layers once your driver is fully ready to do so.

Any objections changing the order?

> +	if (ret < 0)
> +		goto unreg;
> +
> +	return 0;
> +
> +unreg:
> +	thermal_zone_of_sensor_unregister(&pdev->dev, chip->tz_dev);

As mentioned by Stanimir Varban, you may also remove the above, since
the irq is devm.

> +fail:
> +	if (!IS_ERR(chip->adc))
> +		iio_channel_release(chip->adc);
> +
> +	return ret;
> +}
> +
> +static int qpnp_tm_remove(struct platform_device *pdev)
> +{
> +	struct qpnp_tm_chip *chip =3D dev_get_drvdata(&pdev->dev);
> +
> +	thermal_zone_of_sensor_unregister(&pdev->dev, chip->tz_dev);
> +	if (!IS_ERR(chip->adc))
> +		iio_channel_release(chip->adc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qpnp_tm_match_table[] =3D {
> +	{ .compatible =3D "qcom,spmi-temp-alarm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qpnp_tm_match_table);
> +
> +static struct platform_driver qpnp_tm_driver =3D {
> +	.driver =3D {
> +		.name =3D "spmi-temp-alarm",
> +		.of_match_table =3D qpnp_tm_match_table,
> +	},
> +	.probe  =3D qpnp_tm_probe,
> +	.remove =3D qpnp_tm_remove,
> +};
> +module_platform_driver(qpnp_tm_driver);
> +
> +MODULE_ALIAS("platform:spmi-temp-alarm");
> +MODULE_DESCRIPTION("QPNP PMIC Temperature Alarm driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>=20

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUz76OAAoJEMLUO4d9pOJWaUgH/A71qCOsUxfKLQPHPpBn/jNT
J/wRrmlpd1X/GLDkXXKx5hqdzUb2/TOwaDcQGLxIIShJm0/YkmFprRlCessTirKV
7xkK/G7n00TbLPkti7FeCiD9CfDZ+JX+1fz7uq92IPU4DEZfAjslfrO45INJCQC9
vtfLKEGuL4vDRdey84iccFtt6Fmp73qkAi2PZLAp5eRIo4jUg1VoPEl14yQfEGeE
9Orrc0VrsCUAIKyq64+ery+k2QVIBjPjyF8AgCVsEvn4iZK/BKB8tAmOErqf9trV
2kRBipm0q35cQ1+oTyzjqL9w3bapSD00qsObUfv2ey9uqFrIRct3w4RZSog8IM4=
=lD/y
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
