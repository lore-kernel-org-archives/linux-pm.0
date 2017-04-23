From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] drm/etnaviv: add thermal dependency
Date: Sun, 23 Apr 2017 08:36:57 -0700
Message-ID: <20170423153654.GA6355@localhost.localdomain>
References: <20170419181209.537907-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170419181209.537907-1-arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@linux.ie>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 08:11:16PM +0200, Arnd Bergmann wrote:
> When CONFIG_THERMAL is enabled as a loadable module, and etnaviv is
> built-in, we get a link error:
>=20
> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_bind':
> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0x34): undefined reference to `ther=
mal_of_cooling_device_register'
> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0xe0): undefined reference to `ther=
mal_cooling_device_unregister'
> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_unbind':
> etnaviv_gpu.c:(.text.etnaviv_gpu_unbind+0xf0): undefined reference to `th=
ermal_cooling_device_unregister'
>=20
> This adds a Kconfig dependency to prevent etnaviv from being built-in
> with CONFIG_THERMAL=3Dm, while still allowing the valid configurations.
> Unfortunately, simply adding the dependency here breaks Kconfig through
> a dependency loop involving lots of symbols all the way until ACPI_VIDEO,
> which is the only video driver that explicitly selects 'THERMAL'. Turning
> this into a 'depends on' addresses the problem.
> For completeness, I'm also removing the redundant 'select THERMAL'
> from INTEL_MENLOW, so no other driver uses that statement.
>=20
> Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/acpi/Kconfig            | 2 +-
>  drivers/gpu/drm/etnaviv/Kconfig | 1 +
>  drivers/platform/x86/Kconfig    | 1 -
>  3 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 03cc4e74096b..252399efa8b3 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -184,7 +184,7 @@ config ACPI_VIDEO
>  	tristate "Video"
>  	depends on X86 && BACKLIGHT_CLASS_DEVICE
>  	depends on INPUT
> -	select THERMAL
> +	depends on THERMAL
>  	help
>  	  This driver implements the ACPI Extensions For Display Adapters
>  	  for integrated graphics devices on motherboard, as specified in
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kc=
onfig
> index 71cee4e9fefb..1d6c744e7924 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -3,6 +3,7 @@ config DRM_ETNAVIV
>  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
>  	depends on DRM
>  	depends on ARCH_MXC || ARCH_DOVE || (ARM && COMPILE_TEST)
> +	depends on THERMAL || THERMAL=3Dn
>  	depends on MMU
>  	select SHMEM
>  	select SYNC_FILE
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index e229ea317b9c..76ced87efde5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -544,7 +544,6 @@ config SENSORS_HDAPS
>  config INTEL_MENLOW
>  	tristate "Thermal Management driver for Intel menlow platform"
>  	depends on ACPI_THERMAL
> -	select THERMAL
>  	---help---
>  	  ACPI thermal management enhancement driver on
>  	  Intel Menlow platform.
> --=20
> 2.9.0
>=20

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/MoQAAoJEA6VkvSQfF5T6rMQAJPOQKsSwD8s2vG7z25QZWO+
yjT+w+1MAf000ap2nHyy2kuTjkKtGbPy3TIHfcUqug3hyaW2PGlIMB+vcWMFaEim
3QX3fYihw7oGHz5YJJydwRrooRXQw3a3CwoxPkFckB4s2SloMROv2kVkf/mO7z4w
+YYyx9DkBisffFQ5YMbWlsxH7WvcYwm7VuHPzVLfbVR/JUyC3hr+ZQtejH6k/M2B
o7grbNBpPNw0jxWkzNdw1IzQ3rVG4xAfn9JBg2WxkMmIavyCvyCn7UprIjYH87Y7
Mtsm7NAbNjntVUNLrKtQV+17GzY6u1T9D1p32TRwga9HCVi/e8OMSUtTp9eRzty1
1PK+0pFQjYuQ1ApVkInoqmfbjKA/NKoNV1IGk0PW+3vvWra3Y3zkxGoDwQT94d1B
OHeip/2ZuzbyoannidIXauP++ytQHxQc2QDxNNJgOv74m5FswOeMICmgGfsXm8HQ
mJLNXmVEtrmReQfGDvyUrru0vf5vP9i6wVoOS6E2VboHktQWEWyyqqcDsAzBcK7a
gQIE88uh7+/n8hoFnk6KHawpq7fO1xxI/qibL0nZOElzXmVbHx7prNuFABpqV/Yw
6X0DjeUj3bYorD4XlM+SvRds9lXSFN/hutuHF1ED0qeLdRH7d/T3vETsxPAOLieq
B1eaGYwHcLdr6qLIaZEN
=LWPG
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
