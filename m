From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: suspend2 merge (was Re: [Suspend2-devel] Re:
	CFS and suspend2: hang in atomic copy)
Date: Fri, 27 Apr 2007 12:09:17 +0200
Message-ID: <1177668558.7828.38.camel__24194.1574299291$1177668621$gmane$org@johannes.berg>
References: <20070425072350.GA6866@ucw.cz> <200704262040.31760.rjw@sisk.pl>
	<1177612802.6814.121.camel@johannes.berg>
	<200704262102.38568.rjw@sisk.pl>
	<1177666915.7828.35.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2660369056445330891=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177666915.7828.35.camel@johannes.berg>
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
Cc: Nick Piggin <npiggin@suse.de>, Nigel Cunningham <nigel@nigel.suspend2.net>, suspend2-devel@lists.suspend2.net, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============2660369056445330891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-q/W2ajiTTplPeOUo2Gnm"


--=-q/W2ajiTTplPeOUo2Gnm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 11:41 +0200, Johannes Berg wrote:

> No, because acpi doesn't know at build time whether it can actually do
> S4 or not.

Actually, you could probably do it by making some weak symbol for it
that only ACPI overrides, and then check in the ACPI code if S4 is
possible, otherwise somehow invoke the old symbol or copy the code or
something. Seems a bit more fragile though.

johannes

--=-q/W2ajiTTplPeOUo2Gnm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMcvN/ETPhpq3jKURAjB1AJwKJgM+u+zMsDr5gD5gz1tK1VbKBwCfan6P
h/sBaTT+2rgQ88cVHtxR4oU=
=jLsN
-----END PGP SIGNATURE-----

--=-q/W2ajiTTplPeOUo2Gnm--


--===============2660369056445330891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2660369056445330891==--
