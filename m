From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ safe option
Date: Mon, 03 Nov 2014 18:59:37 +0200
Message-ID: <2519900.LRhHM3UCtt@avalon>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com> <3452823.YQ5FR2FtKz@avalon> <20141103162728.GB1870@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141103162728.GB1870@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Vinod,

On Monday 03 November 2014 21:57:28 Vinod Koul wrote:
> On Sat, Nov 01, 2014 at 02:29:42AM +0200, Laurent Pinchart wrote:
> > On Friday 31 October 2014 15:40:16 Krzysztof Kozlowski wrote:
> >> On pi=C4=85, 2014-10-31 at 15:22 +0100, Pavel Machek wrote:
> >>> On Fri 2014-10-31 10:14:55, Krzysztof Kozlowski wrote:
> >>>> On pon, 2014-10-20 at 11:04 +0200, Krzysztof Kozlowski wrote:
> >>>>> Add a simple getter pm_runtime_is_irq_safe() for querying wheth=
er
> >>>>> runtime PM IRQ safe was set or not.
> >>>>>=20
> >>>>> Various bus drivers implementing runtime PM may use choose to
> >>>>> suspend differently based on IRQ safeness status of child drive=
r
> >>>>> (e.g. do not unprepare the clock if IRQ safe is not set).
> >>>>>=20
> >>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>=20
> >>>> Rafael, Len, Pavel,
> >>>>=20
> >>>> Is proposed API ok? Do you have any comments?
> >>>>=20
> >>>> I'll upload whole patchset to Russell's patch tracking system.
> >>>> However an ack from PM maintainer is probably needed.
> >>>=20
> >>> I don't like the API. Having callbacks work in different context =
(irq
> >>> / noirq) based on what another function reports is ugly.
> >>>=20
> >>> What is the penalty if we always decide callbacks are not IRQ saf=
e?
> >>=20
> >> Then pm_runtime_get_sync() could not be called in atomic context. =
The
> >> pl330 runtime PM would have to be completely reworked because one
> >> pm_runtime_get_sync() is called in device_issue_pending which cann=
ot
> >> sleep (at least in non preemptible kernels). Probably this can be =
solved
> >> some way...
> >=20
> > Many other drivers suffer from the same problem. While I won't reje=
ct your
> > proposed fix, I would prefer a more generic approach.
> >=20
> > One option that has been discussed previously was to use a work que=
ue to
> > delay starting the DMA transfer to an interruptible context where
> > pm_runtime_get_sync() could be called. However, as Russell pointed =
out
> > [1],
> > even that won't work in all cases as the DMA slave might need the t=
ransfer
> > to be started before enabling part of its hardware (OMAP audio seem=
 to be
> > such a case).
> >=20
> > I've heard a rumor of a possible DMA engine rework to forbid callin=
g the
> > descriptor preparation API from atomic context. This could be used =
as a
> > base to implement runtime PM, as DMA slave drivers should not prepa=
re
> > descriptors if they don't need to use them. However that's a long t=
erm
> > plan, and we need a solution sooner than that.
>=20
> Well it is not a rumour :)

I didn't want to put too much pressure on you by quoting you on that :-=
)

> I have been contemplating that now that async_tx will be killed so we=
 dont
> have to worry about that usage. For the slave dma usage, we can chang=
e the
> prepare API to be non atomic. I think the users will be okay with app=
roach.
> This way drivers can use runtime pm calls in prepare.

I'd certainly welcome that. There's a couple of users we will need to f=
ix as=20
they call the prepare API from an atomic context. I'm thinking about AS=
oC=20
drivers in particular.

Do you have any time line in mind ?

> > I've been toying with the idea of adding explicit open/close (or wh=
atever
> > we would call them) operations to the DMA engine API. Those would b=
e used
> > by DMA slave drivers to signal that they will start/stop using the =
DMA
> > engine.
> >=20
> > If (1) we must start the DMA synchronously with a DMA slave call, (=
2) need
> > to sleep to handle PM, and (3) don't want to keep the DMA engine po=
wered
> > for as long as one channel is requested, then we need to turn at le=
ast
> > preparation as not callable in atomic context, or introduce a new
> > operation.
> >=20
> > [1] http://www.spinics.net/lists/dmaengine/msg01548.html
> >=20
> > > >>> --- a/Documentation/power/runtime_pm.txt
> > > >>> +++ b/Documentation/power/runtime_pm.txt
> > > >>>=20
> > > >>> @@ -468,6 +468,10 @@ drivers/base/power/runtime.c and
> > > >>>=20
> > > >>> include/linux/pm_runtime.h:
> > > >>>      - set the power.irq_safe flag for the device, causing th=
e
> > > >>>        runtime-PM callbacks to be invoked with interrupts off
> > > >>>=20
> > > >>> +  bool pm_runtime_is_irq_safe(struct device *dev);
> > > >>> +    - return true if power.irq_safe flag was set for the dev=
ice,
> > > >>> causing
> > > >>> +      the runtime-PM callbacks to be invoked with interrupts=
 off
> > > >>> +
> > > >>>=20
> > > >>>    void pm_runtime_mark_last_busy(struct device *dev);
> > > >>>      - set the power.last_busy field to the current time

--=20
Regards,

Laurent Pinchart

