From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 03 May 2007 11:45:51 +0200
Message-ID: <1178185551.13233.85.camel__45674.3325492882$1178185543$gmane$org@johannes.berg>
References: <200705022213.35831.rjw@sisk.pl>
	<1178181680.13233.74.camel@johannes.berg>
	<200705031146.03358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5609238449537617061=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031146.03358.rjw@sisk.pl>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============5609238449537617061==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-aE/pwnnva4tmFxQn5UBd"


--=-aE/pwnnva4tmFxQn5UBd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-03 at 11:46 +0200, Rafael J. Wysocki wrote:

> Well, BUG_ON() is extremely user-unfriendly, and it'd trigger even if the=
 user
> actually didn't intend to suspend at all.

Well, hibernation_set_ops is invoked whenever the user loads his ACPI
module with S4 possible, and typically having a BUG_ON here will make
the developers who wrote the code that calls hibernation_set_ops see it
right away while they might miss the message.

I don't care much though, it just seems wasteful to have this string in
there when it'll never be seen by anyone but the developers who create
new hibernation_ops.

johannes

--=-aE/pwnnva4tmFxQn5UBd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOa9P/ETPhpq3jKURAoFqAJ4w6iuB1XxRnr/21RXstvnCz4LWDACgrIEO
spH8U52v87mYwriPWyL2mjk=
=i65e
-----END PGP SIGNATURE-----

--=-aE/pwnnva4tmFxQn5UBd--


--===============5609238449537617061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5609238449537617061==--
