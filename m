From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Fri, 12 Jan 2018 12:20:29 +0100
Message-ID: <CAMuHMdV8swqU+ubh9ybBR5kC1zMnn2M1qkmMGqY_Y+hJf56XWg@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <CAMuHMdX=rc4M9oO0dFQ9b2TtRgUXRG_37sw+MVJ3REeAa-0ogw@mail.gmail.com>
 <CAJZ5v0gvN4DDgLUfHftpJ+Mj5nPkhaKBqadzPtvLXpWs9M6nqA@mail.gmail.com> <23692721.edtBXv1IdE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40112 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeALLUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 06:20:30 -0500
In-Reply-To: <23692721.edtBXv1IdE@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Rafael,

On Tue, Jan 9, 2018 at 5:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, January 9, 2018 4:00:35 PM CET Rafael J. Wysocki wrote:
>> On Tue, Jan 9, 2018 at 2:37 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > On Wed, Jan 3, 2018 at 12:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>
>> >> One of the limitations of pm_runtime_force_suspend/resume() is that
>> >> if a parent driver wants to use these functions, all of its child
>> >> drivers have to do that too because of the parent usage counter
>> >> manipulations necessary to get the correct state of the parent during
>> >> system-wide transitions to the working state (system resume).
>> >> However, that limitation turns out to be artificial, so remove it.
>> >>
>> >> Namely, pm_runtime_force_suspend() only needs to update the children
>> >> counter of its parent (if there's is a parent) when the device can
>> >> stay in suspend after the subsequent system resume transition, as
>> >> that counter is correct already otherwise.  Now, if the parent's
>> >> children counter is not updated, it is not necessary to increment
>> >> the parent's usage counter in that case any more, as long as the
>> >> children counters of devices are checked along with their usage
>> >> counters in order to decide whether or not the devices may be left
>> >> in suspend after the subsequent system resume transition.
>> >>
>> >> Accordingly, modify pm_runtime_force_suspend() to only call
>> >> pm_runtime_set_suspended() for devices whose usage and children
>> >> counters are at the "no references" level (the runtime PM status
>> >> of the device needs to be updated to "suspended" anyway in case
>> >> this function is called once again for the same device during the
>> >> transition under way), drop the parent usage counter incrementation
>> >> from it and update pm_runtime_force_resume() to compensate for these
>> >> changes.
>> >>
>> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > This patch causes a regression during system resume on Renesas Salvator-XS
>> > with R-Car H3 ES2.0:
>>
>> I have dropped it for now, but we need to address the underlying issue.
>>
>> >     SError Interrupt on CPU3, code 0xbf000002 -- SError
>> >     SError Interrupt on CPU2, code 0xbf000002 -- SError
>> >     CPU: 3 PID: 1769 Comm: kworker/u16:13 Not tainted
>> > 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>> >     CPU: 2 PID: 1774 Comm: kworker/u16:18 Not tainted
>> > 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>> >     Hardware name: Renesas Salvator-X 2nd version board based on
>> > r8a7795 ES2.0+ (DT)
>> >     Hardware name: Renesas Salvator-X 2nd version board based on
>> > r8a7795 ES2.0+ (DT)
>> >     Workqueue: events_unbound async_run_entry_fn
>> >     Workqueue: events_unbound async_run_entry_fn
>> >     pstate: 60000005 (nZCv daif -PAN -UAO)
>> >     pstate: 60000005 (nZCv daif -PAN -UAO)
>> >     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>> >     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>> >     lr : phy_init+0x64/0xcc
>> >     lr : phy_init+0x64/0xcc
>> >     ...
>> >     Kernel panic - not syncing: Asynchronous SError Interrupt
>> >
>> > Note that before, it printed a warning instead:
>> >
>> >     Enabling runtime PM for inactive device (ee0a0200.usb-phy) with
>> > active children
>> >     WARNING: CPU: 0 PID: 1741 at drivers/base/power/runtime.c:1300
>> > pm_runtime_enable+0x94/0xd8
>> >
>> > Reverting commit 0408584d580d4a2c ("PM / runtime: Rework
>> > pm_runtime_force_suspend/resume()") fixes the crash.
>> >
>> > Note that applying Ulf's "[PATCH v2 0/3] phy: core: Re-work runtime PM
>> > deployment and fix an issue"
>> > (https://www.spinics.net/lists/linux-renesas-soc/msg21719.html) instead
>> > does not fix the crash.
>>
>> OK
>>
>> > With more debug code added, it seems the EHCI module clocks (701-703) are
>> > enabled earlier than before. I guess this triggers the workqueue to perform
>> > an operation while another related device (HSUSB 704?) is still disabled?
>>
>> Probably.
>>
>> Likely a device that wasn't resumed before resumes now and that causes
>> the issue to appear.
>>
>> I'm wondering if adding the ignore_children check to the patch helps.
>> If not, there clearly is a resume ordering issue that is papered over
>> by the current code.
>
> Below is an alternative version of the patch that caused the problem
> to happen which checks the ignore_children flag of the device.  It may
> avoid the issue by accident, but then I'd rather make it not happen. :-)

So the delta with the previous version is:

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1616,7 +1616,8 @@ void pm_runtime_drop_link(struct device *dev)
 static bool pm_runtime_need_not_resume(struct device *dev)
 {
        return atomic_read(&dev->power.usage_count) <= 1 &&
-               atomic_read(&dev->power.child_count) == 0;
+               (atomic_read(&dev->power.child_count) == 0 ||
+                dev->power.ignore_children);
 }

 /**

> Please try this patch anyway, though, and let me know if the crash is still
> there.

Unfortunately it still fails the same way.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
