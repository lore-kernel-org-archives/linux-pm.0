From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ safe option
Date: Sat, 01 Nov 2014 02:29:42 +0200
Message-ID: <3452823.YQ5FR2FtKz@avalon>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com> <20141031142241.GA17547@amd> <1414766416.6537.6.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1414766416.6537.6.camel@AMDC1943>
Sender: linux-doc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On Friday 31 October 2014 15:40:16 Krzysztof Kozlowski wrote:
> On pi=C4=85, 2014-10-31 at 15:22 +0100, Pavel Machek wrote:
> > On Fri 2014-10-31 10:14:55, Krzysztof Kozlowski wrote:
> >> On pon, 2014-10-20 at 11:04 +0200, Krzysztof Kozlowski wrote:
> >>> Add a simple getter pm_runtime_is_irq_safe() for querying whether
> >>> runtime PM IRQ safe was set or not.
> >>>=20
> >>> Various bus drivers implementing runtime PM may use choose to sus=
pend
> >>> differently based on IRQ safeness status of child driver (e.g. do=
 not
> >>> unprepare the clock if IRQ safe is not set).
> >>>=20
> >>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>=20
> >> Rafael, Len, Pavel,
> >>=20
> >> Is proposed API ok? Do you have any comments?
> >>=20
> >> I'll upload whole patchset to Russell's patch tracking system. How=
ever
> >> an ack from PM maintainer is probably needed.
> >=20
> > I don't like the API. Having callbacks work in different context (i=
rq
> > / noirq) based on what another function reports is ugly.
> >=20
> > What is the penalty if we always decide callbacks are not IRQ safe?
>=20
> Then pm_runtime_get_sync() could not be called in atomic context. The
> pl330 runtime PM would have to be completely reworked because one
> pm_runtime_get_sync() is called in device_issue_pending which cannot
> sleep (at least in non preemptible kernels). Probably this can be sol=
ved
> some way...

Many other drivers suffer from the same problem. While I won't reject y=
our=20
proposed fix, I would prefer a more generic approach.

One option that has been discussed previously was to use a work queue t=
o delay=20
starting the DMA transfer to an interruptible context where=20
pm_runtime_get_sync() could be called. However, as Russell pointed out =
[1],=20
even that won't work in all cases as the DMA slave might need the trans=
fer to=20
be started before enabling part of its hardware (OMAP audio seem to be =
such a=20
case).

I've heard a rumor of a possible DMA engine rework to forbid calling th=
e=20
descriptor preparation API from atomic context. This could be used as a=
 base=20
to implement runtime PM, as DMA slave drivers should not prepare descri=
ptors=20
if they don't need to use them. However that's a long term plan, and we=
 need a=20
solution sooner than that.

I've been toying with the idea of adding explicit open/close (or whatev=
er we=20
would call them) operations to the DMA engine API. Those would be used =
by DMA=20
slave drivers to signal that they will start/stop using the DMA engine.

If (1) we must start the DMA synchronously with a DMA slave call, (2) n=
eed to=20
sleep to handle PM, and (3) don't want to keep the DMA engine powered f=
or as=20
long as one channel is requested, then we need to turn at least prepara=
tion as=20
not callable in atomic context, or introduce a new operation.

[1] http://www.spinics.net/lists/dmaengine/msg01548.html

> >>> --- a/Documentation/power/runtime_pm.txt
> >>> +++ b/Documentation/power/runtime_pm.txt
> >>>=20
> >>> @@ -468,6 +468,10 @@ drivers/base/power/runtime.c and
> >>> include/linux/pm_runtime.h:
> >>>      - set the power.irq_safe flag for the device, causing the
> >>>      runtime-PM
> >>>     =20
> >>>        callbacks to be invoked with interrupts off
> >>>=20
> >>> +  bool pm_runtime_is_irq_safe(struct device *dev);
> >>> +    - return true if power.irq_safe flag was set for the device,
> >>> causing
> >>> +      the runtime-PM callbacks to be invoked with interrupts off
> >>> +
> >>>=20
> >>>    void pm_runtime_mark_last_busy(struct device *dev);
> >>>   =20
> >>>      - set the power.last_busy field to the current time

--=20
Regards,

Laurent Pinchart

