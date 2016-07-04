From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Mon, 4 Jul 2016 15:57:50 +0200
Message-ID: <CAMuHMdU+nGmU0TJXtRxvfjsdFokhsh3e0m1DPXnU20k141BN5Q@mail.gmail.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
 <1463485296-22742-5-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdVM66516s_+Ups7fng5xpasdiUnW=3Ybz+vGHbgN+5mpQ@mail.gmail.com> <CAPDyKFotR6dk+ntMWH4nCjg2mFJe3YzVqw=M-6Vy7b8tdMFxsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34551 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbcGDN5w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2016 09:57:52 -0400
In-Reply-To: <CAPDyKFotR6dk+ntMWH4nCjg2mFJe3YzVqw=M-6Vy7b8tdMFxsw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf,

On Wed, Jun 29, 2016 at 7:30 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 28 June 2016 at 18:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> This patch (commit eb13a0a1b6d5d5c2 in pm/linux-next) breaks resume on
>
> Thanks for reporting!
>
>> sh73a0/kzm9g and r8a73a4/ape6evm. On these boards, the Ethernet controller is a
>> child of a local bus (bsc), whose clock (zb) is controlled through pm_clk and
>> simple-pm-bus, cfr.
>>
>>     arch/arm/boot/dts/r8a73a4-ape6evm.dts
>>     arch/arm/boot/dts/r8a73a4.dtsi
>>     arch/arm/boot/dts/sh73a0-kzm9g.dts
>>     arch/arm/boot/dts/sh73a0.dtsi
>>
>> During resume, the bus clock is not enabled, causing an imprecise abort
>> when accessing the Ethernet controller's registers. With some debug code
>> added:
>
> I was looking into this in some more detail.
>
> As you are stating that Ethernet device is a child device to the local
> bus device, I would have expected that the pm_runtime_get_sync()
> invoked during ->probe() in the Ethernet driver should cause its
> parent device (the bus device) to be "forced" resumed.
>
> That's because the pm_runtime_get_sync() should trigger an increased
> usage count of the parent device. Later, when
> pm_runtime_force_resume() validates the count for the bus device, it
> should be 2 and thus it should lead to that it decides to *not* defer
> the resume of the device. Apparently this isn't happening for some
> reason...
>
> Perhaps there's a pm_suspend_ignore_children() set for the parent?
> Or perhaps the parent/child relationship isn't set up correctly?

No, ignore_children = 0. I've dumped all fields from the bus' prepare
callback I had added for Kevin's test:

PM: Suspending system (mem)
simple-pm-bus fec10000.bus: simple_pm_bus_prepare
can_wakeup = 0
async_suspend = 0
is_prepared = 0
is_suspended = 0
is_noirq_suspended = 0
is_late_suspended = 0
early_init = 1
direct_complete = 0
wakeup_path = 0
syscore = 0
no_pm_callbacks = 0
timer_expires = 0
usage_count = 1
child_count = 1
disable_depth = 0
idle_notification = 0
request_pending = 0
deferred_resume = 0
run_wake = 0
runtime_auto = 1
ignore_children = 0
no_callbacks = 0
irq_safe = 0
use_autosuspend = 0
timer_autosuspends = 0
memalloc_noio = 1
request = 0
runtime_status = 0
runtime_error = 0
autosuspend_delay = 0
last_busy = 4294937777
active_jiffies = 0
suspended_jiffies = 430
accounting_timestamp = 4294937777
PM: suspend of devices complete after 4.394 msecs

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
