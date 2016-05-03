From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
Date: Tue, 3 May 2016 12:29:22 +0200
Message-ID: <20160503102922.GD3956@kozik-lap>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460701975-24178-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 15, 2016 at 03:32:47PM +0900, Chanwoo Choi wrote:
> This patchset support the AMBA bus frequency scaling on Exynos5422-based
> Odroid-XU3 board. But, this series only support the bus frequency scaling
> for INT (Internal) block using VDD_INT power line.
> 
> Also, to support the bus frequency scaling for Exynos542x SoC,
> Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
> to measure the transfered data traffic on NoC (Network on Chip)
> instead of PPMU (Platform Performance Monitoring Unit). NoC Probe device
> provide the utilization for INT block of Exynos542x SoC.
> 
> The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq-event
> device (drivers/devfreq/event/exynos-nocp.c) without any modification.
> Just add the phandle of 'NoC Probe' dt node to bus dt node.
> 
> Depend on:
> This patchset depends on patch[1] which support the generic exynos-bus
> frequency driver.
> [1] http://www.spinics.net/lists/arm-kernel/msg495976.html
> - [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor
> 
> 
> Changse from v1:
> (https://lkml.org/lkml/2016/4/8/28)
> - Simplify the documentation of exynos-nocp.txt
> - Check the return value of regmap function
> - Modify Device Tree node name using general device name
>  : nocp_memX_X@ nocp_memX_X -> nocp_memX_X@ nocp
> - Fix wrong node name about nocp device tree node
> - Drop the CLK_SET_RATE_PARENT flag
> - Reorder bus device tree node alpabetically
> - Add the tested-by tag from Anand Moon and Markus Reichl
> - Add the reviewed-by tag to patch5/7 from Exynos SoC Maintainer
> - Add patch2 to modify the devfreq_event_get_edev_by_phandle()
>   to get the instance of devfreq-event device by using the phandle
> 
> Chanwoo Choi (8):
>   PM / devfreq: event: Add new Exynos NoC probe driver
>   PM / devfreq: event: Find the instance of devfreq-event device by using phandle
>   PM / devfreq: exynos: Add the detailed correlation for Exynos5422 bus
>   ARM: dts: Add NoC Probe dt node for Exynos542x SoC
>   dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
>   clk: samsung: exynos542x: Add the clock id for ACLK
>   ARM: dts: Add bus nodes using VDD_INT for Exynos542x SoC
>   ARM: dts: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3


Applied DTS patches for late v4.7 (hopefully).

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
