From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] power: bq27xxx: add support for NVRAM R/W access
Date: Fri, 6 Jan 2017 02:53:14 +0100
Message-ID: <20170106015314.7qju6eodkwldty6h@earth>
References: <20170105021007.22088-1-matt@ranostay.consulting>
 <20170105021007.22088-4-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jxjlxtimakzalopx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170105021007.22088-4-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--jxjlxtimakzalopx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 06:10:07PM -0800, Matt Ranostay wrote:
> Initial support for access and modification of the non-volatile regions
> of the bq27425 fuel gauge DesignEnergy, DesignCapacity, and
> TerminateVoltage settings.
>=20
> This is intended for fine tuning the fuel gauge state machine for the
> respective battery specifications.
>=20
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  drivers/power/supply/bq27xxx_battery_i2c.c | 335 +++++++++++++++++++++++=
++++++
>  include/linux/power/bq27xxx_battery.h      |   4 +
>  2 files changed, 339 insertions(+)

I only skipped over this one, as the changed DT binding requires
quite some changes in this patch anyways. Here are a couple of
comments how I would like to see this implemented:

Add a patch for the power-supply core, which implements a
structure for the battery info. Something like this:

struct power_supply_battery_info {
    uint32 energy; /* =B5Wh */
    uint32 power;  /* =B5Ah */
    uint32 nominal_voltage; /* =B5V */
    /* ... */
};

And a function in the core framework, which gets the information
=66rom DT. The function itself should *not* be DT specific, so that
ACPI/platformdata/whatever support can be added later without
modifying every single driver.

static struct power_supply_battery_info*
power_supply_get_battery_info(struct power_supply *psy) {
    if (psy->dt) {
        /* get battery phandle or return -ENXIO */
        /* fill and return struct */
    }

    return -ENOTSUP;
}

Then call power_supply_get_battery_info() during bq27xxx probe and
use the struct to initialize the registers. Also I expect that
functionality in bq27xxx_battery.c instead of bq27xxx_battery_i2c.c,
since it's not I=B2C specific.

-- Sebastian

--jxjlxtimakzalopx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhu+IcACgkQ2O7X88g7
+ppnEQ//VrdWF6o0Gqzg0xUzU/Gnob0kOmEeJrRBZyDIjWnNyz3ADMlhu0ahw1a8
oXhHOoyg2myb+fhwRwz9oRh+CcWi5gw7whKvjcf1u6VY6LoQQakwlENMRw2RASfd
bO3RH4NLius1y0GIWRJRDf9Dy9BYtkmp+bdMJSjOJCGXCevTy38xfCGZV3mbQ/x9
bnjJJDCkB/xkQCLzTVK5pQsz6k1+xmX7VktOB4s1MMg+1DLyhdr8bOVlz9Kk3Orn
7eDstSD5PYE/CVz2xQy53qDmU/Ho2KAyFeH+EtMkIyBrWc4VxTJlwlLcYSvrrgU1
6IQq59Y+Prn6D1p4Bur9LJOCO7jQE8/eZwGVCyas3BTh9W07YC/8Rz9cyYLKCV07
5zamVg+fBoP1dyHWEU4SvPRxjTjT9WX9hLwpZ+6IkceTVPmEb9gyzvYbhpZuiLnc
scP1fa44eECRbDXY6WUwd6w6ay8Jfo3wDvt3Z6eOXfe4/8zM2Rdl6YMyTQ0QFz5i
gAlnaFXpDxtBP0a5QpuGHfPy32AS45PaQi3vnWrLyS9SoJzyXWyAu3GfEUYO96Xv
hJxkbNiJZXgifpsqiCsscWyLU8b5MKcBNgNewDLivtp3YVIv1GRE92WBEy/HxySJ
4QBAEcukLwMmzYywZzj83sy1Av1txtChtvoByP6ssgI618gPoUU=
=MQ8Y
-----END PGP SIGNATURE-----

--jxjlxtimakzalopx--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
