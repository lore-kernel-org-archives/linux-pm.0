From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/2] power: reset: document LTC2952 poweroff support
Date: Thu, 9 Oct 2014 16:07:56 +0100
Message-ID: <20141009150756.GC18384@leverpostej>
References: <1412866242-6474-1-git-send-email-frans.klaver@xsens.com>
 <1412866242-6474-3-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412866242-6474-3-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?utf-8?B?UmVuw6k=?= Moll <linux@r-moll.nl>, Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Oct 09, 2014 at 03:50:42PM +0100, Frans Klaver wrote:
> From: Ren=C3=A9 Moll <linux@r-moll.nl>
>=20
> Signed-off-by: Ren=C3=A9 Moll <linux@r-moll.nl>
> Signed-off-by: Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>
> Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> ---
>  .../bindings/power/reset/ltc2952-poweroff.txt      | 31 ++++++++++++=
++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ltc=
2952-poweroff.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-po=
weroff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-powe=
roff.txt
> new file mode 100644
> index 0000000..c3f3d9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.=
txt
> @@ -0,0 +1,31 @@
> +Binding for the LTC2952 PowerPath controller
> +
> +This chip is used to externally trigger a system shut down. Once the=
 trigger
> +has been sent, the chips watchdog has to be reset to gracefully shut=
 down.

s/chips/chip's/

> If +the Linux systems decides to shut down, it powers off the platfor=
m
> via the +poweroff signal.

This sentence can go; the binding should describe the hardware rather
than the Linux behaviour.

Thanks,
Mark.

> +
> +Required properties:
> +
> +- compatible:		Must be: "lltc,ltc2952"
> +- watchdog-gpios:	phandle + gpio-specifier for the GPIO connected to=
 the
> +			chip's watchdog line
> +- poweroff-gpios:	phandle + gpio-specifier for the GPIO connected to=
 the
> +			chip's kill line
> +
> +Optional properties:
> +
> +- trigger-gpios:	phandle + gpio-specifier for the GPIO connected to =
the
> +			chip's trigger line. If this property is not set, the
> +			trigger function is ignored and the chip is kept alive
> +			until an explicit kill signal is received
> +
> +Example:
> +
> +ltc2952 {
> +	compatible =3D "lltc,ltc2952";
> +
> +	trigger-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
> +	watchdog-gpios =3D <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +	poweroff-gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
> +};
> --=20
> 2.1.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
