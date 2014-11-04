From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 4 Nov 2014 17:42:13 +0100
Message-ID: <CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<2024276.CFr3nVUAlA@vostro.rjw.lan>
	<CAPDyKFp=T8Luomeaoz5Y=eLAuFaOfdb+-aoU3QVnpjoDYVKPjg@mail.gmail.com>
	<17707586.6KbjDf5Kep@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <17707586.6KbjDf5Kep@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

On 4 November 2014 14:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, November 04, 2014 09:54:19 AM Ulf Hansson wrote:
>> [...]
>>
>> > Generally, there are two or even three levels of runtime PM handling,
>> > driver, (possibly) bus type and (possibly) PM domain (and multiple levels
>> > of these are possible in principle).  All of them have to be initialized
>> > at different times.
>> >
>> > Quite arguably, the PM domain and/or bus type runtime PM handling should
>> > be initialized even before registerind the device or during device
>> > registration.  Doing that later may be too late.  When the device has been
>> > registered, runtime PM should work to an extent allowing the driver to access
>> > the device and configure it further after calling pm_runtime_resume().
>> >
>> > Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
>> > it must take the fact that the driver's own ->runtime_resume() may be called
>> > as a result of this into account.  That's why I'm asking whether or not the
>> > core should call pm_runtime_resume() before calling really_probe() in a
>> > followup branch of this thread.
>>
>> I am reading the other thread, let's see.
>>
>> >
>> > The driver's own runtime PM handling must be initialized in the driver and
>> > the only place suitable for that is ->probe().  However, it needs to be done
>> > *before* the driver's own ->runtime_resume() or ->runtime_suspend() callback
>> > is executed.  If that is done properly, it should be possible to cover
>> > both the CONFIG_PM_RUNTIME set/unset cases in that code.
>> >
>> > And I wouldn't recommend anyone to do the runtime PM initialization in
>> > ->runtime_resume() (when it is called for the first time), as that would be
>> > error prone and fragile.
>>
>> Great! That's means we are at least aligned on this topic. :-)
>>
>> >
>> >> The AMBA bus and some of its drivers a good example of how this has
>> >> been implemented:
>> >> driver/amba/bus.c
>> >> drivers/mmc/host/mmci.c
>> >> drivers/spi/spi-pl022.c
>> >>
>> >> This conclusion I have made from this is:
>> >> - Using pm_runtime_get_sync() during the ->probe() path to explicitly
>> >> power up a PM domain, is not suitable as the _common_ solution to
>> >> solve the race condition. It certainly may work for some scenarios,
>> >> but not for those I am looking at.
>> >
>> > I think, however, that it might work if the core calls pm_runtime_get_sync()
>> > from driver_probe_device().
>>
>> Currently this won't work.
>>
>> That's because the buses' ->probe() are invoked in this path and they
>> are doing the attachment of the device to its PM domain.
>>
>> In other words, we can't power up the PM domain using
>> pm_runtime_get_sync(), until the device has been attached to its PM
>> domain. Right?
>
> Yes, but my point was that those bus types might need to be changed.
>
> We can't make everyone happy at the same time if their ideas about what to do
> are different.

Urgh. I fail to understand this comment.

Why do we prefer the pm_runtime_get_sync() solution in favour of this
pathset's approach?

What are the benefit do we get with pm_runtime_get_sync()?

>
>>
>> [...]
>>
>> >> For PM domains that are initialized in powered off state, we can't
>> >> rely on CONFIG_PM_RUNTIME and thus not on pm_runtime_get_sync() to
>> >> power on these PM domains. We need a different mechanism, which is
>> >> suggested in this v3 patchset.
>> >
>> > That is quite simple to address, though.  You can register a bus type
>> > notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
>> > (where the target device belongs to the domain), and do that only for
>> > CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).
>>
>> I guess we could use notifiers, but I am not sure I see any benefit.
>> The code will be more complex and we need error handling as well.
>
> Like "oh, I can't power up this thing, so I should fail ->probe()"?
>
> Then your driver would need to depend on the specific knowledge about the
> given PM domain, I'm afraid.
>
> If you want error handling like that, it needs to be handled by the core,
> so as to avoid calling the bus type's ->probe() as well in that case.

Yes, I want this error handling - but I fail to understand why the bus
can't handle the errors.

If works perfectly in this patchset's approach.

>
> So to summarize:
>
> - Devices need to be added to power domains before really_probe() is called
>   for them.  Otherwise we'll have ordering problems all over.

What ordering problems?

>
> - Runtime PM (if compiled in) needs to be enabled for all devices in power
>   domains by default.  Otherwise devices may lose power as a result for
>   power management of the other devices in the same domain.
>
> - The core should try to power up domains before calling really_probe() both
>   for CONFIG_PM_RUNTIME set and unset, so ->probe() can always make the
>   "device is accessible" assumption.

And how exactly will you then power up the PM domain when
CONFIG_PM_RUNTIME is unset?

>
> - Bus types may need to do more on top of that in their ->probe(), so the
>   driver's ->probe() can make that assumption too in all cases.
>
> Does that make sense to you?

I working on fully understanding your idea. :-)

Kind regards
Uffe
