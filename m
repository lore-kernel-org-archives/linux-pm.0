From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] thermal: tegra: soctherm: add const to struct
 thermal_cooling_device_ops
Date: Mon, 9 Apr 2018 13:56:15 +0200
Message-ID: <20180409115615.GA29946@ulmo>
References: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srplinux2008 <srplinux2008@gmail.com>
Cc: jonathanh@nvidia.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 05:31:45PM +0530, srplinux2008 wrote:
> From: srp linux <srplinux2008@gmail.com>

Looks like you haven't properly set up git. Try setting your real name
using:

	$ git config user.name 'Your Name'

> Correct the typecast with const to struct thermal_cooling_device_ops.
> It is the last argument to the function thermal_of_cooling_device_register
> and this argument is of type const. So, declare this structure
> thermal_cooling_device_ops as constant.
>=20
> Signed-off-by: srp linux <srplinux2008@gmail.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrLVNwACgkQ3SOs138+
s6EasBAAwX2tVtJJelfLvUVmeW84stYcfjQzpcV44aW2YE69Am1Ev1dZ1+r6VPMS
+Uqgf0KkBzKPvNDRzJ9MbJapzb0L7J/rkAdn5A69flHVcqwuVaSnQrAMKdBZjK67
WMAyhuyUWan1KbLG1iKOdx6WFzP6YQ8zX2Z83p0wc0PgQhKRZL5rDXcpKGi/nGFp
rb7I7DvmCKUbvQFLqArotunFZYQ3KFFWwHo7+VVt0XFneJk6OdtTjITkBWMPcbt3
W73OPp56HHOu4yCUykEsVNHgsH8MemmHU2uBUCF3MmZlzWJd3zkJ47I6evkPac4A
vsXQT7JMjvpBj45Jym3iJOoZ5NXM18bJUbKlQVpVoCUwWWjylbOaz2F5MxfPQNcc
QPQlMMSKmlb3YSuDTgLOnsUw6t6G6JG5lu7ypZcrK1vYazttts9iwE3tJYl1sdFe
6DMN1YjSwpcqaDtT7KZ2Ealr04O8adcBfmi88R9ZzIQ+0/fAcxK2l7t1zFtp7Mo7
cRBLJZLQ/v9sJD0LNRwYWrHpL4PNjLntvV3IOBzEysVD5lED+IUh8X2wnId5aqZG
fn2nn2QXKPvPvkaev0/bEW9ElptHr1Uq5BU3c5tqwSOjlX0tNu0r1AoxOmJG3CMr
G3U67DFjglt4xS6hsnbvlObMdzjDpeNkYzOdtWIzo5oWuLTr444=
=L2zH
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
