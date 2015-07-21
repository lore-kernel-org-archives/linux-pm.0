From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 7/8] dmaengine: add a driver for Intel integrated DMA 64-bit
Date: Tue, 21 Jul 2015 10:08:28 +0300
Message-ID: <CAHp75VeC=LzvZ0UbZ_uagW8M80aFoXD5h8v3kQEC2vKX3AjNww@mail.gmail.com>
References: <1436185334-34275-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1436185334-34275-8-git-send-email-andriy.shevchenko@linux.intel.com>
	<20150717043803.GE5086@localhost>
	<CAHp75VcMej=a0pLT61hbnHmTvY7Mn_aBrrk0Rq0nYbU7e_C67A@mail.gmail.com>
	<20150721045055.GG23525@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150721045055.GG23525@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 21, 2015 at 7:50 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, Jul 20, 2015 at 11:46:28AM +0300, Andy Shevchenko wrote:
>> >> +static void idma64_chan_init(struct idma64 *idma64, struct idma64_chan *idma64c)
>> >> +{
>> >> +     u32 cfghi = IDMA64C_CFGH_SRC_PER(1) | IDMA64C_CFGH_DST_PER(0);
>> >> +     u32 cfglo = 0;
>> >> +
>> >> +     /* Enforce FIFO drain when channel is suspended */
>> >> +     cfglo |= IDMA64C_CFGL_CH_DRAIN;
>> >> +
>> >> +     /* Set default burst alignment */
>> >> +     cfglo |= IDMA64C_CFGL_DST_BURST_ALIGN | IDMA64C_CFGL_SRC_BURST_ALIGN;
>> >> +
>> >> +     channel_writel(idma64c, CFG_LO, cfglo);
>> >> +     channel_writel(idma64c, CFG_HI, cfghi);
>> >> +
>> >> +     /* Enable interrupts */
>> >> +     channel_set_bit(idma64, MASK(XFER), idma64c->mask);
>> >> +     channel_set_bit(idma64, MASK(ERROR), idma64c->mask);
>> >> +
>> >> +     /*
>> >> +      * Enforce the controller to be turned on.
>> >> +      *
>> >> +      * The iDMA is turned off in ->probe() and looses context during system
>> >> +      * suspend / resume cycle. That's why we have to enable it each time we
>> >> +      * use it.
>> >> +      */
>> >> +     idma64_on(idma64);
>> > would it be better that you do this in resume and runtime_resume cycle. That
>> > way it need not be called for every channel init
>>
>> Mika, I don't remember details here, but this piece came from you. Can
>> you shed a light?
>>
>> My understanding that DMA IP is private to the host controller and has
>> the same power rail. Thus, there is no need to do separate power
>> management for it, which makes things more complicated for no profit.
>> It is also needed for time period from probe till first transfer
>> (otherwise we have to check the status of DMA anyway and enable it if
>> required), which currently remains DMA off.
> so who does runtime management of this power rail and whosoever does that
> how do they ensure the dma is not active at that time?

The host controller driver knows this and it makes it so.
Anyway, even if we introduce PM callbacks in this driver how to solve
the issue to run very first transfer in a neat way?

>> >> +static size_t idma64_desc_size(struct idma64_desc *desc, unsigned int active)
>> >> +{
>> >> +     size_t bytes = 0;
>> >> +     unsigned int i;
>> >> +
>> >> +     for (i = active; i < desc->ndesc; i++)
>> >> +             bytes += desc->hw[i].len;
>> > it can help for the non active case to have this size stored in desc while
>> > preparing, that gets rid of runtime calculation for that case
>>
>> I don't see much improvement, since it's a rare cases, but waste of
>> memory. If you consider that should be done I can implement it.
> The users of timing information will invoke this in non sleeping context so
> it will help in using one more variable, maybe a good trade off. Also if
> this is a rare case do you have use of this calculation and code?

I have no calculations done, but the residue check is used only in one
case for now, i.e. in the UART driver (see 8250_dma.c). That code
serializes requests, so it will not ask for pending descriptor size.
The case when we start the DMA and immediately ask for residue is
unlike (when UART RX timeout happens).

>> >> +static int idma64_terminate_all(struct dma_chan *chan)
>> >> +{
>> >> +     struct idma64_chan *idma64c = to_idma64_chan(chan);
>> >> +     unsigned long flags;
>> >> +     LIST_HEAD(head);
>> >> +
>> >> +     spin_lock_irqsave(&idma64c->vchan.lock, flags);
>> >> +     idma64_stop_transfer(idma64c);
>> > I dont think this is the right method for terminate. Can you check, it
>> > might be that we have to suspend the channel before terminating an active
>> > one. For non active case this should be okay
>>
>> Do you mean hardware can become into wrong state?
> Yes at least that was true for 32bit version of this IP

Can you elaborate what exactly is happening? We can do a test then and
check. For now on we experienced no problems.

>
>> Only what can actually happen is the data loss which is in DMA FIFO,
>> but we already know we would like to terminate the transfer we don't
>> care about any data loss since that.
> The terminate flow expect you to suspend the channel first and then terminate

Hm... I didn't see anything in the specification. Can you point out
where it's described?

>
>> >> +static const struct dev_pm_ops idma64_dev_pm_ops = {
>> >> +     SET_LATE_SYSTEM_SLEEP_PM_OPS(idma64_suspend_late, idma64_resume_early)
>> > any reason why late ops?
>>
>> We already discussed this several times. There is no dependency
>> between DMA and its users during PM cycles. We have to be sure that
>> device (host controller) is quiescent before we stop DMA.
> And the realities change! you should be looking at deferred probing for this
> rather than using late ops.

> Clients should be suspended first which means
> they should be probed last and in the probe ensure all the resources (dma)
> are available if not defer the probe.

Ah, deferred probe here makes no sense. We have set probing ordering
in the MFD driver (for our drivers).
Looks like we may use normal calls.

>
> --
> ~Vinod



-- 
With Best Regards,
Andy Shevchenko
