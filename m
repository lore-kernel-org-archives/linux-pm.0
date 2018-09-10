From: Pavel Machek <pavel@ucw.cz>
Subject: Re: next-20180910: boots on thinkpad x60 (32bit machine) but has
 problems during suspend
Date: Mon, 10 Sep 2018 16:16:54 +0200
Message-ID: <20180910141654.GA881@amd>
References: <20180909214632.GA26303@amd>
 <20180910060533.GA26941@amd>
 <20180910075053.GA26513@amd>
 <alpine.DEB.2.21.1809101457400.1292@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809101457400.1292@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
List-Id: linux-pm@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Next -0910 seems to boot ok... but when I hit the power button to
> > suspend the machine...  Full dmesg is in the attachment.
>=20
> Is this a next only issue or is this happening on Linus tree as well?

I believe this only happens in next. I'm pretty sure v4.19-rc1 was
ok. Let me check v4.19-rc3... that one is ok.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluWfNYACgkQMOfwapXb+vJHawCgpDQeuxIRhK8tI17jGRAC7pOd
nE4An37wUZCLB71xtApUxr6QB2FnBFW6
=HlhM
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
