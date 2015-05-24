From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Sun, 24 May 2015 13:02:03 +0200
Message-ID: <20150524110203.GA4188@earth>
References: <1431089869-14477-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43968 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbbEXLC2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 07:02:28 -0400
Content-Disposition: inline
In-Reply-To: <1431089869-14477-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anda-Maria,

On Fri, May 08, 2015 at 03:57:49PM +0300, Anda-Maria Nicolae wrote:
> Based on the datasheet found here:
> http://www.richtek.com/download_ds.jsp?p=3DRT9455
>=20
> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
> ---
>=20
> Updates from v4 version:                                                 =
      =20
> - replaced depends on REGMAP_I2C with select REGMAP_I2C
> - got the latest version of vendor_prefixes file; prev patch contained an=
 older one
> - added explanation in rt9455_charger.txt about what boost-output-voltage=
 represents
>=20
>  .../devicetree/bindings/power/rt9455_charger.txt   |   46 +

Please move this into its own patch, see

Documentation/devicetree/bindings/submitting-patches.txt

>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +

Please also move this into its own patch

>  drivers/power/Kconfig                              |    7 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/rt9455_charger.c                     | 1821 ++++++++++++++=
++++++
>  5 files changed, 1876 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/rt9455_charge=
r.txt
>  create mode 100644 drivers/power/rt9455_charger.c
>=20
> diff --git a/Documentation/devicetree/bindings/power/rt9455_charger.txt b=
/Documentation/devicetree/bindings/power/rt9455_charger.txt
> new file mode 100644
> index 0000000..a87c0f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rt9455_charger.txt
> @@ -0,0 +1,46 @@
> +Binding for Richtek rt9455 battery charger
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> + * "richtek,rt9455"
> +
> +- reg:					integer, i2c address of the device.
> +- richtek,output-charge-current:	integer, output current from the charge=
r to the
> +					battery, in uA.
> +- richtek,end-of-charge-percentage:	integer, percent of the output charg=
e current.
> +					When the current in constant-voltage phase drops
> +					below output_charge_current x end-of-charge-percentage,
> +					charge is terminated.
> +- richtek,battery-regulation-voltage:	integer, maximum battery voltage i=
n uV.
> +- richtek,boost-output-voltage:		integer, maximum voltage provided to co=
nsumer
> +					devices, when the charger is in boost mode.
> +
> +Optional properties:
> +- richtek,min-input-voltage-regulation: integer, input voltage level in =
uA, used to
> +					decrease voltage level when the over current
> +					of the input power source occurs.
> +					This prevents input voltage drop due to insufficient
> +					current provided by the power source.
> +- richtek,avg-input-current-regulation: integer, input current value dra=
ined by the
> +					charger from the power source.
> +
> +Example:
> +
> +rt9455@22 {
> +	compatible =3D "richtek,rt9455";
> +	reg =3D <0x22>;
> +
> +	interrupt-parent =3D <&gpio1>;
> +	interrupts =3D <0 1>;
> +
> +	interrupt-gpio =3D <&gpio1 0 1>;
> +	reset-gpio =3D <&gpio1 1 1>;

Neither the gpios, nor the interrupts are specified as
required/optional properties. Also the reset gpio is
not referenced in the sourcecode at all.

> +	richtek,output-charge-current	    =3D <500000>;
> +	richtek,end-of-charge-percentage    =3D <10>;
> +	richtek,battery-regulation-voltage  =3D <4200000>;
> +	richtek,boost-output-voltage	    =3D <5050000>;
> +
> +	richtek,min-input-voltage-regulation =3D <4500000>;
> +	richtek,avg-input-current-regulation =3D <500000>;
> +};
>
> [...]
>
> +/*
> + * Before setting the charger into boost mode, boost output voltage is
> + * set. This is needed because boost output voltage may differ from batt=
ery
> + * regulation voltage. F_VOREG bits represent either battery regulation =
voltage
> + * or boost output voltage, depending on the mode the charger is. Both b=
attery
> + * regulation voltage and boost output voltage are read from DT/ACPI dur=
ing
> + * probe.
> + */
> +static int rt9455_set_boost_voltage_before_boost_mode(struct rt9455_info=
 *info)
> +{
> +	struct device *dev =3D &info->client->dev;
> +	int curr_boost_voltage, ret;
> +
> +	ret =3D rt9455_get_field_val(info, F_VOREG,
> +				   rt9455_boost_voltage_values,
> +				   ARRAY_SIZE(rt9455_boost_voltage_values),
> +				   &curr_boost_voltage);
> +	if (ret) {
> +		dev_err(dev, "Failed to read boost output voltage value\n");
> +		return ret;
> +	}
> +
> +	if (curr_boost_voltage !=3D info->boost_voltage) {
> +		ret =3D rt9455_set_field_val(info, F_VOREG,
> +					rt9455_boost_voltage_values,
> +					ARRAY_SIZE(rt9455_boost_voltage_values),
> +					info->boost_voltage);
> +		if (ret) {
> +			dev_err(dev, "Failed to set boost output voltage value\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

The register comparision looks over-engineered to me.
Just write the new value into the register.

> +/*
> + * Before setting the charger into charge mode, battery regulation volta=
ge is
> + * set. This is needed because boost output voltage may differ from batt=
ery
> + * regulation voltage. F_VOREG bits represent either battery regulation =
voltage
> + * or boost output voltage, depending on the mode the charger is. Both b=
attery
> + * regulation voltage and boost output voltage are read from DT/ACPI dur=
ing
> + * probe.
> + */
> +static int rt9455_set_voreg_before_charge_mode(struct rt9455_info *info)
> +{
> +	struct device *dev =3D &info->client->dev;
> +	int curr_voreg, ret;
> +
> +	ret =3D rt9455_get_field_val(info, F_VOREG,
> +				   rt9455_voreg_values,
> +				   ARRAY_SIZE(rt9455_voreg_values),
> +				   &curr_voreg);
> +	if (ret) {
> +		dev_err(dev, "Failed to read VOREG value\n");
> +		return ret;
> +	}
> +
> +	if (curr_voreg !=3D info->voreg) {
> +		ret =3D rt9455_set_field_val(info, F_VOREG,
> +					   rt9455_voreg_values,
> +					   ARRAY_SIZE(rt9455_voreg_values),
> +					   info->voreg);
> +		if (ret) {
> +			dev_err(dev, "Failed to set VOREG value\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

see last comment

> [...]
>
> +static int rt9455_setup_irq(struct rt9455_info *info)
> +{
> +	struct device *dev =3D &info->client->dev;
> +	int ret;
> +
> +	/* Obtain IRQ GPIO */
> +	info->gpiod_irq =3D devm_gpiod_get_index(dev, RT9455_IRQ_NAME, 0);
> +	if (IS_ERR(info->gpiod_irq)) {
> +		dev_err(dev, "Failed to get IRQ GPIO\n");
> +		return PTR_ERR(info->gpiod_irq);
> +	}
> +
> +	/* Configure IRQ GPIO */
> +	ret =3D gpiod_direction_input(info->gpiod_irq);
> +	if (ret) {
> +		dev_err(dev, "Failed to set IRQ GPIO direction err =3D %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Map the pin to an IRQ */
> +	ret =3D gpiod_to_irq(info->gpiod_irq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to associate GPIO with an IRQ err =3D %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n",
> +		desc_to_gpio(info->gpiod_irq), ret);
> +	info->client->irq =3D ret;
> +
> +	info->gpio_irq =3D desc_to_gpio(info->gpiod_irq);

info->gpio_irq is never referenced. Drop it.

> +	return 0;
> +}

There is no usage of info->gpiod_irq except for irq conversion, so you
can just drop the whole gpio usage and reference the gpio as irq in the
DT specification:

interrupts-parent =3D <&gpio42>;
interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH>;

This way the irq will be assigned to client->irq automatically. For
ACPI the same will be supported once this patchset is merged:

https://lkml.org/lkml/2015/4/28/455

> [...]
>
> +static int rt9455_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
> +	struct device *dev =3D &client->dev;
> +	struct rt9455_info *info;
> +	struct power_supply_config rt9455_charger_config =3D {};
> +	/*
> +	 * Mandatory device-specific data values. Also, VOREG and boost output
> +	 * voltage are mandatory values, but they are stored in rt9455_info
> +	 * structure.
> +	 */
> +	u32 ichrg, ieoc_percentage;
> +	/* Optional device-specific data values. */
> +	u32 mivr =3D -1, iaicr =3D -1;
> +	int i, ret;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
> +		return -ENODEV;
> +	}
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->client =3D client;
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap =3D devm_regmap_init_i2c(client,
> +					    &rt9455_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		dev_err(dev, "Failed to initialize register map\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < F_MAX_FIELDS; i++) {
> +		info->regmap_fields[i] =3D
> +			devm_regmap_field_alloc(dev, info->regmap,
> +						rt9455_reg_fields[i]);
> +		if (IS_ERR(info->regmap_fields[i])) {
> +			dev_err(dev,
> +				"Failed to allocate regmap field =3D %d\n", i);
> +			return PTR_ERR(info->regmap_fields[i]);
> +		}
> +	}
> +
> +	ret =3D rt9455_discover_charger(info, &ichrg, &ieoc_percentage,
> +				      &mivr, &iaicr);
> +	if (ret) {
> +		dev_err(dev, "Failed to discover charger\n");
> +		return ret;
> +	}
> +
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +	info->usb_phy =3D devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +	if (IS_ERR(info->usb_phy)) {
> +		dev_err(dev, "Failed to get USB transceiver\n");
> +	} else {
> +		info->nb.notifier_call =3D rt9455_usb_event;
> +		ret =3D usb_register_notifier(info->usb_phy, &info->nb);
> +		if (ret) {
> +			dev_err(dev, "Failed to register USB notifier\n");
> +			/*
> +			 * If usb_register_notifier() fails, set notifier_call
> +			 * to NULL, to avoid calling usb_unregister_notifier().
> +			 */
> +			info->nb.notifier_call =3D NULL;
> +		}
> +	}
> +#endif
> +
> +	INIT_DEFERRABLE_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_callback);
> +	INIT_DEFERRABLE_WORK(&info->max_charging_time_work,
> +			     rt9455_max_charging_time_work_callback);
> +	INIT_DEFERRABLE_WORK(&info->batt_presence_work,
> +			     rt9455_batt_presence_work_callback);
> +
> +	rt9455_charger_config.of_node		=3D dev->of_node;
> +	rt9455_charger_config.drv_data		=3D info;
> +	rt9455_charger_config.supplied_to	=3D rt9455_charger_supplied_to;
> +	rt9455_charger_config.num_supplicants	=3D
> +					ARRAY_SIZE(rt9455_charger_supplied_to);
> +	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> +					rt9455_irq_handler_thread,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					RT9455_DRIVER_NAME, info);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IRQ handler\n");
> +		goto put_usb_notifier;
> +	}
> +
> +	ret =3D rt9455_hw_init(info, ichrg, ieoc_percentage, mivr, iaicr);
> +	if (ret) {
> +		dev_err(dev, "Failed to set charger to its default values\n");
> +		goto put_usb_notifier;
> +	}
> +
> +	info->charger =3D power_supply_register(dev, &rt9455_charger_desc,
> +					      &rt9455_charger_config);
> +	if (IS_ERR(info->charger)) {
> +		dev_err(dev, "Failed to register charger\n");
> +		ret =3D PTR_ERR(info->charger);
> +		goto put_usb_notifier;
> +	}

You can use devm_power_supply_register() and remove the
power_supply_unregister() call from rt9455_remove().

> +
> +	return 0;
> +
> +put_usb_notifier:
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +	if (info->nb.notifier_call)  {
> +		usb_unregister_notifier(info->usb_phy, &info->nb);
> +		info->nb.notifier_call =3D NULL;
> +	}
> +#endif
> +	return ret;
> +}
>
> [...]

-- Sebastian

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYa+oAAoJENju1/PIO/qaLPAQAIJvoKXRxm+xignDTIwrMvYF
0aLAZS+2WJBZrJTfuBJOGh6SFbiixG1tPbgmIjGZjkZ1C9mVtvIgebcVLxwgZ4YP
0ylyaDMfACHiYn2zkTDbcQm8S5y0aYtxWn68nTF4lbapS1eyrVcIgGeKfLybVOAB
erlfLI9/37Hxh09SA7lcvrS1xaSiDLL6x/H0jrCad3lQ8x7+DeI+BTzfIlqThe8b
G3oyMP24h0dEj942N9APlyaI5bQIGdRqHei3bY6IJ1hysLMYhOsI9dzEHX6lT+KC
C2of6M574TxMlUXI1ZYeFsZowy6g0DU1ZwOLOlM7SmKNkGhRLTG6BjrySuZKmjKN
HybnKPdhQqseiMb/iFSTBt4AKjs6U5e0lmXbeVYjOGIXMz1KHgEqnhZTUy9189az
ihWS/xu8z0ysjKBNklJXkLCwUoakuRG6J13Pv20kZuAVR/z+XnltohD2okvhWeqg
LvvPWqbmz7MMWjgrWZu8jNOWWTcd7gmOpX2vvc7RjUI4qVKf/4B2pLQ8Bj7FwLQk
ImtxTBH7NU3RHkJaTtDVT7Y9UsevNPU+6R2xmY8hiwU6Kl1CQrrYG050QS/SaUwk
wcwgIGydrUNcRzFcsI5UoHGBkQ7obp8mPit2aT0SEKOXkPR3Hwh53zMCZT2kEj8s
BclmnhcQhSrfnvjPgXbw
=Oya/
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
