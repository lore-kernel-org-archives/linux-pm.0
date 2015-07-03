From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] mfd: da9150: Update DT bindings for Fuel-Gauge
 support
Date: Fri, 3 Jul 2015 16:19:23 +0100
Message-ID: <20150703151923.GB10500@x1>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <afbda3c9439f08cbf57c184ff6b96bdf7f5ca8b4.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36433 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455AbbGCPT3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 11:19:29 -0400
Received: by wguu7 with SMTP id u7so91019660wgu.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2015 08:19:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <afbda3c9439f08cbf57c184ff6b96bdf7f5ca8b4.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

On Fri, 26 Jun 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9150.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Docum=
entation/devicetree/bindings/mfd/da9150.txt
> index d0588ea..8bf1a20 100644
> --- a/Documentation/devicetree/bindings/mfd/da9150.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9150.txt
> @@ -6,6 +6,7 @@ Device			 Description
>  ------			 -----------
>  da9150-gpadc		: General Purpose ADC
>  da9150-charger		: Battery Charger
> +da9150-fg		: Battery Fuel-Gauge
>=20
>  =3D=3D=3D=3D=3D=3D
>=20
> @@ -22,6 +23,7 @@ Required properties:
>  Sub-devices:
>  - da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150=
-gpadc.txt
>  - da9150-charger: See Documentation/devicetree/bindings/power/da9150=
-charger.txt
> +- da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.t=
xt

Can you send a subsequent patch doing:

s-Documentation/devicetree/bindings/-../-
>=20
>=20

Superfluous '\n' here.

>  Example:
> @@ -40,4 +42,8 @@ Example:
>  		da9150-charger {
>  			...
>  		};
> +
> +		da9150-fg {
> +			...
> +		};

Perhaps a little content wouldn't go amiss here for quick reference.

Saves dipping in and out of the other binding files.

This patch is fine though:
  Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
