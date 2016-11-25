From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 03/10] Documentation: DT: binding: axp20x_usb_power: add
 axp223 compatible
Date: Fri, 25 Nov 2016 17:25:25 +0800
Message-ID: <CAGb2v64mB_fwKwF3YbkNunYCbx28CbQqpGw8Czu_5v-7A+a=wA@mail.gmail.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com> <20161125090921.23138-4-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161125090921.23138-4-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> This adds the "x-powers,axp223-usb-power-supply" to the list of
> compatibles for AXP20X VBUS power supply driver.

Please explain why we need this. Basically the part about
AXP221 vs AXP223 from your cover letter.

ChenYu

>
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> index f1d7bee..bf3953c 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> @@ -3,6 +3,7 @@ AXP20x USB power supply
>  Required Properties:
>  -compatible: One of: "x-powers,axp202-usb-power-supply"
>                       "x-powers,axp221-usb-power-supply"
> +                     "x-powers,axp223-usb-power-supply"
>
>  This node is a subnode of the axp20x PMIC.
>
> --
> 2.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
