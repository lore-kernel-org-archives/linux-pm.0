From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 04/10] power: power_supply: Add
 power_supply_battery_info and API
Date: Thu, 23 Mar 2017 11:17:27 +0100
Message-ID: <20170323101727.y53vc74fskqxdw34@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-5-liam@networkimprov.net>
 <CAKvHMgTpRLx+8NHsjcaGpqN=W-7ujBoiXtRwm9A+JGbcNANS-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lhths7l6htwcw44"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932198AbdCWKRd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 06:17:33 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgTpRLx+8NHsjcaGpqN=W-7ujBoiXtRwm9A+JGbcNANS-w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--6lhths7l6htwcw44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 01:59:01PM -0700, Liam Breck wrote:
> On Mon, Mar 20, 2017 at 2:43 AM, Liam Breck <liam@networkimprov.net> wrot=
e:
> > From: Liam Breck <kernel@networkimprov.net>
> >
> > power_supply_get_battery_info() reads battery data from devicetree.
> > struct power_supply_battery_info provides battery data to drivers.
> > Drivers may surface battery data in sysfs via corresponding
> > POWER_SUPPLY_PROP_* fields.
> >
> > Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> > Signed-off-by: Liam Breck <kernel@networkimprov.net>
> > ---
> >  Documentation/power/power_supply_class.txt | 12 ++++++++
> >  drivers/power/supply/power_supply_core.c   | 45 ++++++++++++++++++++++=
++++++++
> >  include/linux/power_supply.h               | 18 ++++++++++++
> >  3 files changed, 75 insertions(+)
> >
> > diff --git a/Documentation/power/power_supply_class.txt b/Documentation=
/power/power_supply_class.txt
> > index 0c72588..dc92c77 100644
> > --- a/Documentation/power/power_supply_class.txt
> > +++ b/Documentation/power/power_supply_class.txt
> > @@ -174,6 +174,18 @@ issued by external power supply will notify suppli=
cants via
> >  external_power_changed callback.
> >
> >
> > +Devicetree battery characteristics
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Drivers should call power_supply_get_battery_info() to obtain battery
> > +characteristics from a devicetree battery node, defined in
> > +Documentation/devicetree/bindings/power/supply/battery.txt. This is
> > +implemented in drivers/power/supply/bq27xxx_battery.c.
> > +
> > +Properties in struct power_supply_battery_info and their counterparts =
in the
> > +battery node have names corresponding to elements in enum power_supply=
_property,
> > +for naming consistency between sysfs attributes and battery node prope=
rties.
> > +
> > +
> >  QA
> >  ~~
> >  Q: Where is POWER_SUPPLY_PROP_XYZ attribute?
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index a74d8ca..61e20b1 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/device.h>
> >  #include <linux/notifier.h>
> >  #include <linux/err.h>
> > +#include <linux/of.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/thermal.h>
> >  #include "power_supply.h"
> > @@ -487,6 +488,50 @@ struct power_supply *devm_power_supply_get_by_phan=
dle(struct device *dev,
> >  EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
> >  #endif /* CONFIG_OF */
> >
> > +int power_supply_get_battery_info(struct power_supply *psy,
> > +                                 struct power_supply_battery_info *inf=
o)
> > +{
> > +       struct device_node *battery_np;
> > +       const char *value;
> > +       int err;
> > +
> > +       info->energy_full_design_uwh =3D -EINVAL;
> > +       info->charge_full_design_uah =3D -EINVAL;
> > +       info->voltage_min_design_uv  =3D -EINVAL;
> > +
> > +       if (!psy->of_node) {
> > +               dev_warn(&psy->dev, "%s currently only supports devicet=
ree\n",
> > +                        __func__);
> > +               return -ENXIO;
> > +       }
> > +
> > +       battery_np =3D of_parse_phandle(psy->of_node, "monitored-batter=
y", 0);
> > +       if (!battery_np)
> > +               return -ENODEV;
> > +
> > +       err =3D of_property_read_string(battery_np, "compatible", &valu=
e);
> > +       if (err)
> > +               return err;
> > +
> > +       if (strcmp("simple-battery", value))
> > +               return -ENODEV;
> > +
> > +       /* The property and field names below must correspond to elemen=
ts
> > +        * in enum power_supply_property. For reasoning, see
> > +        * Documentation/power/power_supply_class.txt.
> > +        */

Let's make this "should correspond".

> > +       of_property_read_u32(battery_np, "energy-full-design-microwatt-=
hours",
> > +                            &info->energy_full_design_uwh);
> > +       of_property_read_u32(battery_np, "charge-full-design-microamp-h=
ours",
> > +                            &info->charge_full_design_uah);
> > +       of_property_read_u32(battery_np, "voltage-min-design-microvolt",
> > +                            &info->voltage_min_design_uv);

> Should we also check for an acpi_handle, and use
> device_property_read_* here? Tho presumably the acpi property names
> would be different...
>=20
> I wouldn't have a way to test that however.

Yes, please use device_property_read_* instead of of_property_read_*.
Apart from that you do not have to care for ACPI for now. It can be
added once needed.

> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
> > +
> >  int power_supply_get_property(struct power_supply *psy,
> >                             enum power_supply_property psp,
> >                             union power_supply_propval *val)
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 3965503..e84f1d3 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -288,6 +288,21 @@ struct power_supply_info {
> >         int use_for_apm;
> >  };
> >
> > +/*
> > + * This is the recommended struct to manage static battery parameters,
> > + * populated by power_supply_get_battery_info(). Most platform drivers=
 should
> > + * use these for consistency.
> > + * Its field names must correspond to elements in enum power_supply_pr=
operty.
> > + * The default field value is -EINVAL.
> > + * Power supply class itself doesn't use this.
> > + */
> > +
> > +struct power_supply_battery_info {
> > +       int energy_full_design_uwh;     /* microWatt-hours */
> > +       int charge_full_design_uah;     /* microAmp-hours */
> > +       int voltage_min_design_uv;      /* microVolts */
> > +};
> > +
> >  extern struct atomic_notifier_head power_supply_notifier;
> >  extern int power_supply_reg_notifier(struct notifier_block *nb);
> >  extern void power_supply_unreg_notifier(struct notifier_block *nb);
> > @@ -306,6 +321,9 @@ static inline struct power_supply *
> >  devm_power_supply_get_by_phandle(struct device *dev, const char *prope=
rty)
> >  { return NULL; }
> >  #endif /* CONFIG_OF */
> > +
> > +extern int power_supply_get_battery_info(struct power_supply *psy,
> > +                                        struct power_supply_battery_in=
fo *info);
> >  extern void power_supply_changed(struct power_supply *psy);
> >  extern int power_supply_am_i_supplied(struct power_supply *psy);
> >  extern int power_supply_set_battery_charged(struct power_supply *psy);
> > --
> > 2.9.3
> >

--6lhths7l6htwcw44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljToLcACgkQ2O7X88g7
+prvoA//VO9NPSdB3ONWa2i35nCqcyZP6nu0QfdCzYKXpFLiwhpd7ybluPwG3G6r
HvpKg8yR4DkvDCsgz2LCQ9tHzrftKbBZ3R8/aVC/dQq38onQaFVPzNTPOavswdzb
TraiqqBjk+OBIJAwAeAFj09brtM2wDDry5IV4oi+l7sTJe0E03hv1yu/dUBQTUQw
YHB9+e/y68udkp6vT3bNL2sea8pCKyANi3eDkhJpPPfOHAt3/vt6pKqw1cky9vPQ
1E71RJA4TnufoWv/MwC3pGMY6J1HG+BGvlgDZA1C6jcmiEkE6GUadTUqK0VTo4ya
UTaP29o4mbG8RqSrKpgCgHSOjzIRj8iiCZgQxVrKfREzZTYf9bVXIONXZ4P4O4EA
4xx+c2xM+la2/tTaMRNY7b2wChPGYMvPy1MPNwFqSLkaAI3Yf1CFTkApnUwjNxsN
1HHPDg8f2HApdNkDRHNJ4Xe0ifmP2PRAVZProGBIr+RwUDXxAxA7CfdZ9k3ZlWSv
fHsl892od8Btbv7lpU3l2QDvT3XNXVJPJaKTTnL4PBYHE/vWT8wAZz5IUo/ZtQwi
//1KxFnAgjaC3turc7TMC1M7wyp8yo8V6dOPHUbB83bYXhIWGudkmMH1XaVIuUMx
HiPX7u3o8KuKYzQQS3G5BZvAYef5YlMm4ywdYM0mF7nszrCmiAk=
=OJ7J
-----END PGP SIGNATURE-----

--6lhths7l6htwcw44--
