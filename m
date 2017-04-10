From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] power: tps65217_charger: Add properties like voltage
 and current charge
Date: Mon, 10 Apr 2017 10:02:46 -0500
Message-ID: <20170410150246.lwcapmknbcpqbgxi@rob-hp-laptop>
References: <20170403164446.28076-1-enric.balletbo@collabora.com>
 <20170403164446.28076-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170403164446.28076-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 03, 2017 at 06:44:46PM +0200, Enric Balletbo i Serra wrote:
> Allow the possibility to configure the charge and the current voltage of
> the charger and also the NTC type for battery temperature measurement.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  .../bindings/power/supply/tps65217_charger.txt     |  15 ++
>  drivers/power/supply/tps65217_charger.c            | 187 +++++++++++++++++++--
>  include/linux/mfd/tps65217.h                       |   2 +
>  3 files changed, 192 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> index a11072c..600da6e 100644
> --- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> @@ -6,6 +6,18 @@ Required Properties:
>               Should be <0> for the USB charger and <1> for the AC adapter.
>  -interrupt-names: Should be "USB" and "AC"
>  
> +Optional properties:
> +-ti,charge-voltage-uvolt: set the charge voltage. The value can be: 4100000,
> +	4150000, 4200000, 4250000; default: 4100000
> +
> +-ti,charge-current-uamp: set the charging current. The value can be: 300000,
> +	400000, 500000, 700000; default: 500000

These should be standard properties. (Also, you are not using standard 
unit suffixes. See bindings/property-units.txt.)

> +
> +-ti,ntc-type: set the NTC type for battery temperature measurement. The value
> +	must be 0 or 1, where:
> +	  0 – 100k (curve 1, B = 3960)
> +	  1 – 10k  (curve 2, B = 3480) (default)
> +
>  This node is a subnode of the tps65217 PMIC.
>  
>  Example:
> @@ -14,4 +26,7 @@ Example:
>  		compatible = "ti,tps65217-charger";
>  		interrupts = <0>, <1>;
>  		interrupt-names = "USB", "AC";
> +		ti,charge-voltage-uvolt = <4100000>;
> +		ti,charge-current-uamp = <500000>;
> +		ti,ntc-type = <1>;
>  	};
