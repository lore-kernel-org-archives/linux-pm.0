From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 04/13] thermal: qoriq: Add local struct qoriq_sensor pointer
Date: Fri, 5 Apr 2019 10:57:48 -0700
Message-ID: <CAHQ1cqF3VBn9UTQvY5f3ySz9Q-zeZHcb5ojMt8suDPTfcJbZLw@mail.gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-5-andrew.smirnov@gmail.com> <02822a7c-ae86-8c00-093e-665b603b1430@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <02822a7c-ae86-8c00-093e-665b603b1430@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 3, 2019 at 8:28 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Add local struct qoriq_sensor pointer in qoriq_tmu_register_tmu_zone()
> > for brevity.
> >
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
> >  drivers/thermal/qoriq_thermal.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 6d40b9788266..e281bdcfa11f 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -114,18 +114,18 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
> >
> >       for (id = 0; id < SITES_MAX; id++) {
> >               struct thermal_zone_device *tzd;
> > +             struct qoriq_sensor *s;
> >
> > -             qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> > +             s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> >                               sizeof(struct qoriq_sensor), GFP_KERNEL);
>
> I would not recommend this, especially if you use a variable helper for
> clarity. Keep using the 's' variable and then assign qdata->sensor[id] =
> s at the end when everything is ok. May be rename it 'sensor'?
>

Sure, I'll move the assignment in v4.

Thanks,
Andrey Smirnov
