From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V6 03/10] PM / Domains: Add function to remove a pm-domain
Date: Mon, 29 Feb 2016 08:15:21 +0100
Message-ID: <20160229071521.GG23745@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37599 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbcB2HPY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 02:15:24 -0500
Content-Disposition: inline
In-Reply-To: <1456501724-28477-4-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:37PM +0000, Jon Hunter wrote:
> The genpd framework allows users to add power-domains via the
> pm_genpd_init() function, however, there is no corresponding function
> to remove a power-domain. For most devices this may be fine as the power
> domains are never removed, however, for devices that wish to populate
> the power-domains from within a driver, having the ability to remove a
> power domain if the probing of the device fails or the driver is unloaded
> is necessary. Therefore, add a function to remove a power-domain. Please
> note that the power domain can only be removed if there are no devices
> using the power-domain and it is not linked to another domain.

So I guess this introduces a problem not uncommon to other types of
resources. If you remove the driver, even if you fail ->remove() the
module may still go away along with any code associated with it. So
even if the PM domains can't be removed, you can't prevent the module
=66rom going away. That could be somewhat mitigated if we were holding a
module reference count, because then the only way to unload the driver
would be via sysfs (we could prevent that too, which might be the best
way to do this today).

There is work underway to solve this generically, Rafael was working on
this, so I'm not sure we need to add additional infrastructure to the PM
domain code as part of this series. But we may want to mark the Tegra
PMC driver as .suppress_bind_attrs =3D true, to make sure it can't be
removed.

> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  5 +++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 608bc00655ee..22f6e9d738bf 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1557,6 +1557,37 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
> =20
> +/**
> + * pm_genpd_remove - Remove a generic I/O PM domain object.
> + * @genpd: PM domain object to remove.
> + */

Would it be worth noting here that the object is only removed from the
list of domains, but that users are still responsible for freeing any
resources (such as memory) associated with it? It seems like this might
be obvious enough given the usage model of pm_genpd_init(), but it's
something that I noticed missing from the function.

Otherwise this looks fine:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0/ADAAoJEN0jrNd/PrOh2NUP/25RqAgF2c0W88VGCKxD0dKE
1/AK73iF5KKdnGKJ4Rsu86wi1yAH3qV5IBVsNUFU6hRBjZw/HW6qnNKTIb5TZCBE
anxQek+2MjdVvB4x6uI5k2fvBG/FUiAvM9v1TmutT9eCmSMfsiN+x8uM9CBMg000
IjsQt0fNa/k6JKJsAF+NPluiUV/4ZPBhvZG7ZIrxEJp1FHWglwtFogcdVm3tY7lI
XA1aTzv2pWGALCv2Zj4gAS4chrFhMreTc5Pr9OVK4OmyS8RmQeU47YTBc+/LvWJE
ZQ2y/pA7c0EeRq4FHBjTpVf6q9dy/nAbhwIdQ1FFBjDvunUysA3x9V2nYKeeEiUq
w3o/yPT8YXHuunQd/qKeqvq/oxVcepArDhPAFJ2nrjbABvuHUVlk3BHHNaxNMr6b
59iAm+LdhdE3R+mkIQjVCAVX7kgpHpOLVlG8bIeKWxc+eVABcZ9EmmZmYVwIg9Ey
ny9Fxd6xVkud2o76XUbIVwFkyW66UtJb5O/XqkW4+jWn7N2mq0O5SlDNTe8nGYmN
W4Y7XV03diq0pOPDH9m+drMKcCAyW/bzW/d7n7tUwW/pCe5lExzGwU5djtryHBzT
QTiUbcmjs3oMAtdeMXvShKGIXmgOCHzrlydXNmJHSMQwnmaI+fX8WHjSkwbNQmos
j4AxtstNos4z38DrFx0C
=+kt+
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
