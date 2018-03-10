From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
Date: Sat, 10 Mar 2018 14:16:05 +0100
Message-ID: <20180310131605.GA28296@amd>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com>
 <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com>
 <20180303092417.GA30917@amd>
 <CAJZ5v0iVmE0jwRW1f6hnohSVzKsZbLr0axi+VKoR+FQcHM+_7w@mail.gmail.com>
 <20180303204512.GA9259@amd>
 <CA+Y=x3k5tsf+oxTo9YQv195XQpEECfqtFcbCoYGkJVCQsbjWpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+Y=x3k5tsf+oxTo9YQv195XQpEECfqtFcbCoYGkJVCQsbjWpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Worsley <amworsley@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
List-Id: linux-pm@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, I've just tested linux-next, and it works ok for me on thinkpad
> > x60. (But that's probably rather different configuration from the
> > macbook).
> >
> > Unfortunately, I could not deduce anything useful from the
> > backtraces. Andrew, could you try v4.15 with KPTI disabled ?
> >
> > Thanks,
> >                                                                        =
 Pavel
>=20
> This is 4.15 kernel with KPTI disabled:
> % grep PAGE_TABLE .config
> # CONFIG_PAGE_TABLE_ISOLATION is not set
>=20
> As I expected it appears no more infomative to me.
>=20
> What I really need is some clue as to what is supposed to be happening
> at this point.

You may want to add some printks to see where it hangs.

But maybe before that, you may want to test CPU hotplug, and make sure
s2ram works, etc...

Perhaps basic-pm-debugging.txt is good place to start?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqj2pUACgkQMOfwapXb+vJDIgCZAWZ+L/H4yZdnrsyUO3R4JZXp
wpQAn1X6i4bBkLVxWsYbdV1lpOqomRYu
=onj6
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
