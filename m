From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ safe
 option
Date: Fri, 31 Oct 2014 15:40:16 +0100
Message-ID: <1414766416.6537.6.camel@AMDC1943>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
 <1413795888-18559-2-git-send-email-k.kozlowski@samsung.com>
 <1414746895.6797.3.camel@AMDC1943> <20141031142241.GA17547@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20141031142241.GA17547@amd>
Sender: linux-doc-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2014-10-31 at 15:22 +0100, Pavel Machek wrote:
> On Fri 2014-10-31 10:14:55, Krzysztof Kozlowski wrote:
> > On pon, 2014-10-20 at 11:04 +0200, Krzysztof Kozlowski wrote:
> > > Add a simple getter pm_runtime_is_irq_safe() for querying whether=
 runtime
> > > PM IRQ safe was set or not.
> > >=20
> > > Various bus drivers implementing runtime PM may use choose to sus=
pend
> > > differently based on IRQ safeness status of child driver (e.g. do=
 not
> > > unprepare the clock if IRQ safe is not set).
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >=20
> > Rafael, Len, Pavel,
> >=20
> > Is proposed API ok? Do you have any comments?
> >=20
> > I'll upload whole patchset to Russell's patch tracking system. Howe=
ver
> > an ack from PM maintainer is probably needed.
>=20
> I don't like the API. Having callbacks work in different context (irq
> / noirq) based on what another function reports is ugly.
>=20
> What is the penalty if we always decide callbacks are not IRQ safe?

Then pm_runtime_get_sync() could not be called in atomic context. The
pl330 runtime PM would have to be completely reworked because one
pm_runtime_get_sync() is called in device_issue_pending which cannot
sleep (at least in non preemptible kernels). Probably this can be solve=
d
some way...=20

Best regards,
Krzysztof


>=20
> > > --- a/Documentation/power/runtime_pm.txt
> > > +++ b/Documentation/power/runtime_pm.txt
> > > @@ -468,6 +468,10 @@ drivers/base/power/runtime.c and include/lin=
ux/pm_runtime.h:
> > >      - set the power.irq_safe flag for the device, causing the ru=
ntime-PM
> > >        callbacks to be invoked with interrupts off
> > > =20
> > > +  bool pm_runtime_is_irq_safe(struct device *dev);
> > > +    - return true if power.irq_safe flag was set for the device,=
 causing
> > > +      the runtime-PM callbacks to be invoked with interrupts off
> > > +
> > >    void pm_runtime_mark_last_busy(struct device *dev);
> > >      - set the power.last_busy field to the current time
> > > =20

