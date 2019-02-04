From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] cpufreq: tegra124: add missing of_node_put()
Date: Mon, 4 Feb 2019 09:18:56 +0100
Message-ID: <20190204081856.GD19087@ulmo>
References: <20190204074854.1538-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204074854.1538-1-tiny.windzz@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, jonathanh@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 02:48:54AM -0500, Yangtao Li wrote:
> of_cpu_device_node_get() will increase the refcount of device_node,
> it is necessary to call of_node_put() at the end to release the
> refcount.
>=20
> Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> Cc: <stable@vger.kernel.org> # 4.4+
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> v2:
> - move of_node_put() to the very end
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX9XAACgkQ3SOs138+
s6G4jBAAlgA2xdi+6rc/lInEg58zKJ0Zho9KQJtCw50zyKh29ehRJk0FiH3JHasX
yKm87ps5b29isZOQx4vOcCgKI6qSl3zhHCQwSFbcJAtabcIDU68yBJtA45Of12WQ
2X043Rc8Q41+Qzh4c0zK9kOfExkIZhMCdiOEbwyZ8qkKPw6JzagKfRQzkyDFUTkE
6S34wMlA9euHF59PcIY1GYuZy3x9bLL7qfef42wJgU+tvR4e2mkxE5MGlPDlkeli
ptVC8Fm+vEROwynHleP0SYPPjmWEcPSkdBUEfADQeTeQS38CoCapTJb7xolN48k4
j+k17gy2v0Ewf5SDCYGJTrKRjtXvW1VRMzrXhMnOajJ7u3yeIV2iUORIj7MhSFhG
Oaexc16CokJsMaeEZD43PT5kz8teb9UvdC4f+7KGeYt5jMY7oMkec7BpDmm3ZPDt
gJkk9vDEaQTj7AwoNSqJzI1Spt+oTeNzRo54ZWxRJydld7ZhqmU2CuGTAIP/ZFs1
WCeZtH6qH0eZo8Tj0HwNEZmu93A9+ub6bwPlKWsUIR099lgqQ6RSvBaytvBiNXDX
bYTih+Wm6BsrvlbNdVcEGVBnsVFfzNEnnyY486nDEes7lHhedIIRDpx8lYDLUO8R
jKZbTsQx+4xtCkQcJHcUDYBSUtOU4ZGowGV6o7wG1BRoP8A2gcY=
=1pfn
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
