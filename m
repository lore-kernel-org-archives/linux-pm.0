From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Sleep: Fall back to subsystem level PM callbacks for
 PM domains
Date: Wed, 21 May 2014 11:36:20 +0200
Message-ID: <CAPDyKFrW3JTQCZGJjQ8132OFdN4TaE-_EdDEO7wcBMmVCjCyiQ@mail.gmail.com>
References: <1398422695-2295-1-git-send-email-ulf.hansson@linaro.org>
	<1753685.C73DLtyD2t@vostro.rjw.lan>
	<1679843.u9z8cZFExt@vostro.rjw.lan>
	<CAPDyKFr_1CJZ3KAwAbrzeoW0me1SjqC221Kb=_4RnaXa8Uh_gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:57828 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaEUJgV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 05:36:21 -0400
Received: by mail-qc0-f181.google.com with SMTP id m20so2706583qcx.26
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2014 02:36:20 -0700 (PDT)
In-Reply-To: <CAPDyKFr_1CJZ3KAwAbrzeoW0me1SjqC221Kb=_4RnaXa8Uh_gA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>

On 30 April 2014 14:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 30 April 2014 00:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, April 30, 2014 12:47:28 AM Rafael J. Wysocki wrote:
>>> On Friday, April 25, 2014 12:44:55 PM Ulf Hansson wrote:
>>> > Previously once the PM core found a PM domain pointer for a device,
>>> > but which didn't have a valid PM callback, it falled back to try the
>>> > driver's PM callback.
>>> >
>>> > In this scenario, change the behavior of the PM core to try out the
>>> > other subsystem level PM callbacks, before it moves on to the driver.
>>> >
>>> > This gives provision for PM domains to easier re-use subsystem level
>>> > code to handle the needed operations.
>>> >
>>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> Are you sure this is not going to break the existing PM domains?
>
> I have checked the current implementations of the PM domains - all are
> providing the PM callbacks. So this should be safe.
>
>>
>> And even if it isn't, the idea behind PM domains was to provide a mechanism to
>> bypass the bus types' (etc) PM callbacks, so I'm not liking this patch at all.
>
> I understand your view, it's the current mindset we have of the
> hierarchy of handling the callbacks. I am wondering if it's time to
> reconsider. :-)
>
> To be clear, I don't want to prevent the PM domain from bypassing bus,
> types etc, that's should be up to each implementation to decide, and
> this patch won't affect that behaviour.
>
> I intend to only simplify for those PM domains that want to re-use the
> callbacks from bus, types. etc. Currently that's the most of them.
>
> a)
> Those ARM SOCs that implements PM domains, which don't use the generic
> power domain, cares only about platform devices attached to the
> platform_bus_type. These are copying the callbacks from the
> platform_bus_type (using the USE_PLATFORM_PM_SLEEP_OPS macro)  - I
> assume this is because they need to handle legacy suspend/resume.
>
> arch/arm/mach-davinci/pm_domain.c
> arch/arm/mach-keystone/pm_domain.c
> arch/arm/mach-omap1/pm_bus.c
> arch/arm/mach-omap2/omap_device.c
> drivers/sh/pm_runtime.c
>
> b)
> An actual copy of the bus' PM callbacks to the PM domain's callbacks also exist.
>
> drivers/gpu/vga/vga_switcheroo.c:
> vga_switcheroo_init_domain_pm_ops()
> vga_switcheroo_init_domain_pm_optimus_hdmi_audio()
>
> c)
> That leaves the generic power domain and acpi power domain, which
> don't re-use callbacks, but have their own set.
>
>
> The more complicated scenario have not yet been implemented - but I
> can see it coming. :-)
> That's when the PM domain wants to re-use callbacks for whatever bus,
> types etc, the device is attached to.
>
> To handle this, the PM domain will have to re-implement the code for
> walking the hierarchy of callbacks, which is a bit messy. This patch
> will make it possible for the PM domain to rely on the PM core to
> handle this instead.
>

Hi Rafael,

Just wanted to understand if you are still considering this patch or
if think it's the wrong approach?

Kind regards
Ulf Hansson
