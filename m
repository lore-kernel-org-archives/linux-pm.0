From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: nomadik: move runtime suspend of hw to _noirq
Date: Thu, 14 Jul 2016 22:40:15 +0900
Message-ID: <20160714134014.GI4149@tetsubishi>
References: <1464008356-21162-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFpvwQkqS9TRCj+JCOro-fdbkPKrXr6V7eEeSJLMah61Ng@mail.gmail.com>
 <CACRpkdbFvRKpzY82qWpt6CNLEe8GfgaSOJPaebaanOWbT7mC9Q@mail.gmail.com>
 <20160619171221.GD2933@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32932 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbcGNNkX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 09:40:23 -0400
Content-Disposition: inline
In-Reply-To: <20160619171221.GD2933@tetsubishi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 19, 2016 at 07:12:21PM +0200, Wolfram Sang wrote:
>=20
> > > This is indeed a generic problem, as we don't have a way to describe
> > > these kind of dependences between devices. In other words, we need to
> > > control the order of how devices becomes suspended/resumed. If that
> > > could be done, we could likely avoid runtime resuming devices
> > > unnecessarily.
> >=20
> > Correct, keep me in the loop and I can test some patches.
>=20
> So, this patch is discarded in favor of a generic solution?

Yes?


--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh5Y9AAoJEBQN5MwUoCm2wEkQAJb4fZ+8M0vDXdFE3XHBmqEP
7AYyxuyZW2stNe/MX3DRhsFJI2lPYwl5Xb3bewEIttAgqbwJPS2BL1z9qeTy0jmm
8PeDQq82GokWW4JKa0fssIMe2EQg2AVXPLwWCo/B15yQXNpJd4OqjEseRdzKLzDQ
3dc7tJWA0m9ZQ47VoIcw0eKGmm94IJ+23rSm8Rs11eHEGguVhW7XiRtfLo7vReI5
3pj7jqhfivD83bC4bJuPObuH1aHUnc4ySonHMCEw8/ljxJuugfgscv2cmLcLnD9W
CVrbgZ5NSE1xnNRjPJaUz7QjwZeTMYk7EgXmOB45HbhE2hNulEipOYiI+tLtWuLW
hGZZ4pwjCWaw+ackrJg5nwg7RsdEJ7dbCbuLzO6i5WwW/tEqb1tegkgzSEkap7E1
zqnOPh6qs4ue2QxE6tNYHAfyaIcDTsqwKI90x68zgqOU06To6hPD586e7H+bABvR
CZK+b6AhjUaD/6D1DhTYaEYyMWUOOufaycLf1HYZEUjkmr4na0y+9rGEcs95+mSc
MlfWU7euU2efLtQ3GPFzyM6TAMbpDafqsJruOVsYEgSaiLtcGIrsBh5k8ujOynhY
w4lRsCleSDjsj5fBlxeaefNDt3ZDTPhjzXLTrV8iAgZ3lMAgLPffAaSwKeaJU2m6
DGI5RhIn3saaugsW0aRh
=3bpH
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
