From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:20:07 +0200
Message-ID: <1176502807.7052.136.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<20070413215241.GO28264@elf.ucw.cz>
	<1176501547.7052.130.camel@johannes.berg>
	<200704140018.07367.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0270950104=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704140018.07367.rjw@sisk.pl>
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


--===============0270950104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EmYLJkTdqn1UKafSEtfm"


--=-EmYLJkTdqn1UKafSEtfm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-14 at 00:18 +0200, Rafael J. Wysocki wrote:

> Technically, they may be not needed by (u)swsusp, but since (u)swsusp alr=
eady
> uses pm_ops in the platform mode, it formally should use these new hooks =
in
> the platform mode too. =20

Sure. I'll do that.

> Otherwise it won't make sense to use pm_ops in
> (u)swsusp at all, IMHO.

IMHO it never has and never will be, it's just to make it all fit the
ACPI model ;)

johannes

--=-EmYLJkTdqn1UKafSEtfm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGIAIX/ETPhpq3jKURAgvPAJsEmBNCTgzzlyCrNN1L4p63b7pZlQCgo4oQ
gMH/NcRep5ZoEofbga7iAYQ=
=+pdq
-----END PGP SIGNATURE-----

--=-EmYLJkTdqn1UKafSEtfm--


--===============0270950104==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0270950104==--
