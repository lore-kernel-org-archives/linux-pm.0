From: Sebastian Reichel <sre@kernel.org>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Sun, 21 Feb 2016 21:06:53 +0100
Message-ID: <20160221200653.GD15242@earth>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
 <20160212085157.GA16326@amd>
 <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com>
 <20160215115304.GA5014@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60859 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcBUUG7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 21 Feb 2016 15:06:59 -0500
Content-Disposition: inline
In-Reply-To: <20160215115304.GA5014@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Linux PM mailing list <linux-pm@vger.kernel.org>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 15, 2016 at 12:53:04PM +0100, Pavel Machek wrote:
> > >> some time ago I did post series which added some conversion table fr=
om
> > >> voltage to percent for charging and discharging states [1] in
> > >> twl4030_madc driver. This approach was not accepted and we still want
> > >> to have something like that in kernel. We re-think re-thinking
> > >> original idea and also get reference where Pavel point us to formula
> > >> which could be used for computing voltage-to-percent conversion [2]
> > >>
> > >> What about adding this formula as a default for the
> > >> voltage-to-percent-conversion to the generic-adc-battery
> > >> driver (and converting it to DT)? Would that be a better
> > >> solution than a table driven and twl4030 only driver?
> > >
> > > I'd say battery, yes. And maybe even better would be putting it into
> > > lib/ or seaparet driver, as it does not really depend on IIO? You just
> > > supply voltage, current and internal resistance, and it produces numb=
er...
> > >
> > Can we put this small helper to some common power header file
> > which can be then included to driver which can use this formula.
> > I think it's better way then adding it to /lib as it won't be
> > used in whole kernel tree just in power. What do you think?
> > Thanks.
>=20
> Sounds good to me.

Sounds fine for me, too.

-- Sebastian

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWyhjZAAoJENju1/PIO/qa1wQP/A4rGuPZwz23XjAN/zterQWd
+awuXetgxZDWRcifrKLq8MRfYQLRWn33XLVd/pOFeXwdHAJmLzFcZNi5AO7IhIEc
mrXAFIzOQMopRpUTo036vlPKUPnMU8OvitOa+aTJ3qzGFo2d9moUn8iW8OKan3cc
c/czQsRGbVavHNacX+XZxtWmdPTY53Jh0nr7+1lyT1p4QE4Zadx6E7uOZHJrE995
lqRDMCzf0Ei1IetlQnJBR1ol5IhLTNMOIW0/pdq4ouwQe5HV6ujg50McW3VpSz8p
EMGkD+y9ux58jOuQps2Dwscfa7fWG7+sdqswSQdGjxfGr7S338k0xyWlIAHkDO62
CmeX+3rfurna399EpNcX3vwNkQz9qieiGTbtOYw0ksCtrxvOusQw1lIuSwv4qyjz
2536kR7vJI0U4NrWifQ92MSaKvUJy9Y8/UfoRNgKuQ41Voi/Wsu5pemesOjs8+p0
ojRPxYDcDqjqrFjjrYI7le3I7ibbBiF3flOdgrcdcC8DKOQ0NmxzfEupyB/6TviI
yGMuk0E70ypSeB6K4KYSZx4HVBalV68z1uUhDDGVdjaiOPsUn6ek0CvCvXm40Dsz
dbluxuAYyfSb7fsRVYvKGxschQ4/iMK/pulUwF162WEMMqi4iSB6NLLTbMLPrrqz
TcHXjmR9zLqU937UClXe
=gde8
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
