From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 2/6] mfd: da9150: Update DT bindings for Fuel-Gauge
 support
Date: Tue, 13 Oct 2015 10:26:09 +0100
Message-ID: <20151013092609.GT32409@x1>
References: <cover.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
 <0fba7f849b31b230970543240bcfa28ff2c17f0e.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35917 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbJMJ0N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 05:26:13 -0400
Received: by wicgb1 with SMTP id gb1so180183070wic.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 02:26:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0fba7f849b31b230970543240bcfa28ff2c17f0e.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

On Wed, 07 Oct 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>=20
> Changes in v6:
>  - Rebase to v4.3-rc4
>=20
> Changes in v5:
>  - Rebase to v4.2
>=20
> Changes in v4:
>  - Update compatible string of fuel-gauge to "da9150-fuel-gauge".
>  - Node name tidy up, relating to maintainer comments on fuel-gauge D=
T
>    binding doc.
>  - Removed Ack to patch from Lee Jones, as this has now been modified=
 slightly
>    and didn't want to make assumptions of approval.
>=20
> Changes in v3:
>  - Removal of unwanted new-line.
>  - Flesh out example bindings usage.
>=20
>  Documentation/devicetree/bindings/mfd/da9150.txt | 27 ++++++++++++++=
++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Docum=
entation/devicetree/bindings/mfd/da9150.txt
> index d0588ea..970801d 100644
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
> @@ -22,7 +23,7 @@ Required properties:
>  Sub-devices:
>  - da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150=
-gpadc.txt
>  - da9150-charger: See Documentation/devicetree/bindings/power/da9150=
-charger.txt
> -
> +- da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.t=
xt
>=20
>  Example:
>=20
> @@ -34,10 +35,28 @@ Example:
>  		interrupt-controller;
>=20
>  		gpadc: da9150-gpadc {
> -			...
> +			compatible =3D "dlg,da9150-gpadc";
> +			#io-channel-cells =3D <1>;
> +		};
> +
> +		charger {
> +			compatible =3D "dlg,da9150-charger";
> +
> +			io-channels =3D <&gpadc 0>,
> +				      <&gpadc 2>,
> +				      <&gpadc 8>,
> +				      <&gpadc 5>;
> +			io-channel-names =3D "CHAN_IBUS",
> +					   "CHAN_VBUS",
> +					   "CHAN_TJUNC",
> +					   "CHAN_VBAT";
>  		};
>=20
> -		da9150-charger {
> -			...
> +		fuel-gauge {
> +			compatible =3D "dlg,da9150-fuel-gauge";
> +
> +			dlg,update-interval =3D <10000>;
> +			dlg,warn-soc-level =3D /bits/ 8 <15>;
> +			dlg,crit-soc-level =3D /bits/ 8 <5>
>  		};
>  	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
