From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] remove software_suspend() and fix compile
	w/	SOFTWARE_SUSPEND disabled
Date: Fri, 23 Mar 2007 14:46:12 +0100
Message-ID: <1174657572.3366.10.camel@johannes.berg>
References: <1174571192.32051.5.camel@johannes.berg>
	<200703222212.45050.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1189006767=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703222212.45050.rjw@sisk.pl>
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


--===============1189006767==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Wx9wxkQPmT/savWEgVqW"


--=-Wx9wxkQPmT/savWEgVqW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 22:12 +0100, Rafael J. Wysocki wrote:

> The patches have been reworked after Andrew rejected them due to this bre=
akage.
> The current versions are in the -mm tree (http://lkml.org/lkml/2007/3/20/=
327).

Aha :)

> As far as the rest of the patch is concerned, I have no objections.

I'll respin then and post against -mm.

johannes

--=-Wx9wxkQPmT/savWEgVqW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGA9ok/ETPhpq3jKURAo2uAJ9pQMHOrrCGQ4KH6Qz1bcfgXwUPRACeOcps
fXPfJQVbbLYqyrTYKsWTN6o=
=hrpL
-----END PGP SIGNATURE-----

--=-Wx9wxkQPmT/savWEgVqW--


--===============1189006767==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1189006767==--
