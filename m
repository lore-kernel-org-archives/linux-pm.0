From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 32-bit user suspend program on 64-bit kernel?
Date: Wed, 21 Mar 2007 15:14:52 +0100
Message-ID: <1174486492.4230.38.camel@johannes.berg>
References: <1174468281.3769.7.camel@johannes.berg>
	<200703211505.52812.rjw@sisk.pl>
	<1174485879.4230.36.camel@johannes.berg>
	<200703211517.20297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1213026783=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703211517.20297.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1213026783==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7KffsVKvcuoXwGTMzMoJ"


--=-7KffsVKvcuoXwGTMzMoJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 15:17 +0100, Rafael J. Wysocki wrote:

> Well, the change itself wouldn't be big (three #defines or so), but it wo=
uld
> break all of the existing setups.
>=20
> Alternatively, we can add some ioctls that duplicate those with nonportab=
le
> numbers and tell people to use the new ones in the future (documentation
> changes would be needed).

Sounds like a plan then, no? Make them print a big warning that people
actually see and put the other numbers on the feature deprecation
schedule :)

I do have a 64-bit powerpc that runs 32-bit userspace exclusively,
that's why I asked.

johannes

--=-7KffsVKvcuoXwGTMzMoJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAT3c/ETPhpq3jKURAjPVAJ97iV1xPq/Nl6L7kQ4eUbCezzgNEgCgnozG
IwDxHNsddC9cai/RehNSShk=
=MbEO
-----END PGP SIGNATURE-----

--=-7KffsVKvcuoXwGTMzMoJ--


--===============1213026783==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1213026783==--
