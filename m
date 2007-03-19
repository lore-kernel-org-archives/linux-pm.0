From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: what can we do with frozen processes (or: calling
	sync with	processes frozen)
Date: Mon, 19 Mar 2007 12:14:57 +0100
Message-ID: <1174302897.5442.1.camel@johannes.berg>
References: <1174173718.13027.0.camel@johannes.berg>
	<200703191146.17503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1788577231=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703191146.17503.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1788577231==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lxeCnNKWgsgVVP0ViBTO"


--=-lxeCnNKWgsgVVP0ViBTO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> We call sys_sync() in freeze_processes() _before_ kernel threads are froz=
en.
> I don't think it's safe to call it any time later before the kernel threa=
ds are
> thawed.

Obviously isn't safe :)

Thanks for the clarification.

johannes

--=-lxeCnNKWgsgVVP0ViBTO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/nCx/ETPhpq3jKURAiIdAJ9Ght1xXKHUGOhZzsyN2IlI8u9Y5QCbBuvz
YuSjjbTEnxyBZUKf0UDRgys=
=ygLP
-----END PGP SIGNATURE-----

--=-lxeCnNKWgsgVVP0ViBTO--


--===============1788577231==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1788577231==--
