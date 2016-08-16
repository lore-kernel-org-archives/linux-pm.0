From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1] power: reset: reboot mode: fix build error of missing
 ioremap/iounmap on UM
Date: Wed, 17 Aug 2016 00:07:45 +0200
Message-ID: <20160816220745.okcvpcgflejlehha@earth>
References: <1470996110-8550-1-git-send-email-andy.yan@rock-chips.com>
 <df657519-da7b-dbf3-1096-54253cb289c1@samsung.com>
 <082e9630-26cb-6587-6f9f-f97c334407ca@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x5fhmwnt6rcvjrat"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35564 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbcHPWHv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Aug 2016 18:07:51 -0400
Content-Disposition: inline
In-Reply-To: <082e9630-26cb-6587-6f9f-f97c334407ca@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, matthias.bgg@gmail.com, dbaryshkov@gmail.com, richard@nod.at, alexandre.belloni@free-electrons.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, nicolas.ferre@atmel.com


--x5fhmwnt6rcvjrat
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, Aug 16, 2016 at 06:55:49PM +0800, Andy Yan wrote:
> On 2016=E5=B9=B408=E6=9C=8812=E6=97=A5 20:48, Krzysztof Kozlowski wrote:
> > On 08/12/2016 12:01 PM, Andy Yan wrote:
> > > commit 4fcd504edbf7 ("power: reset: add reboot mode driver") uses api=
 from
> > > syscon, and syscon uses ioremap/iounmap which depends on HAS_IOMEM, so
> > > let's depend on MFD_SYSCON instead of selecting it directly to avoid =
the
> > > um-allyesconfig like build error on archs that without iomem:
> > >=20
> > > drivers/mfd/syscon.c: In function 'of_syscon_register':
> > > drivers/mfd/syscon.c:67:9: error: implicit declaration of function 'i=
oremap' [-Werror=3Dimplicit-function-declaration]
> > >    base =3D ioremap(res.start, resource_size(&res));
> > >           ^
> > > drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from int=
eger without a cast [-Wint-conversion]
> > >    base =3D ioremap(res.start, resource_size(&res));
> > >         ^
> > > drivers/mfd/syscon.c:109:2: error: implicit declaration of function '=
iounmap' [-Werror=3Dimplicit-function-declaration]
> > >    iounmap(base);
> > >    ^
> > >=20
> > > Reported-by: Kbuild test robot <fengguang.wu@intel.com>
> > > Fixes: 4fcd504edbf7("power: reset: add reboot mode driver")
> > > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > >=20
> > > ---
> > >=20
> > > Changes in v1:
> > > - let this driver depend on MFD_SYSCON
> > > - add Reported-by tag, which suggested by Krzysztof Kozlowski
> > > - add Fixes tag, which suggested by Matthias Brugger
> > >=20
> > >   drivers/power/reset/Kconfig | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
>  Will you please take this patch to avoid the Kbuild test robot warning ?

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/com=
mit/?h=3Dfixes&id=3D7a4947cf6f26b7d0a5db260d212f6df41a563d23

-- Sebastian

--x5fhmwnt6rcvjrat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXs46uAAoJENju1/PIO/qa6GkQAIzxfTIRKV3KxPOP9csepilf
zDqgOEPXW4IhYDLd/i//r4i/fL+jEIMKj1JQKZ9DzYoXi+aq24Smf9bQKF0Xb774
TxzN5Zd+1pyXHIr7JqLiW6LlHSKgjtLs2tvaIvoVVg3F4g4UYcIEGdDM0Op/NxEV
xOouURS7xPInEImRpXo9Y5YpQAky1jMS+tyrR3WuTeqngSNAhytrrzR+6g9QFCiX
DWJawR5UOvSXSavq0dl4K0nvlMwlliqqxlYVnliW/4NZWlfOkxHm+oP26OY+AlMO
K3YbWW4WD0aBJ/AVKIL27V2guX/Y+CE+MZoc/hqOFcEsMA2oyQNOsWVW2QZHZpYm
WATKm644P6qnUarjr2glgdNcrBiQBjsuV9O6oSNi+VrhqurGBN7SrcSDxRa0f7XG
LVP71kCztOxgIYs5bOzVulDmQem/kp5mHt5xqUH/a51HkDLnKZqNpoly+U/6BbvP
64UgMSafdqfJZ2Bf+6dfue5Ni4QLIHftsjaNBQg9HVRbt0SHOGS1FKHCUFRo4LCp
SAiRQDzDQ/lkzwYYOzDxlDct/knpeKvp+wjkoIVRPBAkgg3uQQW+40g+RY4HwL8s
IQLMYjhTRSoHZtNH/PjgZGGSNusBzOg4AXWbjzCQ1NgoHeMk8o55Qlz5M04/ryvc
Ple5vv6mOzCNJKdv8fhd
=5tDS
-----END PGP SIGNATURE-----

--x5fhmwnt6rcvjrat--
