From: Pavel Machek <pavel@ucw.cz>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Thu, 3 Nov 2016 10:57:58 +0100
Message-ID: <20161103095758.GA7973@amd>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
 <20161018104539.GB15639@leverpostej>
 <20161019094227.GB1461@amd>
 <20161019131145.GA11036@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54552 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbcKCJ6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2016 05:58:01 -0400
Content-Disposition: inline
In-Reply-To: <20161019131145.GA11036@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, yoma sophian <sophian.yoma@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2016-10-19 14:11:45, Mark Rutland wrote:
> On Wed, Oct 19, 2016 at 11:42:27AM +0200, Pavel Machek wrote:
> > On Tue 2016-10-18 11:45:39, Mark Rutland wrote:
>=20
> > Either the lowlevel suspend code is stable and bug free, and then
> > having that code is not a problem.
>=20
> This ignores the cost of maintaining that code. Kernel APIs change over
> time, and no code is ever completely stable, even if at one point in
> time it happens to be bug-free.

Well, kernel interfaces only change when there's good reason for a
change, and if you force stable binary interface to external
component, and there _is_ need for a change, we are all screwed.

> > BSD is better than closed source, but it also means that you will not
> > get the sources from your hw vendor.
>=20
> That depends on your hardware vendor, as always. There are a number of
> platform ports in the upstream ATF repo.
>=20
> It's also worth considering that a number of 32-bit arm parts require
> closed firmware (as far as I can tell, including the N900).

Yeah, but we are trying to remove closed firmware. Don't make people
add more of it...

> > Being separate module means it will be hard to debug, in area where
> > debugging is already pretty hard.
>=20
> It can be harder, yes. There are also benefits, given the same code can
> be tested on a variety of platforms.

What benefits? You are able to share code between platforms in kernel,
too.

> > Can it do advanced stuff like deep powersaving on N900 idle?
>=20
> Sorry, I don't know precisely what you're referring to.
>=20
> It can do things like shutting down entire CPU clusters (and IIRC
> associated interconnect) when all relevant CPUs are idle, if that's what
> you mean.

I mean equivalent power savings between idle system and system in
s2ram.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgbCiYACgkQMOfwapXb+vLsFgCguiSXLt6seNAL57Hxe8Pcgomp
J4YAn08H6jICj8MtAn+vQNdlvpCc/T3t
=PIH8
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
