From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Fri, 31 Oct 2014 10:16:14 +0100
Message-ID: <CAPDyKFo3rrHDGzZ7SkobnV2fTkpcDBgPvyuL34H8SxGgfCYsgg@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<7hd29h8n0o.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <7hd29h8n0o.fsf@deeprootsystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On 24 October 2014 18:12, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> Changes in v3:
>>       -Rework the entire intermediate step which was suggested in v2.
>>        That means solving the race condition, but also cope with PM domains
>>        that are initialized in powered off state.
>>
>> Changes in v2:
>>       -Added some acks.
>>       -Updated commit messages.
>>       -Included a wider audience of the patchset. V1 was lacking SoC
>>        maintainers.
>>
>> Here are link to the first patchset, were some discussion started.
>> http://marc.info/?l=linux-pm&m=141208104729597&w=2
>>
>> There may be more than one device in a PM domain which then will be
>> probed at different points in time.
>>
>> Depending on timing and runtime PM support, in for the device related
>> driver/subsystem, a PM domain may be advised to power off after a
>> successful probe sequence.
>>
>> A general requirement for a device within a PM domain, is that the
>> PM domain must stay powered during the probe sequence. To cope with
>> such requirement, let's add two new APIs, dev_pm_domain_get|put().
>>
>> These APIs are intended to be invoked from subsystem-level code and the
>> calls between get/put needs to be balanced.
>>
>> dev_pm_domain_get(), tells the PM domain that it needs to increase a
>> usage count and to keep supplying power. dev_pm_domain_put(), does the
>> opposite.
>
> I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?

See, below.

>
> What's not explained here (or what I'm not understanding) is why a PM
> domain is powering off if it has active devices.

It doesn't. The problem is that using pm_runtime_get_sync() in this
path is not working.

Now, I failed to include some of the important information from
previous discussions around this patchset. Let me iterate the patchset
with better commit messages, but let's first continue this thread.

Here are some of the previous discussion:

http://marc.info/?l=linux-pm&m=141270897014653&w=2
http://marc.info/?l=linux-pm&m=141208104729597&w=2

Below is a summary of why I think "pm_runtime_get_sync()" isn't working for us.

1)
It's bad practice to use pm_runtime_get_sync() in the ->probe() path,
to bring your resources to full power. The consequence would be a
driver that requires CONFIG_PM_RUNTIME to be even functional, which
just isn't acceptable.

Drivers that behaves well within this context, follows the runtime PM
documentation/recommendation. They use pm_runtime_set_active() during
->probe() to reflect that their devices are fully powered and capable
of handling I/O.

You may also have a look at these discussions which also touches this
topic, but within a context of another patchset.
https://lkml.org/lkml/2014/10/23/95

2)
Another good example why pm_runtime_get_sync() is a bad solution to
our problem, is the amba bus. Before it invokes the driver's ->probe()
callback it does the following.
- "enable bus clock"
- pm_runtime_get_noresume()
- pm_runtime_set_active()
- pm_runtime_enable()

For these scenarios a pm_runtime_get_sync() from any of amba driver's
->probe() callback wouldn't have any effect, since the device is
already active. In other words, the resources needs to be "manually"
enabled.


Kind regards
Uffe
