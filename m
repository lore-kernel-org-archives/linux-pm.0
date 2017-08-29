From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] power: supply: max17042_battery: Fix ACPI interrupt
 issues
Date: Tue, 29 Aug 2017 10:43:11 +0200
Message-ID: <20170829084311.5hjtgggtfmyctvfe@earth>
References: <20170814201811.21110-1-hdegoede@redhat.com>
 <20170814201811.21110-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6jdtaef5ftmumok"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbdH2InP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 04:43:15 -0400
Content-Disposition: inline
In-Reply-To: <20170814201811.21110-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org


--t6jdtaef5ftmumok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 14, 2017 at 10:18:11PM +0200, Hans de Goede wrote:
> On some x86/ACPI boards the DSDT defines an ACPI event handler for
> the max17047 IRQ, this causes several problems:
>=20
> 1) We need to share the IRQ to avoid an error getting it
>=20
> 2) Even of we are willing to share, we may fail to share because some
>    DSDTs claim it exclusivly
>=20
> 3) If we are unable to share the IRQ, or the IRQ is only listed as an
>    ACPI event source and not in the max1704 firmware node, then the
>    charge threshold IRQ (which is used to give an IRQ every 1 percent
>    charge change) becomes a problem, the ACPI event handler will not
>    update this to the next 1 percent threshold, so the IRQ keeps firing
>    and we get an IRQ storm pegging 1 CPU core.
>=20
>    This happens despite the max17042 driver not setting the charge
>    threshold because Windows uses it and leaves it set on reboot.
>=20
>    So if we are unable to get the IRQ we need to reprogram the
>    charge threshold to its disabled setting.
>=20
> This commit fixes al of the above, while at it it also makes the error
> msg when being unable to get the IRQ consistent with other messages.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index b2ddb7eb69c6..18a44e4ed6ff 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1050,11 +1050,18 @@ static int max17042_probe(struct i2c_client *clie=
nt,
>  	}
> =20
>  	if (client->irq) {
> +		unsigned int flags =3D IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> +
> +		/*
> +		 * On ACPI systems the IRQ may be handled by ACPI-event code,
> +		 * so we need to share (if the ACPI code is willing to share).
> +		 */
> +		if (acpi_id)
> +			flags |=3D IRQF_SHARED | IRQF_PROBE_SHARED;
> +
>  		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>  						NULL,
> -						max17042_thread_handler,
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,
> +						max17042_thread_handler, flags,
>  						chip->battery->desc->name,
>  						chip);
>  		if (!ret) {
> @@ -1064,10 +1071,13 @@ static int max17042_probe(struct i2c_client *clie=
nt,
>  			max17042_set_soc_threshold(chip, 1);
>  		} else {
>  			client->irq =3D 0;
> -			dev_err(&client->dev, "%s(): cannot get IRQ\n",
> -				__func__);
> +			if (ret !=3D -EBUSY)
> +				dev_err(&client->dev, "Failed to get IRQ\n");
>  		}
>  	}
> +	/* Not able to update the charge threshold when exceeded? -> disable */
> +	if (!client->irq)
> +		regmap_write(chip->regmap, MAX17042_SALRT_Th, 0xff00);
> =20
>  	regmap_read(chip->regmap, MAX17042_STATUS, &val);
>  	if (val & STATUS_POR_BIT) {
> --=20
> 2.13.4
>=20

--t6jdtaef5ftmumok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlKR8ACgkQ2O7X88g7
+pq1IA/+LWbawIFSWvl7XASWx8F27l66Mhw0d649m+VdhgGzz6MGQdvccAt/OQW/
4TQfx6/eaJBN/73pWyKMhQRUyP/DCqFqEo6/kxq60vumRI1mheD1iUinSZmIpleN
EXbpVCo8TPC9ZGqJKmLNRQpkaRi1ECo602zS0BxEVaX/+xA47+PFFEVEa5ZFX1MT
9g/qg0ioktaNLcOTDT/9IK6xk/GoAinThFD2eFG+aG9VCeNdMZTIg1P+e9uTQhwY
oJ/Ejm28/1M3iEpkqMssatIqHxErw82PYzz6VMyFx4v6ZpnjUbQqa1RrnYp/xJmd
Yjo700Rbu256Uidot0KzPZuwa4iXR9bStpKfaIOWcvrFeXcozrJglyIOUZlPyUyw
Y5RWz5sr6n21A/6bGf7kw7PMmng1qkaklWEdCJvapCaTqnE1sSVoPs4OdMEnqJNe
ZPlsliy+kTOqQ5GvxSmf7BdI6xTVGyM74F0K8cygTr+0f49B0XG8OAecPfMP3+LG
vtZXTVW4QbM5/9YZ4iqwMoFv9MWQlr1l5P4AyJgN2gHUnSNFWPwmxri6R38D630K
3vVqFaFqF5czkZ581KInd3F7MPgZCUnYBn6OziD//cT64OnvltMvjrhTXtACZpuK
yxbdGBBfxzFOnEoPdxw44ncnc+gY1iutEIVG6OUqrXj9B3To6ds=
=MaXz
-----END PGP SIGNATURE-----

--t6jdtaef5ftmumok--
