From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 51/51] power: suspend test: stop using rtc deprecated
 functions
Date: Tue, 20 Jun 2017 14:10:35 +0200
Message-ID: <20170620121035.GB13221@amd>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-52-git-send-email-benjamin.gaignard@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60806 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbdFTMKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 08:10:37 -0400
Content-Disposition: inline
In-Reply-To: <1497951359-13334-52-git-send-email-benjamin.gaignard@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linaro-kernel@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-06-20 11:35:59, Benjamin Gaignard wrote:
> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllJELsACgkQMOfwapXb+vItPACfWZa9Zvws5xviE1Uo93s0SZFX
nmAAoJE89i+iligrXRD5h2/QONUrMghS
=0Eaj
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
