From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH 4/8] arm64: dts: mt8183: Configure CPU cooling
Date: Tue, 7 May 2019 16:57:47 +0800
Message-ID: <CAJMQK-i===iehSxLky1rZMnYhZfrnAJzWtDxT2OLOwRnKwaZoA@mail.gmail.com>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-5-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556793795-25204-5-git-send-email-michael.kao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "michael.kao" <michael.kao@mediatek.com>
Cc: fan.chen@mediatek.com, jamesjj.liao@mediatek.com, dawei.chien@mediatek.com, louis.yu@mediatek.com, roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrot=
e:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> Add two passive trip points at 68=C2=B0C and 85=C2=B0C for the CPU temper=
ature.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 55 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8183.dtsi
> index 95f1d7b..0b3294b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -375,6 +375,61 @@
>
>                                 thermal-sensors =3D <&thermal 0>;
>                                 sustainable-power =3D <1500>;
> +
> +                               trips {
> +                                       threshold: trip-point@0 {
> +                                               temperature =3D <68000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "passive";
> +                                       };
> +
> +                                       target: trip-point@1 {
> +                                               temperature =3D <85000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "passive";
> +                                       };
> +
> +                                       cpu_crit: cpu-crit {
> +                                               temperature =3D <115000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "critical";
> +                                       };
> +                               };
> +
> +                               cooling-maps {
> +                                       map0 {
> +                                               trip =3D <&target>;
> +                                               cooling-device =3D <&cpu0
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu1
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu2
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu3
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
;
> +                                               contribution =3D <3072>;
> +                                       };
> +                                       map1 {
> +                                               trip =3D <&target>;
> +                                               cooling-device =3D <&cpu4
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu5
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu6
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu7
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
;
> +                                               contribution =3D <1024>;
> +                                       };
> +                               };
>                         };
>
>                         tzts1: tzts1 {

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
