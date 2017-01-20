From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 20 Jan 2017 14:47:23 +0100
Message-ID: <20170120134722.sic6q5i5asp352tq@earth>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth>
 <20170119232934.GA18102@roeck-us.net>
 <20170120124404.wmlpiuqyizi7uhyi@earth>
 <20170120131116.GA26505@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ng5cegwkaujnqrm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120131116.GA26505@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>
List-Id: linux-pm@vger.kernel.org


--2ng5cegwkaujnqrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 20, 2017 at 02:11:16PM +0100, Thierry Reding wrote:
> On Fri, Jan 20, 2017 at 01:44:04PM +0100, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Thu, Jan 19, 2017 at 03:29:34PM -0800, Guenter Roeck wrote:
> > > On Fri, Jan 20, 2017 at 12:00:36AM +0100, Sebastian Reichel wrote:
> > > I actually have a set of patches somewhere which transforms the remai=
ning
> > > direct users of arm_pm_restart to use the framework (unless I removed=
 it
> > > from my trees - I don't really recall). I just never got around to su=
bmit
> > > it, and then [2] happened and I lost interest.
> >=20
> > I found a patchset from you from 2016. I see a few Acks and no
> > negative feedback. Looks like they only need to be uploaded at
> > Russel's patch system?
> >=20
> > arch/arm/mach-prima2/rstc.c			https://patchwork.kernel.org/patch/884444=
1/
> > arch/arm/xen/enlighten.c			https://patchwork.kernel.org/patch/8844481/
> > drivers/firmware/psci.c				https://patchwork.kernel.org/patch/8844411/
> > arch/arm/kernel/setup.c				https://patchwork.kernel.org/patch/8844451/
> > removal of ARM64 arm_pm_restart		https://patchwork.kernel.org/patch/884=
4471/
> > removal of ARM32 arm_pm_restart		https://patchwork.kernel.org/patch/884=
4391/
>=20
> Nice, those would be excellent preparatory work for my earlier
> framework proposal. Do you want me to pick those up and run with
> them a bit?

They implement what I suggested earlier in this thread, so I think
they should get upstream. If you pick them up, you can add my
Reviewed-By to all patches. After having them upstream, ARM, ARM64,
MIPS and PPC use do_kernel_restart() for reboot.

-- Sebastian

--2ng5cegwkaujnqrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliCFOgACgkQ2O7X88g7
+pqH+w/7BrHM7lagv/zC6AlEtiaOqbPGt3Kx77NwrBqX+RZL9QPHAyzAp2JY2U+Y
l6xC9DMEuZMDbAlE6kMnXVgaRFhvk8cvj+c1cdlzIV+nY79SkZgXXdpEIWrTYEAV
LzUDrSgkCxwMKkxxp1MbhylYwf9H5hyh60+kIZh23v6jM8tuDuYgUzlUTt1ZzNSm
fyGZBuvnvkhvD5vM8v7VWR6sSb8ZG3EGgy5F0gX96n3z6Dds5Cak60ZLOls/XHVt
HR3a4byo7eELk6etLG9CJyJvPn7PGXDezQ4O6Cu95EovyfriikxyalOmwkDkMKqP
U/egB6v6cJyGt7BRokt7jLFtyCb8zWi3JjioZo6yezuV86exppMz3jybtUDHIc2l
O+HSavXIUgGbD9kybCOK0USX1/REcSwcvyKHcGaRTpEu9mXPyj3N4Lr6SKXrxQmc
+bqwi1e9i/CpGucAmc3ZkvqrUttkxWsjaQRxKjA7DXPT9rBrWN4s1dh15qACWwCy
3+V3+clIebK/gepgW1sU2H9rKUIvFooROibgVTOxLrtYMOT/lDZPqqlF18E1KeDF
nGYyEfF1d6WTLsjBniuqWokJfcAgbQ5Q/0kSvgC+KHRrjS7qIJpOdPiKmQRuhcwy
ED+Yp/fJ3GHJh35MyTj6y8pdxewoEEx96w6NdMO6gF3mEjmE9XA=
=NWwS
-----END PGP SIGNATURE-----

--2ng5cegwkaujnqrm--
