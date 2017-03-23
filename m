From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 07/10] power: bq27xxx_battery: Keep track of specific
 chip id
Date: Thu, 23 Mar 2017 13:30:54 +0100
Message-ID: <20170323123054.jyngk44mea435cal@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-8-liam@networkimprov.net>
 <20170323102825.vvxfzvuvvnhyzlna@earth>
 <CAKvHMgQsuTNcGUXZL7qk_YZ+qcdcLJ1+1xPB0zP97DqiitHJXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tmkpew3cdrfjcqut"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755258AbdCWMbA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 08:31:00 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgQsuTNcGUXZL7qk_YZ+qcdcLJ1+1xPB0zP97DqiitHJXA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--tmkpew3cdrfjcqut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 03:35:33AM -0700, Liam Breck wrote:
> On Thu, Mar 23, 2017 at 3:28 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Mon, Mar 20, 2017 at 02:43:32AM -0700, Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> Pass actual chip ID into _setup(), which translates it to a group ID,
> >> to allow support for all chips by the power_supply_battery_info code.
> >> There are no functional changes to the driver.
> >>
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >
> > This is really ugly. If we need chip ID and group ID let's store
> > them in different variables. For example put the detailed chipid
> > into di->realchip and then do
>=20
> I tried this in a previous version, and Andrew rejected it as
> confusing to have two IDs. That was while you were away on business
> :-)

now we have two IDs in the same variable.
That definitely more confusing. We can name the second variable
group to reduce confusion.

-- Sebastian

--tmkpew3cdrfjcqut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTv/4ACgkQ2O7X88g7
+pp5phAAk/ogfCCqrq2DHk7T681p+6fUqlR+VEY0IO/vS7OgjBFcz2WLD+vJd2Dq
E85Tidx/29kUFmmEinp8XEj2BrHGfjGFTqbzTr36LEsuuisGDxZO02xYlrX9qUdd
bFSCBvHQu1fdrUQ9H2By6sSgeywIBOYLi78iEcyxaZTviNNrQLOhX8bbkXOM31NK
O6peUr9x7GaRceibJItwpwWU5WavfC2auQGCTYqGg5aIU9TUNu7QP2gHYoL/1daB
d7SCYELZ3TMghr0nOE8E0kZRF5WyNYdQDm+Qn8ICNcaOSOZivYv1yCweL0Jo/Bxn
KmKalMbgapYZq2PB3oH9buznPAFvXr8OwKyCZBltno6UsMk01xXLZGuzVLuTFPd9
TWRJYSwpWG8kZ2On9ApN7/3JTBEueKTPvdE3OMMSZJBWa6oquINFjbIvG6N6hus8
/FxlB8ucaeZaL9a/Kup0UI5Q8NXFrQ7LjYPO5byuAWnjHkwP4SRKNyh6S+1MxkXj
cX17K2TmzqqxNjpGM+2MslrRNropDcIt1SjrTJlTKGNBGzjSpaxcPMVTztTOQ0f3
f3rc/Lm+QHzDk9FaJ4tJKfIWcOtMJ8p+Q6ClTIa0RNOefBfvsiRoqNKNs5aptXok
v0StGVElPtqQQcU0iYWcws/8Ey4grgLg0+BYDlL8BlCKCxqc6XI=
=AtqB
-----END PGP SIGNATURE-----

--tmkpew3cdrfjcqut--
