From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Hibernation and suspend patchset
Date: Fri, 04 May 2007 14:05:52 +0200
Message-ID: <1178280352.7408.15.camel@johannes.berg>
References: <200705011558.11170.rjw@sisk.pl>
	<1178219335.4575.4.camel@johannes.berg>
	<200705041402.40964.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1413775915091507015=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705041402.40964.rjw@sisk.pl>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1413775915091507015==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-h7YAhoxZKaPmo0+vMQje"


--=-h7YAhoxZKaPmo0+vMQje
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> These #includes are added by
>=20
> 008-add-try_to_freeze-everywhere.patch
>=20
> Perhaps it's one of the patches that don't apply to the current -git?

Hmm, could be, but shouldn't the patch that adds the freezer_exempt
calls add them as well?

johannes

--=-h7YAhoxZKaPmo0+vMQje
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOyGg/ETPhpq3jKURAjxsAJ4yFr8gNxaO4nIz5/6KKyGEaGlFnQCgutG6
QrX8nfzoTVTKgNa9ri9V1Bw=
=WPIO
-----END PGP SIGNATURE-----

--=-h7YAhoxZKaPmo0+vMQje--


--===============1413775915091507015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1413775915091507015==--
