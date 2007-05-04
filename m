From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ACPI code in platform mode hibernation code paths
	(was: Re: [PATCH] swsusp: do not use pm_ops)
Date: Fri, 04 May 2007 12:54:32 +0200
Message-ID: <1178276072.7408.7.camel__41478.3297259875$1178276085$gmane$org@johannes.berg>
References: <20070425072350.GA6866@ucw.cz> <200705021542.24988.rjw@sisk.pl>
	<8f8ff01d0705020711r630b8b92sdd2cd9316eb39edc@mail.gmail.com>
	<200705022126.47897.rjw@sisk.pl>  <20070503224807.GD13426@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2161154425911866587=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070503224807.GD13426@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============2161154425911866587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CjF+mLxeAtR+/hSspegD"


--=-CjF+mLxeAtR+/hSspegD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-04 at 00:48 +0200, Pavel Machek wrote:

> Crazy idea... could we kill hibernate_ops-like struct, and just create
> a device for ACPI, using its suspend()/resume()/whatever callbacks to
> do the ACPI magic?

Doesn't that have the ordering problem again? You must ensure that this
sysdev is suspended as the last one, and that's currently impossible if
ACPI is modular.

johannes

--=-CjF+mLxeAtR+/hSspegD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOxDo/ETPhpq3jKURAlG2AJwN0pnM3ASCTCS07ixmYkmKTm0eWQCeJx0Y
KFGVxDWv+FATUIUpsxC0ZBc=
=YONC
-----END PGP SIGNATURE-----

--=-CjF+mLxeAtR+/hSspegD--


--===============2161154425911866587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2161154425911866587==--
