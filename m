From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Mon, 16 Apr 2007 10:37:13 +0200
Message-ID: <1176712634.7052.175.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz> <200704140009.33298.rjw@sisk.pl>
	<1176503122.5764.109.camel@localhost.localdomain>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
	<20070416073249.GA2057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0985771857=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070416073249.GA2057@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0985771857==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xSI9L78KtaWvbW81+5nB"


--=-xSI9L78KtaWvbW81+5nB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-16 at 09:32 +0200, Pavel Machek wrote:

> As decrementer is special for s2ram, we can add the hook. (It is
> single hook).

No, it's two, for enabling as well.

johannes

--=-xSI9L78KtaWvbW81+5nB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGIzW5/ETPhpq3jKURAsZaAJ9YwOhAty6gddFdweGuYp+9Nk5MGQCggv2A
+oITKRftr6Bt2qaxcmAyTwk=
=cu8e
-----END PGP SIGNATURE-----

--=-xSI9L78KtaWvbW81+5nB--


--===============0985771857==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0985771857==--
