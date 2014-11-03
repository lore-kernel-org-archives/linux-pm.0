From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Mon, 3 Nov 2014 15:03:46 +0100
Message-ID: <CAPDyKFo_sxW8bE=C29fyfsqOO0tk_=eYFRkCVFRWc2kUx_bQHA@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<7hd29h8n0o.fsf@deeprootsystems.com>
	<CAPDyKFo3rrHDGzZ7SkobnV2fTkpcDBgPvyuL34H8SxGgfCYsgg@mail.gmail.com>
	<5370046.DXkB0EA6xC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5370046.DXkB0EA6xC@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

On 1 November 2014 01:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, October 31, 2014 10:16:14 AM Ulf Hansson wrote:
>> On 24 October 2014 18:12, Kevin Hilman <khilman@kernel.org> wrote:
>> > Ulf Hansson <ulf.hansson@linaro.org> writes:
>> >
>> >> Changes in v3:
>> >>       -Rework the entire intermediate step which was suggested in v2.
>> >>        That means solving the race condition, but also cope with PM domains
>> >>        that are initialized in powered off state.
>> >>
>> >> Changes in v2:
>> >>       -Added some acks.
>> >>       -Updated commit messages.
>> >>       -Included a wider audience of the patchset. V1 was lacking SoC
>> >>        maintainers.
>> >>
>> >> Here are link to the first patchset, were some discussion started.
>> >> http://marc.info/?l=linux-pm&m=141208104729597&w=2
>> >>
>> >> There may be more than one device in a PM domain which then will be
>> >> probed at different points in time.
>> >>
>> >> Depending on timing and runtime PM support, in for the device related
>> >> driver/subsystem, a PM domain may be advised to power off after a
>> >> successful probe sequence.
>> >>
>> >> A general requirement for a device within a PM domain, is that the
>> >> PM domain must stay powered during the probe sequence. To cope with
>> >> such requirement, let's add two new APIs, dev_pm_domain_get|put().
>> >>
>> >> These APIs are intended to be invoked from subsystem-level code and the
>> >> calls between get/put needs to be balanced.
>> >>
>> >> dev_pm_domain_get(), tells the PM domain that it needs to increase a
>> >> usage count and to keep supplying power. dev_pm_domain_put(), does the
>> >> opposite.
>> >
>> > I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?
>>
>> See, below.
>>
>> >
>> > What's not explained here (or what I'm not understanding) is why a PM
>> > domain is powering off if it has active devices.
>>
>> It doesn't. The problem is that using pm_runtime_get_sync() in this
>> path is not working.
>>
>> Now, I failed to include some of the important information from
>> previous discussions around this patchset. Let me iterate the patchset
>> with better commit messages, but let's first continue this thread.
>>
>> Here are some of the previous discussion:
>>
>> http://marc.info/?l=linux-pm&m=141270897014653&w=2
>> http://marc.info/?l=linux-pm&m=141208104729597&w=2
>>
>> Below is a summary of why I think "pm_runtime_get_sync()" isn't working for us.
>>
>> 1)
>> It's bad practice to use pm_runtime_get_sync() in the ->probe() path,
>
> Honestly, I'm no longer amused.
>
>> to bring your resources to full power. The consequence would be a
>> driver that requires CONFIG_PM_RUNTIME to be even functional, which
>> just isn't acceptable.
>
> Sorry, but this is utter nonsense.

I admit, I was too vague while stating this. Looking at the big
picture you are obviously right.

I should have referred to those SOCs/buses/drivers that I am working/looking at.

>
> CONFIG_PM_RUNTIME unset means "no runtime PM at all", so all drivers can expect
> everything they need to be always on.  If that is not the case, then someone is
> doing runtime PM behind the scenes and therefore cheating.  Or in different
> words, for CONFIG_PM_RUNTIME unset bus types, platforms etc must ensure that
> everything is on from the drivers' perspective.

I don't think I have stated anything that isn't in agreement with the above?

While I am struggling in making my points clearer, it seems like we
look a bit differently upon how runtime PM are being deployed.

For those drivers I am working on, it's common that these handles
runtime PM resources, like for example clocks. The clocks needs to be
enabled for the driver to handle I/O, but those may also be gated at
request inactivity to save power. That means, the clocks may be
considered as both functional clocks and runtime PM resources.

Therefore, the driver must enable its clocks during ->probe() and
without relying on CONFIG_PM_RUNTIME to be set. Similar to what you
stated for the buses above.

To also cope with the scenario where CONFIG_PM_RUNTIME is set, drivers
must update the device's runtime PM status using
pm_runtime_set_active(), to synchronize the state with the runtime PM
core. Otherwise we will get clock unbalance issues while
gating/ungating the clocks from the runtime PM callbacks.

The AMBA bus and some of its drivers a good example of how this has
been implemented:
driver/amba/bus.c
drivers/mmc/host/mmci.c
drivers/spi/spi-pl022.c

This conclusion I have made from this is:
- Using pm_runtime_get_sync() during the ->probe() path to explicitly
power up a PM domain, is not suitable as the _common_ solution to
solve the race condition. It certainly may work for some scenarios,
but not for those I am looking at.

>
> If that is the case, then calling pm_runtime_get_sync() from ->probe
> for CONFIG_PM_RUNTIME unset simply doesn't matter.
>
> Now, for CONFIG_PM_RUNTIME enabled, if power domains are in use, doing
> pm_runtime_get_sync() from ->probe is the only way the driver can ensure
> in a non-racy way that the device will be accessible going forward.
>
> Why?  Simply because the probing need not happen during system initialization.
> It very well may take places when the other devices in the same domain have
> beein in use for quite a while and have been using runtime PM (in which
> case the domain may go off at any time unless it is explicityly prevented from
> doing that).

For PM domains that are initialized in powered off state, we can't
rely on CONFIG_PM_RUNTIME and thus not on pm_runtime_get_sync() to
power on these PM domains. We need a different mechanism, which is
suggested in this v3 patchset.

The requirement of being able to initialize PM domains in powered off
state, was raised during review of v2 of this patchset. I do realize
that's not easy for you to keep track and remember of all discussions.
I apologize for not providing this as the topmost important argument
to why pm_runtime_get_sync() can't be used, in my reply to Kevin.

>
> One thing that you may be missing is that, for CONFIG_PM_RUNTIME set,
> runtime PM has to be either enabled or disabled for all devices in one
> domain (and if it is disabled, then the domain needs to be always on for
> all practical purposes).  Otherwise you can't just make all of them happy
> at the same time.  The documentation doesn't cover this, because it had been
> written before we even started to consider power domains.
>
>> Drivers that behaves well within this context, follows the runtime PM
>> documentation/recommendation.
>
> So please go to Documentation/power/runtime_pm.txt and read it again.  Quote:
>
> "If the default initial runtime PM status of the device (i.e. 'suspended')
> reflects the actual state of the device, its bus type's or its driver's
> ->probe() callback will likely need to wake it up using one of the PM core's
> helper functions described in Section 4.  In that case, pm_runtime_resume()
> should be used.  Of course, for this purpose the device's runtime PM has to be
> enabled earlier by calling pm_runtime_enable()."
>
> So how is this in agreement with what you're saying, I wonder?
>
>> They use pm_runtime_set_active() during ->probe() to reflect that their
>> devices are fully powered and capable of handling I/O.
>
> And how the heck can a driver (whose device belongs to a power domain) be sure
> that the device is "fully powered and capable of handling I/O" duing ->probe()?

Typically drivers expects the bus/subsystem level code to power on
their resources which is needed for it to succeed probing/handling
I/O. I believe this is also in agreement to what you stated earlier
above.

This patchset adopts the behaviour above, for those buses which may
hold devices belonging to PM domains.

That said, maybe the wording of "race conditions" should have been
better picked to better describe the issue I am trying to solve.

>
>> You may also have a look at these discussions which also touches this
>> topic, but within a context of another patchset.
>> https://lkml.org/lkml/2014/10/23/95
>
> Which looks like reiterating the same incorrect arguments.
>
>> 2)
>> Another good example why pm_runtime_get_sync() is a bad solution to
>> our problem, is the amba bus. Before it invokes the driver's ->probe()
>> callback it does the following.
>> - "enable bus clock"
>> - pm_runtime_get_noresume()
>> - pm_runtime_set_active()
>> - pm_runtime_enable()
>
> Which may not work if power domains are involved.
>
>> For these scenarios a pm_runtime_get_sync() from any of amba driver's
>> ->probe() callback wouldn't have any effect, since the device is
>> already active. In other words, the resources needs to be "manually"
>> enabled.
>
> There seems to be a lot of confusion around this, so let me summarize:
>
> - For CONFIG_PM_RUNTIME unsed drivers should be able to *safely* assume
>   that they can access devices at any time.  All of the runtime PM helpers
>   don't matter then (up to the error codes returned).
>
> - For CONFIG_PM_RUNTIME set, if power domains are in use, then runtime PM
>   has to be either enabled or disabled for all devices in one domain (and
>   if disabled, the expected behavior is like the above).
>
> - For CONFIG_PM_RUNTIME set, if power domains are in use, drivers (or bus
>   types etc) should not make any assumptions about devices being fully
>   powered without ensuring that this is the case, usually by holding an
>   active PM runtime reference to the device before accessing it.
>
> Now, there may be places in the core/bus type code that aren't aligned with
> the above, so they need to be fixed this way or another.
>
> HTH,
> Rafael
>

Kind regards
Uffe
