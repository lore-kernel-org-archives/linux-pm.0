From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / runtime: Fix some typo
Date: Tue, 21 Feb 2017 22:26:32 +0100
Message-ID: <20170221212632.GA27706@amd>
References: <20170221204153.4803-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52814 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdBUV0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 16:26:35 -0500
Content-Disposition: inline
In-Reply-To: <20170221204153.4803-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-02-21 21:41:53, Christophe JAILLET wrote:
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  Documentation/power/runtime_pm.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/run=
time_pm.txt
> index 4870980e967e..64546eb9a16a 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -100,7 +100,7 @@ knows what to do to handle the device).
>    * If the suspend callback returns an error code different from -EBUSY =
and
>      -EAGAIN, the PM core regards this as a fatal error and will refuse t=
o run
>      the helper functions described in Section 4 for the device until its=
 status
> -    is directly set to  either'active', or 'suspended' (the PM core prov=
ides
> +    is directly set to  either 'active', or 'suspended' (the PM core pro=
vides
>      special helper functions for this purpose).
> =20
>  In particular, if the driver requires remote wakeup capability (i.e. har=
dware
> @@ -217,7 +217,7 @@ defined in include/linux/pm.h:
>        one to complete
> =20
>    spinlock_t lock;
> -    - lock used for synchronisation
> +    - lock used for synchronization
> =20
>    atomic_t usage_count;
>      - the usage counter of the device
> @@ -565,7 +565,7 @@ appropriate to ensure that the device is not put back=
 to sleep during the
>  probe. This can happen with systems such as the network device layer.
> =20
>  It may be desirable to suspend the device once ->probe() has finished.
> -Therefore the driver core uses the asyncronous pm_request_idle() to subm=
it a
> +Therefore the driver core uses the asynchronous pm_request_idle() to sub=
mit a
>  request to execute the subsystem-level idle callback for the device at t=
hat
>  time.  A driver that makes use of the runtime autosuspend feature, may w=
ant to
>  update the last busy mark before returning from ->probe().

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlissIcACgkQMOfwapXb+vIJvQCgxNgWflpX2MIAmFR7RBoYk+oj
ElEAoKE0aMz/OY6LR8sT1h80lueblxPN
=GhXI
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
