From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Wed, 7 Jun 2017 09:52:18 +0200
Message-ID: <20170607075218.GA6268@amd>
References: <20170430182727.24412-1-contact@paulk.fr>
 <20170430182727.24412-5-contact@paulk.fr>
 <20170528191619.GA20159@xo-6d-61-c0.localdomain>
 <1496249719.1774.1.camel@paulk.fr>
 <20170531173207.GA10763@amd>
 <1496258936.2038.8.camel@paulk.fr>
 <1496819733.927.16.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55843 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdFGHwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 03:52:21 -0400
Content-Disposition: inline
In-Reply-To: <1496819733.927.16.camel@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I'd pass to userspace what the controller reports. Yes, I seldom see
> > > "STATUS_FULL" but that may be a problem we need to track down.
> >=20
> > The controller is known, from my experience, to not be reliable in that
> > regard,
> > so I don't think it makes sense to pass a state that doesn't reflect the
> > actual
> > state of charging just because the chip tells us so.
> >=20
> > Worst case, we could also have a dt property to enable that kind of fix=
up
> > workaround and let every device maintainer decide whether it is relevan=
t for
> > their device.
>=20
> Actually, since a similar fix[0] was accepted in sbs-battery, I'd rather =
not
> make this optional but rather make it the default and perhaps have a dt p=
rop to
> disable it.
>=20
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?
> h=3Dv4.12-rc4&id=3D7f93e1fa032bb5ee19b868b9649bc98c82553003

Is there some documentation that explains what different power supply
statuses mean? Because without that, we can have long and useless
discussions.

If you have 40Wh battery, and you are charging it with 1mW, I don't
believe you should be indicating "charging". That battery is
full. Yes, even full batteries are sometimes charged with very low
currents to keep them full.

And I'm not sure what this is supposed to do, but its quite strange
code.

+static int sbs_status_correct(struct i2c_client *client, int *intval)
+{
+	int ret;
+
+	ret =3D sbs_read_word_data(client, sbs_data[REG_CURRENT].addr);
+	if (ret < 0)
+	   return ret;
+
+	ret =3D (s16)ret;
+

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlk3sLIACgkQMOfwapXb+vJvXwCbB2DP5Hbw0QX+xiLXWUMXMl14
nBsAl1PmZ0SJzkhgFtc2Px7t2YHUAhY=
=S/AN
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
