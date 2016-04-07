From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] cpufreq: tegra124: No need of setting platform-data
Date: Thu, 7 Apr 2016 13:41:05 +0200
Message-ID: <20160407114105.GB10231@ulmo.ba.sec>
References: <60bdca9a8f31714d733ace7e7c25c46cd366082f.1459260280.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <60bdca9a8f31714d733ace7e7c25c46cd366082f.1459260280.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2016 at 07:35:12PM +0530, Viresh Kumar wrote:
> All CPUs on Tegra platform share clock/voltage lines and there is
> absolutely no need of setting platform data for 'cpufreq-dt' platform
> device, as that's the default case.
>=20
> Stop setting platform data for cpufreq-dt device.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Only compile tested.
>=20
>  drivers/cpufreq/tegra124-cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)

Everything seems to be working fine after this:

Tested-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXBkdOAAoJEN0jrNd/PrOhVmkQAIP1JXkU1FR7JWCPJdIi0wBK
YoegQl4Kmp+7GmyJPOr96wdmMKKYRluaFHp4LWA7mmKH7omO+kEEZrBM6Ph09LZg
g9h9Y9A+sOhH0oyyhR85vhzVpl7CJJo8YaTucb3sM2F4EZYnV2mKbK+U7HG7NGSu
HNOELLDNEXevZmLQhPjhQyD0iyuO6DV2A9etYKc1uEUqTNvOohBaMLGmNs31uM7j
hI0lp6vSmnWoZ9H/9FfcTvG5ay1Uz4Zddzxy+c/SwmF7mbfr14nQhe9OM7bWxMBi
kfdbX41pXtGWFymeggin/0JmjD1Mn78iOJwZd3GVLRh0fS26hM2eM+l9FUBnQIpd
5mOVuuTHCx+5UsucUMjgE7yoQvnEIvqdF3iVNtvzll1nDQwcLBy/KZMN36SRR+f9
LPYVpRf8SjS8ayrJRWOzGwuA7Ai2PCSGEuRWKFKDdHREF7cdX39NlVyBLG+1vsgx
zPmidCj2Beo8tVIYsiI2ojdvlajrrltlYvMGB4URacMUEjF9xmfSOEdcssASOeHj
Gt9z96ZJ3IxuLYry2/dwcR1oWuI1LfFtbZz21s+dwFvUsad/fvrD2MIvFHXPYoSA
+OXB1qE6R5T+o6xTql0fnHTdt7GSHS2wYwGqxl6xAUYQD18cjb0pAIfAsUafhzrz
xUtAIYIZEVVlp4OSGarf
=ocUn
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
