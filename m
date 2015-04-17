From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH v2 3/5] devicetree: bindings: Add new cpuidle enable
 method for Renesas R-car SoCs
Date: Fri, 17 Apr 2015 21:26:27 +0900
Message-ID: <CANqRtoQ04KxrSsLR5QEM9PekSYiRuSVzCn1p3KwN8mKf6JuvBQ@mail.gmail.com>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
	<1429180540-5692-4-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429180540-5692-4-git-send-email-keita.kobayashi.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keita Kobayashi <keita.kobayashi.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "Simon Horman [Horms]" <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Kobayashi-san,

On Thu, Apr 16, 2015 at 7:35 PM, Keita Kobayashi
<keita.kobayashi.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> This patch add the ARM CPUs Device Tree binding to document a new
> enable method of Renesas cpuidle.
>
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 8b9e0a9..663ee11 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -196,6 +196,7 @@ nodes to be present and contain the properties described below.
>                             "qcom,gcc-msm8660"
>                             "qcom,kpss-acc-v1"
>                             "qcom,kpss-acc-v2"
> +                           "renesas,rcar-idle"
>                             "rockchip,rk3066-smp"
>
>         - cpu-release-addr

I don't mind this portion so much and I can see other vendors are
using this format. And with risk of upsetting the DT police I have to
mention my doubts about why we need this particular piece of binding.

The proposed string by this patch does not seem to describe any
hardware but it is aligned to other existing stings referring to
software such as "spin-table" and "psci". From a C code implementation
point of view we would get enough information to make a good decision
by just checking SoC compatible string. At the same time, this seems
to be the standard way of doing things and standard is good.

So if we should turn this into something that describes actual
hardware, how about pointing out the APMU hardware that is actually
managing the Core Standby mode that this CPUIdle implementation is
invoking? May I suggest using "renesas,rcar-apmu"? Or perhaps to be
safe we should do per-SoC string like in other cases like
"renesas,r8a7791-apmu"? Or is there some way we can make this work
without adding a new binding?

Thanks,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
