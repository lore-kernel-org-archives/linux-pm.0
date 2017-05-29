From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] regmap: Add OneWire (W1) bus support
Date: Mon, 29 May 2017 14:13:46 +0100
Message-ID: <20170529131346.gsauzllpplc2e7vy@sirena.org.uk>
References: <20170528071120.6604-1-minimumlaw@rambler.ru>
 <20170528071120.6604-2-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="appagsrjfio4i6qw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58318 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdE2NOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2017 09:14:00 -0400
Content-Disposition: inline
In-Reply-To: <20170528071120.6604-2-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--appagsrjfio4i6qw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 28, 2017 at 10:11:18AM +0300, Alex A. Mihaylov wrote:

> +	int ret = -ENODEV;
> +
> +	mutex_lock(&sl->master->bus_mutex);
> +	if (!w1_reset_select_slave(sl)) {
> +		w1_write_8(sl->master, W1_CMD_READ_DATA);
> +		w1_write_8(sl->master, reg);
> +		*val = w1_read_8(sl->master);
> +		ret = 0;
> +	}

I asked you to move the error handling into the else case in these :(

--appagsrjfio4i6qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlksHoYACgkQJNaLcl1U
h9Axzgf+OQ1lRt47CeOFYAAhNsd/ElaMkoJMM8/7USx6FE/HJfHESbuJ4+MOl3Wy
useeBD+GyI8Q5icP5Jmj4UzqdGrXj0eYzOVDsnEmuuBiFv/L5wfWn3SjJH97fB7A
IAhCh6zlOkm9uOCajx45dhztIGJrbHD18pvKOhnk4mKGcqIqAJjyIBDZXAgqVUfv
8wYaQ+uvYFG3a1WOm7Ou0jmmIo80ltMuXPSD4JFlKwzYV/d5Nu+pPX0WZs9CSaYk
11y5+GNcVLbww8aL1imsSqlaX0yTMYyGTDc94WY8es0/Jo6Z6J2iDHd2omiKkOSJ
yL5Wx6pSVHUXmEYtZUzSv3bd8IU+Sg==
=3an5
-----END PGP SIGNATURE-----

--appagsrjfio4i6qw--
