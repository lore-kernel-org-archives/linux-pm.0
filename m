From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 01/10] power: supplies: bq27xxx: rename BQ27500 allow
 for deprecation in future.
Date: Wed, 11 Jan 2017 00:29:11 +0100
Message-ID: <20170110232910.62ec45a2obg43zq4@earth>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1484025938-114133-1-git-send-email-chris@lapa.com.au>
 <1484025938-114133-2-git-send-email-chris@lapa.com.au>
 <20170110085825.GA11770@pali>
 <a7f219cf-8d53-867a-89df-93d603422643@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="clhkg3dnm3cq6hti"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757379AbdAJX3T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Jan 2017 18:29:19 -0500
Content-Disposition: inline
In-Reply-To: <a7f219cf-8d53-867a-89df-93d603422643@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--clhkg3dnm3cq6hti
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 09:25:01AM +1100, Chris Lapa wrote:
> On 10/1/17 7:58 pm, Pali Roh=E1r wrote:
> > On Tuesday 10 January 2017 16:25:29 Chris Lapa wrote:
> > > From: Chris Lapa <chris@lapa.com.au>
> > >=20
> > > The BQ275XX definition exists only to satisfy backwards compatibility.
> > >=20
> > > tested: yes
> >=20
> > Instead "tested: yes" we use: "Tested-by: name <email>" line.
> >=20
> > > Signed-off-by: Chris Lapa <chris@lapa.com.au>
> > > Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > > Reviewed-by: Andrew F. Davis <afd@ti.com>
> >=20
>=20
> Doh, I went through the log and thought I saw 'tested: yes' being used
> previously. Want me to resend?

If a respin is needed, please fix it. Also the patches still use
"supplies" instead of "supply" in the patch subject. I would have
fixed this while applying, but this (PATCH 1/10) actually looks
fishy to me:

> -       { "bq27500", BQ27500 },
> -       { "bq27510", BQ27510 },
> -       { "bq27520", BQ27510 },
> +       { "bq27500", BQ275XX },
> +       { "bq27510", BQ275XX },
> +       { "bq27520", BQ275XX },

Previously bq27500 and bq27510/bq27520 had different type ids,
while after the patch both use the same. The patch description
does not mention why this is ok and it actually looks incorrect.
I guess we need to introduce BQ2750X and BQ2751X for backwards
compatibility instead?

-- Sebastian

--clhkg3dnm3cq6hti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh1bkQACgkQ2O7X88g7
+primxAAqdQSlVtHyv3cedjZZzmcn77KTAKsXQ4hY1OyZ3d2jOFEInxVB+AxZKvq
NsmqvJ2urT+m9wcKQr/nowq8J4w0PRCY9Ek/6sUDbFOkflvrB2849TZ/OaMWw/Dr
0I5Z8HBGF4DpOKeQJaE++NA18Y0gMK+2uZQf1KL4D6aqG0p8eucbIHTgyMK+cgpB
aml+vYS//sFQnCyCVL0ten3QRiLjHb6IkYHMcc7LHvZRyLRa4Sc+FQpMNQ7mmCNs
nTMTDMO+KW49P48YycAeRxkJRzGjGrLTW0L6+k+7xr41X3jgFuVjfpdFkXMiCPoY
X1W6NjqAC+79AS9u83nfA56D5qbshD6+X3hYaUPy/T0K00DBYsPoPVzONn/6F1tt
sEPKdZh6QgnPsdUetGN/d5i5EJndI3aAtb4JaSV5hyzd096ChvHu/ydnGE/N+cC4
uL792g0D9RHy5S786AD8TzTDOQnR98gye88kTBk6OGbgI6DF6PnmMe/OtKjm0d/S
bAwmdzzFMuuBpZ5CMW6ECp2wv0LhWf2w3Xgaa3k2ESqy4vB53w908EdEaDq5kqRZ
aJ8VS3E7Z8WvNWUS2snlKlcR4qW5A0P8gOxii/omTE8ibm6zPyA51qlnIK/KCZoj
jpV+vkYe6zbwsu1sFwGOHbNwoCyr75R1zjSsM3NoTRVmzMirpcc=
=fbTb
-----END PGP SIGNATURE-----

--clhkg3dnm3cq6hti--
