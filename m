From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power_supply: Add Apple Brick ID power supply type
Date: Mon, 15 May 2017 16:13:38 +0200
Message-ID: <20170515141338.pw4owhtou7z5ttem@earth>
References: <20170508220248.97372-1-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6552mc4kogrpcf3e"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965407AbdEOONr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2017 10:13:47 -0400
Content-Disposition: inline
In-Reply-To: <20170508220248.97372-1-bleung@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ras@apple.com, tomeu.vizoso@collabora.com, bleung@google.com


--6552mc4kogrpcf3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 08, 2017 at 03:02:48PM -0700, Benson Leung wrote:
> Apple currently supports three very common USB chargers:
> https://www.apple.com/power-adapters/
>=20
> These chargers implement a proprietary Apple method for advertising
> 1A, 2.1A, and 2.4A at 5V called "Brick ID".
> In addition, 3rd parties implement the same charging method in many
> charging accessories that work with iOS devices.
>=20
> Devices that have charger detection chips such as the Pericom PI3USB9281,
> eg. Google Chromebook Pixel 2015, are capable of detecting
> these chargers, so let's add a type to facilicate passing that info
> up to userspace.
>=20
> This adds a separate power supply type for Apple's proprietary
> "Brick ID" charging method.
>=20
> Signed-off-by: Benson Leung <bleung@chromium.org>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/supply/power_supply_sysfs.c |  2 +-
>  include/linux/power_supply.h              | 15 ++++++++-------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index bcde8d13476a..07b484f995c1 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -46,7 +46,7 @@ static ssize_t power_supply_show_property(struct device=
 *dev,
>  	static char *type_text[] =3D {
>  		"Unknown", "Battery", "UPS", "Mains", "USB",
>  		"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
> -		"USB_PD", "USB_PD_DRP"
> +		"USB_PD", "USB_PD_DRP", "BrickID"
>  	};
>  	static char *status_text[] =3D {
>  		"Unknown", "Charging", "Discharging", "Not charging", "Full"
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 3965503315ef..4bd34051995e 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -159,13 +159,14 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_BATTERY,
>  	POWER_SUPPLY_TYPE_UPS,
>  	POWER_SUPPLY_TYPE_MAINS,
> -	POWER_SUPPLY_TYPE_USB,		/* Standard Downstream Port */
> -	POWER_SUPPLY_TYPE_USB_DCP,	/* Dedicated Charging Port */
> -	POWER_SUPPLY_TYPE_USB_CDP,	/* Charging Downstream Port */
> -	POWER_SUPPLY_TYPE_USB_ACA,	/* Accessory Charger Adapters */
> -	POWER_SUPPLY_TYPE_USB_TYPE_C,	/* Type C Port */
> -	POWER_SUPPLY_TYPE_USB_PD,	/* Power Delivery Port */
> -	POWER_SUPPLY_TYPE_USB_PD_DRP,	/* PD Dual Role Port */
> +	POWER_SUPPLY_TYPE_USB,			/* Standard Downstream Port */
> +	POWER_SUPPLY_TYPE_USB_DCP,		/* Dedicated Charging Port */
> +	POWER_SUPPLY_TYPE_USB_CDP,		/* Charging Downstream Port */
> +	POWER_SUPPLY_TYPE_USB_ACA,		/* Accessory Charger Adapters */
> +	POWER_SUPPLY_TYPE_USB_TYPE_C,		/* Type C Port */
> +	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
> +	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
> +	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
> =20
>  enum power_supply_notifier_events {
> --=20
> 2.13.0.rc1.294.g07d810a77f-goog
>=20

--6552mc4kogrpcf3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkZt48ACgkQ2O7X88g7
+ppM9g//fSGcX1gICsr93ldrS95aPoxmuM2D6eew+wTjuto1G06MF8XXlQRowbM7
+ZENICCmXZqQhi2i/56TlIer6PdBsqbsXcesbikhLu8SX+j2b3TfktSXOsq53Tyn
qvwNaMZWMJ5l1yLqx3U4zFyN2TJcC3Q92Fako/MAyiwvwdPNVn2dSFmVEGHgUcx5
K5wYf8fRYhFu4/TEV1Of7aKL2RJ1Hxw1gcWLgDDkfIMik1AwuCOJ1rYXqHrSms9R
ggqQETvtidMJYq1mNOm1DtnB944KD6CuHXcaxV4e4+BGWUN4Wk/yf4pQiCWDnZLJ
wXAFknP+4eg8VV4/sI2+7/PARunWE2LwSqBOTBm7RDUasjDpV1Iudb2FMyHqsh9r
yCMl5rzSG++GMDXpXyjGgcA9v3JGIv7Osr8GWpltBAGh+QQaxfkwg9MNMA82gOv1
OvWDLYOy+xJY46CpLQlbhYY2hyFv5ttX6B/pBLMnmMm5YCEv2qJjCFGAMwdN8QUJ
lV4KynhrSZyRnmzw0AFmOuagwUN9gLasUnLBU3VtrsoMhQIuHvHe1AReszlcibt3
cT63TGgSONXsBFpMW8BKGHscinUdqoKvVzcGCrRHr6z0sxqYQjjRjlWuJ6olDJwH
VYUNmvcBTITUO0FNBMGbOUAYLRdl1uAWUiyFjv4xPz3I4v9WlNY=
=F1aY
-----END PGP SIGNATURE-----

--6552mc4kogrpcf3e--
