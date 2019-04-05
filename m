From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 08/13] thermal: qoriq: Convert driver to use devm_ioremap()
Date: Fri, 5 Apr 2019 11:14:15 -0700
Message-ID: <CAHQ1cqFgS1euUwc=vuUX1W24fBPcvb3tUsTwwFTKUb9tEdWNzg@mail.gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-9-andrew.smirnov@gmail.com> <4d17af42-9db4-685e-799d-7b7981344129@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4d17af42-9db4-685e-799d-7b7981344129@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2019 at 1:23 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Convert driver to use devm_ioremap() to simplify memory deallocation
> > and error handling code. No functional change intended.
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
> >  drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index a3ddb55740e4..4f9a2543f9c3 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -192,6 +192,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >       struct qoriq_tmu_data *data;
> >       struct device_node *np = pdev->dev.of_node;
> >       struct device *dev = &pdev->dev;
> > +     struct resource *io;
> >
> >       data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
> >                           GFP_KERNEL);
> > @@ -200,7 +201,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >
> >       data->little_endian = of_property_read_bool(np, "little-endian");
> >
> > -     data->regs = of_iomap(np, 0);
> > +     io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!io) {
> > +             dev_err(dev, "Failed to get memory region\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     data->regs = devm_ioremap(dev, io->start, resource_size(io));
>
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         base = devm_ioremap_resource(&pdev->dev, res);
> ?
>

devm_ioremap_resource() will call devm_request_mem_region() which
would change original behavior. I don't know if original code was
purposefully written to not request underlying memory region or not,
but I didn't want to change the behavior. I am more than happy to
change the code to use devm_ioremap_resource() (or probably even
devm_platform_ioremap_resource()) if we agree that such a change is
acceptable.

Thanks,
Andrey Smirnov
