From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v1 01/10] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
Date: Fri, 10 Aug 2018 10:20:38 +0530
Message-ID: <CAP245DUtn=dzfaNPTmYdHZBRDzmKJ9q4EZw-n9-zgeoeBPGr2g@mail.gmail.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
 <20180809191059.GI160295@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180809191059.GI160295@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mka@chromium.org
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, smohanad@codeaurora.org, Eduardo Valentin <edubezval@gmail.com>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Andy Gross <andy.gross@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Lists LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 10, 2018 at 12:41 AM Matthias Kaehlcke <mka@chromium.org> wrote:
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
>
> nit: adding the number of sensors isn't directly related and probably
> should be in a separate patch. Not important enough to re-spin just
> for this though ;-)

Hi Matthias,

Sometimes the urge to avoid frivolous patches takes over too strongly. :-)

I'll split it out in a respin. Thanks for the quick review of the series.

Regards,
Amit

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
>
> ditto
>
> >                       #thermal-sensor-cells = <1>;
> >               };
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 6207d8d92351..478739543bbc 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -21,7 +21,7 @@
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > -#define S0_ST_ADDR           0x1030
> > +#define STATUS_OFFSET                0x30
> >  #define SN_ADDR_OFFSET               0x4
> >  #define SN_ST_TEMP_MASK              0x3ff
> >  #define CAL_DEGC_PT1         30
> > @@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
> >       unsigned int status_reg;
> >       int last_temp = 0, ret;
> >
> > -     status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> > +     status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
> >       ret = regmap_read(tmdev->map, status_reg, &code);
> > +
> >       if (ret)
> >               return ret;
> >       last_temp = code & SN_ST_TEMP_MASK;
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
