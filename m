From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 05/13] thermal: qoriq: Embed per-sensor data into
 struct qoriq_tmu_data
Date: Fri, 5 Apr 2019 11:00:42 -0700
Message-ID: <CAHQ1cqEJbXKdoqqwKjkD_yPjv52Y9w+XOOKxqFpPN23q-qnFaw@mail.gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-6-andrew.smirnov@gmail.com> <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2019 at 12:57 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Embed per-sensor data into struct qoriq_tmu_data so we can drop the
> > code allocating it. This also allows us to get rid of per-sensor back
> > reference to struct qoriq_tmu_data since now its address can be
> > caluclated using container_of().
>
> This seems to be a repeating pattern, drivers are forced to put a back
> pointer in the thermal sensor structure to regain access to the
> container structure in the get_temp callback.
>
> It would make sense to pass the sensor id to the get_temp callback as we
> register with the sensor id.
>

I'll rebase this series on the two patches you submitted.

> One comment below.
>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index e281bdcfa11f..deb5cb6a0baf 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -59,22 +59,24 @@ struct qoriq_tmu_regs {
> >       u32 ttr3cr;             /* Temperature Range 3 Control Register */
> >  };
> >
> > -struct qoriq_tmu_data;
> > -
> >  /*
> >   * Thermal zone data
> >   */
> >  struct qoriq_sensor {
> > -     struct qoriq_tmu_data           *qdata;
> >       int                             id;
> >  };>
> >  struct qoriq_tmu_data {
> >       struct qoriq_tmu_regs __iomem *regs;
> >       bool little_endian;
>
> Why not replace the little_endian boolean by a couple of callback
> read/write and assign them to ioread32|ioread32be at init time.
>
> That will kill the tmu_read and tmu_write functions and from there you
> can figure out how to remove the qdata backpointer. In addition, it will
> save a few instructions to test the boolean.
>

I am sure you've seen it by now, but little_endian is going away in
this series in regmap conversion patch.

Thanks
Andrey Smirnov
