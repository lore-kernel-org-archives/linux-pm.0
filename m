From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Mon, 3 Jul 2017 20:20:34 +0200
Message-ID: <20170703182033.5stv5eq33et63coh@earth>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
 <20170703133602.ejcdu35ku3i63cj2@earth>
 <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
 <20170703171427.qtpodt7watymphac@earth>
 <CAHp75VeLV_ySCRN3B=MSoZdyrbXXqqEXrgC+hJCDoLLCJRComQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qja3ofhibnxtq7ia"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53163 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753897AbdGCSUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 14:20:45 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VeLV_ySCRN3B=MSoZdyrbXXqqEXrgC+hJCDoLLCJRComQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--qja3ofhibnxtq7ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 03, 2017 at 08:33:53PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 3, 2017 at 8:14 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > On Mon, Jul 03, 2017 at 07:37:59PM +0300, Andy Shevchenko wrote:
> >> On Mon, Jul 3, 2017 at 4:36 PM, Sebastian Reichel
> >> <sebastian.reichel@collabora.co.uk> wrote:
> >> > On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:
> >>
> >> >  * drivers/gpio/gpio-pca953x.c (line 190-192)
> >>
> >> It has double conversion there:
> >> 1. LE CPU: Read as LE and converted to LE (no-op), so, just u16
> >> 2. BE CPU: Read as BE and converted to LE, makes it __le16
> >>
> >> Looks like the conversion is not needed, only get_unaligned() is neces=
sary.
> >>
> >> P.S. What about lines 244-245 there? I think they are no-op.
> >> Interesting that those two parts were added in quite different
> >> commits.
> >
> > val[0] =3D (u16)ret & 0xFF;
> > val[1] =3D (u16)ret >> 8;
> >
> > looks like cpu_to_be16()?
>=20
> cpu_to_le16(). No-op on LE CPU.

uhm yes of course.

> Perhaps they should be replaced by put_unaligned().

Makes sense to me.

-- Sebastian

--qja3ofhibnxtq7ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaiu8ACgkQ2O7X88g7
+prPww/8DucY7t/WF0SkmiN5F9BYJc2YOvtedunIu4irUg8rML1RNVxmY9L4PgJP
zc6El+PmEXAijZv1rgBjKopcjnL5+NJQp7w1sZGpKipkRAmNaE4RxY6524dlaPsB
tOeANz0W6gCsZrimfQw5IY/9YWhosIkB19NNrZM+D0AeFjfOGnkN9d5+O8tbpmeG
oHm5eKfhW1IztGfLN7A2ubpQ8zE25lQtlZTkaCt8QIEkzZuXBoUjYa8uQlG/MH3p
CJ8Wfya5TXX+3QQjWyDtBLSegU3mV9kZhKQxn4HXNn0O+SkYIKCvaL2K0N2gzLgX
MDsOovTUsRKYpQiQn4bYohqxko8IGnuNe4IQFVmw3/WTnS8lFGPdpdF6MqlPIPvW
nD0HDbM4f7jwcezSkr5kvKyI2xza7m0Cr++5bKPsX79hiQ2a3fvvhlR0onq6OD67
fe+ApU0/BnUG51nJqbbLseEXaCCTg6DczTmfJb3/c7bQRptGg/e+2zTzo+uQPiAz
6TcXUL0Et2pqdWtjrsAg9A7uQF3D6pW6p1YVoMGVDBWFPZYtbWDKtM7D2JhkIVdI
rIYzNh+cnkc3eXEUi5WDYNwSVigrEQGdVxc3legisMP00r6dZ7TPskd2GUERRJK6
Swxjd16IQwQmX81yywyRexJba5PYBSLo2iOz4Y04xSDAha01JNs=
=sMIC
-----END PGP SIGNATURE-----

--qja3ofhibnxtq7ia--
