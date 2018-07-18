From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v7 2/7] thermal: tsens: Add support to split up register
 address space into two
Date: Wed, 18 Jul 2018 09:12:50 +0530
Message-ID: <CAP245DXH=k--JJvTxV29uxqeRGJgFW+QgN-ctq5NJLYXRgjjWg@mail.gmail.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
 <20180717232907.GC129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717232907.GC129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mka@chromium.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Doug Anderson <dianders@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2018 at 4:59 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Jul 12, 2018 at 02:09:03PM +0530, Amit Kucheria wrote:
> > There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
> > SoCs these were contiguous, leading to DTs mapping them as one register
> > address space of size 0x2000. In newer SoCs, these two banks are not
> > contiguous anymore.
> >
> > Add logic to init_common() to differentiate between old and new DTs and
> > adjust associated offsets for the TM register bank so that the old DTs will
> > continue to function correctly.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/thermal/qcom/tsens-8996.c   |  4 ++--
> >  drivers/thermal/qcom/tsens-common.c | 12 ++++++++++++
> >  drivers/thermal/qcom/tsens.h        |  1 +
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> > index e1f7781..3e60cec 100644
> > --- a/drivers/thermal/qcom/tsens-8996.c
> > +++ b/drivers/thermal/qcom/tsens-8996.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > -#define STATUS_OFFSET        0x10a0
> > +#define STATUS_OFFSET        0xa0
> >  #define LAST_TEMP_MASK       0xfff
> >  #define STATUS_VALID_BIT     BIT(21)
> >  #define CODE_SIGN_BIT                BIT(11)
> > @@ -28,7 +28,7 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
> >       unsigned int sensor_addr;
> >       int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
> >
> > -     sensor_addr = STATUS_OFFSET + s->hw_id * 4;
> > +     sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> >       ret = regmap_read(tmdev->map, sensor_addr, &code);
> >       if (ret)
> >               return ret;
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index b1449ad..c22dc18 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/io.h>
> >  #include <linux/nvmem-consumer.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> > @@ -126,11 +127,22 @@ static const struct regmap_config tsens_config = {
> >  int __init init_common(struct tsens_device *tmdev)
> >  {
> >       void __iomem *base;
> > +     struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
> >
> > +     if (!op)
> > +             return -EINVAL;
> >       base = of_iomap(tmdev->dev->of_node, 0);
> >       if (!base)
> >               return -EINVAL;
> >
> > +     /* The driver only uses the TM register address space for now */
> > +     if (op->num_resources > 1) {
> > +             tmdev->tm_offset = 0;
> > +     } else {
> > +             /* old DTs where SROT and TM were in a contiguous 2K block */
> > +             tmdev->tm_offset = 0x1000;
> > +     }
>
> nit: no curly braces for conditionals with a single statement. There
> is probably no need to respin just for this though.

Yeah, that was leftover from refactoring because I have an upcoming
patch that adds SROT mapping inside those braces. I'm about to post it
soon.

> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
