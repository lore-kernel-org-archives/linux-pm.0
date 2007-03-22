From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 11:03:05 +0100
Message-ID: <1174557785.3944.74.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<Pine.LNX.4.60.0703212325560.7211@poirot.grange>
	<20070321225730.GL6057@elf.ucw.cz>
	<200703211625.23253.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1418194690=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703211625.23253.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org


--===============1418194690==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-b1azxHY+jV4E455YpsEq"


--=-b1azxHY+jV4E455YpsEq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 16:25 -0700, David Brownell wrote:
> [ removed crosspost to linux-arm, members-only ]

My mistake, sorry about that.

> And remember that the implementor must make various decisions in
> any case, since the SOC probably has half a dozen distinct
> low power states, but Linux can only name two of them.

Actually, now that we have everybody using .valid we can add an
arbitrary amount of them if we wish :>

johannes

--=-b1azxHY+jV4E455YpsEq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAlRZ/ETPhpq3jKURApn1AKCFpcxR2X+IcIi4rUIuJ/yL9irKGACePcnB
8/ArRhqYXNsHLXPMUXp7RUQ=
=bAxH
-----END PGP SIGNATURE-----

--=-b1azxHY+jV4E455YpsEq--


--===============1418194690==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1418194690==--
