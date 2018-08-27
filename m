From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v1 07/10] thermal: tsens: Check if the IP is correctly
 enabled by firmware
Date: Mon, 27 Aug 2018 18:34:40 +0530
Message-ID: <CAP245DV282a-WW6KfaZM8JuSUgWTJtUQJOULXHviR4_cKTen8A@mail.gmail.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <985ed415774fdac9ac21afad4b4b74f30f6c5068.1533815718.git.amit.kucheria@linaro.org>
 <20180824233039.GF25163@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824233039.GF25163@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>, Doug Anderson <dianders@chromium.org>, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 25, 2018 at 5:00 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Thu, Aug 09, 2018 at 06:02:39PM +0530, Amit Kucheria wrote:
> > The SROT registers are initialised by the secure firmware at boot. We
> > don't have write access to the registers. Check if the block is enabled
> > before continuing.
> >
>
> Should this be merged to patch 6?

I've kept it separate because this 'enable' check could've been added
to the old code as well, without the separate SROT mapping in patch 6.
So in my mind, they're two different things: splitting the address map
and adding the 'enable' check and I'd prefer to keep it as it is.

> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 0b8a793f15f4..d250b757d1f0 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -12,6 +12,11 @@
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > +/* SROT */
> > +#define CTRL_OFFSET          0x4
> > +#define TSENS_EN             BIT(0)
> > +
> > +/* TM */
> >  #define STATUS_OFFSET                0x30
> >  #define SN_ADDR_OFFSET               0x4
> >  #define SN_ST_TEMP_MASK              0x3ff
> > @@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
> >  {
> >       void __iomem *tm_base, *srot_base;
> >       struct resource *res;
> > +     u32 code;
> > +     int ret;
> >       struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
> >
> >       if (!op)
> > @@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
> >       if (IS_ERR(tmdev->tm_map))
> >               return PTR_ERR(tmdev->tm_map);
> >
> > +     if (tmdev->srot_map) {
> > +             ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
> > +             if (ret)
> > +                     return ret;
> > +             if (!(code & TSENS_EN)) {
> > +                     dev_err(tmdev->dev, "tsens device is not enabled\n");
> > +                     return -ENODEV;
> > +             }
> > +     }
> > +
> >       return 0;
> >  }
> > --
> > 2.17.1
> >
