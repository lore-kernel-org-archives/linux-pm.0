From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: 88pm860x_charger: Fix possible NULL
 pointer dereference and use of initialized variable
Date: Fri, 20 Mar 2015 12:58:54 +0100
Message-ID: <20150320115854.GA17858@earth>
References: <1426843562-6415-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426843562-6415-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Fri, Mar 20, 2015 at 10:26:02AM +0100, Krzysztof Kozlowski wrote:
> Do not put reference to power supply in early exit paths of
> pm860x_done_handler() because:
> 1. it is not yet initialized,
> 2. it is NULL.
>=20
> This fixes possible NULL pointer dereference and following build
> warning:
> drivers/power/88pm860x_charger.c: In function =E2=80=98pm860x_done_handle=
r=E2=80=99:
> drivers/power/88pm860x_charger.c:516:18: warning: =E2=80=98psy=E2=80=99 m=
ay be used uninitialized in this function [-Wmaybe-uninitialized]
>=20
> Additionally this puts the power supply reference before unlocking
> mutex. This actually is not needed (there is no race here) but has
> logical sense and makes the exit paths cleaner.
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks, pulled.

-- Sebastian

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVDAt7AAoJENju1/PIO/qal+gP/iOb0jCUUk2Wbw7Xrt80wUdT
iGUcJ57q73REUEzSsGUipk6ebTJ9ItWGYfVLk7E5oHD8FLc4Igy0cdlTZTTnNxEh
yMA4UvnvusNjb/wm1IP4udO2SXKTnrR13sPhUT1jKUbTEcniBPeMkCiBNN4iFmw3
UJ8WQukr0+HS4h6ZKcSaUAAYB7AZcEwA1Uo/DX5GJgfcRuBjlPxY00ZruccanNYC
ZyHjKYZFSaIoKOZ98YSzwBAzupeLEoxi48rXUQFcMpUpDdtU6ys8paCFqiUtdv4t
swteSLO0a+PosZ7eFK4fPkHbbV9B4pxxA/Ezkl0N4ljCmJM9HpWw9RIuWZvpmiIx
fPNHEwsEpvPMWm6ID6l1bvgBxeVCKfTKU891wjzzZ+tXjrsGEENIq+Y3ZjWRKYJK
bqIWPA5VWEQ3SzYLrcXaiiDf3Sky93mJZ1mZK8zy2o5VYo8H3uZv+YBjMjLePmW+
Cq5aAmUQFPSh5I3E3L+hkANKrpyGsoaZOEaSoncJP5R04c2bhQvUiKVrq4ABCcPp
4PHrhw33rEuckXuPKYV1MYls0HpTEEI//EfAAWZ63UUMByKpsPuOZ2GQ2AIpC5z5
LU+W5F+xz9Ewyg/ovHgyCV02uFMIySMNibalCOYayycZ42CoGI+5nYR6RWCB/2uE
SEzQyKFUw/JQl3kWY9Wv
=55RY
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
