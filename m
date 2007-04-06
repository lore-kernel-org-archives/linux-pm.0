From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 06 Apr 2007 10:48:42 +0200
Message-ID: <1175849322.3489.64.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060202.13597.rjw@sisk.pl>
	<1175818158.3489.47.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1602745769=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704060217.50560.rjw@sisk.pl>
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


--===============1602745769==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tqBH0ogTgVo7EYdRjJwQ"


--=-tqBH0ogTgVo7EYdRjJwQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-06 at 02:17 +0200, Rafael J. Wysocki wrote:

> > Not sure, it might be different for different suspend methods. We
> > actually need to do some platform-function stuff inbetween, and if we
> > ever want some S4-like state then we might need to do it differently.
>=20
> Ah, OK

Keep in mind that I don't know that yet, and am not totally sure I ever
will implement something S4-like (it would probably require kexec or
similar tricks). Also, these handlers are not even called fro the
suspend to disk case right now (and documented that way.)

I will repost with some BUG_ON() assertions, but should I change it to
have 4 handlers before_irq_off/after_irq_off/before_irq_on/after_irq_on
instead of the two I have now?

johannes

--=-tqBH0ogTgVo7EYdRjJwQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFglq/ETPhpq3jKURApRuAJ9qs3NjCaaxph1n+4Cxs3TekGKrWACcDl1q
Q4f7DM4ewsPr01od8gvZ1kc=
=riOe
-----END PGP SIGNATURE-----

--=-tqBH0ogTgVo7EYdRjJwQ--


--===============1602745769==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1602745769==--
