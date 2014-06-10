From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/24] drivercore: Bind/unbind power domain on probe/remove
Date: Wed, 11 Jun 2014 00:15:19 +0200
Message-ID: <CAPDyKFo+QOhKvOO-C_t-oH7D9=whRF-WRf5w3dP=oTym7=6z6A@mail.gmail.com>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
	<CAJZ5v0hUT0QPGWeDM9WoxnobaL5eoNi5UFrUUZrQ1gSBCX=aVg@mail.gmail.com>
	<CAPDyKFqWZdA4ZisJvCDP8j6D2_A8oRAHkjikddyGSwpToFg-Gw@mail.gmail.com>
	<1894835.cKK4602bPf@vostro.rjw.lan>
	<20140610212731.GA11191@kroah.com>
	<53977BC1.5000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:44220 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbaFJWPU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 18:15:20 -0400
Received: by mail-qc0-f180.google.com with SMTP id i17so3214362qcy.39
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 15:15:19 -0700 (PDT)
In-Reply-To: <53977BC1.5000301@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Tomasz Figa <t.figa@samsung.com>

On 10 June 2014 23:42, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 10.06.2014 23:27, Greg Kroah-Hartman wrote:
>> On Tue, Jun 10, 2014 at 11:27:45PM +0200, Rafael J. Wysocki wrote:
>>> On Tuesday, June 10, 2014 02:53:26 PM Ulf Hansson wrote:
>>>> On 10 June 2014 14:11, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>> On Tue, Jun 10, 2014 at 12:51 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>> From: Tomasz Figa <t.figa@samsung.com>
>>>>>>
>>>>>> On a number of platforms, devices are part of controllable power
>>>>>> domains, which need to be enabled before such devices can be accessed
>>>>>> and may be powered down when the device is idle to save some power.
>>>>>> This means that on systems that support power domain control using
>>>>>> generic power domains subsystem, it is necessary to add device to its
>>>>>> power domain before binding a driver to it and remove it from its power
>>>>>> domain after its driver is unbound to make sure that an unused device
>>>>>> does not affect power domain state.
>>>>>>
>>>>>> Since this is not limited to particular busses and specific
>>>>>> archs/platforms,
>>>>>
>>>>> Actually, this isn't correrct.  It is limited to the platforms that
>>>>> use Device Trees now.
>>>>
>>>> Correct, we should update the commit message/docs.
>>>>
>>>>>
>>>>> Moreover, it is not consistent with the way we add devices to the ACPI PM
>>>>> domain, which is the ACPI counterpart of this.
>>>>
>>>> I am not sure why you think consistency for ACPI is important here.
>>>> ACPI PM will still be able to handle it's domain/device registering as
>>>> before. There are even other pm_domains that don't use genpd which
>>>> need to handle this themselves.
>>>
>>> My point is that doing things like that in different places for different
>>> firmware interfaces is confusing and likely to lead to coding mistakes in
>>> the future.
>>>
>>>> Or are you saying that you prefer bus notifiers in favour of making
>>>> use of the driver core for this matter?
>>>
>>> Well, please grep for acpi_dev_pm_attach() and see where it is done.
>>> Surely not in drivers/base/dd.c.  Also I'm not sure why you're talking
>>> about bus notifiers in this context.
>>>
>>>> Shouldn't the driver core handle most of the common things for a device
>>>> driver?
>>>
>>> Common, yes.  Platform-specific, no.
>>>
>>>> Let's compare how the pinctrls are being managed in the driver core, for
>>>> example.
>>>
>>> pinctrl has Device Trees support only at the moment (as far as firmware
>>> interfaces go) and quite frankly I'm not sure if/how we'll need to change
>>> it to cover ACPI as well.
>>>
>>> But for power domains, please keep that stuff away from dd.c.  That is,
>>> unless Greg specifically disagrees with me and decides to apply this
>>> patch regardless. :-)
>>
>> Nope, no disagreement from me toward you at all here, keep up the good
>> work :)
>
> OK, so proposed solution is to put this in:
>
> - platform_drv_probe(),
> - spi_drv_probe(),
> - i2c_device_probe(),
> - amba_probe(),
>
> ...
>
> - and any other bus type, which can have devices instantiated from DT.
>
> If this is what you mean, I still think putting this in dd is cleaner
> and more scalable, but I'm not going to insist, as I believe you have
> good reasons to prefer this approach over current one.

I am not so sure we should ignore scalability.

Currently there are SoCs those that uses bus notifiers to handle the
device registration for it's pm_domain. When each of them converts to
use bus' ->probe() function instead, they will have their own version
of acpi_dev_pm_attach(), and the scalability becomes an issue.

An option could be to invent a common "pm_domain_attach_dev() API",
which will check what kind of power domain the device may reside in.
In principle invoke acpi_dev_pm_attach() and if no attachment happens,
try genpd_bind_domain().

Kind regards
Ulf Hansson
