From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 05/47] mfd: as3722: Drop reference to pm_power_off
 from devicetree bindings
Date: Tue, 21 Oct 2014 09:15:15 +0100
Message-ID: <20141021081515.GD26842@x1>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-6-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413864783-3271-6-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 20 Oct 2014, Guenter Roeck wrote:

> Devicetree bindings are supposed to be operating system independent
> and should thus not describe how a specific functionality is implemen=
ted
> in Linux.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: No change
>=20
>  Documentation/devicetree/bindings/mfd/as3722.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Docum=
entation/devicetree/bindings/mfd/as3722.txt
> index 4f64b2a..0b2a609 100644
> --- a/Documentation/devicetree/bindings/mfd/as3722.txt
> +++ b/Documentation/devicetree/bindings/mfd/as3722.txt
> @@ -122,8 +122,7 @@ Following are properties of regulator subnode.
> =20
>  Power-off:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> -AS3722 supports the system power off by turning off all its rail. Th=
is
> -is provided through pm_power_off.
> +AS3722 supports the system power off by turning off all its rails.
>  The device node should have the following properties to enable this
>  functionality
>  ams,system-power-controller: Boolean, to enable the power off functi=
onality

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
