From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 17/17] soc/tegra: remove lagacy powergate APIs
Date: Thu, 12 Mar 2015 13:45:02 +0100
Message-ID: <20150312124501.GA632@ulmo>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-18-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426162518-7405-18-git-send-email-vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 08:15:18PM +0800, Vince Hsu wrote:
> We switch to generic power domain now. So remove the legacy functions.
>=20
> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/soc/tegra/pmc.c | 68 -------------------------------------------=
------
>  include/soc/tegra/pmc.h | 22 ----------------
>  2 files changed, 90 deletions(-)

I don't think we can do this. What if somebody updates their kernel but
not the DTB? In that case they'll end up with drivers that don't enable
power partitions but at the same time the powergate driver won't enable
them either because it is missing the corresponding nodes in the DTB.

What we'll have to do is probably keep the code that enables the power
partitions and make it conditional on the power domains somehow. Is
there a way to determine at runtime whether a device has been attached
to a power domain?

Thierry

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAYpKAAoJEN0jrNd/PrOhMugP/3YKe8e5CNxes75pZTg0fZtq
8KA7x5iTwHX/ca4ll1pqIrLf9LqCTf40PYb9w56PfVPik6++b3PNWb7dPC8ByEqo
tXkptS+YvTpvkjW3TIxGcOzpOnUJFidQpzxuDNjRdaP/purjGHZnc9mRpJMEwfW2
dm/+9PX6luAuIRXdkl0z7A7cqxR8k7k4v4n9ubK/Wk4Aj8pnPqf0y1/CyRDiPLY5
vhMJ+QMszMw5EGyF1y/VSeHxXMrpj4Z4uL4+HqWGt81Hjm+sF3tcK3xDB37MOCQO
GhJgF117C57t53/4Aec6nTFwTHyqSxkyMluQAh3IoM6p3w6X/B6U6g+Uu6vky6R+
mCYKR1iG7biMw0m+WHaQPL750M54EUpuPtwTWsWxUj0grPIch62eciZv6MKfwusD
iF0LHHYVebujsi613Y9fyOtyLlUHWPDmfUb2f3IxiYEfNt0Rknd6OyU5yQ9irlE8
PTj0oOrMdeQTvCBGrRmJIBpJ4xSY3i9nQdeh75dI4c38Nc2e5Gcvmoz2CmC06JWw
qzAvLdi0IGUoZsacL/Pyqn7QfeJDQKPRG5EhlxbfNB9/zmHjmuN1DyFH+V/5e25D
zBuU0hZCYjk/jgxrda0CP4iG4qfC4gqhOHlynA22uYq+7sy4HgQNq+SgFfurrnLC
ojUV9I/lqzUOA4qBsUOt
=F4Vi
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
