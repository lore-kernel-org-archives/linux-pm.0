From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 5/7] power: act8945a_charger: Add capacity level
 property
Date: Tue, 23 Aug 2016 04:40:59 +0200
Message-ID: <20160823024059.i7mvsef4t7flskcv@earth>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
 <1471848557-27278-6-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3uxmj6q6l4ms5ysd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471848557-27278-6-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--3uxmj6q6l4ms5ysd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Aug 22, 2016 at 02:49:15PM +0800, Wenyou Yang wrote:
> [...]
>
> +	charger->lbo_gpio = gpiod_get(dev->parent, "active-semi,lbo", GPIOD_IN);
> +	if (PTR_ERR(charger->lbo_gpio) == -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"lbo\"\n");
> +	} else if (IS_ERR(charger->lbo_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"lbo\"\n");
> +		charger->lbo_gpio = NULL;
> +	}
> +
> +	ret = devm_request_irq(dev, gpiod_to_irq(charger->lbo_gpio),
> +			       act8945a_status_changed,
> +			       (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
> +			       "act8945a_lbo_detect", charger);
> +	if (ret)
> +		dev_info(dev, "failed to request gpio \"lbo\" IRQ\n");

that does not work, since you need to release the irq before
releasing the gpio. So if the gpio is not requested via devm_
than you can't request the irq via devm_ (actually you can by
using devm_free_irq in remove(), but then you can also drop
the devm_ alltogether).

> [...]

-- Sebastian

--3uxmj6q6l4ms5ysd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu7e5AAoJENju1/PIO/qaYhUQAID/SVnEw6uRXPeV6Cb4+evU
x1RZrga2tU7lOXrW2oVT94wBkXQwO4MLIuxfXRbU2OJF9cUlBdYa5+ZGCKLzssbO
stzO3EwIch5JfMA4nLPTzW1PD2qM1MBIkySo5x+zxKgw+YCiqJO3S9ZOSu+/H5mk
COs2CxHEAJFaRb2F+HMYgnDwq7BNMCBFISyB8cjyvTlqeNi3XT2jAPwAyySswV1M
uNjh6Ecuk/xXmsDfMWWDrNKiVoZ+014AC2xXJBqUjKw365qmVCgKQyqd/wtXdiop
WUIm6nEsFesQNu5H9gSI1FS9ayi5+RFu073FF0XRtYqz3iQ/q86l8K97wu3Q3BTX
q+NoXF4joVqIa/3Oqi28cXPS5vm5nneOCz/OFJbKN+PSqTyQb85510GFZNUgkRfs
UqgpW56FBorghoJz3JQXs+ivKldGXg39ttrpz2Oejyx68QnQ0JkyimBJlK74Y2u2
SI1uu5f5pe5W94uqTp8S01CHGBbTH2nw54qJQpm7CU1FbRf+UmyiaPZMI9ycefLm
qD8IEaiVyAz9Nu+WJxkrZ5Jp6rjpiVReoDaMDc1cO6gbvBGvIeembthI1g6HDf0Z
ZJFiuxh8gQtRoXMzRpHb4KvCpq09/D5CCWcRyXc7DlgflGHfseOICycuACi3uQgm
oe0Cs1QApT1WOYWjOn9Y
=BT+b
-----END PGP SIGNATURE-----

--3uxmj6q6l4ms5ysd--
