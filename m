From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH 5/8] arm64: dts: mt8183: Increase polling frequency for
 CPU thermal zone
Date: Tue, 7 May 2019 16:58:18 +0800
Message-ID: <CAJMQK-hKoK1hfK+XJuyExxp3rDWY9py6j3_jwEMfVeJcYYM7XA@mail.gmail.com>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-6-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556793795-25204-6-git-send-email-michael.kao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "michael.kao" <michael.kao@mediatek.com>
Cc: fan.chen@mediatek.com, jamesjj.liao@mediatek.com, dawei.chien@mediatek.com, louis.yu@mediatek.com, roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> Evaluate the thermal zone every 500ms while not cooling and every
> 100ms when passive cooling is performed.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 0b3294b..be879ac 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -370,8 +370,8 @@
>
>                 thermal-zones {
>                         cpu_thermal: cpu_thermal {
> -                               polling-delay-passive = <1000>;
> -                               polling-delay = <1000>;
> +                               polling-delay-passive = <100>;
> +                               polling-delay = <500>;
>
>                                 thermal-sensors = <&thermal 0>;
>                                 sustainable-power = <1500>;

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
