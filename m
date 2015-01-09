From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/3] of: Add binding for NVIDIA Tegra ACTMON node
Date: Fri, 9 Jan 2015 09:16:14 -0600
Message-ID: <CAL_JsqLRWLrNHbtOxWMm1MnkuppAL9CJh4BGk2RgyrniFuxo0g@mail.gmail.com>
References: <1418719298-25314-1-git-send-email-tomeu.vizoso@collabora.com> <1418719298-25314-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418719298-25314-2-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 16, 2014 at 2:41 AM, Tomeu Vizoso
<tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> This block gathers statistics about various counters and can be configured to
> fire interrupts when thresholds are crossed.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>
> ---
>
> v2:     * Add operating-points property
> ---
>  .../devicetree/bindings/arm/tegra/actmon.txt       | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/tegra/actmon.txt b/Documentation/devicetree/bindings/arm/tegra/actmon.txt
> new file mode 100644
> index 0000000..b4069df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/actmon.txt
> @@ -0,0 +1,38 @@
> +Tegra124 Activity Monitor driver
> +
> +Required properties:
> +
> +- compatible: should be "nvidia,tegra124-actmon"
> +- reg: offset and length of the register set for the device
> +- interrupts: standard interrupt property
> +- clocks: Must contain a phandle and clock specifier pair for each entry in clock-names. See ../clock/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - actmon
> +  - emc
> +- resets: Must contain an entry for each entry in reset-names. See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - actmon
> +- operating-points: Supported operating points. See ../power/opp.txt for details.

FYI, we are looking to deprecate this and do something more
extensible[1]. I'm not saying don't use this, but input on the new one
would be helpful. This is also the 2nd bus scaling binding I've
reviewed this week (Exynos being the other). I like the simplicity of
this, but would like something common even more.

This somewhat seems like it is in the wrong place. Is this for scaling
internal buses or DDR? Is it the activity monitor that also does the
frequency changes? I would expect the DDR controller to do that and
then the OPPs should be part of the DDR controller.

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308629.html

> +
> +Example:
> +       actmon@6000c800 {
> +               compatible = "nvidia,tegra124-actmon";
> +               reg = <0x0 0x6000c800 0x0 0x400>;
> +               interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&tegra_car TEGRA124_CLK_ACTMON>,
> +                        <&tegra_car TEGRA124_CLK_EMC>;
> +               clock-names = "actmon", "emc";
> +               resets = <&tegra_car 119>;
> +               reset-names = "actmon";
> +               operating-points = <
> +                       /* kHz  uV */
> +                       102000  800000
> +                       204000  800000
> +                       300000  820000
> +                       396000  850000
> +                       528000  880000
> +                       600000  910000
> +                       792000  980000
> +                       924000  1010000
> +               >;
> +       };
> --
> 1.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
