From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v7 07/10] Documentation: Add sbs-manager device tree node
 documentation
Date: Mon, 3 Jul 2017 15:57:09 +0200
Message-ID: <20170703135709.staqrypylh6pvfby@earth>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-8-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hu7ijcaiz7ackdir"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932301AbdGCN5S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 09:57:18 -0400
Content-Disposition: inline
In-Reply-To: <1497535178-12001-8-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>


--hu7ijcaiz7ackdir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 15, 2017 at 09:59:35PM +0800, Phil Reid wrote:
> From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
>=20
> This patch adds device tree documentation for the sbs-manager
>=20
> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  .../bindings/power/supply/sbs,sbs-manager.txt      | 66 ++++++++++++++++=
++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sb=
s-manager.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manag=
er.txt b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> new file mode 100644
> index 0000000..4b219557
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> @@ -0,0 +1,66 @@
> +Binding for sbs-manager
> +
> +Required properties:
> +- compatible: "<vendor>,<part-number>", "sbs,sbs-charger" as fallback. T=
he part
> +  number compatible string might be used in order to take care of vendor
> +  specific registers.
> +- reg: integer, i2c address of the device. Should be <0xa>.
> +Optional properties:
> +- gpio-controller: Marks the port as GPIO controller.
> +  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
> +- #gpio-cells: Should be <2>. The first cell is the pin number, the seco=
nd cell
> +  is used to specify optional parameters:
> +  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
> +
> +From OS view the device is basically an i2c-mux used to communicate with=
 up to
> +four smart battery devices at address 0xb. The driver actually implement=
s this
> +behaviour. So standard i2c-mux nodes can be used to register up to four =
slave
> +batteries. Channels will be numerated starting from 1 to 4.
> +
> +Example:
> +
> +batman@a {
> +    compatible =3D "lltc,ltc1760", "sbs,sbs-manager";
> +    reg =3D <0x0a>;
> +    #address-cells =3D <1>;
> +    #size-cells =3D <0>;
> +
> +    gpio-controller;
> +    #gpio-cells =3D <2>;
> +
> +    i2c@1 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        reg =3D <1>;
> +
> +        battery@b {
> +            compatible =3D "ti,bq2060", "sbs,sbs-battery";
> +            reg =3D <0x0b>;
> +            sbs,battery-detect-gpios =3D <&batman 1 1>;
> +        };
> +    };
> +
> +    i2c@2 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        reg =3D <2>;
> +
> +        battery@b {
> +            compatible =3D "ti,bq2060", "sbs,sbs-battery";
> +            reg =3D <0x0b>;
> +            sbs,battery-detect-gpios =3D <&batman 2 1>;
> +        };
> +    };
> +
> +    i2c@3 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        reg =3D <3>;
> +
> +        battery@b {
> +            compatible =3D "ti,bq2060", "sbs,sbs-battery";
> +            reg =3D <0x0b>;
> +            sbs,battery-detect-gpios =3D <&batman 3 1>;
> +        };
> +    };
> +};
> --=20
> 1.8.3.1
>=20

--hu7ijcaiz7ackdir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaTTQACgkQ2O7X88g7
+ppRQg//X9v5OpO8GURFB16sEvfc1Jg5XLAKcPffsKcr99hcm/HC3OBwk9ZTPC2I
gwMdaEZ8Eh63h7d4AZImKCo7dOBjPmmI4WdHxhj4uirsnwXToCo5JvUEl7dMmVAn
yoFYiGic7VL8jUhiRQ5vowJTvWOThGruUOcOMtVPR1OSN+5EW1bHnzzlF41acINA
eZAfDuMWxHaolV+NKb82LoercIVkc8xnGCLkfPMt9Zu0F5fBzaMHnUeGgpk2R3cP
botI/pPGvTuJABVmWygknyVgOPqcZRzOJyPFQfbhyOnop8k2x2IOfBCsM5U5M99O
DmILhSyidfJqIACPIjCmJFhhw/tgcK5Pxh8Pd/zmKHKvgs7Boq0sUzKasNyngsjb
iKDf7AE7TbCzvfiDt2KdW3kKTWF+kaidXxHJjeMP7NLpnFn1rvxhONjHEFaIXAU2
+xlzgM6T230UREa+lr+MD8/6ionQldpGDKA9w0z/x4fwJgHqK9vYu7blUwMw+WY4
ZTfM9p3qWKMivmNoxEAR4YN7voCYO3rxWT62vw2IYXeZl7Opq8D8zJV0QSKHdn5s
/2A9vduJagV/3CAWd0f97v6Lz8Lkf7eclm9C+lOqhrbkA5X3TiM4lrSmAPKec0PH
++oW430qw457mP2yGaBFbncduVLQIpyX4fheWQZ5R+GgGWWX0cc=
=tbsx
-----END PGP SIGNATURE-----

--hu7ijcaiz7ackdir--
