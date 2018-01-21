From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 02/16] dt-bindings: iio: adc: add binding for
 X-Powers AXP PMICs ADC
Date: Sun, 21 Jan 2018 12:18:10 +0000
Message-ID: <20180121121810.5be83df8@archlinux>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
        <8191dd8cc334049b8b91a231f9f276b6d0689628.1516012352.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeAUMSQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Jan 2018 07:18:16 -0500
In-Reply-To: <8191dd8cc334049b8b91a231f9f276b6d0689628.1516012352.git-series.quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com, julian.calaby@gmail.com

On Mon, 15 Jan 2018 11:33:36 +0100
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> X-Powers PMICs have several ADC channels that can be used for different
> purposes, e.g. PMIC internal temperature, battery voltage or AC current.
> 
> This is the documentation for AXP209, AXP221/223 and AXP813 ADC
> bindings.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 48 +++++++++-
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> new file mode 100644
> index 0000000..7a63139
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> @@ -0,0 +1,48 @@
> +* X-Powers AXP ADC bindings
> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "x-powers,axp209-adc",
> +    - "x-powers,axp221-adc",
> +    - "x-powers,axp813-adc",
> +  - #io-channel-cells: should be 1,
> +
> +Example:
> +
> +&axp22x {
> +	adc {
> +		compatible = "x-powers,axp221-adc";
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
> +
> +AXP813
> +------
> + 0 | pmic_temp
> + 1 | gpio0_v
> + 2 | batt_v
> + 3 | batt_chrg_i
> + 4 | batt_dischrg_i
