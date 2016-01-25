From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 04/16] soc: tegra: pmc: Remove debugfs entry on probe
 failure
Date: Mon, 25 Jan 2016 14:25:59 +0100
Message-ID: <20160125132559.GR20452@ulmo.nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-5-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="soWJpSPh+l8Y6Fy7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-5-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--soWJpSPh+l8Y6Fy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:05PM +0000, Jon Hunter wrote:
> The debugfs entry for the PMC device will not be removed if the probe of
> the device fails on registering the restart handler and so fix this so
> that it is removed.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/soc/tegra/pmc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, with a slightly rewritten commit message. Thanks.

Thierry

--soWJpSPh+l8Y6Fy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWpiJnAAoJEN0jrNd/PrOhKBYQAIgGdKKlIG4LBoh87p3m2dda
iW37v4FeGTXAbbva9JBS+KSuMveq+kpUsR7LgJt2pJfeKRps5UkYyPC0gitZJVeJ
0F5lL2vOaIgumIz+lNngSHgegnts9sgmWSSiKeZzOb49Xqpko5bu08x4SggNMyEq
WljpJ0l251kE87s3n8aFDM19JFXMVWYgMH7YnI2GgRunwnVpxUpy2ThjicNyRKDj
LP28S+8S9MEuWrmtWoNwbd5B4dNXTjC3cBl0B9yxo8vtw+akwCk6Ckb947GzFDtC
8OgzrdJl0x/IUWZYTdOn+2ESfh/gKY2y1bZl5f4SZguBJagzvf95KXGNBZBgr7Yw
CxfUy01bqRPFKlIjbAaTrEz54bBeMNVlokDoTvp2hFeSBvE/PoJmFmYUwZdEi8cI
96vvUzcvhnO7FG3mD+HYoQGDOSbIR96x6g7uAjfZa3sOo6Dddn2h+mBvOQPMyqP5
kq9PjeK3vUYQAi7pzgVu2EpAkJ2tjTa6JzyicUQ1wliY7JpM7Vvo6fVYWq5zohLw
qR5+zH4IBKbPScZula5wdolt9iFlVcNPGAj3r4OyLXhkaQtxVvbDbZIcTol0R9kf
Pcb98IItLoZq3j4eCw4dhDozD53Faccbz77J4ev5iYT7Wvyj/o1T7zwPtz9MoTs7
puv2u68Iusv/StqHaAu+
=+YOy
-----END PGP SIGNATURE-----

--soWJpSPh+l8Y6Fy7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
