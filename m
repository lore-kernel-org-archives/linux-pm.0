From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 06/10] soc: tegra: pmc: Wait for powergate state to
 change
Date: Mon, 29 Feb 2016 13:14:33 +0100
Message-ID: <20160229121433.GA1383@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456501724-28477-7-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:40PM +0000, Jon Hunter wrote:
> Currently, the function tegra_powergate_set() simply sets the desired
> powergate state but does not wait for the state to change. In most cases
> we should wait for the state to change before proceeding. Currently, there
> is a case for tegra114 and tegra124 devices where we do not wait when
> starting the secondary CPU as this is not necessary. However, this is only
> done at boot time and so waiting here will only have a small impact on
> boot time. Therefore, update tegra_powergate_set() to wait when setting
> the powergate.
>=20
> By adding this feature, we can also eliminate the polling loop from
> tegra30_boot_secondary().
>=20
> A function has been added for checking the status of the powergate and
> so update the tegra_powergate_is_powered() to use this macro as well.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-tegra/platsmp.c | 16 +++-------------
>  drivers/soc/tegra/pmc.c       |  9 ++++++++-
>  2 files changed, 11 insertions(+), 14 deletions(-)

Applied, thanks.

Thierry

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW1DYmAAoJEN0jrNd/PrOhtgwP/0fkP20whj0n26f55vx10A4u
LDubiBwUig7oSIJF8WjfA+hCUS97LzeH253Hm4r8j7z/XLrNe2JwvZj+SiTc+hRF
g+INo41LT30TCZOJIwDxEyViaHV+34SuSJg92DSdvaOMgZtkWd4diEqSk8n5N8uB
V0clw3/aRWW+Ns7jpSNRP8lQLG+CBqS1g1JsU2mtEZpE7fq8LKIKOVu+a/UgbO65
hffh4e0p/n5lYAY8uiwlzqn+CtUaO9wsk8uR8pqCaV67GF9z25yXrCaaAD3k/LGF
jmc6Gz1MtD53tGDLxGRtJ/p3Rlxv1GZhAtAsbmtzDw53L6HiuPzd1VcmQVmGGkT1
cdlGAmF7v/9YGZYyRrHOKuBbNNpTaMtFQJx0g27ZuRHkos7J/KJX0J/kN02IK6R4
/4l847/HIpFHvJMd7P+f/wJuu/B255iRkaMoWobsg136bcjlqsBo5jQyDLJOm8Wq
5iDNJ0wUIxbdDjzWewQSNvGnayvnyV3UfSO5a/ypmUYqb0mlVtTxjZfG90bt9kKn
0j1Tni4y0x+3v8akr5LS7SHOK4SHykf1B9pnbdfDNkUqhucbHmG9lkaySZ6rSh1S
PTcXuB2ed4ndn+NUyE3st4tU0GOcyXmg7WmAj9duPCIDCmCcI7kcr0TXbMlofRPT
eMhG+YhooeNX+f1mdGK0
=ek+G
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
