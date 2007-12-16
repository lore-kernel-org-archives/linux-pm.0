From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] apm-emulation: implement notify/ack for
	/sys/power/state events
Date: Sun, 16 Dec 2007 21:09:08 +0100
Message-ID: <1197835748.6769.23.camel@johannes.berg>
References: <1197827906.6769.7.camel@johannes.berg>
	<200712162015.59963.rjw@sisk.pl>  <1197835380.21886.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4911922903040457734=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1197835380.21886.0.camel@pasglop>
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
To: benh@kernel.crashing.org
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Jamey Hicks <jamey@crl.dec.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org


--===============4911922903040457734==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Kuk0LGyBD6K7IiSleeIB"


--=-Kuk0LGyBD6K7IiSleeIB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Mon, 2007-12-17 at 07:03 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2007-12-16 at 20:15 +0100, Rafael J. Wysocki wrote:
> > > +              *
> > > +              * Unfortunately we cannot do a timeout because then we=
'd
> > > +              * suspend again right away if the process that had apm=
_bios
> > > +              * open and that we timed out waiting for "acknowledges=
" the
> > > +              * event after we have resumed. If suspend doesn't work=
 because
> > > +              * of a rogue process, just kill that process.
> > > +              *
> > > +              * FIXME: is the suspends_pending =3D=3D 1 test racy?
>=20
> I think we can do the timeout thing easily... Just mark the fd's that
> haven't ack'ed with a flag that makes us ignore the next ack...

Yeah, except, is it really worth it? I should reword the comment into
"I'm too lazy to do it" I guess, but you need CAP_SYS_ADMIN and you can
always kill -9 the program that is making it wait.

johannes

--=-Kuk0LGyBD6K7IiSleeIB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2WF46Vg1VMiehFYAQKIfg//bU6XtSB3pXMhubrYk9RuNwL0S2EMMG+j
u8ds+uJ263WURxPilqZEkrm4o77esPjCQsBUaReSKPTYJkePZmBkfVFA6jDLFStm
xBSZ2xTUzXEhVMKKmV5Cf0fvAlDaNGycp6zyMjOmJJ1sXCKZ3G6WcjC94P0QZGhD
5+pKb25J6gVOy7UJPT4Di6GH3yV196pP4uN3RuEMeLOaUTh9ip5OfcsqJHHCoS4Z
PJxhQULW6gVI485NsBLJ4uGtzyVh8yyR4V8RANAJuSFX2889ifV0hXgze/qHuhFA
LCROxkJUs224N4xq6hCEyR2lUlL+/HU0kRyb+PxXoYpBV2YopVU53xcjgkrCRlUB
LszMSa6S5tB5G1k8mdNO1IqvWtUFK+7IwXsMI8ngF84zJeYUUpx/OjCw4kIPNrg0
nuiLrX4+i1gUsjOk6fZr4MxjEOzXDmYzGDcS2PqC4pbXGP0dIYOFMaNkQ/c1TGhF
66S+IvWzVLAAUDPPS8Tcg1MfN9kY1GeS1aMjtM6HXF8vBBjNRL5JE3xiBW7vsVCY
yKyS4SG3C1zvaJtmj1CTXhYIG9W8UgVkYyrCRsUnpH3vQT9Oz1g1F6QRkBOQGQZz
0GPAPY3q9MxaEfFgoEY4W4Dw2OYg+JbkoYO9DolkDW7QMJ671NrFJI/B2mjK5smD
ifmxs8MQ98I=
=GcGY
-----END PGP SIGNATURE-----

--=-Kuk0LGyBD6K7IiSleeIB--


--===============4911922903040457734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4911922903040457734==--
