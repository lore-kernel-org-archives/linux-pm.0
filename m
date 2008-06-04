From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add a printk_init variant storing
	format	strings in	__initdata
Date: Wed, 04 Jun 2008 11:10:22 +0200
Message-ID: <1212570622.14371.19.camel__41698.7942917787$1212570935$gmane$org@johannes.berg>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
	<20080604011607.15dec5a7.akpm@linux-foundation.org>
	<1212569949.4042.56.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0405550986198254429=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1212569949.4042.56.camel@shinybook.infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0405550986198254429==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kkdVtk5xS0drJPkX2HNr"


--=-kkdVtk5xS0drJPkX2HNr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-06-04 at 09:59 +0100, David Woodhouse wrote:
> On Wed, 2008-06-04 at 01:16 -0700, Andrew Morton wrote:
> > We're going to want to be able to call printk_init() from modules.=20
> > Please fix and test that, if we decide to proceed.
>=20
> Can we fix that by making it an alias for printk in the module case?
>=20
> The only reason we need it to be __init is so that we get the section
> warnings when you use it from non-init code, right? Won't we get the
> warning when non-init code refers to the string in initdata anyway?

In fact, wasn't the warning Andy showed such a warning?

>     WARNING: vmlinux.o(.text+0x3): Section mismatch in reference from the
>         function something() to the variable .init.data:__printk_init_fmt=
.31426
>     The function something() references
>     the variable __initdata __printk_init_fmt.31426.
>     This is often because something lacks a __initdata
>     annotation or the annotation of __printk_init_fmt.31426 is wrong.

johannes

--=-kkdVtk5xS0drJPkX2HNr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASEZb/KVg1VMiehFYAQJ50g/8DUKSWg8SuR69Wx9hjM1Y7os78sPT8S3h
4xANMMqnUdqRCIF4ZHn0FU/FY82Y4MuyHs6p8/yDIWkEylO+Yy7F+Gomf3d24qSR
oGO1iftM79zlyS//9xgiZ+1AgQ79Mi1sQNRNDmkAFxwYaZaUpEDuKQeJn1mEXZsA
pmbntH4uKYBep7P+dMR7xDKoeWzL/j28K5Tc/wyq8oa8q22NRm2QASRpRS8Qavjx
VaWGhophMSg4Igtm+KXVrsgc9NBV4qPqPv+BTkN0azuHFcPDw78Pn9mBe3FtXBkj
lVeSl7Oy5jPDOl4IG2TfQvwZb3QbMAFJO3v3ppOZnNUMK+sdD4F375I0XvddiuGJ
XUee3gW7m74/qL/fQ6zh1+RlLZfK7aMRa7KrQFmWHbDnBJbN+7Xyyz8S5AxwqKWY
xsKtqKQCQ+CE6ZC0QQsaWpoWYs7ZGywsnRoKjnJHfCaI/yCMHIhr4Cmjf/M8y8b4
25aTXrxYm7rJjPMSERBbwYeQ7Le4P+xYwYRFWMvvG7A9QbhJRZ5YsOjjXqoxKb+z
z3Rn3Cg0TKqOHvIzVbT2owaZeoh+5Ilj6VX6qjZfsql3C8x+k9lCGp5voAet7mqH
BNLQqvHw+EeN7Jk26KDmnicHvQqFOqLd9eJ1FTfCDIQnytLZ00t+jFYSpfE/jk6x
9KRDmqEwBwM=
=Kxfh
-----END PGP SIGNATURE-----

--=-kkdVtk5xS0drJPkX2HNr--


--===============0405550986198254429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0405550986198254429==--
