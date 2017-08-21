From: Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] kbuild: use $(abspath ...) instead of $(shell cd ... &&
 /bin/pwd)
Date: Mon, 21 Aug 2017 10:49:30 +0200
Message-ID: <20170821084930.GA7678@ulmo>
References: <1503209051-16477-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503209051-16477-1-git-send-email-yamada.masahiro@socionext.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, =?utf-8?B?QmrDuHJu?= Forsman <bjorn.forsman@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.com>, linux-pm@vger.kernel.org, Kieran Bingham <kieran@bingham.xyz>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
List-Id: linux-pm@vger.kernel.org

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 03:04:11PM +0900, Masahiro Yamada wrote:
> Kbuild conventionally uses $(shell cd ... && /bin/pwd) idiom to get
> the absolute path of the directory because GNU Make 3.80, the minimal
> supported version at that time, did not support $(abspath ...) or
> $(realpath ...).
>=20
> Commit 37d69ee30808 ("docs: bump minimal GNU Make version to 3.81")
> dropped the GNU Make 3.80 support, so we are now allowed to use those
> make-builtin helpers.
>=20
> This conversion will provide better portability without relying on
> the pwd command or its location /bin/pwd.
>=20
> I am intentionally using $(realpath ...) instead $(abspath ...) in
> some places.  The difference between the two is $(realpath ...)
> returns an empty string if the given path does not exist.  It is
> convenient in places where we need to error-out if the makefile fails
> to create an output directory.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  Makefile                       | 12 ++++++------
>  scripts/gdb/linux/Makefile     |  2 +-
>  tools/power/cpupower/Makefile  |  2 +-
>  tools/scripts/Makefile.include |  6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)

This looks very similar to a patch I had written a long time ago:

Acked-by: Thierry Reding <treding@nvidia.com>

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmanpcACgkQ3SOs138+
s6E41w//XaIYnoRQswXyc2L8SpJTW3Rm0BJIgfrzKNvvAdtfdPOvwVyX6/0KCCOS
Q5+VLAUXOM6Iv4m6n+2FIz+0/wiUBPaxhgirlaS5vGU1f2xpjGw6uWdrOeW7EDOH
sOExltQtcu5KSdJKjBo8Rlqk74NOCghpAf4a8FR+kaHBx14yLqAoWhefzyYx0Ku9
WICJIi8+6fItarHuVgIKwLc+8ZiOuV/KwExFnPn9bT3QrTF9YlihkYiZfEanZvvq
1C9dA4ZaC78wOuFpifyl+GjlvDrH3ec20qr08yQ8+dm5J4JbWTkuQ0SJHur+QOR2
nSWPfHwErmcuv2+WMmHIIiLyOt9OjMMKzqnsI1056GXRYazhlUM8e5LKZV4IoaTF
NeDQmrkBLtalwVNbktu09Dug92SN7c2R5fRwPKhmwl7cRqrZI6rm6zgAVKWGIdGx
2gtmLe2O+Wn/uWqzxYBcrunyn7DfqQDAsoX43tv6WQYfsjm86M4Kw83dP5yO7oql
ZccEiSM3eOOw8nElaij3cpO8egT11qKL2nN1s/beMAm7GVYotpgyf6hGRBl4DFAf
gzSFvEq/WaGhwxVqMA7zsiKD0pzfE6IkTXDCBmMcF1+4Z7TYA8YLmTatxXlnDApk
b0qnwGq/0GXqRi0ja/WVzGAM7segXBqa65rbdrH0o70N/KzUi5g=
=5n/b
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
