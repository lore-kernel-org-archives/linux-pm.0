From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 01/10] dt: power: bq24257-charger: Cover additional
 devices
Date: Mon, 14 Sep 2015 15:11:32 +0900
Message-ID: <55F66514.1080909@samsung.com>
References: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
 <1442003202-1430-2-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:29630 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbINGLl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 02:11:41 -0400
In-reply-to: <1442003202-1430-2-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 12.09.2015 05:26, Andreas Dannenberg wrote:
> Extend the bq24257 charger's device tree documentation to cover the
> bq24250 and bq24251 devices as well feature additions.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  .../devicetree/bindings/power/bq24257.txt          | 59 ++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/bq24257.txt
> index 5c9d394..4a88c96 100644
> --- a/Documentation/devicetree/bindings/power/bq24257.txt
> +++ b/Documentation/devicetree/bindings/power/bq24257.txt
> @@ -1,21 +1,70 @@
> -Binding for TI bq24257 Li-Ion Charger
> +Binding for TI bq24250/bq24251/bq24257 Li-Ion Charger
>  
>  Required properties:
>  - compatible: Should contain one of the following:
> + * "ti,bq24250"
> + * "ti,bq24251"
>   * "ti,bq24257"
> -- reg:			   integer, i2c address of the device.
> +- reg: integer, i2c address of the device.
> +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
> +    also be defined through the standard interrupt definition properties (see
> +    optional properties section below). Only use one method.
>  - ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
> -- ti,charge-current:	   integer, maximum charging current in uA.
> -- ti,termination-current:  integer, charge will be terminated when current in
> -			   constant-voltage phase drops below this value (in uA).
> +- ti,charge-current: integer, maximum charging current in uA.
> +- ti,termination-current: integer, charge will be terminated when current in
> +    constant-voltage phase drops below this value (in uA).
> +
> +Optional properties:
> +- pg-gpios: GPIO used for connecting the bq2425x device PG (Power Good) pin.
> +    This pin is not available on all devices however it should be used if
> +    possible as this is the recommended way to obtain the charger's input PG
> +    state. If this pin is not specified a software-based approach for PG
> +    detection is used.
> +- ti,current-limit: The maximum current to be drawn from the charger's input
> +    (in uA). If this property is not specified a USB D+/D- signal based charger
> +    type detection is used (if available) and the input limit current is set
> +    accordingly. If the D+/D- based detection is not available on a given device
> +    a default of 500,000 is used (=500mA).
> +- ti,ovp-voltage: Configures the over voltage protection voltage (in uV). If
> +    not specified a default of 6,5000,000 (=6.5V) is used.
> +- ti,in-dpm-voltage: Configures the threshold input voltage for the dynamic
> +    power path management (in uV). If not specified a default of 4,360,000
> +    (=4.36V) is used.
> +- ti,safety-timer-2x-enable: If this property is set to 1 the device's safety
> +    timer is extended (slowed down) by a factor of two. Setting this property
> +    to 0 or not providing it will leave the safety timer at its default
> +    setting.

Now I spotted the difference in this binding from previous emails.
Previously you made it as a boolean property. Now it is a integer
property for a boolean value. It is unusual. If you expect a need (or a
possibility of need) of:
1. extending,
2. overriding,
3. using similar (extended) property in different drivers,
then it should be a real value, like:

1. ti,safety-timer: integer, in seconds
2. ti,safety-timer-ratio/multiplier: integer, supported values are: 0
(use default) or 2 (slow down by factor of 2)

It is unusual and not obvious to use a integer value for boolean strict
property. With current solution you can actually only override it.
Extending is possible but would look really weird, like:
	ti,safety-timer-2x-enable = <4>; /* Heh? 4x or (4*2)x ??? */

To add even more confusion: why this property has to be configured in
Device Tree? How it is related to the hardware? It rather looks like a
job for sysfs.

Best regards,
Krzysztof

> +- interrupt-parent: Should be the phandle for the interrupt controller. Use in
> +    conjunction with "interrupts" and only in case "stat-gpios" is not used.
> +- interrupts: Interrupt mapping for GPIO IRQ (configure for both edges). Use in
> +    conjunction with "interrupt-parent" and only in case "stat-gpios" is not
> +    used.
>  
>  Example:
>  
>  bq24257 {
>  	compatible = "ti,bq24257";
>  	reg = <0x6a>;
> +	stat-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +	pg-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>  
>  	ti,battery-regulation-voltage = <4200000>;
>  	ti,charge-current = <1000000>;
>  	ti,termination-current = <50000>;
>  };
> +
> +Example:
> +
> +bq24250 {
> +	compatible = "ti,bq24250";
> +	reg = <0x6a>;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
> +
> +	ti,battery-regulation-voltage = <4200000>;
> +	ti,charge-current = <500000>;
> +	ti,termination-current = <50000>;
> +	ti,current-limit = <900000>;
> +	ti,ovp-voltage = <9500000>;
> +	ti,in-dpm-voltage = <4440000>;
> +};
> 

