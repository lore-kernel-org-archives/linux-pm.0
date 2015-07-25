From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 3/6] power: Add support for DA9150 Fuel-Gauge
Date: Sat, 25 Jul 2015 19:27:15 +0200
Message-ID: <20150725172715.GA1697@earth>
References: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
 <d122a6ffc20fca836847016895e5181f5d2248e7.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54876 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754962AbbGYR1V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 25 Jul 2015 13:27:21 -0400
Content-Disposition: inline
In-Reply-To: <d122a6ffc20fca836847016895e5181f5d2248e7.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Adam,

The driver looks mostly fine. I have a few comments, though:

On Tue, Jul 07, 2015 at 05:34:19PM +0100, Adam Thomson wrote:
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Please add a short description to the commit message.

> [...]=20
>
> +config FG_DA9150

Please name the config entry BATTERY_DA9150 to be consistent with
the other fuel gauges.

> [...]
>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/power_supply.h>
> +#include <linux/list.h>
> +#include <asm/div64.h>
> +#include <linux/mfd/da9150/core.h>
> +#include <linux/mfd/da9150/registers.h>

I wonder if the "depends CHARGER_DA9150" in Kconfig should be
"depends MFD_DA9150" instead.

> [...]
> +
> +/* Power Supply attributes */
> +static int da9150_fg_capacity(struct da9150_fg *fg,
> +			      union power_supply_propval *val)
> +{
> +	da9150_fg_read_sync_start(fg);
> +	val->intval =3D da9150_fg_read_attr(fg, DA9150_QIF_SOC_PCT,
> +					  DA9150_QIF_SOC_PCT_SIZE);
> +	da9150_fg_read_sync_end(fg);

Create a wrapper function for this. Reading a single value
with sync guards is done multiple times.

da9150_fg_read_attr_sync(fg, ...) {
    da9150_fg_read_sync_start(fg);
    da9150_fg_read_attr(fg, ...);
    da9150_fg_read_sync_end(fg);
}

> +	if (val->intval > 100)
> +		val->intval =3D 100;
> +
> +	return 0;
> +}
> +
>
> [...]
> +					  DA9150_QIF_E_FG_STATUS_SIZE);
> +
> +	/* Handle warning/critical threhold events */
> +	if ((DA9150_FG_IRQ_LOW_SOC_MASK | DA9150_FG_IRQ_HIGH_SOC_MASK) &
> +	    e_fg_status)

Please make this (e_fg_status & CONSTANT_MASK).

> +		da9150_fg_soc_event_config(fg);
> +
> +	/* Clear any FG IRQs */
> +	da9150_fg_write_attr(fg, DA9150_QIF_E_FG_STATUS,
> +			     DA9150_QIF_E_FG_STATUS_SIZE, e_fg_status);
> +
> +	return IRQ_HANDLED;
> +}
> +
>
> [...]
>
> +static int da9150_fg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct da9150 *da9150 =3D dev_get_drvdata(dev->parent);
> +	struct da9150_fg_pdata *fg_pdata =3D dev_get_platdata(dev);
> +	struct da9150_fg *fg;
> +	int ver, irq, ret;
> +
> +	fg =3D devm_kzalloc(dev, sizeof(*fg), GFP_KERNEL);
> +	if (fg =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, fg);
> +	fg->da9150 =3D da9150;
> +	fg->dev =3D dev;
> +
> +	mutex_init(&fg->io_lock);
> +
> +	/* Enable QIF */
> +	da9150_set_bits(da9150, DA9150_CORE2WIRE_CTRL_A, DA9150_FG_QIF_EN_MASK,
> +			DA9150_FG_QIF_EN_MASK);
> +
> +	fg->battery =3D power_supply_register(dev, &fg_desc, NULL);
> +	if (IS_ERR(fg->battery)) {
> +		ret =3D PTR_ERR(fg->battery);
> +		return ret;
> +	}

Please use devm_power_supply_register(...) to simplify the driver.

> +	ver =3D da9150_fg_read_attr(fg, DA9150_QIF_FW_MAIN_VER,
> +				  DA9150_QIF_FW_MAIN_VER_SIZE);
> +	dev_info(dev, "Version: 0x%x\n", ver);
> +
> +	/* Handle DT data if provided */
> +	if (dev->of_node) {
> +		fg_pdata =3D da9150_fg_dt_pdata(dev);
> +		dev->platform_data =3D fg_pdata;
> +	}
> +
> +	/* Handle any pdata provided */
> +	if (fg_pdata) {
> +		fg->interval =3D fg_pdata->update_interval;
> +
> +		if (fg_pdata->warn_soc_lvl > 100)
> +			dev_warn(dev, "Invalid SOC warning level provided, Ignoring");
> +		else
> +			fg->warn_soc =3D fg_pdata->warn_soc_lvl;
> +
> +		if ((fg_pdata->crit_soc_lvl > 100) ||
> +		    (fg_pdata->crit_soc_lvl >=3D fg_pdata->warn_soc_lvl))
> +			dev_warn(dev, "Invalid SOC critical level provided, Ignoring");
> +		else
> +			fg->crit_soc =3D fg_pdata->crit_soc_lvl;
> +
> +
> +	}
> +
> +	/* Configure initial SOC level events */
> +	da9150_fg_soc_event_config(fg);
> +
> +	/*
> +	 * If an interval period has been provided then setup repeating
> +	 * work for reporting data updates.
> +	 */
> +	if (fg->interval) {
> +		INIT_DELAYED_WORK(&fg->work, da9150_fg_work);
> +		schedule_delayed_work(&fg->work,
> +				      msecs_to_jiffies(fg->interval));
> +	}
> +
> +	/* Register IRQ */
> +	irq =3D platform_get_irq_byname(pdev, "FG");
> +	ret =3D request_threaded_irq(irq, NULL, da9150_fg_irq, IRQF_ONESHOT, "F=
G",
> +				   fg);
> +	if (ret)
> +		goto irq_fail;
> +
> +	return ret;
> +
> +irq_fail:
> +	cancel_delayed_work(&fg->work);
> +	power_supply_unregister(fg->battery);
> +
> +	return ret;
> +}
> +
> +static int da9150_fg_remove(struct platform_device *pdev)
> +{
> +	struct da9150_fg *fg =3D platform_get_drvdata(pdev);
> +	int irq;
> +
> +	irq =3D platform_get_irq_byname(pdev, "FG");
> +	free_irq(irq, fg);
> +
> +	if (fg->interval)
> +		cancel_delayed_work(&fg->work);

It looks like the order of irq freeing and canceling of the
delayed work is not important. In that case I suggest switching
to devm_request_threaded_irq(...).

> +	power_supply_unregister(fg->battery);
> +
> +	return 0;
> +}
>=20
> [...]
>
> +
> +MODULE_DESCRIPTION("Fuel-Gauge Driver for DA9150");
> +MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
> +MODULE_LICENSE("GPL");

MODULE_LICENSE("GPL v2");

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVs8bvAAoJENju1/PIO/qaSlsP/RCw3u4dweX+lTdHgcW4DyTS
6qBQ69zY1ikR+3cr3Lu38pZzPtvojN2f9nyPput1Ij5nMtv/A4ZUkiyrZuiWFKUe
TQprKeUbxl15u+TbBZJl4gGdJ12t/rFLvOMH2QQ6h8DQPk5d9V9YyG6Z9nNRCq9x
jwvimntZ7LU5OJp4c2oyyF6TdqYEDZnJ3RPZ0cT46c5R5faubiaZzw+A3TBXfEKK
d8SY5P1lr+WNWHDUlhSp/ReFj6AUbEAjXBb1W3gIvaxn7uyHMhPV5Rhl/xaPljM6
5HWwY6jQjUv1M83a+gJKMEbspHa1V8/sBPy3pPrA/QtmQJYGuEya5xJXi8HggNBH
Qv/gtp0CRb4UPz05GjleCuM6BA7zLejIC3aHUbNSOJX+Inr/8kjPBsnml8R7D1nj
FVTHYaARQqols1otbQ+PSrwhB4qbPeexdLlrj/TqQ89wj2+rtD+VbERTuZpNzUZd
q4s2TYB6FUEgE696/dSRdLGomppq9FggbqPO+kfhWxZpEj9jYX4gt6BoPcDIPxXA
lTuL/53wC/QMYm3gqWgyC5IZnfYywSkXyfxhakEDoJxSVA/Oa0jhGoCcMuDBHuE5
T0nJYW1KM9WjYrAwVfG31ddPYfNhZzy6SfpHSB4PXp+6J1p0INNZUacrwLDXiENi
3DB5kLEf9PxaIp+AANT8
=VwbL
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
