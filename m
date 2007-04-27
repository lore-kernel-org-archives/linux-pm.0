From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [RFC/PATCH 2/2] kernel: don't update load
	average during snapshot/shutdown
Date: Fri, 27 Apr 2007 17:02:44 +0200
Message-ID: <1177686164.3565.24.camel@johannes.berg>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<200704271700.52678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3343138807584088819=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704271700.52678.rjw@sisk.pl>
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
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, nigel@nigel.suspend2.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


--===============3343138807584088819==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sg1Z/8VnNI5L6ZK2ALo+"


--=-sg1Z/8VnNI5L6ZK2ALo+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 17:00 +0200, Rafael J. Wysocki wrote:

> This clashes with the recent freezer changes in -mm quite violently.

Can't somebody have a git tree for things like that? It can still be
imported into -mm, but tracking -mm just for the sake of the suspend
stuff isn't always feasible.

johannes

--=-sg1Z/8VnNI5L6ZK2ALo+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMhCU/ETPhpq3jKURAj04AKC1Bu/ZUbdiEHuuV9GO5ocafI3+hQCfbvMI
91EUuWSM8qaXXe17Rz0nuME=
=N6TR
-----END PGP SIGNATURE-----

--=-sg1Z/8VnNI5L6ZK2ALo+--


--===============3343138807584088819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3343138807584088819==--
