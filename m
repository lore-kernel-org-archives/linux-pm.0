From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC v2 1/5] power: supply: bq27xxx: Create single chip data
 table
Date: Sat, 12 Aug 2017 12:39:12 -0400
Message-ID: <20170812163912.xsuyj6dlq5upguz3@earth>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-2-liam@networkimprov.net>
 <20170809160621.xcfwrerbe2ztehd4@earth>
 <CAKvHMgRebOYrfM4gYGiEBwVhFCi28Q9wdrZ69hrg9n0PBbeZgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qxphmppf6cmggxuw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50536 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdHLQjS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2017 12:39:18 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgRebOYrfM4gYGiEBwVhFCi28Q9wdrZ69hrg9n0PBbeZgg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--qxphmppf6cmggxuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 11, 2017 at 05:52:50PM -0700, Liam Breck wrote:
> On Wed, Aug 9, 2017 at 9:08 AM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > On Sun, Aug 06, 2017 at 11:22:12PM -0700, Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> To support new features which require different data for each chip, we
> >> unify the bq27xxx_regs and bq27xxx_battery_props tables into a single =
one.
> >>
> >> No functional changes to the driver.
> >>
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >
> > Looks fine to me.
>=20
> Regarding the whole series? If so, I'll post a fully-tested
> "PATCH" version...

I simply ran out of time to review the remaining ones. You should
have replies on all patches now.

-- Sebastian

--qxphmppf6cmggxuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPLy0ACgkQ2O7X88g7
+po/UBAAqS0Kob1W8Gy0M0v8rv6xkdKfByWQt9iT339PXnIH9ybaJcnt5WTNPNyI
zl0f/O2Pm7OscW5v1pX0y4yS8tQlgh/0vj1CtS0Er3L6OKW7ose5MmQAc8+ExaaZ
OLlSQs4yLq6hIq6g7VzwEoyXeTi+L/16G9ofCfTUWQs/ksHlW2KUykKMRf+qCyAu
e39vpiWaoXjuV0S3MACXfOQ7tJvpmm6dpuo/9RwrNO6xkclREE0XrzxXr1ikZRtJ
pz+EVD2jZG+03VOZsJGpISAy8cPMKsdycnY6q1UedtRpLuBMYuW8N5M0/KMCv/7L
xtMCnAkH8OiPob6F1WTbqP8fadgAOAis/UZsGHjQFpeafn09tt1heCGVErCwDB5C
e1UZxIGhBkdhKpxt4Ok8sjQ9gixFNgCUQ3HzeZ/9cAMacqCRo+GNzORYM54pJEwg
uD3W6MvrOjxxd7c1v7qEkEoGRLY/6tUzVSE/C/xFbFoVX+1ksTwVJuqKo4qsEl44
SA4GM0GrbxuOiJBqfxoxR+S9WxxJCDQ3xqzmdU3flI1QeS8uPIKdGx58F9jB/LBV
pWsOm6wbALbdXc972eHVzwgqHJYCs59v+7b4monbRDnyqAEWkUY33NEI+NhuPbcl
fu52yelDjjvjaGSy0D1TYMaX60z/W5fsUhdTHTg28Fee7kFm4Xw=
=/3kM
-----END PGP SIGNATURE-----

--qxphmppf6cmggxuw--
