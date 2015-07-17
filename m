From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 10/19] drm/tegra: dc: Prepare for generic PM domains
Date: Fri, 17 Jul 2015 12:41:55 +0200
Message-ID: <20150717104154.GM3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-11-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zROEGoKAXsG5UqGB"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436791197-32358-11-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--zROEGoKAXsG5UqGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:48PM +0100, Jon Hunter wrote:
> Add support to the tegra dc driver for generic PM domains. However,
> to ensure backward compatibility with older device tree blobs ensure
> that the driver can work with or without generic PM domains. In order
> to migrate to generic PM domain infrastructure the necessary changes
> are:
>=20
> 1. If the "power-domains" property is present in the DT device node then
>    generic PM domains is supported and pm_runtime_enable() should be
>    called for the device. Furthermore, the enabling and disabling of the
>    power-domain is handled via calling pm_runtime_get/put, respectively.

The device could be PM runtime enabled even if no power-domains property
is set. Couldn't we check something more direct, like for example if the
dev->pm_domain is non-NULL?

Perhaps it'd be worth converting the driver to use runtime PM first, and
move all the powergate and clock handling into suspend/resume functions,
and then we can conditionalize whether or not we call the legacy API iff
dev->pm_domain =3D=3D NULL?

> 2. To ensure that clocks are managed consistently when generic PM domains
>    are used and are not used, drivers should be migrated to use the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy=
()
>    functions instead of the current tegra_powergate_sequence_power_up()
>    and tegra_powergate_power_off(). The purpose of the
>    tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy=
()
>    APIs is to mimick the behaviour of the tegra generic power-domain code,
>    such that if generic power domains are not supported the functionality
>    is the same.
>=20
> 3. The main difference between the tegra_powergate_sequence_power_up() API
>    and the tegra_powergate_power_on_legacy() is that the clock used to
>    enable the powergate is not kept enabled when using the
>    tegra_powergate_power_on_legacy() API. Therefore, drivers must enable
>    the clocks they need after calling tegra_powergate_power_on_legacy()
>    and disable these clocks before calling
>    tegra_powergate_power_off_legacy().

This seems like it should go into the previous patch. I'm not sure I
understand why this is necessary. Wouldn't it be easier to update the
drivers to properly cope with this? We'll need to move them to runtime
PM at some point anyway, so if we do that first, we should be able to
hide all these details within the driver's suspend/resume functions
but without the need for the API churn here.

Thierry

--zROEGoKAXsG5UqGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNvvAAoJEN0jrNd/PrOh8q0P/1wINIsYJXw7TmYgSRbyg2Dr
U1gAvoDdAUKVIEjl8XDxesQVmKPbtQfw+PKDddbfS2QbPyg2Pv+nB4MoYBFTFbYZ
Hr9TquIxCr7mgDugig1YQVxZ/vnwEPQBtqSCru/gUsmVOg3iAVyZ0re6CjcoiFTa
3WpPmqkYwh8AbsfOS/M661PH8r0VOP2yU2sR0KKlKVQzFnCN1zH6z92GAZa0uxpI
9xCPBeMaQGPsXj3rPI/317pHO3WwqDWJrzDb30Ts89doSuFKGw8j0lyyq5Qu4y51
beLv3A57mpehbQgLb/GTGdzHVFGZ3IdkMv2mOJNXP+cmdraXWn+/qcVAreMhL+UC
ruGBu5DqUicCM0fVkXQIdcj3PqOJe67Mb0+gW/HSNiFzBxAPDVY1VjswMXFawNDw
9/qG9MiuKthi/pWvbFX0IoajjxMwg5D1npF+Unka4et2oKop1dz7fMbF8PsLJrA5
kmmApSUbQVXhhqEb4LZnY4PWrTqMxpuayoFaMr1Hi89oFkU0rQFUZMjutf4QoYLl
BsfGpBeOpoHQZtac98eLjImbgV9Y6uTons2Da5W3/ZKZpILQm5AV+5BUTE2mjlZ5
XMa9ZM6YtjtMsGNoXNe9UFa+ZPXDzXkKuOVcEba3Iv8FHX+eZVmyuooJayLrJOw+
nxTr2T4wIPt89oUUN+Cj
=w6aM
-----END PGP SIGNATURE-----

--zROEGoKAXsG5UqGB--
