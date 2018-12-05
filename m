From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
Date: Wed, 5 Dec 2018 12:12:24 +0100
Message-ID: <CAJKOXPd8eErBf4a4x2bAQUnCenOsM+omJoVJ3FrakcTT6KWedg@mail.gmail.com>
References: <CGME20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f@eucas1p1.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com> <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: l.luba@partner.samsung.com
Cc: linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 Dec 2018 at 12:06, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Mark the state for devfreq device while entring suspend/resume process.
>
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>

I already applied v2:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=next/dt

Best regards,
Krzysztof

> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index b6091c2..4429b72 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -298,6 +298,7 @@
>                         opp-400000000 {
>                                 opp-hz = /bits/ 64 <400000000>;
>                                 opp-microvolt = <1150000>;
> +                               opp-suspend;
>                         };
>                 };
>
> @@ -367,6 +368,7 @@
>                         };
>                         opp-200000000 {
>                                 opp-hz = /bits/ 64 <200000000>;
> +                               opp-suspend;
>                         };
>                 };
>         };
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 51f72f0..908c0c4 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -432,6 +432,7 @@
>                         opp-400000000 {
>                                 opp-hz = /bits/ 64 <400000000>;
>                                 opp-microvolt = <1050000>;
> +                               opp-suspend;
>                         };
>                 };
>
> @@ -520,6 +521,7 @@
>                         opp-200000000 {
>                                 opp-hz = /bits/ 64 <200000000>;
>                                 opp-microvolt = <1000000>;
> +                               opp-suspend;
>                         };
>                 };
>
> --
> 2.7.4
>
