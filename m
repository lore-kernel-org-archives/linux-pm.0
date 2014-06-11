From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 02/24] drivercore: Bind/unbind power domain on probe/remove
Date: Wed, 11 Jun 2014 20:19:56 +0200
Message-ID: <53989DCC.9050109@gmail.com>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>	<CAJZ5v0hUT0QPGWeDM9WoxnobaL5eoNi5UFrUUZrQ1gSBCX=aVg@mail.gmail.com>	<CAPDyKFqWZdA4ZisJvCDP8j6D2_A8oRAHkjikddyGSwpToFg-Gw@mail.gmail.com>	<1894835.cKK4602bPf@vostro.rjw.lan> <20140610212731.GA11191@kroah.com>	<53977BC1.5000301@gmail.com> <7h38fbia65.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:51079 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbaFKSUQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 14:20:16 -0400
In-Reply-To: <7h38fbia65.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Tomasz Figa <t.figa@samsung.com>



On 11.06.2014 20:16, Kevin Hilman wrote:
> Tomasz Figa <tomasz.figa@gmail.com> writes:
> 
>> On 10.06.2014 23:27, Greg Kroah-Hartman wrote:
>>> On Tue, Jun 10, 2014 at 11:27:45PM +0200, Rafael J. Wysocki wrote:
>>>> On Tuesday, June 10, 2014 02:53:26 PM Ulf Hansson wrote:
>>>>> On 10 June 2014 14:11, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>> On Tue, Jun 10, 2014 at 12:51 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>>> From: Tomasz Figa <t.figa@samsung.com>
>>>>>>>
>>>>>>> On a number of platforms, devices are part of controllable power
>>>>>>> domains, which need to be enabled before such devices can be accessed
>>>>>>> and may be powered down when the device is idle to save some power.
>>>>>>> This means that on systems that support power domain control using
>>>>>>> generic power domains subsystem, it is necessary to add device to its
>>>>>>> power domain before binding a driver to it and remove it from its power
>>>>>>> domain after its driver is unbound to make sure that an unused device
>>>>>>> does not affect power domain state.
>>>>>>>
>>>>>>> Since this is not limited to particular busses and specific
>>>>>>> archs/platforms,
>>>>>>
>>>>>> Actually, this isn't correrct.  It is limited to the platforms that
>>>>>> use Device Trees now.
>>>>>
>>>>> Correct, we should update the commit message/docs.
>>>>>
>>>>>>
>>>>>> Moreover, it is not consistent with the way we add devices to the ACPI PM
>>>>>> domain, which is the ACPI counterpart of this.
>>>>>
>>>>> I am not sure why you think consistency for ACPI is important here.
>>>>> ACPI PM will still be able to handle it's domain/device registering as
>>>>> before. There are even other pm_domains that don't use genpd which
>>>>> need to handle this themselves.
>>>>
>>>> My point is that doing things like that in different places for different
>>>> firmware interfaces is confusing and likely to lead to coding mistakes in
>>>> the future.
>>>>
>>>>> Or are you saying that you prefer bus notifiers in favour of making
>>>>> use of the driver core for this matter?
>>>>
>>>> Well, please grep for acpi_dev_pm_attach() and see where it is done.
>>>> Surely not in drivers/base/dd.c.  Also I'm not sure why you're talking
>>>> about bus notifiers in this context.
>>>>
>>>>> Shouldn't the driver core handle most of the common things for a device
>>>>> driver?
>>>>
>>>> Common, yes.  Platform-specific, no.
>>>>
>>>>> Let's compare how the pinctrls are being managed in the driver core, for
>>>>> example.
>>>>
>>>> pinctrl has Device Trees support only at the moment (as far as firmware
>>>> interfaces go) and quite frankly I'm not sure if/how we'll need to change
>>>> it to cover ACPI as well.
>>>>
>>>> But for power domains, please keep that stuff away from dd.c.  That is,
>>>> unless Greg specifically disagrees with me and decides to apply this
>>>> patch regardless. :-)
>>>
>>> Nope, no disagreement from me toward you at all here, keep up the good
>>> work :)
>>
>> OK, so proposed solution is to put this in:
>>
>> - platform_drv_probe(),
>> - spi_drv_probe(),
>> - i2c_device_probe(),
>> - amba_probe(),
>>
>> ...
>>
>> - and any other bus type, which can have devices instantiated from DT.
> 
> Since this is a DT feature, what about calling
> __pm_genpd_of_add_device()  when the power-domain nodes are discovered?

I'm not sure how this would work. Could you elaborate on this?

Best regards,
Tomasz
