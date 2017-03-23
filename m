From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Thu, 23 Mar 2017 13:18:04 +0100
Message-ID: <20170323121804.c7qi2libbpchcl2a@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-2-liam@networkimprov.net>
 <20170323102006.2ftvsoukgmqh7dtv@earth>
 <CAKvHMgSEDAZregni_hb2e92BXD2d2gZDpmnd02DFjnvTOni0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ifmackl52u7clku"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753675AbdCWMSK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 08:18:10 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSEDAZregni_hb2e92BXD2d2gZDpmnd02DFjnvTOni0zA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Rob Herring <robh@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--4ifmackl52u7clku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 03:30:42AM -0700, Liam Breck wrote:
> On Thu, Mar 23, 2017 at 3:20 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Mon, Mar 20, 2017 at 02:43:26AM -0700, Liam Breck wrote:
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
> >>  .../devicetree/bindings/power/supply/battery.txt   | 43 +++++++++++++=
+++++++++
> >>  1 file changed, 43 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/bat=
tery.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/battery.tx=
t b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> new file mode 100644
> >> index 0000000..53a68c0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> >> @@ -0,0 +1,43 @@
> >> +Battery Characteristics
> >> +
> >> +The devicetree battery node provides static battery characteristics.
> >> +In smart batteries, these are typically stored in non-volatile memory
> >> +on a fuel gauge chip. The battery node should be used where there is
> >> +no appropriate non-volatile memory, or it is unprogrammed/incorrect.
> >> +
> >> +Required Properties:
> >> + - compatible: Must be "simple-battery"
> >> +
> >> +Optional Properties:
> >> + - voltage-min-design-microvolt: drained battery voltage
> >> + - energy-full-design-microwatt-hours: battery design energy
> >> + - charge-full-design-microamp-hours: battery design capacity
> >> +
> >> +Battery properties are named, where possible, for the corresponding
> >> +elements in enum power_supply_property, defined in
> >> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/include/linux/power_supply.h#n86
> >
> > The above paragraph does not belong into DT bindings. Apart
> > from that
> >
> > Acked-by: Sebastian Reichel <sre@kernel.org>
>=20
> How then should I indicate that there is a method to the madness of
> the above names? More information in the docs is helpful than less!

You don't. This does not belong into the DT binding document. DT
binding documents are _not_ Linux FW API. I thought we were through
this already. FWIW if anything is not named like the power-supply
subsystem names it, then that's not nice, but ok. Also if anybody
adds stuff he will=20

1. send patches to the power-supply subsystem maintainer (me at
   the moment), who can reject patches.
2. implement the parsing in the driver, which asks for power-supply
   naming to be used if possible.

-- Sebastian

> > FYI: I will wait for Acked-by from Rob Herring on this patch.
> >
> > -- Sebastian
> >
> >> +Batteries must be referenced by chargers and/or fuel-gauges
> >> +using a phandle. The phandle's property should be named
> >> +"monitored-battery".
> >> +
> >> +Example:
> >> +
> >> +     bat: battery {
> >> +             compatible =3D "simple-battery";
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

--4ifmackl52u7clku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTvPwACgkQ2O7X88g7
+pqybg/5AavafWA3+e8yExRRwRMSWor/RFLSe79squOTF7yDXp14fZJdCy2FDBhH
yuPetPnxPPZS8SreWO9eJx1NJcU3dLdz3yQuN5ligfLdXGGYLmJ6eHFwv2IrGEQc
BupOOLm8MsFSf5eilBqlfzTmATGxrIiM20ZDJpNIlKqi/idLOhUacsMVAayJDkHC
BmgYr9t/a3j2XpoiPJK9zgMzjAebmgZYazhfTs82QxdOFDcjQgjzQReULTu22h6C
VrQCwj7SYC6kmD3AA/qDDtfw1Ovi6n8wTuXtrssy/sv+8ob25lUbZ/pUdYP9koqO
EHowFBT4jpckQGiouNDFEneIcQSehQwnFp3QObF47Tq//8kve90qYq7imwA3WBmN
DmT/2dyYTcwIIBF3F8z3azrPo1TX/FjzXabOze4pxch2e++qO/1TkHVraEfmpDOw
u+TgZ/c/gkfReyJBW1ZkK2uuFaVDrCDxNKAltUczmxh7ya0ZdQ0U4uIZDw2PrrqD
0G10gxbk0OWMiD9V5IrdQEgujgu0/sszDPeVihiKS5BxTcQ0yFalhgeBJLFlZZi3
YQJugz8KSoc0VCNellWGu1DZ65XivsVkVoToR8a8oU5QoG/CkajDVdvCad55pKMf
pIOHVly6/rIMPFdsNcL+L/wRDEKHm30uEds33Bl+xtSs0gi0apU=
=qSJM
-----END PGP SIGNATURE-----

--4ifmackl52u7clku--
