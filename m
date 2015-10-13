From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 5/6] mfd: da9150: Use relative paths in DT bindings
 document
Date: Tue, 13 Oct 2015 10:26:42 +0100
Message-ID: <20151013092642.GW32409@x1>
References: <cover.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
 <111d8cc33a416d304e99b568fabbf56224f6886d.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <111d8cc33a416d304e99b568fabbf56224f6886d.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 07 Oct 2015, Adam Thomson wrote:

> When referencing other DT bindings documentation, use relative
> path rather than absolute.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>=20
> Changes in v6:
>  - Rebase to v4.3-rc4
>=20
> Changes in v5:
>  - Rebase to v4.2
>=20
> Changes in v3:
>  - Initial version.
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9150.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Docum=
entation/devicetree/bindings/mfd/da9150.txt
> index 970801d..fd4dca7 100644
> --- a/Documentation/devicetree/bindings/mfd/da9150.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9150.txt
> @@ -17,13 +17,13 @@ Required properties:
>    the IRQs from da9150 are delivered to.
>  - interrupts: IRQ line info for da9150 chip.
>  - interrupt-controller: da9150 has internal IRQs (own IRQ domain).
> -  (See Documentation/devicetree/bindings/interrupt-controller/interr=
upts.txt for
> +  (See ../interrupt-controller/interrupts.txt for
>     further information relating to interrupt properties)
>=20
>  Sub-devices:
> -- da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150=
-gpadc.txt
> -- da9150-charger: See Documentation/devicetree/bindings/power/da9150=
-charger.txt
> -- da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.t=
xt
> +- da9150-gpadc: See ../iio/adc/da9150-gpadc.txt
> +- da9150-charger: See ../power/da9150-charger.txt
> +- da9150-fg: See ../power/da9150-fg.txt
>=20
>  Example:
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
