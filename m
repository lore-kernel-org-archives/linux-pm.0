From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 06 Apr 2007 01:28:57 +0200
Message-ID: <1175815737.3489.37.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060130.52885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1487284199=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704060130.52885.rjw@sisk.pl>
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


--===============1487284199==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TDFoNq7pXBsffCGDA78l"


--=-TDFoNq7pXBsffCGDA78l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-06 at 01:30 +0200, Rafael J. Wysocki wrote:

> Well is this possible to do something like
>=20
> if (pm_ops->do_something_before_disabling_irqs)
> 	pm_ops->do_something_before_disabling_irqs()
> local_irq_save(flags);
> if (pm_ops->do_something_after_disabling_irqs)
> 	pm_ops->do_something_after_disabling_irqs()
>=20
> and analogously for enabling the IRQs?

Ultimately yes, but is it worth the added complexity? Somebody mucking
with pm_ops has to know what he's doing anyway.

johannes

--=-TDFoNq7pXBsffCGDA78l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFYY5/ETPhpq3jKURAv2DAJ9dPFMUb7xXui2MwWmDNB6hNoOYVQCfR597
vvKsQxnu1o1xKHOJBwFhHF4=
=COGJ
-----END PGP SIGNATURE-----

--=-TDFoNq7pXBsffCGDA78l--


--===============1487284199==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1487284199==--
