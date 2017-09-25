From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] dt-bindings: add compatibles for
 AXP803 Battery/USB power supplies
Date: Mon, 25 Sep 2017 11:14:42 +0200
Message-ID: <8cf69d3d-0004-b5dc-16e0-ce1a4f8c313b@free-electrons.com>
References: <20170920151814.22461-1-icenowy@aosc.io>
 <20170920151814.22461-2-icenowy@aosc.io>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBDUSUPHAKGQED6FHT4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170920151814.22461-2-icenowy-h8G6r0blFSE@public.gmane.org>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Icenowy,

On 20/09/2017 17:18, Icenowy Zheng wrote:
> The AXP803 PMIC has different Battery and USB power supplies than the
> AXP series PMICs already supported by the kernel, but the AC power
> supply is the same as AXP22x (as it can only detect the present/online
> state of the AC power supply on both AXP22x and AXP803).
> 
> Add compatible strings for the AXP803 Battery/USB power supplies. For AC
> power supply the one on AXP803 is compatible with the one on AXP22x.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt   | 1 +
>  Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index c24886676a60..091e5471a8c6 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible, one of:
>  			"x-powers,axp209-battery-power-supply"
>  			"x-powers,axp221-battery-power-supply"
> +			"x-powers,axp803-battery-power-supply"
>  
>  This node is a subnode of the axp20x/axp22x PMIC.
>  
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> index ba8d35f66cbe..f30e3bf8d23f 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> @@ -4,6 +4,7 @@ Required Properties:
>  -compatible: One of: "x-powers,axp202-usb-power-supply"
>                       "x-powers,axp221-usb-power-supply"
>                       "x-powers,axp223-usb-power-supply"
> +                     "x-powers,axp803-usb-power-supply"

No. You are adding support for AC and battery power supply in this
patchset, not for USB.

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
