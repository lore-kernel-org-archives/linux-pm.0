From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend to disk modes, default mode
Date: Tue, 20 Mar 2007 01:51:17 +0100
Message-ID: <1174351877.3645.12.camel@johannes.berg>
References: <1174351671.3645.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1777046702=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174351671.3645.8.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1777046702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2Gut4z/vdotHYXJSo9SL"


--=-2Gut4z/vdotHYXJSo9SL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-20 at 01:47 +0100, Johannes Berg wrote:

> This suspend to disk modes stuff really sucks. The last time I looked
> must have been a long time ago because then shutdown was default. Now I
> find that in November 06 you changed it to be platform by default.

Besides, this also means that anyone not setting pm_ops->pm_disk_mode to
platform has a weird consistency issue: you can change to shutdown but
not back. Umm...

johannes

--=-2Gut4z/vdotHYXJSo9SL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/zAE/ETPhpq3jKURAqIDAJwP769kVVnBzK11K/QRerAxwraHPACgij+I
UmVBJM6N5yW1oaaA5QzmAcI=
=hbjE
-----END PGP SIGNATURE-----

--=-2Gut4z/vdotHYXJSo9SL--


--===============1777046702==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1777046702==--
