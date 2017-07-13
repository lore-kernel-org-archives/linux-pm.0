From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM / Suspend: Print wall time at suspend entry and exit
Date: Thu, 13 Jul 2017 10:54:08 +0200
Message-ID: <20170713085407.GD1363@amd>
References: <20170605193157.59875-1-salyzyn@android.com>
 <CAJZ5v0iLFw68RxzkgyFF_WhxO-nzr0nWoZjq-uEEU6+UzMB7cQ@mail.gmail.com>
 <20170605211835.GB9035@amd>
 <5931f9cb-016f-4163-4908-6825cf84b9d3@android.com>
 <ca5fb419-386f-9e27-43c4-677be6f0ae4b@android.com>
 <20170605224011.GA26558@amd>
 <e9c40b99-7fa7-71b2-5917-250d638a5162@android.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e9c40b99-7fa7-71b2-5917-250d638a5162@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >And userspace should not really be parsing kernel logs for time
> >keeping, right?
> Post-mortem, armed with user space logs in CLOCK_REALTIME (a choice that
> most want on Android Logging) and kernel logs, these messages are
> _invaluable_ in order to merge the kernel activities with user space. At
> runtime they help too, as there is some post-mortem activities on user sp=
ace
> logging daemon startup.
> >The devices you are talking about... is any of them running something
> >close to mainline kernel, or is planned for merge? I'd like to get a
> >phone that is supported by mainline...
>=20
> Android on hikey development board is running 4.9 kernel + Android patches
> (this is one of 'em), I _expect_ ToT will work. As for _real_ phones, you
> have to take that up with the vendors making the chips.

Well, there are real phones with mainline Linux: Nokia N900, N9, N950,
Motorola Droid 4.

Current kernel is 4.13, not v4.9.

Yes, Qualcomm is a problem. There are other vendors, you can get those
phones in retail. So no, I don't think android community is doing a
good job. I don't think it makes sense to merge patches that "help
debugging" when basic support is missing.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllnNS8ACgkQMOfwapXb+vJ6GACeP2tusmfKJPMpHhAsukkrIs+C
E4IAoL0tLer/ttrN1+m6ke8Vl+04lE/V
=2zMt
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
