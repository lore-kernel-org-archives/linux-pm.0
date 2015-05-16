From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] Documentation: devicetree: Add TI BQ25890 bindings
Date: Sat, 16 May 2015 20:53:42 +0900
Message-ID: <CAJKOXPeprMYOgd1uHpdV3TjVdP9g+-SmV8q7A-127LQ7V_hAkQ@mail.gmail.com>
References: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
	<1431698778-29462-2-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f48.google.com ([209.85.216.48]:45826 "EHLO
	mail-vn0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbbEPLxo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 May 2015 07:53:44 -0400
In-Reply-To: <1431698778-29462-2-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

2015-05-15 23:06 GMT+09:00 Laurentiu Palcu <laurentiu.palcu@intel.com>:
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
> ---
>  .../devicetree/bindings/power/bq25890.txt          | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/bq25890.txt
>
> diff --git a/Documentation/devicetree/bindings/power/bq25890.txt b/Documentation/devicetree/bindings/power/bq25890.txt
> new file mode 100644
> index 0000000..44f50a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/bq25890.txt
> @@ -0,0 +1,45 @@
> +Binding for TI bq25890 Li-Ion Charger
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +    * "ti,bq25890"
> +- reg: integer, i2c address of the device.
> +- ti,battery-regulation-voltage: integer, maximum charging voltage (in uV);
> +- ti,charge-current: integer, maximum charging current (in uA);
> +- ti,termination-current: integer, charge will be terminated when current in
> +    constant-voltage phase drops below this value (in uA);
> +- ti,precharge-current: integer, maximum charge current during precharge
> +    phase (in uA);
> +- ti,minimum-sys-voltage: integer, when battery is charging and it is below
> +    minimum system voltage, the system will be regulated above
> +    minimum-sys-voltage setting (in uV);
> +- ti,boost-voltage: integer, VBUS voltage level in boost mode (in uV);
> +- ti,boost-max-current: integer, maximum allowed current draw in boost mode
> +    (in uA).
> +
> +Optional properties:
> +- ti,boost-low-freq: boolean, if present boost mode frequency will be 500kHz,
> +    otherwise 1.5MHz;
> +- ti,use-ilim-pin: boolean, if present the ILIM resistor will be used and the
> +    input current will be the lower between the resistor setting and the IINLIM
> +    register setting;
> +- ti,thermal-regulation-threshold: integer, temperature above which the charge
> +    current is lowered, to avoid overheating (in degrees Celsius);

What if property is absent? The temperature will be ignored? If so,
maybe consider adding such short statement about the default state?

Rest looks good, but I am still digging through the driver and I want
to give reviewed-tag after that. This will take me some time :) .

Best regards,
Krzysztof
