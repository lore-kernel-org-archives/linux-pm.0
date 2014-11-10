From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no PM_RUNTIME
Date: Mon, 10 Nov 2014 14:38:11 +0100
Message-ID: <CAPDyKFrxAVjRCVZYTDHVDkBGNvuCzSFgmDw5fnVE_VsJ_nHmBw@mail.gmail.com>
References: <1415263010-7992-1-git-send-email-k.kozlowski@samsung.com>
	<1415263010-7992-2-git-send-email-k.kozlowski@samsung.com>
	<2475860.cssHTQVJGf@vostro.rjw.lan>
	<1415347601.8532.7.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:61009 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaKJNiM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 08:38:12 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so6535276qcw.9
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 05:38:11 -0800 (PST)
In-Reply-To: <1415347601.8532.7.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 7 November 2014 09:06, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On czw, 2014-11-06 at 23:51 +0100, Rafael J. Wysocki wrote:
>> On Thursday, November 06, 2014 09:36:46 AM Krzysztof Kozlowski wrote:
>> > Some drivers (e.g. bus drivers) may want to check if power.irq_safe was
>> > called by child driver, regardless of CONFIG_PM_RUNTIME.
>> >
>> > An example scenario is amba/bus.c and dma/pl330.c drivers. The runtime
>> > suspend/resume callbacks in amba bus driver act differently if irq_safe
>> > was set by child driver (in irq_safe mode bus clock is only disabled).
>> >
>> > The pl330 driver sets irq_safe and assumes that amba bus driver will
>> > only disable the clock in runtime PM. So in system sleep suspend
>> > callback the pl330 driver unprepares the clock after calling
>> > pm_runtime_force_suspend().
>> >
>> > However inconsistency would appear if CONFIG_PM_RUNTIME is not set and
>> > child drivers do not want the irq_safe runtime PM. In such case amba bus
>> > driver still has to know whether child driver wanted irq_safe - by
>> > looking at dev->power.irq_safe field.
>> >
>> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> > ---
>> >  include/linux/pm.h         | 2 +-
>> >  include/linux/pm_runtime.h | 5 ++++-
>> >  2 files changed, 5 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/include/linux/pm.h b/include/linux/pm.h
>> > index 383fd68aaee1..b05fa954f50d 100644
>> > --- a/include/linux/pm.h
>> > +++ b/include/linux/pm.h
>> > @@ -566,6 +566,7 @@ struct dev_pm_info {
>> >     bool                    ignore_children:1;
>> >     bool                    early_init:1;   /* Owned by the PM core */
>> >     bool                    direct_complete:1;      /* Owned by the PM core */
>> > +   unsigned int            irq_safe:1;     /* PM runtime */
>> >     spinlock_t              lock;
>> >  #ifdef CONFIG_PM_SLEEP
>> >     struct list_head        entry;
>> > @@ -590,7 +591,6 @@ struct dev_pm_info {
>> >     unsigned int            run_wake:1;
>> >     unsigned int            runtime_auto:1;
>> >     unsigned int            no_callbacks:1;
>> > -   unsigned int            irq_safe:1;
>> >     unsigned int            use_autosuspend:1;
>> >     unsigned int            timer_autosuspends:1;
>> >     unsigned int            memalloc_noio:1;
>>
>> Well, that is a good reason to introduce a wrapper around power.irq_safe in my
>> view.
>>
>> And define the wrapper so that it always returns false for CONFIG_PM_RUNTIME
>> unset.
>>
>> This way not only you wouldn't need to move the flag from under the #ifdef,
>> but also you would make the compiler skip the relevant pieces of code
>> entiretly for CONFIG_PM_RUNTIME unset.
>
> Few days ago I would be happy with your opinion :), but know I think
> this is better solution than wrapper. Consider case:
> 1. PM_RUNTIME unset.
> 2. System suspends.
> 3. The pl330 in its suspend callback calls force_runtime_suspend which
> leads us to amba/bus.
> 4. The amba/bus.c in runtime suspend checks for irq_safe (it is FALSE),
> so it disables and unprepares the clock.
> 5. The pl330 in probe requested irq_safe so it assumes amba/bus will
> only disable the clock. So the pl330 unprepares the clock. Again.

This is easy to solve, still by using Rafael's approach.

In the pl330 system PM callbacks, you need to check
"pm_runtime_is_irqsafe()" or whatever the wrapper would be called.
When it returns true, that's when you should do
clk_prepare|unprepare().

I think that would be quite nice.

Kind regards
Uffe
