From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 3/4] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Wed, 17 Sep 2014 19:59:11 +0200
Message-ID: <CAPDyKFrbC6Qh1mENctZQo1y3Mb3w3fSE8X3iYnChrmxhUpBXkQ@mail.gmail.com>
References: <1410872360-27029-1-git-send-email-k.kozlowski@samsung.com>
	<1410872360-27029-4-git-send-email-k.kozlowski@samsung.com>
	<CAPDyKFrNYxSx3KwOLg0Bgw2TCtsC2-1YXjo1kSms2ie_b8sNww@mail.gmail.com>
	<20140916195255.GN12361@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140916195255.GN12361@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 16 September 2014 21:52, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 16, 2014 at 08:25:25PM +0200, Ulf Hansson wrote:
>> On 16 September 2014 14:59, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>> > The AMBA bus driver defines runtime Power Management functions which
>> > disable and unprepare AMBA bus clock. This is problematic for runtime PM
>> > because unpreparing a clock might sleep so it is not interrupt safe.
>> >
>> > However some drivers may want to implement runtime PM functions in
>> > interrupt-safe way (see pm_runtime_irq_safe()). In such case the AMBA
>> > bus driver should only disable/enable the clock in runtime suspend and
>> > resume callbacks.
>> >
>> > Detect the device driver behavior after calling its probe function and
>> > store it. During runtime suspend/resume deal with clocks according to
>> > stored value.
>> >
>> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> > ---
>> >  drivers/amba/bus.c       | 29 +++++++++++++++++++++++++----
>> >  include/linux/amba/bus.h |  1 +
>> >  2 files changed, 26 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
>> > index 3cf61a127ee5..e8fd5706954f 100644
>> > --- a/drivers/amba/bus.c
>> > +++ b/drivers/amba/bus.c
>> > @@ -94,8 +94,18 @@ static int amba_pm_runtime_suspend(struct device *dev)
>> >         struct amba_device *pcdev = to_amba_device(dev);
>> >         int ret = pm_generic_runtime_suspend(dev);
>> >
>> > -       if (ret == 0 && dev->driver)
>> > -               clk_disable_unprepare(pcdev->pclk);
>> > +       if (ret == 0 && dev->driver) {
>> > +               /*
>> > +                * Drivers should not change pm_runtime_irq_safe()
>> > +                * after probe.
>> > +                */
>> > +               WARN_ON(pcdev->irq_safe != pm_runtime_is_irq_safe(dev));
>>
>> Do we really need a WARN_ON here. Driver shouldn't update their
>> irq_safe value dynamically, right!?
>
> The driver shouldn't update it dynamically, and this makes sure *that*
> is enforced since we end up depending on that property.  Hence the
> check is sensible (and I even suggested it.)

The WARN_ON could be nice to have, but I think this is a task for PM
core to handle.

Copying flags shouldn't be needed for each an every instance of a
driver/bus that manage irq_safe devices. That's my main point.

>
>> > +
>> > +               if (pcdev->irq_safe)
>> > +                       clk_disable(pcdev->pclk);
>>
>> Since the irq_safe flag, could be considered as a special case, an
>> option for these cases - could be to leave the clock to be entirely
>> handled from the driver's runtime PM callback instead.
>
> Too many sub-clauses to make much sense of that statement.

Sorry, agree. :-)

>
> I don't want drivers messing around with this stuff.  This is the /bus/
> clock, not a device specific clock.

For irq_safe devices, driver's will need to handle the
clk_prepare|unprepare during system PM anyway. That's the reason to
why I suggested this.

On the other hand I agree with you, it's a bus clock...

Kind regards
Uffe
