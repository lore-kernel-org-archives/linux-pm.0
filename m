From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 08/11] thermal: tsens: Check if the IP is correctly
 enabled by firmware
Date: Thu, 6 Sep 2018 15:30:43 +0530
Message-ID: <CAP245DWdePT5LZ1Sk20eea5Nx76ESMSz3Yp9b-UbNajT7fsFvQ@mail.gmail.com>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <35c332750fe1eddfa2eb53750b810256310866bd.1535462942.git.amit.kucheria@linaro.org>
 <CAHLCerPF0U22XZ8kEBkXZYJHkL73K8_RFkArs9gXvc0Qmufr-g@mail.gmail.com> <20180903204855.GB1437@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903204855.GB1437@tuxbook-pro>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>, Doug Anderson <dianders@chromium.org>, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 4, 2018 at 2:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 30 Aug 12:23 PDT 2018, Amit Kucheria wrote:
>
> > On Tue, Aug 28, 2018 at 7:08 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > > The SROT registers are initialised by the secure firmware at boot. We
> > > don't have write access to the registers. Check if the block is enabled
> > > before continuing.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > > index 0b8a793f15f4..d250b757d1f0 100644
> > > --- a/drivers/thermal/qcom/tsens-common.c
> > > +++ b/drivers/thermal/qcom/tsens-common.c
> > > @@ -12,6 +12,11 @@
> > >  #include <linux/regmap.h>
> > >  #include "tsens.h"
> > >
> > > +/* SROT */
> > > +#define CTRL_OFFSET            0x4
> >
> > This OFFSET is not constant across the TSENS family and breaks atleast
> > one platform in the test below. I have a patch to fix this for all
> > platforms, will post it after a bit more testing.
> >
>
> Afaict the other 10 patches can be merged independently of this patch.
>
> So please make the minor updates and resend them as a separate series,
> with the acks/reviews, to make it easier for Eduardo to just pick them.
>

Will do.
