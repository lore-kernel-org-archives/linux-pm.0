From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 09/16] soc: tegra: pmc: Ensure partitions can be
 toggled on/off by PMC
Date: Thu, 14 Jan 2016 15:14:53 +0100
Message-ID: <20160114141453.GD23082@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-10-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-10-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:10PM +0000, Jon Hunter wrote:
> For Tegra124 and Tegra210, the GPU partition cannot be toggled on and off
> via the APBDEV_PMC_PWRGATE_TOGGLE_0 register. For these devices, the
> partition is simply powered up and down via an external regulator.
> Describe in the PMC SoC data in which devices the GPU partition can be
> controlled via the APBDEV_PMC_PWRGATE_TOGGLE_0 register and ensure that
> no one can incorrectly try to toggle the GPU partition via the
> APBDEV_PMC_PWRGATE_TOGGLE_0 register.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/soc/tegra/pmc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

The TRM doesn't mention anything like this. Will this be updated in the
TRM as well?

Thierry

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWl61dAAoJEN0jrNd/PrOh9IgP/RtUAxXToxNCJn4+XuWbLRpx
P/OgmmrwJFe4pCWtt0HBk6nnvqyCCywjBXn6AE+JaE3xjHvNnfc/udjSAucO4FZM
IB8BNZc4//y6PVrrNDTFET/XIG/4teuk3eMwFuHpGV9o8V9JJI3kEhjX+HD00Y7x
IK1QM9VZMYvUwNUihJ0PXZgNLf5Znuw+2mlPCaK0qTmkJEf7pocNUnhRhlpuoVlo
vib5JwQM1qtBjQsFAJfh73ft7WXyKi3eCAXbsUe9Zxwrn2g61SEuhfKVbpjH0IYC
3c6TjyJyam/wNgMao8uh0VsCednuKGPxJNl7nN9T78S4IOINdombWgY8tfY7w72Q
dyCGUXNenFomIljKtxQqKzqG06wrEHhsaIMiKuixKv5f31lgY4j6FaBiznUzaXR3
oHyq7Qh8xjFGTkBIIuHyRCuf8Rm/g+fF08mEHx6RrNCZjRZLX1b1eCNXn9O3KewW
1WXvcaRv5Gk/UzuZbFnkGxe0GcMvmMOVaK1PPSTSSr/Is3/0kq4DtBDL/CkXP/qL
TJPLKchg/dLnD3lpbwSOXn4tO8d75cNielsc+gsY2IYzLcn2z4abiy2W7fstLJ1Q
WgqgW8K687iA0mflgYkvIFofdJy8QWlQSldaEOUfyEZPnvV5RfpaQ77+1uwEgHU3
93bjo7p+GWF2zD7WbuYG
=BfOI
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
