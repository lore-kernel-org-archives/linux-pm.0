From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V8 1/4] ARM64: tegra: Remove unused #power-domain-cells
 property
Date: Tue, 5 Apr 2016 16:03:49 +0200
Message-ID: <20160405140349.GA28814@ulmo.ba.sec>
References: <1459329316-27293-1-git-send-email-jonathanh@nvidia.com>
 <1459329316-27293-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459329316-27293-2-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:15:13AM +0100, Jon Hunter wrote:
> Remove the "#power-domain-cells" property which was incorrectly
> included by commit e53095857166 ("arm64: tegra: Add Tegra210
> support").
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXA8XFAAoJEN0jrNd/PrOhea4P/2jzGq1mdF/l8QiSBjCEZe/e
d7vbalcWN+UEuVLoxylXCjlt8Do9BJrXU4XvZbiGEouMtHE8PF2ZD6EKR6rjdmjM
+Ti0zKEJ8v+K1cihfbGN8TNbIWVHaYwJDIWFSFdgRSGc0tfKQ/AYvyP5fDbEDCG9
GjARoUrS+V5uRhTvAL6FIcmQ9+ukwpwgVvGdmtuttxYAHkASSI9mE5Ji5WUA+rS1
NgrYQ4gzQ97Mt186hrNmuOVNLl0OYHKSwN81YYU8d/Tk7iTn/C3qa29hdjNryPr8
GjIICMnV+xZwa5I1JZaf2zkIkk57RNRY8xayvkkG4wI0XEti46Zd3QUx5wjaz90H
lMP1lPQAe38YClb+usg5JOJQ4mzQkOQpl6FsPX+AMZUYOcziA6M73nNKGHnu+mvj
edrjssngaIX0d+f6otVhIaD8Qfz+21Wdm0blliGfawnB3qw71vw5KOiW8afuA5Ak
9mvgn40hH8RA7oO9kS7itSxEu8v4JpGUCsj1p65s/htWkqjvpw2HJa05dp8GHL8D
WiljwCP6b642b/8d2gmtXwa060aAf75Y3PT1O6Q+EmxWZweUlEUg8cOIz7Z5+seg
SQ6yhx2NdvEpRqzATXvzj6mVPCk8uwpCAo3VIf/e3nI342eRCVePhLlkioBdnYA6
85Q3yW3mcqKUItwGf5yq
=yaP9
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
