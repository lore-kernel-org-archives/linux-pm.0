From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: disable runtime PM correctly in slave mode
Date: Wed, 16 Dec 2015 16:43:58 +0100
Message-ID: <20151216154358.GA14817@katana>
References: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
 <Pine.LNX.4.44L0.1512161011070.1751-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1512161011070.1751-100000@iolanthe.rowland.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alan,

> > When we also are I2C slave, we need to disable runtime PM because the
> > address detection mechanism needs to be active all the time. However, we
> > can reenable runtime PM once the slave instance was unregistered. So,
> > use pm_runtime_disable/enable to achieve this, since it has proper
> > refcounting. pm_runtime_allow/forbid is like a global switch which is
> > unsuitable here.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >=20
> > I'd be grateful to get an ACK from a runtime PM expert to verify that my
> > assumptions match reality :)
>=20
> Yes, disabling runtime PM will do what you want.  However you might=20
> consider using pm_runtime_get_sync() and pm_runtime_put() instead,=20
> because pm_runtime_enable() does not check to see if the device is idle=
=20
> and can be suspended right away.  Alternatively, you can call=20
> pm_runtime_idle() after pm_runtime_enable().

Thank you for your answer! I think I'll go for the get/put solution
here.

I have another case, may I ask your advice about this, too? When an I2C
bus is marked in DT as multi-master, then RuntimePM also needs to be
disabled, because arbitration detection needs to stay awake. I am
currently implementing this for the i2c-rcar driver:

-	pm_runtime_enable(dev);
+	/* No RuntimePM in multi-master to keep arbitration working */
+	if (!of_get_property(dev->of_node, "multi-master", NULL)) {
+		pm_runtime_enable(dev);
+		priv->flags |=3D ID_P_PM;
+	}
+
 	pm_runtime_get_sync(dev);
	...

@@ -664,7 +673,8 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	struct device *dev =3D &pdev->dev;
=20
 	i2c_del_adapter(&priv->adap);
-	pm_runtime_disable(dev);
+	if (priv->flags & ID_P_PM)
+		pm_runtime_disable(dev);
=20
 	return 0;
 }

Here, I'd tend to keep using enable/disable, although get/put would
probably also work. What is the rule of thumb using this pattern or the
other?

> pm_runtime_allow/forbid is even more unsuitable than you said, because
> it can be overridden by the user.

Yeah, I realized his today, too.

Thanks!

   Wolfram


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcYa+AAoJEBQN5MwUoCm2oCEP/i6mheCzF6WeX+70JSBScvA4
xiBw5MZJjW029uGJ376CL3kidz/OKTkgeGesmmieUhbyZfxBmg/yPA7am+ji60Bm
js3sY6WtdebURRhwSgzbEv8RBsNwIUNTCY0+4u0y/KpMeFo4tbu0zySyfEttSwNK
m6QOBlJwEQVxF+DwSAr+Mh1ld1YeamsxqwsB7Te+Gba7ayXnVR+A5DM287T4LV62
lzZ5epyWPS4BfYuZF/+HcGVZF6jA9OChOXXBSJBKY9UQzsXK5CbEkUq5lUr6h1RZ
8iHqbRD7GL0rBDg4+Ydh5IBA5iZiR+SEMFz8wsDVPHDjjyS/eQ1q42/9Z2Ft2Qad
FEZrRiiOERcisBr1q9rI7+48dcWuh0nlJExByECMrskpTsDFru361Nq1GE23VUXg
9/IN8cGKdGIIwIQrRLFPXLX3hhZO+Hon895vrDLLm+zFj9hC9fuE76eIjHis1MFM
0Kc0fdkOYF27F2UC4/Y1c97mgMvLq8Mz1+3s95e9RKz69AYBFbklNrzkzEszpPAt
EHImXYzsbfAT03JybMmBfLU6INwCCi4FhzyJDxijriPzgWf2hR2KALa5POsrZV9F
hmsl9kgeoU7mEQmvVZbbXXK5S6/i1PSzyk3MFPvgujjW+LSavxHdCg+mawU0XUEr
cE76rmIl0B4XC8RpmYrv
=i5qV
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
