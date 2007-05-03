From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Hibernation and suspend patchset
Date: Thu, 03 May 2007 15:38:59 +0200
Message-ID: <1178199539.8233.9.camel@johannes.berg>
References: <200705011558.11170.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6107642617936035289=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705011558.11170.rjw@sisk.pl>
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


--===============6107642617936035289==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gouPTIGONsRVq6dTkhp6"


--=-gouPTIGONsRVq6dTkhp6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi again,

I just took your whole patchset, removed two patches that wouldn't apply
against Linus's current git tree, put mine for suspend to disk on G5 on
top of it, then applied the freezer fix I just sent and finally tested
the whole thing. It works :)

johannes

--=-gouPTIGONsRVq6dTkhp6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOeXy/ETPhpq3jKURAkimAKCt4+GwsRBnQ8lCnl+f5AEEyMZiuwCbBBhv
jIOceWD9/ew2z3gsPikRHEs=
=hI/D
-----END PGP SIGNATURE-----

--=-gouPTIGONsRVq6dTkhp6--


--===============6107642617936035289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6107642617936035289==--
