From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: max8998: Add charger subnode
 binding
Date: Mon, 16 Jul 2018 12:00:03 -0600
Message-ID: <20180716180003.GA16037@rob-hp-laptop>
References: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531571213-30593-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531571213-30593-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 14, 2018 at 02:26:53PM +0200, Paweł Chmiel wrote:
> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Removed unneeded Fixes tag
>   - Correct description of all charger values
>   - Added missing property unit
> ---
>  Documentation/devicetree/bindings/mfd/max8998.txt | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> index 23a3650ff2a2..196e50097a36 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -50,6 +50,23 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>    for buck2 regulator that can be selected using dvs gpio.
>  
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - max8998,charge-eoc-percent: Setup End of Charge Level.
> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be value from 10 to 45 by 5 step.
> +
> +  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
> +    If value equals 0, leave it unchanged.
> +    If value equals -1, it will be disabled.

-1 is a bit strange. Why not 'not present' is disabled?

> +    Otherwise it should be one of following values: 100, 150, 200.
> +
> +  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
> +    If value equals 0, leave it unchanged.
> +    If value equals -1, it will be disabled.
> +    Otherwise it should be one of following values: 5, 6, 7.
> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -99,6 +116,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
>  
> +		/* Charger configuration */
> +		charger {
> +			max8998,charge-eoc-percent = <0>;
> +			max8998,charge-restart-level-microvolt = <(-1)>;
> +			max8998,charge-timeout-hours = <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {
> -- 
> 2.7.4
> 
