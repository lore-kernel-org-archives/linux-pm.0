From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] drm/etnaviv: add thermal dependency
Date: Mon, 24 Apr 2017 15:01:25 -0700
Message-ID: <20170424220123.GA3290@localhost.localdomain>
References: <20170419181209.537907-1-arnd@arndb.de>
 <1493030694.2891.10.camel@pengutronix.de>
 <CAK8P3a39B5C9ZcE7ZBMe9FaoTiBP5Dp4o_25V05nC5O8J+fTrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a39B5C9ZcE7ZBMe9FaoTiBP5Dp4o_25V05nC5O8J+fTrg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@linux.ie>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, etnaviv@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

dg
On Mon, Apr 24, 2017 at 07:39:27PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 24, 2017 at 12:44 PM, Lucas Stach <l.stach@pengutronix.de> wr=
ote:
> > Am Mittwoch, den 19.04.2017, 20:11 +0200 schrieb Arnd Bergmann:
> >> When CONFIG_THERMAL is enabled as a loadable module, and etnaviv is
> >> built-in, we get a link error:
> >>
> >> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_bind':
> >> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0x34): undefined reference to `t=
hermal_of_cooling_device_register'
> >> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0xe0): undefined reference to `t=
hermal_cooling_device_unregister'
> >> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_unbind=
':
> >> etnaviv_gpu.c:(.text.etnaviv_gpu_unbind+0xf0): undefined reference to =
`thermal_cooling_device_unregister'
> >>
> >> This adds a Kconfig dependency to prevent etnaviv from being built-in
> >> with CONFIG_THERMAL=3Dm, while still allowing the valid configurations.
> >> Unfortunately, simply adding the dependency here breaks Kconfig through
> >> a dependency loop involving lots of symbols all the way until ACPI_VID=
EO,
> >> which is the only video driver that explicitly selects 'THERMAL'. Turn=
ing
> >> this into a 'depends on' addresses the problem.
> >> For completeness, I'm also removing the redundant 'select THERMAL'
> >> from INTEL_MENLOW, so no other driver uses that statement.
> >>
> >> Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This patch mixes a few things, so the subject doesn't really fit. I'm
> > fine with taking the patch trough my tree, if I can get an ACK on the
> > ACPI part.
>=20
> Actually the ACPI part triggered a new warning that I haven't figured
> out completely yet. Please disregard my patch for the moment.
>=20
> I think we can just drop the dependency in ACPI_VIDEO, but I'm not
> entirely sure yet if we could hit a broken configuration with THERMAL=3Dm
> and ACPI_VIDEO=3Dy in that case. Unfortunately we cannot use the
> same trick in ACPI_VIDEO that I used for ETNAVIV, because of
> another circular dependency in ACPI.
>=20
>         Arnd

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/nWtAAoJEA6VkvSQfF5TeDEP/R0GPowsq2Jzv0AXp7+6yPBe
lJvHa+BvyNkkYYM9dUFgD8AsQspDFkzNaREtuS2QX018dlaCoQLS1RZlA17S4NXl
9in75bVRK29LOqsVj2JrRnJkEz20P1GabNkTh3TDgDY1GlV4TlyAPdlkSwdx5Flj
g9/U8/IOhTL+YXqbZ81tU47Dv1ITDLVhiaNmeSnQWeCBOFXWuyc8ZQ5BC0w7k5Xu
Hjm3KeTqRcgS7j8MIRyPhhHA8e4fd5xnIZk4SK6TXGttga6cdiDB3srjUq7xEPxh
5Cg8lpX8Nh62x+w2mQiaP/7CWPjlDL7F2gELmPCZdcVtdHDHzjaKNHPpcOQbrhyk
IdB+DjwY8lGCqQ9agpj/V9TVDjsxqPS8sq3gf0h512ElgWMDfzCkZ8t6A36nc9U3
Uq48GnXZH6WmdvF2FK22b4UHbFn2G28AR6Dw2sbMwKLMSzuTJ44R/nY19/6vJlUN
BacUEOyQ8NzFJj0Hhywv3UixhahYtZquDjAXYjeRzFuiOW1dJ6QX7pv4eeFRvc9I
3C+vd9uW8+ZmDvZVmk9BjFHtgimHG5WjqH7HBTD5qenpwOr5N0rp05Jg43qcvXjy
KeH66SjWLOyh1Kjxe7UoLuciYvt1J6v85CPQlLsaUt0fXnWFkPWWA1pdsK3tqpF0
3HwYj4+aHiCaPnrvsKZk
=444w
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
