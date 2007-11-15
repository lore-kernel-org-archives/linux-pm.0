From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] PM: make freezer optional for suspend
Date: Thu, 15 Nov 2007 17:47:26 +0100
Message-ID: <1195145246.13846.68.camel@johannes.berg>
References: <1194980670.6695.1.camel@johannes.berg>
	<200711141421.15812.rjw@sisk.pl>
	<1195051139.4091.12.camel@johannes.berg>
	<200711142230.14662.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4402927386763830984=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711142230.14662.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============4402927386763830984==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-clkZfCukoTgZIdQrQ/1+"


--=-clkZfCukoTgZIdQrQ/1+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > > > +config SUSPEND_FREEZER
> > > > +	bool "Enable freezer for suspend to RAM/standby" if ADB_PMU || BR=
OKEN
> > >=20
> > > Hm, is ADB_PMU specific to powerpc?
> >=20
> > Yes, and it's the only code that allows you to suspend w/o the freezer
> > right now (via PMU specific ioctls)
>=20
> It's a bit confusing for someone who doesn't know what ADB_PMU is.
>=20
> Perhaps it might depend on something like ARCH_CAN_DO_WITHOUT_FREEZER ins=
tead?

It can't really. Things break. Ben and Paul just don't want to hear
about it. I made it depend on BROKEN so people can take it out and see
what breaks (to possibly fix it), and depend on ADB_PMU so they can have
their favourite setting without enabling BROKEN.

johannes

--=-clkZfCukoTgZIdQrQ/1+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzx4HaVg1VMiehFYAQIiGg/8DFL/Aln+Kip7Pg/lSZNMqALAuBVrThrN
NMI27Bgd2lC87MDd774+s/j86RlJ2/yHhT9lgqWR7XQ7b898Znz90dBua1E6s3Gp
McKnBSwVwuqxyS0fBzLwQfiznn/TyaE9AZK24h8wJzNRQd2sXYtoc+C20RaD2GGf
P2q9ZMosnf0K1vBQnv92/PUCx6Zv8nhRv+UZt7ug6m9sv51ipq3zCYqj+k3CyT5m
KyKOO4k8HXAUphFxFapVYcBQ1d6+Yss5R36EWzQ1qxT+cVz7877mh5tD0UA+BINp
NIOUhneDnZRw2YoIK9CjhPsIcOaT3u08DqsbJW0Q9mTS0Pi5QE5oLBZIePS2CcXJ
eqVQD9efmViU4p7QdvMpexxl9ZUbNAkjSsVF+HUUDi/kKEggADuf5wXFLwYufxKt
19x4vQ5tBzD27wS5TPxTtc9yqfwd1r9gHhSHRr6NnfsY8lvQ0BBoUnhbq5V4dm1B
K9QJV89wemSARVL7LHewD1WGtHModfx39JQFmA+vCLTlY4rH7hno/s8Y3n4un4Gf
LtBSJvhsfliqfpZd4nm1MPg8M7ML/LTzdLbZFM5TpP5o+O4t0smUbWWMaN8P+74N
KHkQlia45YwrUofZx5179NzZAhJTtLSmnMLxt+0RQbnssY7cgurME4z5XY3/fpM2
8jsI46XzooA=
=y7FA
-----END PGP SIGNATURE-----

--=-clkZfCukoTgZIdQrQ/1+--


--===============4402927386763830984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4402927386763830984==--
