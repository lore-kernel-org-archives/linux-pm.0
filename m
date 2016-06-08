From: Mason <slash.tmp@free.fr>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Wed, 8 Jun 2016 18:26:30 +0200
Message-ID: <57584736.7020201@free.fr>
References: <Pine.LNX.4.44L0.1606071055010.1604-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:64346 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757635AbcFHQ1A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jun 2016 12:27:00 -0400
In-Reply-To: <Pine.LNX.4.44L0.1606071055010.1604-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

On 07/06/2016 17:06, Alan Stern wrote:

> On Tue, 7 Jun 2016, Mason wrote:
>
>> Another point of confusion for me is this: drivers are supposed to
>> be shared among platforms, right? So my platform-specific suspend
>> code should be enabled only if my platform is detected at run-time?
> 
> Is your device platform-specific?  If it is then the driver is also
> platform-specific, and so no part of the driver will be called at
> runtime unless your platform is detected.

Specifically, my platform uses
drivers/net/ethernet/aurora/nb8800.c  => 3 entries in of_match_table.
drivers/tty/serial/8250/8250_core.c (CONFIG_SERIAL_8250_RT288X variant)

and also the XHCI USB3 driver, and AHCI SATA driver, wouldn't I need to
save the context for these too?

> If the device isn't platform-specific then the driver has to work on a 
> bunch of different platforms.  It should be written to be 
> platform-independent as much as possible.
> 
>> So this means I need to add in the probe function, for every driver
>> my platform uses:
>>
>>   if (platform == MY_PLATFORM) {
>>     ops.suspend = my_suspend;
>>     ops.resume  = my_resume;
>>   }
>>
>> Is that correct?
> 
> No.  For one thing, you only have to worry about the 
> platform-independent drivers -- you know that the platform-specific 
> ones won't get used unless your platform is present.

I guess the thermal driver is platform-specific, but most devices
are third-party IP blocks, so there is a "common" driver upstream.
But I would need a platform-specific suspend/resume sequence,
just for my platform.

> For another, the driver should be written in a way that doesn't require
> this sort of code.  The ops pointer (not any of the structure's members
> -- a pointer to the structure) should be set by the platform-dependent
> part of the driver that handles initialization.

I don't understand. If my platform loses context on suspend, then
I must save/restore it. But this wasteful operation should not be
imposed on other platforms.

Regards.
