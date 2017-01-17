From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
Date: Tue, 17 Jan 2017 04:00:13 +0100
Message-ID: <20170117030013.g5xhlmrxpthyfewa@earth>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4980840615660038625=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-9-quentin.schulz@free-electrons.com>
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


--===============4980840615660038625==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxc2sjqngmsewc3s"
Content-Disposition: inline


--zxc2sjqngmsewc3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Quentin,

The driver looks mostly fine. I do have a two comments, though.

On Mon, Jan 02, 2017 at 05:37:08PM +0100, Quentin Schulz wrote:
> [...]
>
> +static int axp20x_ac_power_probe(struct platform_device *pdev)
> +{
> +	static const char * const axp20x_irq_names[] = { "ACIN_PLUGIN",
> +		"ACIN_REMOVAL", NULL };
>
> +	static const char * const *irq_names;
> +	const struct power_supply_desc *ac_power_desc;
> +	int i, irq, ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	if (!axp20x) {
> +		dev_err(&pdev->dev, "Parent drvdata not set\n");
> +		return -EINVAL;
> +	}

axp20x will no longer be needed after implementing below
comments.

> [...]
> +	irq_names = axp20x_irq_names;

Just rename axp20x_irq_names into irq_names, since its only used
here.

> [...]
>
> +	power->np = pdev->dev.of_node;

This can be dropped, it's not used at all.

> +	power->regmap = axp20x->regmap;

power->regmap = dev_get_regmap(pdev->dev.parent, NULL);

> [...]
> +	/* Request irqs after registering, as irqs may trigger immediately */
> +	for (i = 0; irq_names[i]; i++) {
> +		irq = platform_get_irq_byname(pdev, irq_names[i]);
> +		if (irq < 0) {
> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +				 irq_names[i], irq);
> +			continue;
> +		}
> +		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);

The mapping should actually happen in the mfd driver, so that
the platform resource contains a valid irq.

> +		ret = devm_request_any_context_irq(&pdev->dev, irq,
> +						   axp20x_ac_power_irq, 0,
> +						   DRVNAME, power);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], ret);
> +	}

-- Sebastian

--zxc2sjqngmsewc3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9iLsACgkQ2O7X88g7
+ppoow//bhzAGESgVlNyI6XSseMTxEWOMvDT3FvLN0sHG9kRWdzbzXxsdHW6o/xC
B/Zn16dm5f2XQI1bRJ0bZdf61dDDlSrm/+nrCyD3gIn6md9XhWE3vZdJDFVaUcbh
Vw0RJpmfFsodmJwqrr+JLgqPuwFlT7n8GR0BK1FGqq1+T37MaXr1+oAjlCusa90E
7eSB70wW4bYB4OXMliamVw35Z+ysFfloR+JcPYC8pdOhnoJ4YEBfM4+EKOlUONVt
/+WN9VRakfkS/Hbt2zTjtlTgJ2gCz65bY452efFy74jymJBKYWBwci5BduASeSos
+ovrTgMttB0QTjDbRbJljI10VmzmUk2bMD+Y1dUalgGfHeM6amHNZKGBw5A+0Ess
BFJNdjHQp5pHkL0W76+rcbWwzVSpkPRD/aA3vS746yVL8qs7t17LBd75yf1BBTzB
JDTB+YngSOUpmYthNZtpoVVBAgOrfTzuVU8uQ+AB9NAFRaQwt79DvhiMGdNQ4FGi
wwc7nDOm9iVHUAQUv08MZzkhczA6L0/B9WepWWWFZ2uqxQvV2zpypuKCZ4ylo9tD
xXn9yhZzLEUuJg38bupinPIw/JZ9sbxyYkuSsUapl/iNiA98D0HzRb901+NFbe/w
haY3/TNK2w3WrHYnQsI6SebjhhoCVn1SmSU+JCi0PezAKVe33MA=
=qgcj
-----END PGP SIGNATURE-----

--zxc2sjqngmsewc3s--


--===============4980840615660038625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4980840615660038625==--
