From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: max8998: Add charger subnode
 binding
Date: Tue, 7 Aug 2018 11:57:42 -0600
Message-ID: <20180807175741.GA30886@rob-hp-laptop>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 06:05:09PM +0200, Paweł Chmiel wrote:
> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>   - Make charge-restart-level-microvolt optional.
>   - Make charge-timeout-hours optional.
> 
> Changes from v1:
>   - Removed unneeded Fixes tag
>   - Correct description of all charger values
>   - Added missing property unit
> ---
>  Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> index 23a3650ff2a2..264040f4ad15 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -50,6 +50,24 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>    for buck2 regulator that can be selected using dvs gpio.
>  
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - max8998,charge-eoc-percent: Setup End of Charge Level.

This should have a vendor prefix and max8998 is not a vendor. Don't 
continue that pattern even if we already have some properties like that.

These seem like perhaps they should be common charger properties.

> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be value from 10 to 45 by 5 step.
> +
> +  Optional properties:
> +  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
> +    If property is not present, this will be disabled.
> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be one of following values: 100, 150, 200.
> +
> +  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
> +    If property is not present, this will be disabled.
> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be one of following values: 5, 6, 7.
> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -99,6 +117,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
>  
> +		/* Charger configuration */
> +		charger {
> +			max8998,charge-eoc-percent = <0>;
> +			max8998,charge-restart-level-microvolt = <100>;
> +			max8998,charge-timeout-hours = <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {
> -- 
> 2.7.4
> 
