From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v11 5/6] dmaengine: pl330: Add PM sleep support
Date: Wed, 12 Nov 2014 16:53:32 +0100
Message-ID: <1415807612.20177.6.camel@AMDC1943>
References: <1415802748-30530-1-git-send-email-k.kozlowski@samsung.com>
 <1415802748-30530-6-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFoBdq0Vdh-RELGMX_oud2PaDofqBHgc-ViReYwP9-=y2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:26850 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbaKLPxh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 10:53:37 -0500
In-reply-to: <CAPDyKFoBdq0Vdh-RELGMX_oud2PaDofqBHgc-ViReYwP9-=y2w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On =C5=9Bro, 2014-11-12 at 16:28 +0100, Ulf Hansson wrote:
> On 12 November 2014 15:32, Krzysztof Kozlowski <k.kozlowski@samsung.c=
om> wrote:
> > Add system suspend/resume capabilities to the pl330 driver so the a=
mba
> > bus clock could be also unprepared to conserve energy.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/dma/pl330.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index c3bd3584f261..fd71777fc565 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -2627,6 +2627,42 @@ static int pl330_dma_device_slave_caps(struc=
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
> > +       if (!pm_runtime_status_suspended(dev)) {
>=20
> No, this wont work. Consider this scenario:
>=20
> pm_runtime_status_suspended() returns "true", which means you conside=
r
> the device to be runtime PM suspended, thus you will unprepare the
> clock below.
>=20
> Later, a call to pm_runtime_get_sync() is invoked from "somewhere" an=
d
> before this driver's system PM resume callback has been invoked. That
> will trigger the runtime PM resume callback to be invoked, causing
> clock unbalance issues.

If during system resume the device runtime resume is called BEFORE
normal resume of device, then you're right: clock will be unbalanced.=20

But such case does not make sense. pm_runtime_get_sync() is called when
someone wants to use the dmaengine/pl330... but the pl330 driver is
still suspended in that time!

If runtime resume is called AFTER normal resume of device - then it is
fine with my code.

> You need a pm_runtime_disable() prior checking the runtime PM status
> using pm_runtime_status_suspended(). That will prevent this from
> happen.
>=20
> I guess you may see where this is leading. I think
> pm_runtime_force_suspend|resume() is well suited for this situation.

I've been there... :)



