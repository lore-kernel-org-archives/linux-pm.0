From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 03/11] cpufreq: tegra20: Remove EMC clock usage
Date: Fri, 18 May 2018 10:36:39 +0200
Message-ID: <20180518083639.GC14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-4-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:48PM +0300, Dmitry Osipenko wrote:
> The EMC driver has been gone 4 years ago, since the commit a7cbe92cef27
> ("ARM: tegra: remove tegra EMC scaling driver"). Remove the EMC clock
> usage as it does nothing. We may consider re-implementing the EMC scaling
> later, probably using PM Memory Bandwidth QoS API.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+kJcACgkQ3SOs138+
s6FpPA//RtNtZ1WXf+1QXkaeVmqWNiFwVGDxx+6FrMAPjSJ1GSMBfPyKAiC8T9qm
LBPYO3w2cioqvITok4QB39QPgQH2tQHkkUkNs7FiYMBDZhECifzO/v2Njnw8KQwN
6xOarW4xcApDKXziePhGbGb6mOhg7KPtFjQCcFXXo9liuR/OdZLpTSaXkzrHoquQ
2BUSKMf1n/V1TnHKQwhDBZG9ZNVK94+Zk5oabST7cvuSQeZBTHiNF02KvDKm3g/x
owXzc6bV1VZaDLBvEbwV2mkhUKEcnrVfTQt5jZWnnKp5vkjG3pXk0f4PkjIwxdAk
/Q+ckpnR8rNVe4Ses7C8rX9kiOHjLyfRKd7GgFf3t2cO8GGFQzHKAwv1Aw5K6AAC
XYyIJTlYtNmbqq7jBKwxYK/vbY+XGzBDhOmmte0tAY6INubZDdaO3pcGeQgX1H/E
sPXdWS9P13Nvb3Yx//tPnU5OvjX4PoroMQUIQ1n5RsfNLUz6ha3hj8PJuLumbcLl
rdpCGhLqc2+pEJNTCrvRVMawR9MTViCu75NgwVNnLKGoHwDlTG8kQf711XDiBjR4
VjYR8uKx15wYyqLk2IWi9yAdNCNvOzhg+zltxL3xJBaFk12MlUGsW+huftOX4JGr
YmLpI2JY/xCfN6dcrlyUdz1m27jEF6vDd/d1mtgNFLfAy6JnMHw=
=5Djw
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
