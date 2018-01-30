From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] leds: use QoS to control LED suspend behavior from
 userspace
Date: Tue, 30 Jan 2018 09:28:17 +0100
Message-ID: <20180130082817.GA4136@amd>
References: <20180129194947.11071-1-0v3rdr0n3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46612 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeA3I2T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jan 2018 03:28:19 -0500
Content-Disposition: inline
In-Reply-To: <20180129194947.11071-1-0v3rdr0n3@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 0v3rdr0n3@gmail.com
Cc: linux-pm@vger.kernel.org, linux-leds@vger.kernel.org, samorris@lexmark.com


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-01-29 19:49:47, 0v3rdr0n3@gmail.com wrote:
> From: Samuel Morris <samorris@lexmark.com>
>=20
> Signed-off-by: Samuel Morris <samorris@lexmark.com>

But... we'll really need description what this is supposed to do.

Because at least some LEDs (keyboard LEDs on PC) can't be powered on
during suspend.

Does this work for your LEDs? Do we need a way for userspace to tell
if LED supports it or not?

> @@ -196,6 +197,11 @@ static int led_suspend(struct device *dev)
>  {
>  	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> =20
> +	if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) =3D=3D
> +			PM_QOS_FLAGS_ALL) {
> +		return 0;
> +	}

"if (". No need for { } s.

> +
>  	if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
>  		led_classdev_suspend(led_cdev);
> =20
> @@ -206,6 +212,11 @@ static int led_resume(struct device *dev)
>  {
>  	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> =20
> +	if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) =3D=3D
> +			PM_QOS_FLAGS_ALL) {
> +		return 0;
> +	}
> +
>  	if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
>  		led_classdev_resume(led_cdev);
> =20
> @@ -287,6 +298,18 @@ int led_classdev_register(struct device *parent, str=
uct led_classdev *led_cdev)
>  	list_add_tail(&led_cdev->node, &leds_list);
>  	up_write(&leds_list_lock);
> =20
> +	/* Attempt to let userspace take over the policy. */
> +	ret =3D dev_pm_qos_expose_flags(led_cdev->dev,
> +			PM_QOS_FLAG_NO_POWER_OFF);
> +	if (ret < 0) {
> +		dev_warn(led_cdev->dev, "failed to expose pm_qos_no_poweroff\n");
> +		return 0;
> +	}
> +
> +	ret =3D dev_pm_qos_update_flags(led_cdev->dev,
> +			PM_QOS_FLAG_NO_POWER_OFF,
> +			0);
> +
>  	if (!led_cdev->max_brightness)
>  		led_cdev->max_brightness =3D LED_FULL;
> =20

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpwLKEACgkQMOfwapXb+vLVFQCgq6uRYh09bKkC8YqwHtB8k5j/
c14AniUoYt02NAe5SNU6CzPyHr2ymxe8
=dVIZ
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
