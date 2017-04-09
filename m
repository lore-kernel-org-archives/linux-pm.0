From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 2/5] clk: sunxi-ng: allow set parent clock
 (PLL_CPUX) for CPUX clock on H3
Date: Sun, 9 Apr 2017 09:05:32 +0800
Message-ID: <CAGb2v67qxuFhN_oB4YqSTa04pb7T-7CQcmOrSUoTGTKMjW9CPg@mail.gmail.com>
References: <20170408185025.53841-1-icenowy@aosc.io> <20170408185025.53841-3-icenowy@aosc.io>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB5MRU3DQKGQEKZEWDNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170408185025.53841-3-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sun, Apr 9, 2017 at 2:50 AM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:

The subject can just say "set CLK_SET_RATE_PARENT for CPUX clock on H3".

> The CPUX clock, which is the main clock of the ARM core on Allwinner H3,
> can be adjusted by changing the frequency of the PLL_CPUX clock.
>
> Allowing setting parent clock for the CPUX clock, thus the PLL_CPUX
> clock can be adjusted when adjusting the CPUX clock.
>

This paragraph needs some work, particularly the verbs you chose. In the
clk subsystem "setting parent clock" actually refers to re-parenting.

>From include/linux/clk-provider.h:

#define CLK_SET_RATE_PARENT     BIT(2) /* propagate rate change up one level */

So what you want to say is to propagate rate changes to CPUX up one
level, so PLL_CPUX gets changed as well.

The precise wording could be something like:

    The CPUX clock is the clock source for the ARM cores on the H3 SoC.
    It is a mux clock fed by, amongst other fixed clock sources, the
    configurable PLL_CPUX.

    Set CLK_SET_RATE_PARENT on the CPUX clock, so rate changes to it
    are propagated up one level to the PLL_CPUX clock.

ChenYu

> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> index 4cbc1b701b7c..90b4e26a70bc 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -135,7 +135,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
>  static const char * const cpux_parents[] = { "osc32k", "osc24M",
>                                              "pll-cpux" , "pll-cpux" };
>  static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
> -                    0x050, 16, 2, CLK_IS_CRITICAL);
> +                    0x050, 16, 2, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT);
>
>  static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
>
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
