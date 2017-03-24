From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 2/7] devicetree: power: Add docs for TI BQ24190
 battery charger
Date: Fri, 24 Mar 2017 10:00:25 +0100
Message-ID: <20170324090024.4samupuzlszsg76j@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-3-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q367knrnhvqvtmop"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965067AbdCXJAk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 05:00:40 -0400
Content-Disposition: inline
In-Reply-To: <20170321220921.5834-3-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--q367knrnhvqvtmop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The interrupt must be documented, since its mandatory.

On Tue, Mar 21, 2017 at 03:09:16PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Document monitored-battery and ti,system-minimum-microvolt properties.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  .../devicetree/bindings/power/supply/bq24190.txt   | 47 ++++++++++++++++=
++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2419=
0.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b=
/Documentation/devicetree/bindings/power/supply/bq24190.txt
> new file mode 100644
> index 0000000..d252d10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -0,0 +1,47 @@
> +Binding for TI BQ24190 Li-Ion Battery Charger
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +    * "ti,bq24190"
> +- reg: integer, I2C address of the device.

interrupts: interrupt specifier for bq24190's INT

> +
> +Optional properties:
> +- monitored-battery: phandle of battery information devicetree node
> +    These battery properties are relevant:
> +    + precharge-current-microamp: maximum charge current during precharge
> +      phase (typically 20% of battery capacity).
> +    + endcharge-current-microamp: a charge cycle terminates when the
> +      battery voltage is above recharge threshold, and the current is be=
low
> +      this setting (typically 10% of battery capacity).
> +    See Documentation/devicetree/bindings/power/supply/battery.txt
> +- ti,system-minimum-microvolt: when power is connected and the battery
> +    is below minimum system voltage, the system will be regulated above =
this
> +    setting.
> +
> +Other features:
> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current on=
 USB SDP port.
> +
> +Example:
> +
> +bat: battery {
> +	compatible =3D "simple-battery";
> +	precharge-current-microamp =3D <256000>;
> +	endcharge-current-microamp =3D <128000>;
> +};
> +
> +bq24190 charger@6a {
> +	compatible =3D "ti,bq24190";
> +	reg =3D <0x6a>;
> +	// interrupt configuration here

interrupt-parent =3D <&gpiochip23>;
interrupts =3D <42 IRQ_TYPE_EDGE_FALLING>;

> +	monitored-battery =3D <&bat>;
> +	ti,system-minimum-microvolt =3D <3200000>;
> +};
> +
> +&twl_gpio {
> +	otg {
> +		gpio-hog;
> +		gpios =3D <6 0>;
> +		output-high;
> +		line-name =3D "otg-gpio";
> +	};
> +};
> --=20
> 2.9.3
>=20

--q367knrnhvqvtmop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU4CYACgkQ2O7X88g7
+poqFQ//d2zZr8Uiuhene4SeGyezlguCBZEd11l6nfcIQOIySw4AmRLg8huCH15F
po5kJHgYqMJ9PRxFviKc9g8jARfa7VaO4MpZoCVznfCej4l55tYjSKy0gH50+f3P
5hBAGKu9ctNnwlYkCj7kZP5MIP8KdS/+LDzdeYwsZ4T+sYR0prxFhzvG9qrQJDcF
99YLTlX/ZqkOpZBrX09AWc12HvEO+B7f3D/0X+gRAtVP2vfFBv4hM8LDXTz4fTuJ
3fKsLiDWIuvUK+4F8pNo6Q2neXqgey6DB3H06Y1E2CkFEPtzk9PsSKw7AGMF5Lw5
2j3GVgtoAquBs7jAiuhwqIhMMqI1sfZkWPiNiBblvVp7v/3pHmf3/i5jxhhwGcBv
nZ6J38gS+PxMkxpHW6piPBYwNRromVUhSBeY5mR3E0fSOFYZ6RFw6ThusuZVlIaA
7KXbSAISoES9ZrMtTYuyMhPyrn01K4PJoAV9YaCL5cwqjl7mw0sbreTcu9xDHByV
Ivte2LtQeEd86DiJ1xxg5g+EmstEEJcUOiGh3DPFPLb3QXYLWjVTsk+FdoxsiWgb
xd63tK6XmIC1K3qv7AchBLK+HFypDd62OcCn/pPQp7pwS9UkipExcleKdjRO5wvc
uV5rB884nlL39YMXeqcVkVonbd+A8E3zDBlaRtE9YeDzoiN5als=
=5va2
-----END PGP SIGNATURE-----

--q367knrnhvqvtmop--
