From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 4 Nov 2014 09:54:19 +0100
Message-ID: <CAPDyKFp=T8Luomeaoz5Y=eLAuFaOfdb+-aoU3QVnpjoDYVKPjg@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<5370046.DXkB0EA6xC@vostro.rjw.lan>
	<CAPDyKFo_sxW8bE=C29fyfsqOO0tk_=eYFRkCVFRWc2kUx_bQHA@mail.gmail.com>
	<2024276.CFr3nVUAlA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2024276.CFr3nVUAlA@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

[...]

> Generally, there are two or even three levels of runtime PM handling,
> driver, (possibly) bus type and (possibly) PM domain (and multiple levels
> of these are possible in principle).  All of them have to be initialized
> at different times.
>
> Quite arguably, the PM domain and/or bus type runtime PM handling should
> be initialized even before registerind the device or during device
> registration.  Doing that later may be too late.  When the device has been
> registered, runtime PM should work to an extent allowing the driver to access
> the device and configure it further after calling pm_runtime_resume().
>
> Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
> it must take the fact that the driver's own ->runtime_resume() may be called
> as a result of this into account.  That's why I'm asking whether or not the
> core should call pm_runtime_resume() before calling really_probe() in a
> followup branch of this thread.

I am reading the other thread, let's see.

>
> The driver's own runtime PM handling must be initialized in the driver and
> the only place suitable for that is ->probe().  However, it needs to be done
> *before* the driver's own ->runtime_resume() or ->runtime_suspend() callback
> is executed.  If that is done properly, it should be possible to cover
> both the CONFIG_PM_RUNTIME set/unset cases in that code.
>
> And I wouldn't recommend anyone to do the runtime PM initialization in
> ->runtime_resume() (when it is called for the first time), as that would be
> error prone and fragile.

Great! That's means we are at least aligned on this topic. :-)

>
>> The AMBA bus and some of its drivers a good example of how this has
>> been implemented:
>> driver/amba/bus.c
>> drivers/mmc/host/mmci.c
>> drivers/spi/spi-pl022.c
>>
>> This conclusion I have made from this is:
>> - Using pm_runtime_get_sync() during the ->probe() path to explicitly
>> power up a PM domain, is not suitable as the _common_ solution to
>> solve the race condition. It certainly may work for some scenarios,
>> but not for those I am looking at.
>
> I think, however, that it might work if the core calls pm_runtime_get_sync()
> from driver_probe_device().

Currently this won't work.

That's because the buses' ->probe() are invoked in this path and they
are doing the attachment of the device to its PM domain.

In other words, we can't power up the PM domain using
pm_runtime_get_sync(), until the device has been attached to its PM
domain. Right?

[...]

>> For PM domains that are initialized in powered off state, we can't
>> rely on CONFIG_PM_RUNTIME and thus not on pm_runtime_get_sync() to
>> power on these PM domains. We need a different mechanism, which is
>> suggested in this v3 patchset.
>
> That is quite simple to address, though.  You can register a bus type
> notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
> (where the target device belongs to the domain), and do that only for
> CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).

I guess we could use notifiers, but I am not sure I see any benefit.
The code will be more complex and we need error handling as well.

>
>> The requirement of being able to initialize PM domains in powered off
>> state, was raised during review of v2 of this patchset. I do realize
>> that's not easy for you to keep track and remember of all discussions.
>> I apologize for not providing this as the topmost important argument
>> to why pm_runtime_get_sync() can't be used, in my reply to Kevin.
>
> OK
>
> It looks like we need an agreement on what to do and what the expectations
> should be for each driver core operation at the high level.  That is,
> what ->probe() should expect, what ->remove() should expect, what the
> state after executing each of them should be for CONFIG_PM_RUNTIME set and
> unset etc.  Otherwise we'll always have various bus types doing what *they*
> think is appropriate and not agreeing with each other.
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

Kind regards
Uffe
