From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 2/7] mfd: da9150: Add DT binding documentation for core
Date: Thu, 26 Feb 2015 08:43:15 +0000
Message-ID: <20150226084315.GJ6688@x1>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
 <d3c040b8f0c74a7d731b36e24384215327b83725.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d3c040b8f0c74a7d731b36e24384215327b83725.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Feb 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9150.txt | 43 ++++++++++++++=
++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9150.txt

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Docum=
entation/devicetree/bindings/mfd/da9150.txt
> new file mode 100644
> index 0000000..d0588ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/da9150.txt
> @@ -0,0 +1,43 @@
> +Dialog Semiconductor DA9150 Combined Charger/Fuel-Gauge MFD bindings
> +
> +DA9150 consists of a group of sub-devices:
> +
> +Device			 Description
> +------			 -----------
> +da9150-gpadc		: General Purpose ADC
> +da9150-charger		: Battery Charger
> +
> +=3D=3D=3D=3D=3D=3D
> +
> +Required properties:
> +- compatible : Should be "dlg,da9150"
> +- reg: Specifies the I2C slave address
> +- interrupt-parent: Specifies the phandle of the interrupt controlle=
r to which
> +  the IRQs from da9150 are delivered to.
> +- interrupts: IRQ line info for da9150 chip.
> +- interrupt-controller: da9150 has internal IRQs (own IRQ domain).
> +  (See Documentation/devicetree/bindings/interrupt-controller/interr=
upts.txt for
> +   further information relating to interrupt properties)
> +
> +Sub-devices:
> +- da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150=
-gpadc.txt
> +- da9150-charger: See Documentation/devicetree/bindings/power/da9150=
-charger.txt
> +
> +
> +Example:
> +
> +	charger_fg: da9150@58 {
> +		compatible =3D "dlg,da9150";
> +		reg =3D <0x58>;
> +		interrupt-parent =3D <&gpio6>;
> +		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +
> +		gpadc: da9150-gpadc {
> +			...
> +		};
> +
> +		da9150-charger {
> +			...
> +		};
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
