From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 8/9] mmmc: core: Keep PM domain powered during ->probe()
 of SDIO func driver
Date: Mon, 16 Mar 2015 09:24:41 +0100
Message-ID: <CAPDyKFrLnpKGX6f+0s0JYCGRinGfJtEEAcp7VpRvKoo7ZNy3Qw@mail.gmail.com>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
	<1426261429-31883-9-git-send-email-ulf.hansson@linaro.org>
	<20150313161014.GR8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:36781 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbbCPIYm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 04:24:42 -0400
Received: by qcto4 with SMTP id o4so37137762qct.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2015 01:24:42 -0700 (PDT)
In-Reply-To: <20150313161014.GR8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 13 March 2015 at 17:10, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 13, 2015 at 04:43:48PM +0100, Ulf Hansson wrote:
>> To sucessfully probe some devices their corresponding PM domains may
>> need to be powered.
>>
>> Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
>> domain.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/sdio_bus.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
>> index 71357b8..0d89b4b 100644
>> --- a/drivers/mmc/core/sdio_bus.c
>> +++ b/drivers/mmc/core/sdio_bus.c
>> @@ -320,7 +320,14 @@ int sdio_add_func(struct sdio_func *func)
>>       if (ret)
>>               return ret;
>>
>> +     ret = dev_pm_domain_get(func->dev.pm_domain);
>> +     if (ret) {
>> +             dev_pm_domain_detach(&func->dev, false);
>> +             return ret;
>> +     }
>> +
>>       ret = device_add(&func->dev);
>> +     dev_pm_domain_put(func->dev.pm_domain);
>
> This is broken.  It assumes that the device will be probed in device_add().
> That's not always the case.  Come on Ulf, I'm dismayed at you producing
> bad and fragile patches like this.  You are the apparent maintainer for
> several important subsystems, and you are putting yourself up for more,
> yet you don't seem to know the basics about the kernel infrastructure.
> That makes you dangerous.
>
> Look, device_add() adds the device to the list of available devices,
> publishes it in sysfs, triggers a uevent, and tries to find a driver to
> bind it to.
>
> If it doesn't find a driver already registered in the kernel, that could
> be because the required driver is a module.  In that case, device_add()
> will already have returned.
>
> At some point later, the module will be loaded by user space, and that
> will cause the list of devices to be scanned, looking for devices which
> the newly registered driver can bind to.  With your code above, these
> will _not_ result in the PM domain being "got" before probing.
>

Indeed this is broken, thank you for spotting this!

For sure I know how the driver model works,  but I have mistakenly
looked past this for the sdio_bus.

Commit 397a0253527a (mmc: sdio: Convert to
dev_pm_domain_attach|detach()), should not only have converted to the
new APIs but also moved the calls into sdio_bus' ->probe() and
->remove() callbacks.

I will fix this, in one way or the other.

Kind regards
Uffe
