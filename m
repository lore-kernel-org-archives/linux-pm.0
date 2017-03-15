From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v10 1/8] devicetree: power: Add battery.txt
Date: Wed, 15 Mar 2017 23:57:09 +0100
Message-ID: <20170315225709.ugjibnoqfukay657@earth>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-2-liam@networkimprov.net>
 <20170315220425.qeidvmanbsmq4wxk@earth>
 <CAKvHMgSF2rsaAaUqFw1qF+b2NA9CkABYKYOTd2p+imuPAHq9JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dk5atukt3lm4zwyl"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbdCOW5Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 18:57:16 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSF2rsaAaUqFw1qF+b2NA9CkABYKYOTd2p+imuPAHq9JA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--dk5atukt3lm4zwyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 03:18:17PM -0700, Liam Breck wrote:
> Hey Sebastian, welcome back :-)
>=20
> I've taken over work on this patchset from Matt.

Ok.

> On Wed, Mar 15, 2017 at 3:04 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi Liam & Matt,
> >
> > Sorry for my absence in the discussion. I skipped the previous
> > iterations for now and start with this version.
> >
> > On Wed, Mar 15, 2017 at 12:26:46PM -0700, Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> Documentation of static battery characteristics that can be defined
> >> for batteries which cannot self-identify. This information is required
> >> by fuel-gauge and charger chips for proper handling of the battery.
> >>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >> ---
> >>  .../devicetree/bindings/power/supply/battery.txt   | 45 +++++++++++++=
+++++++++
> >>  1 file changed, 45 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/bat=
tery.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/battery.tx=
t b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> new file mode 100644
> >> index 0000000..0278617
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> @@ -0,0 +1,45 @@
> >> +Battery Characteristics
> >
> > Maybe add something like
> >
> > This device provides static battery information, that is usually
> > available in the EEPROM of a smart battery. It's supposed to be
> > used for batteries, which do not have their own EEPROM (or if its
> > unusable).
>=20
> OK.
>=20
> >> +Required Properties:
> >> + - compatible: Must be "fixed-battery"
>=20
> Rob questioned the term "fixed". Shall we consider other terms --
> simple-battery, plain-battery...?

I don't like the term either, but it was the best I came up with.
They are known as "dumb" batteries, but that term looks too
colloquial for DT usage. While I think "simple-battery" is not
perfect either, it's better than "fixed-battery", so please switch
to that in the next revision.

> >> +Optional Properties:
> >> + - voltage-min-design-microvolt: drained battery voltage
> >> + - energy-full-design-microwatt-hours: battery design energy
> >> + - charge-full-design-microamp-hours: battery design capacity
> >
> > Looks fine to me.
> >
> >> +Because drivers surface properties in sysfs using names derived
> >> +from enum power_supply_property, e.g.
> >> +/sys/class/power_supply/<device>/charge_full_design, our
> >> +battery properties must be named for the corresponding elements in
> >> +enum power_supply_property, defined in include/linux/power_supply.h.
> >
> > This is Linux/implementation specific and does not belong
> > into a DT binding document.
>=20
> I just wrote on a thread for an earlier version of this patch:
>=20
> "Sebastian proposed DT:battery specifically to be consumed by
> power_supply_core. Allowing names in DT:battery and
> power_supply_property to diverge would cause confusion and wasted
> time, for no particular benefit. As there is no rationale to
> reconsider the names of these fields for DT:battery, let's write that
> into the docs."

DT bindings are not "Linux hardware information bindings". Of course
there is no need to diverge without a good reason, but that kind of
Documentation just does not belong into the DT bindings.

> >> +Batteries must be referenced by chargers and/or fuel-gauges
> >> +using a phandle. The phandle's property should be named
> >> +"monitored-battery".
> >
> > This looks fine.
> >
> >> +Driver code should call power_supply_get_battery_info() to obtain
> >> +battery properties via monitored-battery. For details see:
> >> +  drivers/power/supply/power_supply_core.c
> >> +  drivers/power/supply/bq27xxx_battery.c
> >
> > This is also Linux/implementation specific and should be dropped.
>=20
> We ought to mention how drivers are expected to consume DT:battery.

That kind of documentation does not belong into
Documentation/devicetree/bindings. We can add something to
Documentation/power/power_supply_class.txt instead.

> >> +Example:
> >> +
> >> +     bat: battery {
> >> +             compatible =3D "fixed-battery";
> >> +             voltage-min-design-microvolt =3D <3200000>;
> >> +             energy-full-design-microwatt-hours =3D <5290000>;
> >> +             charge-full-design-microamp-hours =3D <1430000>;
> >> +     };
> >> +
> >> +     charger: charger@11 {
> >> +             ....
> >> +             monitored-battery =3D <&bat>;
> >> +             ...
> >> +     };
> >> +
> >> +     fuel_gauge: fuel-gauge@22 {
> >> +             ....
> >> +             monitored-battery =3D <&bat>;
> >> +             ...
> >> +     };
> >> --
> >> 2.9.3
> >>

--dk5atukt3lm4zwyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJxsIACgkQ2O7X88g7
+ppWGA/4wOUyzvDM/vZQqRGZA1+PqnuDF/nWZ9fVDnZI+uSHi5A6u/wST+7aH8Fp
TLOjWz8noxgkqailxUEbS5dP9CTjhT3uaPRBzlTsDtylTkTFBz5DxlH+QOAhHrze
a/dZJwzyOoQPbK/rPht8XPyb12uwGTewrCtggjJE7WVV1kEesueMiUywc5g7qwhW
mZvUq9c/fIKSH0lnPZuApoVlQJW83i2cdD3sv9o4fnVhGW6xzxj/7j7j757lsSep
2oUVu4uiO4Z7bcKAjWTvBNJIl4ntYOke8O2ZFoRaBEfJnpBZhQjq2mBpNVRdOX71
DorUKN/zIsdfFK5U2me2oR4dTVyTIVcQVNJ5HAUKos+EzN0uZa5f55vRjATNdjpA
4JiCqrgHe6lW47AfmEYQizZjtpZjYRTUiZ5LS0yWiHDTTS8C2qoxgwGT4yXvZftm
dzEjdA9JDYihk6VDuC4DmuCltZuHMCzNQgrGA9ZBmmvZfuW9G4Rng5Qw9xftIebr
wet8zMSbABWGxHE21Eyn0w2mGtR1/ifdiodiEp0ZIGoCHz7n6i48Hqar9ozlVb4p
DKt2FrLZDFtJGFlCnQfWskdDsZYo1PO52PMhxy6gp7gxCY0h/tbyKRbPgsE1oc02
rSBr7Qu/y0N9mvPLmszYXYpqm27Xen6MKzOcMnHSuwtngcrHlw==
=1sXK
-----END PGP SIGNATURE-----

--dk5atukt3lm4zwyl--
