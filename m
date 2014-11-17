From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 18:54:44 +0200
Message-ID: <546A2854.3020204@ti.com>
References: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org> <20141117153257.GS4042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59385 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbaKQQzj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Nov 2014 11:55:39 -0500
In-Reply-To: <20141117153257.GS4042@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org

Hi Russell,

On 11/17/2014 05:32 PM, Russell King - ARM Linux wrote:
> On Mon, Nov 17, 2014 at 04:19:10PM +0100, Ulf Hansson wrote:
>> The amba bus, amba drivers and a vast amount of platform drivers which
>> enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
>> their devices.
>>
>> Instead, once they have turned on their PM resourses during ->probe()
>> and are ready to handle I/O, these invokes pm_runtime_set_active() to
>> synchronize its state towards the runtime PM core.
> 
> The above is misleading for amba.  The code sequence is:
> 
>                  pm_runtime_get_noresume(dev);
>                  pm_runtime_set_active(dev);
>                  pm_runtime_enable(dev);
> 
>                  ret = pcdrv->probe(pcdev, id);
> 
> AMBA drivers should never call pm_runtime_set_active(), as the runtime PM
> state has already been initialised by the bus code.  Platform drivers are
> different; the platform code provides zero help for runtime PM.
> 
> The sequence used by AMBA bus code is the sequence which was used by PCI
> (as per commit f3ec4f87d607) at the time the runtime PM support was
> written for AMBA.  PCI assumes that unbound devices are already powered
> up, and as far as I'm aware, that's also true of AMBA devices as well.
> I have yet to have access to a platform where this isn't true, neither
> has anyone reported that such a platform exists.
> 

I'd be very appreciated if you would be able to clarify one point to me as
I'm not familiar with amba hw?

I've found at least 2 AMBA drivers where secondary clock is used 
to enable/disable device in addition to "apb_pclk":
 - drivers/mmc/host/mmci.c 
 - drivers/spi/spi-pl022.c
So, form the code point of view, the assumption that "unbound AMBA devices are
already powered up" is not always true. And "apb_pclk" is just an interface clock
in such cases. 
>From another side above statement is true for mailbox/pl320-ipc.c which seems like
is simple device.
Am I wrong?

Thanks in advance. 

regards,
-grygorii

