From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 06/11] cpufreq: tegra20: Remove unneeded check in
 tegra_cpu_init
Date: Fri, 18 May 2018 10:57:37 +0200
Message-ID: <20180518085737.GF14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-7-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-7-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:51PM +0300, Dmitry Osipenko wrote:
> Remove checking of the CPU number for consistency as it won't ever fail
> unless there is a severe bug in the cpufreq core.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+lYEACgkQ3SOs138+
s6FCXA//e3o9EQLf8AXy4zLm2AdX1fPol4HziGLearqZXulBm7LFjk+q8JhuITXD
pk0/froyjqxioHIdeYATbym1DuNO9Q3ZA0vcobpWakgN1HciS/HKbSKaVLLia4cc
q73q9sIyqr41oQ3ych9hXtlxBkTKzmCET+IzbVJVoLrEvTc0jQEBPNJlO6Zpo0Ys
hAHhfebmLBmTQ8YuAxf6XU/PIEsAEz5SENIccHNXNSqiR4mxBjjTbst4WVWEV4uh
GFVRIQ2ooPIrDxswB2ZXpxFFSdSrE9P75odgoLoOb6hnyW8dTn3S9e57GdzKcZeE
EXg08e206VRuk/vO1A4jFdqWnqZ2oZ4ZyKftDjpKB9jhC/hQg3FAan6CBeLWsuBY
ACmjnMDL8+XJSZyqaJVHqQCceOQ1ZBe4zBAhx8C/X1Z0pbfAhlFDeuOpZoMxfj0X
046X0aMqCykC+vQZ1A3psD5PjEdCoDXlV/ItrFjwnOTQCByW+rdJF/4v5q8HHLSc
NJVRZlcUATtPu3GEmHl69EgCXZxSON1cVwqhNiVZ84GNttVOCaJDmMrYo9NoKoXY
dYBMhyujklF8eTEdlV6DxTF91V4C6IK+Qsyyfe9qRNR+0sXVwr2rsHsL6R5xt38L
IMijA/V3p/zRITaWFEF3YC1YosMgKd//lBQKnmP+5XOjO8seggI=
=SAKT
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
