From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:13:26 +0200
Message-ID: <1176502406.7052.134.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>  <200704140009.33298.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1644266773=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704140009.33298.rjw@sisk.pl>
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


--===============1644266773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DJkmSs0xVn+bAlUbAmvk"


--=-DJkmSs0xVn+bAlUbAmvk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-14 at 00:09 +0200, Rafael J. Wysocki wrote:

> Hmm, I missed that. :-(
>=20
> I think we need to make things clear: Either we add the additional hooks =
to
> pm_ops in which case they should be taken into account in the (u)swsusp c=
ode
> too, or we don't add them at all.

I can do that. I don't care one bit since I will never use pm_ops for
suspend to disk anyway.

johannes

--=-DJkmSs0xVn+bAlUbAmvk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGIACG/ETPhpq3jKURAnNUAJ9kAICzxRfXD01Etfz0KLNXjvL1hACghZu7
sZE7LVNFxzLhswDwaxYm0b4=
=/ml3
-----END PGP SIGNATURE-----

--=-DJkmSs0xVn+bAlUbAmvk--


--===============1644266773==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1644266773==--
