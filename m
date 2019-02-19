From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] driver core: Fix PM-runtime for links added during
 consumer probe
Date: Tue, 19 Feb 2019 18:07:04 +0100
Message-ID: <20190219170704.GB14351@ulmo>
References: <2442421.P6CTj2BjBs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2442421.P6CTj2BjBs@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 05:53:26PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> counter imbalance") introduced a regression that causes suppliers
> to be suspended prematurely for device links added during consumer
> driver probe if the initial PM-runtime status of the consumer is
> "suspended" and the consumer is resumed after adding the link and
> before pm_runtime_put_suppliers() is called.  In that case,
> pm_runtime_put_suppliers() will drop the rpm_active refcount for
> the link by one and (since rpm_active is equal to two after the
> preceding consumer resume) the supplier's PM-runtime usage counter
> will be decremented, which may cause the supplier to suspend even
> though the consumer's PM-runtime status is "active".
>=20
> For this reason, partially revert commit 4c06c4e6cf63 as the problem
> it tried to fix needs to be addressed somewhat differently, and
> change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> that the latter only drops rpm_active references acquired by the
> former.  [This requires adding a new field to struct device_link,
> but I coulnd't find a cleaner way to address the issue that would
> work in all cases.]
>=20
> This causes pm_runtime_put_suppliers() to effectively ignore device
> links added during consumer probe, so device_link_add() doesn't need
> to worry about ensuring that suppliers will remain active after
> pm_runtime_put_suppliers() for links created with DL_FLAG_RPM_ACTIVE
> set and it only needs to bump up rpm_active by one for those links,
> so pm_runtime_active_link() is not necessary any more.
>=20
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter=
 imbalance")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Changes from the RFC version:
>  - T-by and R-by tags from Jon and Ulf.
>  - More details in the changelog.
>=20
> ---
>  drivers/base/core.c          |    4 ++--
>  drivers/base/power/runtime.c |   29 ++++++-----------------------
>  include/linux/device.h       |    1 +
>  include/linux/pm_runtime.h   |    4 ----
>  4 files changed, 9 insertions(+), 29 deletions(-)

I'm sure Jon and Ulf have done much more extensive testing, but I've had
this applied for most of today and haven't run into any issues, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxsN7gACgkQ3SOs138+
s6Fm+xAAnvoSqdn6wZcWkWeG6qooOo7YeCJH5FRW4fU6hIXoj6So8VgX9Miqnn+j
bDvvgviE6euyVqHSA2gokG35z0JQE8ZrIBcVwx2nZ7Qk8tGpYncvDtnnXCarnY6p
z4tfFrLK15/c84R1tc/ighFWS+9HAdZ33Lp673bhKCioGS52oUKoHKPIfoSYzIhL
oHcby4bCaWz91vwHVWfIF8vsBzvVPfs784D5Pc/nObvfOpa61ec1QkZvt+sdsC6L
edN63P4bYUzFhASWyrsOSPDomahh535L1cnXnNObcZTIIeOigiI6/gMDAhQkHK6E
QV6KtIPvj/uooTj9WHT5RqGHhQb+6fcyOzVwsJMJLpAdqErOzBTVlw1j1IuvGu2q
uOu1n+pz0c3h2y0B1bRc+CWjEMvRoHYz+eIcfE6GNk9oA1oE2rmiO4K/OeNicbew
hVrAuwBj02PgFmvEyfk9te08jhWwPEdApQB6A1bOazF+HHp/sHF/18F/1zochBcO
2hiyTs8br4Sriv2f+AnYncGTEGGgTtcDI5006mut0QlKTkTJT03PNEpP4I8aKtic
rrAfRIQbDA2BN6qcaBbjvAtgPZ6kVCRMcGBfp/yGg1fFh+6zbrROChQsiXrbbnDO
PLgh+vZMsUpj2QjwLbWCfl9+5ye6vIMX+FeFXSDIkjzWZetK2dY=
=hcNP
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
