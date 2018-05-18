From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 04/11] cpufreq: tegra20: Release clocks properly
Date: Fri, 18 May 2018 10:37:38 +0200
Message-ID: <20180518083738.GD14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-5-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-5-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:49PM +0300, Dmitry Osipenko wrote:
> Properly put requested clocks in the module init/exit code.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+kNIACgkQ3SOs138+
s6El9xAAo0rK3CmKN+KYKlyHNxqiy+l4RfFoogQ4cbV2p/zdjEmzy6OHXrwQT6vn
EPLWlv7QHh8TG/4FZe03Bg4KKjifR1KgdBEeGXOLSzdqe3bf/hYUtFlN/3jgmiEF
2CqaOSokql1ro+2J9tug8kbDlRD4NXXouIla6X1fNW8/5Bib9v/AWt9NdCnUy1OU
o937DezQp7dcU6AfJ9BM86NiSi7zD18x6QnHasqyUA/a5/GswJ9GbbYPDuGGKz8t
5sqa+Z+QiEFxj4K4f8bTRyPcu+DkFRy4tc4wDsVdZNOCNz5TmYuIezgQzloH3b8o
2k5HY2epzFA9xurXtL23fQhDF1WAY1QoGbeAYTPB5or4Gvn0vhw3cdgkc2bYwpwc
Q6Mqd+q8YBTLMqnedW6xx7jUrlZlKf/qQ2bCM/aLBblHAAaewjn4EYLNDEec2Ze6
K5x7d83t3tIv/mz4me0p8N3yKOTDqc2DY9x/aQo2bj/Mm+FsM/JEZVVNOPUmZGqk
K07d9BzjFK8WRtL8UiWCcN9LPxJVtO2q9skGthOoelkZktZRIeApnhhtkjDQm+dY
0CQKx/CKSy40ttXtaioP6iZJh88UyoMU2r/4T/3uOH2In9wvVfAdUK8d0gGI3rhP
KBTZqM1C0HdixGLUEX6Z80Tu9gPy3MdSSAfYSYrGiZttJPjVOnI=
=zMGs
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
