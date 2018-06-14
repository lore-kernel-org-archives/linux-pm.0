From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v3 4/6] thermal: tsens: Add support for SDM845
Date: Thu, 14 Jun 2018 17:55:06 +0300
Message-ID: <CAP245DUMdusJpSWRQK9B8JexwJsDKbY8=7DVwxrFTL05ZY6d1w@mail.gmail.com>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
 <0cdd0957cf80c2f9921928755722a427c7309964.1528972165.git.amit.kucheria@linaro.org>
 <CAL_JsqLPKktGFH4X9gDgCFq70Uo6NvFx9-a0sR7fQU35NwZe1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLPKktGFH4X9gDgCFq70Uo6NvFx9-a0sR7fQU35NwZe1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, David Brown <david.brown@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kees Cook <keescook@chromium.org>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Lists LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

Thanks for the review.

On Thu, Jun 14, 2018 at 5:21 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Jun 14, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > SDM845 uses the TSENS v2 IP block
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 1 +
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi                    | 2 +-
> >  drivers/thermal/qcom/tsens-v2.c                          | 9 ++++++++-
> >  drivers/thermal/qcom/tsens.c                             | 3 +++
> >  drivers/thermal/qcom/tsens.h                             | 5 ++++-
> >  5 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > index 06195e8..84da3db 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > @@ -5,6 +5,7 @@ Required properties:
> >   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> >   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> >   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> > + - "qcom,tsens-v2"      : For any SoC with v2 version of the tsens IP
>
> Stick with "qcom,sdm845-tsens". Though perhaps it should be
> '"qcom,sdm845-tsens", "qcom,msm8996-tsens"' if there is compatibility.

There are lots of (30+) SoC families that use v2 of the tsens IP. So
we're talking about potentially 100s of platforms using the IP. This
could become very unwieldy to deal with very quickly.

The core functionality in tsens v2 remains the same (e.g. reading the
temperature) and any differences could potentially be addressed with
more specific DTs or preferably dynamically detected by probing the
minor version of the HW version register.

> >  - reg: Address range of the thermal registers
> >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 6c8a857..28d4c08 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -460,7 +460,7 @@
> >                 };
> >
> >                 tsens0: thermal-sensor@4a8000 {
> > -                       compatible = "qcom,msm8996-tsens";
> > +                       compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
>
> There's no point to adding this now because you already have to
> support "qcom,msm8996-tsens".

Of course.

>
> >                         reg = <0x4a9000 0x1000>, /* TM */
> >                               <0x4a8000 0x1000>; /* SROT */
> >                         #qcom,sensors = <13>;
> > diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> > index c981a40..abc8f13 100644
> > --- a/drivers/thermal/qcom/tsens-v2.c
> > +++ b/drivers/thermal/qcom/tsens-v2.c
> > @@ -69,8 +69,15 @@ static const struct tsens_ops ops_v2 = {
> >         .get_temp       = get_temp_tsens_v2,
> >  };
> >
> > +const struct tsens_data data_tsens_v2 = {
> > +       .ops            = &ops_v2,
> > +};
> > +
> > +/* Kept around for backward compatibility with old msm8996.dtsi.
> > + * New platforms should use data_tsens_v2 if possible and define
> > + * the #qcom,sensors property in DT.
>
> Hum, I think this should just be implied by the compatible as it was.
> If this was the *only* difference, then a property would be okay, but
> as soon as you find some other difference you need yet another
> property and have to do a DT update on all platforms.

Perhaps I was needless wordy, but the only reason to keep data_8996
around is the num_sensors bit below. Now that Bjorn's patch
6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of sensors to come
from DT") has landed, that should be the default way to specify the
number of sensors connected to each IP block.

We want future DTs to simply use the qcom,tsens-v2 property instead of
saying that they're all compatible with 8996. That will more truly
reflect the HW (tsens v2) and the qcom,msm8996-tsens binding probably
shouldn't have been added in the first place.

> > + */
> >  const struct tsens_data data_8996 = {
> >         .num_sensors    = 13,
> >         .ops            = &ops_v2,
> >  };
> > -
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 3440166c..a2c9bfa 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
> >         }, {
> >                 .compatible = "qcom,msm8996-tsens",
> >                 .data = &data_8996,
> > +       }, {
> > +               .compatible = "qcom,tsens-v2",
> > +               .data = &data_tsens_v2,
>
> Why different data if 8996 is compatible with v2?

See above.

> >         },
> >         {}
> >  };
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> > index dc56e1e..69212cb 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -87,6 +87,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
> >  int init_common(struct tsens_device *);
> >  int get_temp_common(struct tsens_device *, int, int *);
> >
> > -extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
> > +/* TSENS v1 targets */
> > +extern const struct tsens_data data_8916, data_8974, data_8960;
> > +/* TSENS v2 targets */
> > +extern const struct tsens_data data_8996, data_tsens_v2;
> >
> >  #endif /* __QCOM_TSENS_H__ */
> > --
> > 2.7.4
> >
