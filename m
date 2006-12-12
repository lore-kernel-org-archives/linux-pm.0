From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 0/3] experimental G5 powermac suspend implementation
Date: Tue, 12 Dec 2006 13:21:07 +0100
Message-ID: <1165926068.22338.15.camel@johannes.berg>
References: <20061211230208.526233000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1421703441=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20061211230208.526233000@sipsolutions.net>>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>, Michael Buesch <mb@bu3sch.de>
List-Id: linux-pm@vger.kernel.org


--===============1421703441==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pAgtPYD2UrDsob/q3e/K"


--=-pAgtPYD2UrDsob/q3e/K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Date/time is restored to wherever it was when suspending. Does anyone
know how to fix that? Does the RTC somehow warp the time on resume or do
we somehow mark the time/date __nosave?

johannes

--=-pAgtPYD2UrDsob/q3e/K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFfp6z/ETPhpq3jKURAkP3AJwJlvmerj96HokTLeU9aln+3eX3hQCfZq31
kSuDVWiEudyiXOxDBq3a99g=
=xUB7
-----END PGP SIGNATURE-----

--=-pAgtPYD2UrDsob/q3e/K--


--===============1421703441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1421703441==--
