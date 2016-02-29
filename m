From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 06/10] soc: tegra: pmc: Wait for powergate state to
 change
Date: Mon, 29 Feb 2016 08:24:15 +0100
Message-ID: <20160229072415.GI23745@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456501724-28477-7-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:40PM +0000, Jon Hunter wrote:
> Currently, the function tegra_powergate_set() simply sets the desired
> powergate state but does not wait for the state to change. In most cases
> we should wait for the state to change before proceeding. Currently, there
> is a case for tegra114 and tegra124 devices where we do not wait when
> starting the secondary CPU as this is not necessary. However, this is only
> done at boot time and so waiting here will only have a small impact on
> boot time. Therefore, update tegra_powergate_set() to wait when setting
> the powergate.
>=20
> By adding this feature, we can also eliminate the polling loop from
> tegra30_boot_secondary().
>=20
> A function has been added for checking the status of the powergate and
> so update the tegra_powergate_is_powered() to use this macro as well.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-tegra/platsmp.c | 16 +++-------------
>  drivers/soc/tegra/pmc.c       |  9 ++++++++-
>  2 files changed, 11 insertions(+), 14 deletions(-)

This looks to be independent from the generic power domain support. Can
I apply this separately (for 4.6, without waiting for the power domain
series' dependencies to go in)?

Thierry

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0/IfAAoJEN0jrNd/PrOhxpgQAI51umkUmRIiRh4O3WA4a11j
fb6+fH+r7XsKnlsVeSB6MAItpBqQeBToDXQT8SULNRLJHYYgakVKR9TssRVqwqCU
SG+RUbMJQIspaS8AuPuiipZMphkEH/3PwEukwivnF96byIwx7YHcJMQp//JHsJUG
biaBVeLyCO6EnDUbduFZRdQPtmn5yWrchlp5rSiP1j5Qpr2wc4iuG27PaYTRN1R6
Rq3qoG/MBs7T6Sg4ZwkfxZQxJIuKDRjYeb7KPghS2kx8Inb2ejJcyba5kAEAYuKW
Jg/DclrguJmqEcXOk1RjTSpnu9G+RZ3UFu2fgFxglNY6JvEYWTzs5zQDe9qwkOye
yYEP8JugiTFyOmBBRLauQgGXujvoq31YtIsspSNgeiFKl6xBVjC7WbneJd8Y7W31
fDlrqiam7NsZjbve3Xd3Dc9OWvy7XiiZRIgOtpezX9GRmdCnr4mXdqWYiuA1SGhV
yL0tEe5IflDqlDUHTaw1xqEOt1pS4cqlWHlwRN8KrkKq5WROWaAJWFZoYUwAllvA
R4huMEKkXPyHXtHtqOemgWO289T1rw1leUIUtrt8Z6YDtZGMiMFwSs6Xl/PwcQmh
7sS9tpV+9Oiz+UARDuTzwxWmqcet0sY4p3C5DKlHhkOAMggz5o0f7Cst03DoeiuF
07FN/KLv/vNKbC9UOS9g
=P+3Y
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
