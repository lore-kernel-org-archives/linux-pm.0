From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] MAINTAINERS: Add entry for Maxim PMICs on Samsung boards
Date: Fri, 30 Jan 2015 13:17:10 -0800
Message-ID: <20150130211710.22722.17974@quantum>
References: <1422612635-5711-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422612635-5711-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Quoting Krzysztof Kozlowski (2015-01-30 02:10:35)
> Add myself and Chanwoo Choi as supporters to help in reviewing patches
> for Maxim 77686 PMIC and Maxim 14577/77693 MUIC drivers:
>  - mfd (all of them),
>  - extcon (extcon-max14577.c, extcon-max77693.c),
>  - regulator (all of them),
>  - clock (clk-max77686.c),
>  - RTC (rtc-max77686.c).
> 
> Lately I am the author of contributors to them. These drivers are used
> on Exynos-based boards (Trats 2, Gear 1 and Gear 2).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
> Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> ---
> 
> Changes since v1:
> 1. Add also Chanwoo Choi as supporter on his request [1].
> 2. Move out chargers (power supply) to separate patch (applied already
>    by Sebastian Reichel [2]). Patch is rebased on next which includes
>    this.
> 3. Add acks from Mark Brown and Lee Jones.
> 
> [1] https://lkml.org/lkml/2015/1/16/571
> [2] http://git.infradead.org/battery-2.6.git/commit/f8f847b51a0e1cb0c96e706d5da0ac507d96c605
> ---
>  MAINTAINERS | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d7404add7ed..775a631118ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6191,6 +6191,26 @@ S:       Supported
>  F:     drivers/power/max14577_charger.c
>  F:     drivers/power/max77693_charger.c
>  
> +MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
> +M:     Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> +M:     Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> +L:     linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:     Supported
> +F:     drivers/*/max14577.c
> +F:     drivers/*/max77686.c
> +F:     drivers/*/max77693.c
> +F:     drivers/extcon/extcon-max14577.c
> +F:     drivers/extcon/extcon-max77693.c
> +F:     drivers/rtc/rtc-max77686.c
> +F:     drivers/clk/clk-max77686.c
> +F:     Documentation/devicetree/bindings/mfd/max14577.txt
> +F:     Documentation/devicetree/bindings/mfd/max77686.txt
> +F:     Documentation/devicetree/bindings/mfd/max77693.txt
> +F:     Documentation/devicetree/bindings/clock/maxim,max77686.txt
> +F:     include/linux/mfd/max14577*.h
> +F:     include/linux/mfd/max77686*.h
> +F:     include/linux/mfd/max77693*.h
> +
>  MAXIRADIO FM RADIO RECEIVER DRIVER
>  M:     Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
>  L:     linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
