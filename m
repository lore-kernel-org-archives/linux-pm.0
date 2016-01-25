From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 02/16] soc: tegra: pmc: Add missing structure members
 to kernel-doc
Date: Mon, 25 Jan 2016 14:20:57 +0100
Message-ID: <20160125132057.GP20452@ulmo.nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRkqPRiqIDKgfg/F"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-3-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--TRkqPRiqIDKgfg/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:03PM +0000, Jon Hunter wrote:
> Some members of the tegra_pmc structure are missing from the kernel-doc
> comment for this structure. Add the missing members.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/soc/tegra/pmc.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--TRkqPRiqIDKgfg/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWpiE2AAoJEN0jrNd/PrOhzmYP/2IHL7zYJhmJJeAVfNVL9FWZ
ejXzhgXcv9+LSw2EUdIdHkuU9e9bXULQ8mH6mVGvfgm0rKHwKcV+zylIW5PXha2c
HQ1jjIXYNPCrAtXuQ/qhr06G7xx0HQjSZy9V98cjpWx4SRsn+JFPDGfwq3d7ONGg
vLdgaPZ0rI6NNyr3aQCORPdAYIP1zHWSwNJ63wVsemeQ2CRwXByIzgsBpOsT0pid
p/mK/zyv4vqknZF3oBUnHGbFLHpqESvNoh03lSwahnyP2gCDiQZbZ5oJkj7g/Evn
3cgu78glFhDHKbZHRe/KpzRjcxg9MS2p1TqBTBVrXzpdUrtRy79zZN/fZUhI0lvg
qbZIgqZwrJvih9JgGXGd+nJXBK22/VrY7I/HDGzwp9lpLknkmO6NNERjQlcYOarO
GiRUBXuvbKGfVeai6r80PFh7yoNcZx2g5NbIlmg9dRV+p4Tp7ewCNvwvnxQn0v6q
YullkJWpO8vPBIXDI+9I8WPGCIEQ6QR6yGzsKd99hb+p5DbzpGhX5iwu1NBP69Yj
Z/TAxRBHV4HBHcmZKeHHS8Zq/eNw8zohOf1qpO7f3un5Rv46hHXIOU7d3lNGR+q3
YlGbCZbbJc6KOJhQb85L436WWAvzWRUsviCzk4NmkTHXR09dTaYmxoltdkBugnBM
Eci+dL8YQ0mn7WtD3nZx
=129t
-----END PGP SIGNATURE-----

--TRkqPRiqIDKgfg/F--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
