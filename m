From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC RESEND PATCH 2/7] dt-bindings: soc: Add opp table on scpsys bindings
Date: Thu, 3 Jan 2019 12:45:54 -0600
Message-ID: <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com> <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henry Chen <henryc.chen@mediatek.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 AM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Add opp table on scpsys dt-bindings for Mediatek SoC.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/opp/mtk-opp.txt  | 24 +++++++++++++
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
>
> diff --git a/Documentation/devicetree/bindings/opp/mtk-opp.txt b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> new file mode 100644
> index 0000000..036be1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> @@ -0,0 +1,24 @@
> +Mediatek OPP bindings to descibe OPP nodes with level values
> +
> +OPP tables for devices on Mediatek platforms require an additional
> +platform specific level value to be specified.
> +This value is passed on to the mediatek Power Management Unit by the
> +CPU, which then takes the necessary actions to set a voltage rail
> +to an appropriate voltage based on the value passed.
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-mtk-level"
> +
> +* OPP Node
> +
> +Required properties:
> +- mtk,level: On Mediatek platforms an OPP node can describe a positive value
> +representing a level that's communicated with a our power management hardware
> +which then translates it into a certain voltage on a voltage rail.

Work with the Qcom folks and create a common level property.

Rob
