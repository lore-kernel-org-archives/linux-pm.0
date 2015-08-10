From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 5/6] mfd: da9150: Use relative paths in DT bindings
 document
Date: Mon, 10 Aug 2015 14:57:37 +0100
Message-ID: <20150810135737.GL3249@x1>
References: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
 <624a615ce54f3be058165edf499f18cc56d5bfdb.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36042 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbHJN5m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 09:57:42 -0400
Received: by wicja10 with SMTP id ja10so38272432wic.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 06:57:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <624a615ce54f3be058165edf499f18cc56d5bfdb.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

On Tue, 04 Aug 2015, Adam Thomson wrote:

> When referencing other DT bindings documentation, use relative
> path rather than absolute.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>=20
> Changes in v4:
>  - N/A
>=20
> Changes in v3:
>  - Initial version.
>=20
> Changes in v2:
>  - N/A
>=20
>  Documentation/devicetree/bindings/mfd/da9150.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Much better:

Acked-by: Lee Jones <lee.jones@linaro.org>

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
