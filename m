From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v12 5/6] dmaengine: pl330: Add PM sleep support
Date: Fri, 14 Nov 2014 14:47:11 +0100
Message-ID: <1415972831.25433.3.camel@AMDC1943>
References: <1415955033-29093-1-git-send-email-k.kozlowski@samsung.com>
 <1415955033-29093-6-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFr+DVd0qZ=ra5W-HxHDqauX6ZwBK8S8t_fboJfk_BUTaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPDyKFr+DVd0qZ=ra5W-HxHDqauX6ZwBK8S8t_fboJfk_BUTaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2014-11-14 at 14:31 +0100, Ulf Hansson wrote:
> On 14 November 2014 09:50, Krzysztof Kozlowski <k.kozlowski@samsung.c=
om> wrote:
> > Add system suspend/resume capabilities to the pl330 driver so the a=
mba
> > bus clock could be also unprepared to conserve energy.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/dma/pl330.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index c3bd3584f261..e499bb118f0a 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -2627,6 +2627,46 @@ static int pl330_dma_device_slave_caps(struc=
t dma_chan *dchan,
> >         return 0;
> >  }
> >
> > +/*
> > + * Runtime PM callbacks are provided by amba/bus.c driver.
> > + *
> > + * It is assumed here that IRQ safe runtime PM is chosen in probe =
and amba
> > + * bus driver will only disable/enable the clock in runtime PM cal=
lbacks.
> > + */
> > +static int __maybe_unused pl330_suspend(struct device *dev)
> > +{
> > +       struct amba_device *pcdev =3D to_amba_device(dev);
> > +
> > +       pm_runtime_disable(dev);
> > +
> > +       if (!pm_runtime_status_suspended(dev)) {
> > +               /* amba did not disable the clock */
> > +               amba_pclk_disable(pcdev);
> > +       }
> > +       amba_pclk_unprepare(pcdev);
>=20
> I would also invoke pm_runtime_set_suspended() here, to reflect that'=
s
> the current runtime PM state of the device.

Strictly speaking the device is not runtime suspended in that moment. P=
M
runtime callbacks were not called. Although the device status looks lik=
e
runtime suspended (clocks disabled) but I think the whole goal here was
to avoid touching runtime PM because this is system sleep.


> I guess I sounds like broken record :-), but using
> pm_runtime_force_suspend() would help to prevent some code duplicatio=
n
> here.
>=20
> Something like this:
>=20
> pm_runtime_force_suspend()
> if (pm_runtime_is_irq_safe())
>    amba_pclk_unprepare(pcdev);

With !CONFIG_PM_RUNTIME this would leave clocks prepared...

Thanks for feedback!
Best regards,
Krzysztof
