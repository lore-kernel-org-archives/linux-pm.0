From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Date: Mon, 4 Feb 2019 08:28:23 +0100
Message-ID: <20190204072823.GA16448@ulmo>
References: <20190204063501.1348-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204063501.1348-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, jonathanh@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 01:35:01AM -0500, Yangtao Li wrote:
> of_cpu_device_node_get() will increase the refcount of device_node,
> it is necessary to call of_node_put() at the end to release the
> refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra12=
4-cpufreq.c
> index 43530254201a..140a9266b64a 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_dev=
ice *pdev)
>  		goto out_put_pllx_clk;
>  	}
> =20
> +	of_node_put(np);
> +
>  	ret =3D tegra124_cpu_switch_to_dfll(priv);
>  	if (ret)
>  		goto out_put_pllp_clk;

I think this needs to move to the very end of the function, for example
after the call to platform_set_drvdata(), to avoid releasing it twice in
error paths.

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX6ZMACgkQ3SOs138+
s6FTthAAmzju9J/g7xZvUNuFeSub4rVfmwSvbqHS3TrDQA41Mh9Iib5kKF2Aybpu
Q79IB0v1vx90FdVtOMOrEdWEZv5hNhXfgfRpnu1RJaF5kRB/gblG7OUoDKpRSNBS
zRSfArj188UICNpJdC2Bd3U6UAc/IFsO3fnsR4GJCYv0yQKyh455tiaWZ1ZJGbfO
ZlqTXADiMLKEHlEUNyoieYU/O0yVEQm5zynJ7+Q5U0G56bfbzVguo5SWrfMwFp/1
UScRWd+J00zEMkNodIO9wvKzjwKsSizGRwC9zfsPC9PVsIC3y+ecNj1a16vpbjFp
//FWB+cKVtCcIWlj7EmhZuiyoo3DvYt72x1TemVEdj7HqRntkiyuc6zjq1vgh2Pr
h7HDtDTKzsB9Frzjt86ez3zEgvf825dBb/zFlVN16r7xsDpgHdVQw6vWSZb8FXMX
zqDIzeSpQGvND+/XqlPRFEKgvt67fHT62yRbJ8WBbNuz2ANCFuFWFJDCNF1O3XrC
1T4r/0FYD/ALRZjOYPKarttC6Htf2ChBPpeCid2c+kQiheBByPafmCWAKaqMEs2g
Xv8UWCGY/bEOxt/qi0oeWq/VSVdGGBLvH0A4n/3G47YW83u7uKkoYXRiOgJkG8B9
NQa+ap0GhieIFiu3QrQQcF61uQ/1g3DZgTv4GQyzUNNqFDsdk78=
=0N1v
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
