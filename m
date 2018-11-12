From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 06/11] arm64: dts: exynos5433: add support for thermal
 trip irq-mode
Date: Mon, 12 Nov 2018 10:00:33 +0100
Message-ID: <CAJKOXPcGOiVwVuaT+2RHGs0VxA2XRjOd6efsDQaGrWWCJS7vNg@mail.gmail.com>
References: <CGME20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f@eucas1p1.samsung.com>
 <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com> <1541610593-28542-7-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541610593-28542-7-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: l.luba@partner.samsung.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Thanks Lukasz for patches. I like your work!

I have few more comments which will probably apply for all the DTS commits.

On Wed, 7 Nov 2018 at 18:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flag which indicates

This patch does not add support. Support for flag was added in your
first drivers/thermal patches in this set. This patch adds new flag.
(and does something more, so read on)

> that trip point triggers IRQ when temperature is met.
> Exynos5433 supports 8 trip point which will trigger IRQ.

/8 trip point/8 trip points/

> Above that number other trip points should be registered
> without 'irq-mode' flag.

Please fix the line-wrap.

>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
>  1 file changed, 70 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> index fe3a0b1..c4330f6 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> @@ -17,37 +17,44 @@ thermal-zones {
>                         atlas0_alert_0: atlas0-alert-0 {
>                                 temperature = <65000>;  /* millicelsius */
>                                 hysteresis = <1000>;    /* millicelsius */
> -                               type = "active";
> +                               type = "passive";

This change is not explained in commit msg.

Basically you are doing here two things (related to each other). You
clearly define which trip points are IRQ-type and you correct the type
of trip point. Active is incorrect. This second thing is missing in
your commit msg and I believe it is main reason behind this patch. You
should focus then on this reason - start from it. Subject could be
like "Use proper passive type for thermal trip points".

Without this explanation I don't see the strong reason behind that
patch. IOW, everything was working fine before... so why adding this
new flag? Or maybe something was not fine... and then it is real
reason why you are sending the patch. Usually commit message should
answer to the most important question "WHY". Now, it explains
"WHAT"... but I can see it from the source code. However from the code
it is not easy to guess WHY.

Best regards,
Krzysztof
