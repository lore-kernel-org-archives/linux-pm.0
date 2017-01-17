From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
Date: Tue, 17 Jan 2017 04:46:01 +0100
Message-ID: <20170117034601.wevqblqiwrerpmal@earth>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2933949046944896703=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-18-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, jic23@kernel.org, icenowy@aosc.xyz
List-Id: linux-pm@vger.kernel.org


--===============2933949046944896703==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mjxj5dt3uccvr4c"
Content-Disposition: inline


--7mjxj5dt3uccvr4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

Just a couple of small things in this patch.

On Mon, Jan 02, 2017 at 05:37:17PM +0100, Quentin Schulz wrote:
> [...]
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_PWR_INPUT_STATUS,
> +				  &reg);
> +		if (ret)
> +			return ret;
> +
> +		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
> +			chan =3D axp20x_batt->batt_chrg_i;
> +		else
> +			chan =3D axp20x_batt->batt_dischrg_i;
> +
> +		ret =3D iio_read_channel_processed(chan, &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * IIO framework gives mV but Power Supply framework gives =B5V.
> +		 */

Nit: Volt -> Ampere

> +		val->intval *=3D 1000;
> +		break;
>
> [...]
>
> +static int axp20x_power_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> +	struct axp20x_batt_ps *axp20x_batt;
> +	struct power_supply_config psy_cfg =3D {};
> +
> +	axp20x_batt =3D devm_kzalloc(&pdev->dev, sizeof(*axp20x_batt),
> +				   GFP_KERNEL);
> +	if (!axp20x_batt)
> +		return -ENOMEM;
> +
> +	axp20x_batt->batt_v =3D devm_iio_channel_get(&pdev->dev, "batt_v");
> +	if (IS_ERR(axp20x_batt->batt_v)) {
> +		if (PTR_ERR(axp20x_batt->batt_v) =3D=3D -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp20x_batt->batt_v);
> +	}
> +
> +	axp20x_batt->batt_chrg_i =3D devm_iio_channel_get(&pdev->dev,
> +							"batt_chrg_i");
> +	if (IS_ERR(axp20x_batt->batt_chrg_i)) {
> +		if (PTR_ERR(axp20x_batt->batt_chrg_i) =3D=3D -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp20x_batt->batt_chrg_i);
> +	}
> +
> +	axp20x_batt->batt_dischrg_i =3D devm_iio_channel_get(&pdev->dev,
> +							   "batt_dischrg_i");
> +	if (IS_ERR(axp20x_batt->batt_dischrg_i)) {
> +		if (PTR_ERR(axp20x_batt->batt_dischrg_i) =3D=3D -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp20x_batt->batt_dischrg_i);
> +	}
> +
> +	axp20x_batt->regmap =3D axp20x->regmap;
> +	platform_set_drvdata(pdev, axp20x_batt);

Please use drv_get_regmap(pdev->dev.parent, NULL) instead (and drop
axp20x).

> +	psy_cfg.drv_data =3D axp20x_batt;
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +
> +	axp20x_batt->axp_id =3D (int)of_device_get_match_data(&pdev->dev);

use (uintptr_t) to avoid compiler warnings on systems with sizeof
int !=3D sizeof ptr.

-- Sebastian

--7mjxj5dt3uccvr4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9k3YACgkQ2O7X88g7
+ppitg//TS1PXC2tmqPc/8SQ5gvQCTIrQHnkxw3xyXjKK+kFntQr5qSnczVQAJLS
YFEcj74yd4T1sI/mYKKGPwJ4/kf5hZlUzEolvE7afAiCjcO+HYCXXE7Im5g055R5
6QpJBCnEsBZSXxeXPkNgfFGb8enrXtvrr3S1eqnxUXTHBpXxy5zrKx3zZfI2lnLd
TxsrFlGRMsC9kOn/rzDq3uQiKAySQEMJskO1fai7VNEztDC0n4Fy1MaeCbAmSLbY
ovBHDWtyODkwAwWPg465qsfEwmB6CXS1ookCTnqRUQLakIQt6juMQ5pgGXkQJbbj
b3ZpGBKRZ7hBnT5lH2iKXc4P6qag8E5Pq/1YyBpRNBtX1TgFPq4ab5ZEpN3JxuTO
M08wOqVO7Z/TKUnWB4Qp5qVSU+xMt7WBDsO3mErxTSvsce0RnlZylYi8FYpoqH4V
0mtRgXn1QLy/rPeVi47OmWCimFuwxxg5dF2POjV9Ogxo2fxpxtLVRPbuM08aYUjk
GUvPvBfHRhT0koqQ3LuGSZREMENoAdJ47Nieq9Z8AJB3S5HZf0UilSdWc3w7agbP
y15G4t977idLB0c1EIemc9Exj5dznbPV5znlxYHM5sQ/hzmveBihUQS2Vw/Nd7y7
DAdAirVXlOy/WpLMCGhqmRiBotfVuJSU9SLUSJgE2oW0x/ukReo=
=2MEG
-----END PGP SIGNATURE-----

--7mjxj5dt3uccvr4c--


--===============2933949046944896703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2933949046944896703==--
