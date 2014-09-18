From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 4/4] dma: pl330: add Power Management support
Date: Thu, 18 Sep 2014 12:09:56 +0200
Message-ID: <1411034996.23919.9.camel@AMDC1943>
References: <1410857494-15936-1-git-send-email-k.kozlowski@samsung.com>
 <1410857494-15936-5-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFqoLQh=FYg33LTSp-HTs-oJDT4y_K6hGRoiu9zDxOX9sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <CAPDyKFqoLQh=FYg33LTSp-HTs-oJDT4y_K6hGRoiu9zDxOX9sw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On =C5=9Bro, 2014-09-17 at 20:42 +0200, Ulf Hansson wrote:
> On 16 September 2014 10:51, Krzysztof Kozlowski <k.kozlowski@samsung.=
com> wrote:

[...]

> >
> > @@ -2585,6 +2620,34 @@ static int pl330_dma_device_slave_caps(struc=
t dma_chan *dchan,
> >         return 0;
> >  }
> >
> > +/*
> > + * Assume that IRQ safe runtime PM is chosen in probe and amba bus=
 driver
> > + * will only disable/enable the clock in runtime PM suspend/resume=
=2E
> > + */
> > +static int __maybe_unused pl330_suspend(struct device *dev)
> > +{
> > +       struct amba_device *pcdev =3D to_amba_device(dev);
> > +
> > +       if (!pm_runtime_suspended(dev))
> > +               amba_pclk_disable(pcdev);
>=20
> I would suggest to use pm_runtime_force_suspend() instead of the abov=
e.

Sure, I can change it but... (see below)

>=20
> > +       amba_pclk_unprepare(pcdev);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused pl330_resume(struct device *dev)
> > +{
> > +       struct amba_device *pcdev =3D to_amba_device(dev);
> > +
> > +       amba_pclk_prepare(pcdev);
> > +       if (!pm_runtime_suspended(dev))
> > +               return amba_pclk_enable(pcdev);
>=20
> The above if statement could be replaced with pm_runtime_force_resume=
().

But that would lead to runtime resuming the device even when it is not
needed. We don't have to fully wakeup the device during resume operatio=
n
when the device was runtime suspended before suspend.

>=20
> Doing that, means the amba_pclk_enable|disable() don't need to be
> exported from the AMBA bus header, but entirely handled by the AMBA
> bus itself.
>=20
> > +
> > +       return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(pl330_pm, pl330_suspend, pl330_resume);
> > +
> >  static int
> >  pl330_probe(struct amba_device *adev, const struct amba_id *id)
> >  {
> > @@ -2738,6 +2801,9 @@ pl330_probe(struct amba_device *adev, const s=
truct amba_id *id)
> >                 pcfg->data_buf_dep, pcfg->data_bus_width / 8, pcfg-=
>num_chan,
> >                 pcfg->num_peri, pcfg->num_events);
> >
>=20
> You need pm_runtime_set_active() here as well.

This is done by amba/bus.c. Do I have to do it again?

>=20
> > +       pm_runtime_irq_safe(&adev->dev);
> > +       pm_runtime_put_noidle(&adev->dev);
>=20
> Why pm_runtime_put_noidle(), that seems like you might end up leaving
> the device in active state - unless you get some request. Likely not
> what you want?

Hmmm... I am sorry but I do not get the point here. It could be
pm_runtime_put() as well because initially we start with counter
incremented by amba/bus.c.


> A final question, have you considered using runtime PM autosuspend
> feature. Any reason to why not?

There is no reason, I just implemented the easier way. I was hoping for
such ideas of improvement. I'll add autosuspend.


Thanks for feedback, I really appreciate it!

Best regards,
Krzysztof

>=20
> > +
> >         return 0;
> >  probe_err3:
> >         /* Idle the DMAC */
> > @@ -2764,6 +2830,8 @@ static int pl330_remove(struct amba_device *a=
dev)
> >         struct pl330_dmac *pl330 =3D amba_get_drvdata(adev);
> >         struct dma_pl330_chan *pch, *_p;
> >
> > +       pm_runtime_get_noresume(pl330->ddma.dev);
> > +
> >         if (adev->dev.of_node)
> >                 of_dma_controller_free(adev->dev.of_node);
> >
> > @@ -2802,6 +2870,7 @@ static struct amba_driver pl330_driver =3D {
> >         .drv =3D {
> >                 .owner =3D THIS_MODULE,
> >                 .name =3D "dma-pl330",
> > +               .pm =3D &pl330_pm,
> >         },
> >         .id_table =3D pl330_ids,
> >         .probe =3D pl330_probe,
> > --
> > 1.9.1
> >
>=20
> Kind regards
> Uffe

