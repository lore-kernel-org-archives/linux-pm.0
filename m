From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 4/5] ARM: dts: axp209: Add ac_power_supply child node
 to the ax209 node
Date: Thu, 5 May 2016 12:41:04 +0200
Message-ID: <90ca6b6a-19a2-75f1-22ed-3079a7084606@redhat.com>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
 <1462444508-9363-5-git-send-email-haas@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462444508-9363-5-git-send-email-haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 05-05-16 12:35, Michael Haas wrote:
> Add a node representing the ac power supply part of the axp209 pmic.
>
> This node is enabled by default. A device is likely to have an AC power
> connection. If the AC power is indeed absent, the ac power driver
> will simply report the power input as offline.
>
> Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
> ---
>  arch/arm/boot/dts/axp209.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 051ab3b..7deb7d9 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -90,8 +90,14 @@
>  		};
>  	};
>
> +	ac_power_supply: ac_power_supply {
> +		compatible = "x-powers,axp202-ac-power-supply";
> +		status = "okay";
> +	};
> +

Default status needs to be disabled, many tablets have only
a micro/mini usb-b connector which is also used for charging
and do not have a separate ac 5V in connector.

Regards,

Hans


>  	usb_power_supply: usb_power_supply {
>  		compatible = "x-powers,axp202-usb-power-supply";
>  		status = "disabled";
>  	};
> +
>  };
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
