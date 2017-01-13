From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: arm64: dts: mt8173: add node for thermal calibration
Date: Fri, 13 Jan 2017 16:51:21 +0800
Message-ID: <CAGS+omA=aip76=8CcGY7gPUrHj9eLLem=8MBziz99fVDq86zPQ@mail.gmail.com>
References: <1484286771-35913-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484286771-35913-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 13, 2017 at 1:52 PM, Dawei Chien <dawei.chien@mediatek.com> wrote:
>
> From: "dawei.chien@mediatek.com" <dawei.chien@mediatek.com>
>
> Add this for supporting thermal calibration by e-fuse data.
>
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 12e7027..adfac1e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -401,6 +401,11 @@
>                 efuse: efuse@10206000 {
>                         compatible = "mediatek,mt8173-efuse";
>                         reg = <0 0x10206000 0 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       thermal_calibration: calib@528 {
> +                               reg = <0x528 0xc>;
> +                       };
>                 };
>
>                 apmixedsys: clock-controller@10209000 {
> @@ -574,6 +579,8 @@
>                         resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
>                         mediatek,auxadc = <&auxadc>;
>                         mediatek,apmixedsys = <&apmixedsys>;
> +                       nvmem-cells = <&thermal_calibration>;
> +                       nvmem-cell-names = "calibration-data";
>                 };
>
>                 nor_flash: spi@1100d000 {
> --
> 1.9.1
>
