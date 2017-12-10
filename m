From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/8] dt-bindings: power: supply: axp20x: add AXP813
 battery DT binding
Date: Sun, 10 Dec 2017 16:44:11 +0000
Message-ID: <20171210164411.01d28afb@archlinux>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
        <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, icenowy-h8G6r0blFSE@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon,  4 Dec 2017 15:12:50 +0100
Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> The AXP813 can have a battery as power supply, so let's add it to the
> list of compatibles.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index c248866..4614c8e 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,12 +4,12 @@ Required Properties:
>   - compatible, one of:
>  			"x-powers,axp209-battery-power-supply"
>  			"x-powers,axp221-battery-power-supply"
> +			"x-powers,axp813-battery-power-supply"
>  
> -This node is a subnode of the axp20x/axp22x PMIC.
> +This node is a subnode of the axp20x/axp22x/axp81x PMIC.
>  
> -The AXP20X and AXP22X can read the battery voltage, charge and discharge
> -currents of the battery by reading ADC channels from the AXP20X/AXP22X
> -ADC.
> +The AXP20X, AXP22X and AXP81X can read the battery voltage, charge and
> +discharge currents of the battery by reading ADC channels from the ADC.
Might just be me, but this looks like a recipe for unneeded churn in future.

The supported devices can read...

Maybe also

This node is a subnode of the PMIC with the same part number. ?

I don't really care though!

>  
>  Example:
>  
