From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Fri, 20 Jan 2017 16:52:02 -0800
Message-ID: <20170121005202.GB8801@codeaurora.org>
References: <20170119002933.7529-1-code@mmayer.net>
 <20170119002933.7529-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170119002933.7529-2-code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>
Cc: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Clock List <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/18, Markus Mayer wrote:
> diff --git a/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> new file mode 100644
> index 0000000..c4acb53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> @@ -0,0 +1,27 @@
> +The CPU divider node serves as the sole clock for the CPU complex. It supports
> +power-of-2 clock division, with a divider of "1" as the default highest-speed
> +setting.
> +
> +Required properties:
> +- compatible: shall be "brcm,brcmstb-cpu-clk-div"
> +- reg: address and width of the divider configuration register
> +- #clock-cells: shall be set to 0
> +- clocks: phandle of clock provider which provides the source clock
> +          (this would typically be a "fixed-clock" type PLL)
> +- div-table: list of (raw_value,divider) ordered pairs that correspond to the
> +             allowed clock divider settings
> +- div-shift-width: least-significant bit position and width of divider value

Are these properties used? Please don't put these types of
details in DT.

> +
> +Optional properties:
> +- clock-names: the clock may be named
> +
> +Example:
> +	cpuclkdiv: cpu-clk-div@f03e257c {
> +		compatible = "brcm,brcmstb-cpu-clk-div";
> +		reg = <0xf03e257c 0x4>;

This register really looks like some offset in something larger.
Is there some clock controller? What's the hw block at
0xf03e2000? Maybe I already asked this.

> +		div-table = <0x00 1>;
> +		div-shift-width = <0 5>;
> +		#clock-cells = <0>;
> +		clocks = <&cpupll>;
> +		clock-names = "cpupll";
> +	};
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
