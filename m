From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v10 1/8] devicetree: power: Add battery.txt
Date: Wed, 15 Mar 2017 23:04:25 +0100
Message-ID: <20170315220425.qeidvmanbsmq4wxk@earth>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="67pzntgirngkxolh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbdCOWFV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 18:05:21 -0400
Content-Disposition: inline
In-Reply-To: <20170315192653.26799-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--67pzntgirngkxolh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liam & Matt,

Sorry for my absence in the discussion. I skipped the previous
iterations for now and start with this version.

On Wed, Mar 15, 2017 at 12:26:46PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Documentation of static battery characteristics that can be defined
> for batteries which cannot self-identify. This information is required
> by fuel-gauge and charger chips for proper handling of the battery.
>=20
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 45 ++++++++++++++++=
++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 0000000..0278617
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,45 @@
> +Battery Characteristics

Maybe add something like

This device provides static battery information, that is usually
available in the EEPROM of a smart battery. It's supposed to be
used for batteries, which do not have their own EEPROM (or if its
unusable).

> +Required Properties:
> + - compatible: Must be "fixed-battery"
> +
> +Optional Properties:
> + - voltage-min-design-microvolt: drained battery voltage
> + - energy-full-design-microwatt-hours: battery design energy
> + - charge-full-design-microamp-hours: battery design capacity

Looks fine to me.

> +Because drivers surface properties in sysfs using names derived
> +from enum power_supply_property, e.g.
> +/sys/class/power_supply/<device>/charge_full_design, our
> +battery properties must be named for the corresponding elements in
> +enum power_supply_property, defined in include/linux/power_supply.h.

This is Linux/implementation specific and does not belong
into a DT binding document.

> +Batteries must be referenced by chargers and/or fuel-gauges
> +using a phandle. The phandle's property should be named
> +"monitored-battery".

This looks fine.

> +Driver code should call power_supply_get_battery_info() to obtain
> +battery properties via monitored-battery. For details see:
> +  drivers/power/supply/power_supply_core.c
> +  drivers/power/supply/bq27xxx_battery.c

This is also Linux/implementation specific and should be dropped.

> +Example:
> +
> +	bat: battery {
> +		compatible =3D "fixed-battery";
> +		voltage-min-design-microvolt =3D <3200000>;
> +		energy-full-design-microwatt-hours =3D <5290000>;
> +		charge-full-design-microamp-hours =3D <1430000>;
> +	};
> +
> +	charger: charger@11 {
> +		....
> +		monitored-battery =3D <&bat>;
> +		...
> +	};
> +
> +	fuel_gauge: fuel-gauge@22 {
> +		....
> +		monitored-battery =3D <&bat>;
> +		...
> +	};
> --=20
> 2.9.3
>=20

--67pzntgirngkxolh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJumYACgkQ2O7X88g7
+prwDw/8CeREwGVDzcZh4E02ij3caXkVke8QF8Bk7nm7h32f/dhNq7UWqiYWXYUH
0JKq+g/LP3kAeSX+bOoJ+Fyl0KmWmb0EpmViwfRZdqVqkVKK4dH4Wrt0kCFWRWrJ
jnDuVTZO/7JepW7SDlECRJDWilLb1Odx8Ek+uGa9J/VlEkY69cdScJ4D/EGAma7X
HyTKF+y9Hi/+9Vm8qinL5zJgpuGDoh/WMjDO+vnao+5E7HhRkTMEQ1Z6eYaRpUvw
BFZ7VKM5hQUSQzeX5/9dO6oELlza7pG2f/HFV9IKKNS+QwIIsuh7qsXfOMuSsS5Y
gmgYYCL1pP0ZvPk6GRQeghjQh+LD9E0vVoSK0azNxQI92eXG1Cfk/X6G9/AZfOMR
sBtjut3Kr8jhwhohXIyXMwhfEmpwauEsx9t7T3YxwWBnGF4hHaw5fHiNr2zJ0AzO
3kWqwxY3cadq00q6Gy2BmshKnMpLXiP5szR7zZ4dbJCr0n7lpy88e7sVW9fbGH7D
9gUGY+Cqbt4LgYEGGcMOnLMcQylfLuKu53M8cUSKJ/HkKo/ORxVG9lovnO7VrINx
yem7iUUnRZBacnTM+jOiQODMyiz29y48NfKhytP+rdCHcS5OTtH93NbZRsg7r9XU
imIsDn8TtFj8ihDh7b7iF2xhX2eK9j63+4xSyjCyTNbLYFRA6Ac=
=lM2w
-----END PGP SIGNATURE-----

--67pzntgirngkxolh--
