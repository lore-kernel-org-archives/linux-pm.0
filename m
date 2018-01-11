From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: add binding for X-Powers
 AXP PMICs ADC
Date: Thu, 11 Jan 2018 16:07:36 -0600
Message-ID: <20180111220736.xkcen5cr5cexihle@rob-hp-laptop>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <bef3ba5e4a2c47f13fa9ba8e6fb0267b7bb15026.1515486346.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41050 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbeAKWHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 17:07:38 -0500
Content-Disposition: inline
In-Reply-To: <bef3ba5e4a2c47f13fa9ba8e6fb0267b7bb15026.1515486346.git-series.quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com

On Tue, Jan 09, 2018 at 10:33:33AM +0100, Quentin Schulz wrote:
> X-Powers PMICs have several ADC channels that can be used for different
> purposes, e.g. PMIC internal temperature, battery voltage or AC current.
> 
> This is the documentation for AXP209, AXP221/223 ADC bindings.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 39 +++++++++-
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> new file mode 100644
> index 0000000..ed6d04e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> @@ -0,0 +1,39 @@
> +* X-Powers AXP ADC bindings
> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "x-powers,axp20x-adc",
> +    - "x-powers,axp22x-adc",
> +  - #io-channel-cells: should be 1,
> +
> +Example:
> +
> +&axp22x {
> +	axp_adc: axp-adc {

adc {

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		compatible = "x-powers,axp22x-adc";
> +		#io-channel-cells = <1>;
> +	};
> +};
> +
> +ADC channels and their indexes per variant:
> +
> +AXP209
> +------
> + 0 | acin_v
> + 1 | acin_i
> + 2 | vbus_v
> + 3 | vbus_i
> + 4 | pmic_temp
> + 5 | gpio0_v
> + 6 | gpio1_v
> + 7 | ipsout_v
> + 8 | batt_v
> + 9 | batt_chrg_i
> +10 | batt_dischrg_i
> +
> +AXP22x
> +------
> + 0 | pmic_temp
> + 1 | batt_v
> + 2 | batt_chrg_i
> + 3 | batt_dischrg_i
> -- 
> git-series 0.9.1
