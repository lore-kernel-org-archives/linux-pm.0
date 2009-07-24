From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Generic events for wake up from S1-S4
Date: Fri, 24 Jul 2009 16:49:16 +0200
Message-ID: <1248446956.32151.0.camel__40080.394774168$1248447094$gmane$org@johannes.local>
References: <43e72e890907150851m69cd2de6lfb71596fbfac30e6@mail.gmail.com>
	<20090723195114.GR28158@elf.ucw.cz>
	<20090723201050.GD19369@khazad-dum.debian.net>
	<200907232328.03566.rjw@sisk.pl>
	<1248396826.3556.26.camel@localhost.localdomain>
	<20090724133903.GA18827@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2903306567967022077=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090724133903.GA18827@khazad-dum.debian.net>
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
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jouni Malinen <j@w1.fi>, linux-wireless <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, ykzhao <yakui.zhao@intel.com>, Stephen Chen <Stephen.Chen@atheros.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============2903306567967022077==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-k3uMWwkqwgmLBnwDG77h"


--=-k3uMWwkqwgmLBnwDG77h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-07-24 at 10:39 -0300, Henrique de Moraes Holschuh wrote:

> ACPI notifications are hard to extend, I think.  Please correct me if I a=
m
> wrong.

ACPI is the wrong place anyway, since it's fundamentally platform
dependent. Unlike the rest of suspend and wake functionality.

johannes

--=-k3uMWwkqwgmLBnwDG77h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKacnoAAoJEODzc/N7+QmaSScP/R7Y3kpqY/fbBkNKBopqkkpE
eEmGWiYd31VOMMVlcyjQYCogkTc1m7u5PDou7s3pFyqS+Aq8ypFbCsYKuoZRzFFg
69lUr7hLyyHBF7Bb/CwoXAVsoSqdwUvCG0eHLK86KjYnzYurhd//oJq/yXzZbQfz
XmzoUZJk6cFLR4cZ8ZYsPIHfdJi7k3wFulcl1CGRqBvdJt0JdR1wz8c7M5ieMDJN
TER0JsXzkuuPd6i4eqNhOi47y8BeC5JrTXcw5RitxnRFwdd5mAvRpf43eTkdWnZq
y2AiJ0wfSYeTNXVZM5Fc9wOpzWYKcK3BD1YaRtFad5lYS5CK8njCX/yI3yl4PI2g
+H7x5Ur/YikUIHtTg70qNGj/HQ7XoeRqOGIVPP2uo5EJlBWgVrwlGvLLdrzB5eO1
ejhW4mMQo01T0EFz/E0L1l/ptSRE7GOcXuub258Md8SCX8qxHilFVSebRGP/GreC
voc4gKMOlVE+yXvyBEAcJgz6O5YU/f1HHrRRtLU2JzI9KVO/mVc7fBGsXNU/TIuK
WK9JW9BdrzVjshk6HjP9SheOjGCPlEZVeN9dXUbAHiJW3sErOo8m6OKo66UDAiDd
MZvfqvIRz/qfNGxMXSR9l4mfskzg/fkDxkuR1uf0rdjnwi4bgzV82J+9ZErabd3J
CIYyGQg0Nta9kejlVpoc
=92Uq
-----END PGP SIGNATURE-----

--=-k3uMWwkqwgmLBnwDG77h--


--===============2903306567967022077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2903306567967022077==--
