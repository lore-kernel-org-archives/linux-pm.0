From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 6/9] Documentation: Add sbs-manager device tree node
 documentation
Date: Mon, 1 May 2017 13:49:10 +0200
Message-ID: <20170501114909.xohhqfzi4ngkc762@earth>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
 <1493628599-30552-7-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4snsyhc34ebeddjd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493628599-30552-7-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--4snsyhc34ebeddjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Just two notes about compatible. Looks fine otherwise.

On Mon, May 01, 2017 at 04:49:56PM +0800, Phil Reid wrote:
> From: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
>=20
> This patch adds device tree documentation for the sbs-manager
>=20
> Reviewed-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> Signed-off-by: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  .../bindings/power/supply/sbs,sbs-manager.txt      | 64 ++++++++++++++++=
++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sb=
s-manager.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manag=
er.txt b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> new file mode 100644
> index 0000000..c523b37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> @@ -0,0 +1,64 @@
> +Binding for sbs-manager
> +
> +Required properties:
> +- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as fallb=
ack.

Use the same style as sbs-charger:

Required properties:
 - compatible: "<vendor>,<part-number>", "sbs,sbs-manager" as fallback. The=
 part
     number compatible string might be used in order to take care of vendor
     specific registers.

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
> +batman@0a {
> +    compatible =3D "lltc,ltc1760";

This should be

compatible =3D "lltc,ltc1760", "sbs,sbs-manager";

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
> +        battery@0b {
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
> +        battery@0b {
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
> +        battery@0b {
> +            compatible =3D "ti,bq2060", "sbs,sbs-battery";
> +            reg =3D <0x0b>;
> +            sbs,battery-detect-gpios =3D <&batman 3 1>;
> +        };
> +    };
> +};

-- Sebastian

--4snsyhc34ebeddjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHILUACgkQ2O7X88g7
+pq7IxAAhB9Bs43io7KN4tNuDqV9suG9XkZr3p+UhKqIUnbfFvtS2UWdZNG0iGLr
9G+dYXEc1RbZ4HW8Cz8Xy7HPVB59lBD3AZZCXDWHaLhN+bYsdPE/q7gW+BOyytjl
tnKcdHFxnOwVqfBdhyOZ0opcOMzdut6GRafHIC+SrPs8fH0GUgKUqjdB4QRyNenK
ls9gk/X6mROs2y4bu4laMgWA1ml5vNCTCCM/XqV16cT8K68S6mc+StCALxpaQEA+
2hrwSsgPxBvTO1SoE3jRRx/IMKZ1cg6XcQYVuF3RwFusm9bhhbDEvLo2d1zzDFWB
W5ZIMBoocl7RfmOrwG00RYs4db3CUN/cVNZKJqmUBA/H6GU1qoub7qs214TBun0H
ZcJh6tv/Y+LvpYO2H5FCHQunT15mbeFBuCcuSlRS385STc4XgWc2mOvegPCVJfQQ
1yK7Ra63YkDIrGw0r6VUzUQ/PgwFM0OYpaTZlkMmBRkdsva0r/NXUJLXIBBkIs1o
4EdLzL7Ww73gdCjTapEM62PfDVCcnZicceS4OB6fUz7xKZZoVteWEGJgHB4llRne
oVOtA2dwmEO2OkUssf58xHZ7AiAuoFM8+DvGGB/pRN67avT06gHi14Nfa1RrmJOR
TPnpMTAeZbY231xDOS4RQRSgdfsqcT/CMhP0IYZQJBL4a95/ivU=
=5xqn
-----END PGP SIGNATURE-----

--4snsyhc34ebeddjd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
