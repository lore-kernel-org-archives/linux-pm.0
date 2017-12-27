From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Thinkpad x60 hibernate broken on 4.13+
Date: Wed, 27 Dec 2017 18:59:17 +0100
Message-ID: <20171227175917.GA9749@amd>
References: <25febf9d-5d45-a7fc-f5c9-4d3bb2828237@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40143 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdL0R7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Dec 2017 12:59:19 -0500
Content-Disposition: inline
In-Reply-To: <25febf9d-5d45-a7fc-f5c9-4d3bb2828237@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Woody Suwalski <terraluna977@gmail.com>
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, Linux-pm mailing list <linux-pm@vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Merry Christmas all,
> Following Pavel's example I have exercised my Thinkpad x60, and noticed t=
hat
> hibernation is broken - it does hibernate, but upon wakeup it goes through
> restore image 80%, and then black screen and dead system. But the fan _is_
> running, so I guess CPU is doing something.
>=20
> I have only done some rudimentary tests:
> 4.12.3 and 4.12.9 are OK.
> 4.13.3 and 4.13.12 bad
> 4.14.5 and 4.14.9 bad
> 4.15-rc5 bad

> Pavel, can you duplicate the issue? All I did to trigger was "systemctl
> hibernate".

I'm sorry, debugging that is not easy for me at the moment.

> Bisecting will be slow as I build the 32-bit kernels in a VM nowadays...

You should be able to build on x86-64 with right .config...

Before bisect, I'd suggest:

a) testing suspend. That should work in 4.13 and 4.14

b) maybe testing with minimal drivers to see if it is one of the
drivers breaking it.

Oh and there's file in Documentation/ describing hibernation
debugging. You should be able to locate bad driver without bisect.

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpD33UACgkQMOfwapXb+vJeswCfd7xtqxp1Y+0oHXvI7aAX2YVd
MckAnjQWpuUw4HAclkq9hDwlqLKDEjvg
=qyoE
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
