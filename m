From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/2] thermal: add support to slope and offset
Date: Mon, 11 May 2015 20:24:30 -0700
Message-ID: <20150512032428.GH4810@localhost.localdomain>
References: <1431399857-13943-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431399857-13943-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, hongtao.jia@freescale.com, kong.kongxinwei@hisilicon.com, nrajan@codeaurora.org
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2015 at 08:04:15PM -0700, Eduardo Valentin wrote:
> Hello all,
>=20
> This is a patch series to add support to slope and offset constants
> of a linear extrapolation model. This type of model is very common
> across different platforms, and many drivers are attempting
> to have its support.
>=20
> The basic idea is to have this mapping in the thermal core,
> as part of thermal_zone_params. In this series, I also add
> a simple support to read them from DT, i.e.:
>                 /* hotspot =3D 1 * adc + 6000 */
> 		coefficients =3D          <1      6000>;
>=20
> I am copying some of the driver writers that attempted to=20
> use this feature, but by adding their own property. Please,
> check if this change is enough to properly map your slope
> and offset requirement. Remember, they will be added in your
> thermal zone DT node, instead of in your sensor DT node.
>=20

Forgot to copy Narendran, codeaurora developer

> BR,
>=20
> Eduardo Valentin (2):
>   thermal: support slope and offset coefficients
>   thermal: of-thermal: add support for reading coefficients property
>=20
>  Documentation/thermal/sysfs-api.txt | 16 ++++++++++++++++
>  drivers/thermal/of-thermal.c        | 26 ++++++++++++++++++++++++--
>  drivers/thermal/thermal_core.c      |  4 ++++
>  include/linux/thermal.h             | 11 +++++++++++
>  4 files changed, 55 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.3.4
>=20

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVUXJnAAoJEMLUO4d9pOJWSxkH/iA0e0Dlx3bUTdynf/DRHv07
HSfzc3QoTeDk2VC98pv7SgzljNgxe35zG5HlCPtJWVLsILkJjTlwqp+HB6xZqw83
XJKSnZug5M3Zt0kHI5BeSWiqid6S7mzxaXhIFdirlP0A/NM4aV4dWAMABAJoES6V
JqeU9r/HIZoBzPVCOZfNWls4iaaQnC5rpaPD7mkYZO5Dr5j85MJND+3qvpEzVrxC
hNq/KVXDaVG4WZ2W1SjyPvxmNZo0VsWhMtsK4uTyFtZUqMi1yv/jWEdQY4qHadz3
vMpDOadQ4oEIsLcxZwoO6R+P3CEMXGVB2pzP/2oomFGEGS+5/elZo3tcBBhvSdw=
=yKti
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
