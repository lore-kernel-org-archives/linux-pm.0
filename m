From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode
 binding
Date: Mon, 30 Apr 2018 13:30:36 +0100
Message-ID: <20180430123036.GH5147@dell>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Apr 2018, Paweł Chmiel wrote:

> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.
> It's based on current behavior of driver.
> 
> Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")

Why is this here?  This patch doesn't look like a fix to me.

> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/max8998.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> index 23a3650ff2a2..f95610afb57f 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>    for buck2 regulator that can be selected using dvs gpio.
>  
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
> +    remain value set from bootloader or default value will be used.
> +    Valid values: 0, 10 - 45
> +
> +  - max8998,charge-restart: Setup "Charge Restart Level". If value equals 0,
> +    remain value set from bootloader or default value will be used.
> +    Valid values: -1, 0, 100, 150, 200
> +
> +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value equals 0,
> +    remain value set from bootloader or default value will be used.
> +    Valid values: -1, 0, 5, 6, 7
> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -99,6 +114,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
>  
> +		/* Charger configuration */
> +		charger {
> +			max8998,charge-eoc = <0>;
> +			max8998,charge-restart = <(-1)>;
> +			max8998,charge-timeout = <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
