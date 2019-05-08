From: Michael Kao <michael.kao@mediatek.com>
Subject: Re: [PATCH 2/8] arm64: dts: mt8183: add/update dynamic power
 coefficients
Date: Wed, 8 May 2019 20:27:07 +0800
Message-ID: <1557318427.29634.8.camel@mtksdccf07>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
         <1556793795-25204-3-git-send-email-michael.kao@mediatek.com>
         <CAJMQK-jujDXt18M8610G4GpHdrikTD0ZZG_=C2YTt63UfxuHuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJMQK-jujDXt18M8610G4GpHdrikTD0ZZG_=C2YTt63UfxuHuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, jamesjj.liao@mediatek.com, devicetree@vger.kernel.org, louis.yu@mediatek.com, dawei.chien@mediatek.com, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, roger.lu@mediatek.com, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, fan.chen@mediatek.com, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2019-05-03 at 15:16 +0800, Hsin-Yi Wang wrote:
> On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
> >
> > Add dynamic power coefficients for all cores and update those of
> > CPU0 and CPU4.
> >
> > Signed-off-by: Michael.Kao <michael.kao@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index b92116f..5668fb8 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -58,6 +58,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x000>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> Should this line be in [3/8] arm64: dts: mt8183: Add #cooling-cells to
> CPU nodes?
> 
I will fix the mistake at v2 patch list.
> >                 };
> >
> >                 cpu1: cpu@1 {
> > @@ -65,6 +67,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x001>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu2: cpu@2 {
> > @@ -72,6 +76,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x002>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu3: cpu@3 {
> > @@ -79,6 +85,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x003>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu4: cpu@100 {
> > @@ -86,6 +94,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x100>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu5: cpu@101 {
> > @@ -93,6 +103,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x101>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu6: cpu@102 {
> > @@ -100,6 +112,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x102>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu7: cpu@103 {
> > @@ -107,6 +121,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x103>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >         };
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
