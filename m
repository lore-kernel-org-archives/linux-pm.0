From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v1 01/10] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
Date: Mon, 27 Aug 2018 18:24:55 +0530
Message-ID: <CAP245DWcQ1DQCoMv_92wJweySUDaH60+ySwGeQHR9hL1PpD0uw@mail.gmail.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
 <20180824232747.GE25163@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824232747.GE25163@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>, Doug Anderson <dianders@chromium.org>, mka@chromium.org, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 25, 2018 at 4:58 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Thu, Aug 09, 2018 at 06:02:33PM +0530, Amit Kucheria wrote:
> > We've earlier added support to split the register address space into TM
> > and SROT regions.
> >
> > Split up the regmap address space into two for the remaining platforms that
> > have a similar register layout and make corresponding changes to the
> > get_temp_common() function used by these platforms.
> >
> > Since tsens-common.c/init_common() currently only registers one address
> > space, the order is important (TM before SROT).  This is OK since the code
> > doesn't really use the SROT functionality yet.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-msm8974.dtsi   | 6 ++++--
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++--
> >  drivers/thermal/qcom/tsens-common.c   | 5 +++--
> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > index d9019a49b292..3c4b81c29798 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > @@ -427,11 +427,13 @@
> >                       };
> >               };
> >
> > -             tsens: thermal-sensor@fc4a8000 {
> > +             tsens: thermal-sensor@fc4a9000 {
> >                       compatible = "qcom,msm8974-tsens";
> > -                     reg = <0xfc4a8000 0x2000>;
> > +                     reg = <0xfc4a9000 0x1000>, /* TM */
> > +                           <0xfc4a8000 0x1000>; /* SROT */
> >                       nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> >                       nvmem-cell-names = "calib", "calib_backup";
> > +                     #qcom,sensors = <11>;
> >                       #thermal-sensor-cells = <1>;
> >               };
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > index cc1040eacdf5..abf84df5a7bc 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > @@ -774,11 +774,13 @@
> >                       };
> >               };
> >
> > -             tsens: thermal-sensor@4a8000 {
> > +             tsens: thermal-sensor@4a9000 {
> >                       compatible = "qcom,msm8916-tsens";
> > -                     reg = <0x4a8000 0x2000>;
> > +                     reg = <0x4a9000 0x1000>, /* TM */
> > +                           <0x4a8000 0x1000>; /* SROT */
> >                       nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> >                       nvmem-cell-names = "calib", "calib_sel";
> > +                     #qcom,sensors = <5>;
> >                       #thermal-sensor-cells = <1>;
>
> Looking closer to this, I fail to remember the reasoning why
> #qcom,sensors property was needed.

It is necessary for platforms that have multiple TSENS blocks. This
then allows us to specify the number of connected sensors per block.
See commit 6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of
sensors to come from DT") for details.

As requested by Matthias, I'm moving this bit to its own patch in v2.

Regards,
Amit
