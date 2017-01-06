From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/3] devicetree: bq27425: add documentation for
 bq27425 fuel gauge
Date: Fri, 6 Jan 2017 01:56:29 +0100
Message-ID: <20170106005628.qp4mdz6abv4g6if5@earth>
References: <20170105021007.22088-1-matt@ranostay.consulting>
 <20170105021007.22088-3-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtpim75krous7wql"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753975AbdAFA5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Jan 2017 19:57:04 -0500
Content-Disposition: inline
In-Reply-To: <20170105021007.22088-3-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--dtpim75krous7wql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 04, 2017 at 06:10:06PM -0800, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  .../devicetree/bindings/power/bq27425.txt          | 25 ++++++++++++++++=
++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/bq27425.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/bq27425.txt b/Docume=
ntation/devicetree/bindings/power/bq27425.txt
> new file mode 100644
> index 000000000000..5d33b61cf9b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/bq27425.txt
> @@ -0,0 +1,25 @@
> +* TI BQ27425 Fuel Gauge
> +
> +http://www.ti.com/lit/ds/symlink/bq27425-g2a.pdf
> +
> +Please note that if any of the optional properties are defined
> +then all settings must be.
> +
> +Required properties:
> +- compatible: Should be "ti,bq27425"
> +- reg: integer, I2C address of the device
> +
> +Optional properties:
> +- ti,design-microamp-hours: integer of mAh of the battery
> +- ti,design-microvolt-hours: integer of the mWh of the battery
> +- ti,terminate-microvolt: integer of mV of the dead voltage of
> +		the battery
> +
> +bq27425 {
> +	compatible =3D "ti,bq27425";
> +	reg =3D <0x55>;
> +
> +	ti,design-microamp-hours =3D <1360>;
> +	ti,design-microwatt-hours =3D <4970>;
> +	ti,terminate-microvolt =3D <3200>;
> +};

The design capacity of the battery is not a property of the fuel
gauge. It should be modelled more like this:

/ {
    bat0: battery {
        /* Nokia BL-5J */
        nominal-microvolt =3D <3700000>;
        design-microwatt-hours =3D <4900000>;
        design-microamp-hours =3D <1320000>;
        chemistry-type =3D <POWER_SUPPLY_LI_ION>;

        /* other battery specific stuff */
    };
};

&i2c3 {
    bq27425 {
        compatible =3D "ti,bq27425";
        reg =3D <0x55>;

        monitored-battery =3D <&bat0>;

        /* other fuel-gauge specific stuff */
    };
};

Also there is another pending patch series, that documents bq27xxx.
bq27425 should be documented inside of it. The battery binding would
be generic, so it should be described in its own document.

-- Sebastian

--dtpim75krous7wql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhu6zoACgkQ2O7X88g7
+pqSDxAApPlgPJEzoWlVb832R/pT3yaBrzahi1TbBkA10w3H+uzyeN0MZjX9w79g
UPY+eO/6ozrtHtx9mG3Kk5OqOXtdolY5AA6eUBxWJ0JKITjzFiN7vyz942GqC4PG
e18GuNHvJU5fij0juCwy4CI0nco+o2iw7EmRTUARyZ3Y974egr5Q0oSqGAFBntE3
CPbqCUJ0hryrVdv7zeJ5cH8qwznelEjmg7QNqtgJltclMQnrftROupO/SnoNHXac
BKATad9WFaxCc8YODEKLuU/0d1xfrGg3DzsntNqAMvENfA7YNBeXqF1V2SFPgegY
F6QewFQ5MNm+xOZO/MY1vjIY44zTjoD8NLaZGS0IqWCjZntAbIBD2R4sonwNEa8F
82nsO/QcTy+k0SDqttL6kpa8xngwmsPVYsueyNI/0G31UM1e7hztoX0B8oRcMbE6
oH4KISANG2TjtE+nFI6Q9gpO7u7sAfTlgpCOC/c9x+bQABrA6ukUfqxwUH8awqVl
5nvUqMTb9jHJrDOu+WR6vsiB2QUKVldonPNNQYhpZnYlmQy3HheXl4QfgDsbR8jA
RQAjqg/tW6p8vEZRPJ30s9EpTjpaQ51jANdZ8L8+oHQYY2wVSIDvIwTD7R8xSALr
G1kY4+0NyfqU+MxiJj6UuaHyO8Hhn24we8QVjKP+08kQjFpcqms=
=qLI8
-----END PGP SIGNATURE-----

--dtpim75krous7wql--
