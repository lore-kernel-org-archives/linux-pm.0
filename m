From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 1/5] dt-bindings: power: supply: bq24190_charger: add
 bq24192 and usb-otg-vbus
Date: Mon, 15 Oct 2018 13:52:52 -0500
Message-ID: <20181015185252.GA8056@bogus>
References: <20181001053005.18906-1-masneyb@onstation.org>
 <20181001053005.18906-2-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181001053005.18906-2-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: andy.gross@linaro.org, sre@kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 01, 2018 at 01:30:01AM -0400, Brian Masney wrote:
> Add support for the ti,bq24192 variant and a child node for the
> usb-otg-vbus regulator.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> index 9e517d307070..8f2560824a97 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -3,6 +3,7 @@ TI BQ24190 Li-Ion Battery Charger
>  Required properties:
>  - compatible: contains one of the following:
>      * "ti,bq24190"
> +    * "ti,bq24192"
>      * "ti,bq24192i"
>  - reg: integer, I2C address of the charger.
>  - interrupts[-extended]: configuration for charger INT pin.
> @@ -19,6 +20,12 @@ Optional properties:
>  - ti,system-minimum-microvolt: when power is connected and the battery is below
>    minimum system voltage, the system will be regulated above this setting.
>  
> +child nodes:
> +- usb-otg-vbus:
> +  Usage: optional
> +  Description: Regulator that is used to control the VBUS voltage direction for
> +               either USB host mode or for charging on the OTG port.

What about the regulator properties?

> +
>  Notes:
>  - Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
>    charge current on USB SDP ports, among other features). To simulate this on
> -- 
> 2.17.1
> 
