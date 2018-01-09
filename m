From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 9 Jan 2018 17:03:18 +0100
Message-ID: <CAJZ5v0gzAPkHjWEt0Vog+HcbObXSy6nqmsL1_-LT6+F3u7TPSQ@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <303007688.lvsDLFNCpe@aspire.rjw.lan>
 <CAMuHMdX=rc4M9oO0dFQ9b2TtRgUXRG_37sw+MVJ3REeAa-0ogw@mail.gmail.com>
 <CAJZ5v0gvN4DDgLUfHftpJ+Mj5nPkhaKBqadzPtvLXpWs9M6nqA@mail.gmail.com> <CAMuHMdUQQ_iH=HczLNoCsrbmEAG=7BKFEQbspg=SUYczt_4-WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUQQ_iH=HczLNoCsrbmEAG=7BKFEQbspg=SUYczt_4-WA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 9, 2018 at 4:30 PM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Rafael,
>
> CC usb
>
> On Tue, Jan 9, 2018 at 4:00 PM, Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Tue, Jan 9, 2018 at 2:37 PM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>>> On Wed, Jan 3, 2018 at 12:06 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>>>
>>>> One of the limitations of pm_runtime_force_suspend/resume() is that
>>>> if a parent driver wants to use these functions, all of its child
>>>> drivers have to do that too because of the parent usage counter
>>>> manipulations necessary to get the correct state of the parent during
>>>> system-wide transitions to the working state (system resume).
>>>> However, that limitation turns out to be artificial, so remove it.
>>>>
>>>> Namely, pm_runtime_force_suspend() only needs to update the children
>>>> counter of its parent (if there's is a parent) when the device can
>>>> stay in suspend after the subsequent system resume transition, as
>>>> that counter is correct already otherwise.  Now, if the parent's
>>>> children counter is not updated, it is not necessary to increment
>>>> the parent's usage counter in that case any more, as long as the
>>>> children counters of devices are checked along with their usage
>>>> counters in order to decide whether or not the devices may be left
>>>> in suspend after the subsequent system resume transition.
>>>>
>>>> Accordingly, modify pm_runtime_force_suspend() to only call
>>>> pm_runtime_set_suspended() for devices whose usage and children
>>>> counters are at the "no references" level (the runtime PM status
>>>> of the device needs to be updated to "suspended" anyway in case
>>>> this function is called once again for the same device during the
>>>> transition under way), drop the parent usage counter incrementation
>>>> from it and update pm_runtime_force_resume() to compensate for these
>>>> changes.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>>
>>> This patch causes a regression during system resume on Renesas Salvator-XS
>>> with R-Car H3 ES2.0:
>>
>> I have dropped it for now, but we need to address the underlying issue.
>>
>>>     SError Interrupt on CPU3, code 0xbf000002 -- SError
>>>     SError Interrupt on CPU2, code 0xbf000002 -- SError
>>>     CPU: 3 PID: 1769 Comm: kworker/u16:13 Not tainted
>>> 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>>>     CPU: 2 PID: 1774 Comm: kworker/u16:18 Not tainted
>>> 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>>>     Hardware name: Renesas Salvator-X 2nd version board based on
>>> r8a7795 ES2.0+ (DT)
>>>     Hardware name: Renesas Salvator-X 2nd version board based on
>>> r8a7795 ES2.0+ (DT)
>>>     Workqueue: events_unbound async_run_entry_fn
>>>     Workqueue: events_unbound async_run_entry_fn
>>>     pstate: 60000005 (nZCv daif -PAN -UAO)
>>>     pstate: 60000005 (nZCv daif -PAN -UAO)
>>>     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>>>     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>>>     lr : phy_init+0x64/0xcc
>>>     lr : phy_init+0x64/0xcc
>>>     ...
>>>     Kernel panic - not syncing: Asynchronous SError Interrupt
>>>
>>> Note that before, it printed a warning instead:
>>>
>>>     Enabling runtime PM for inactive device (ee0a0200.usb-phy) with
>>> active children
>>>     WARNING: CPU: 0 PID: 1741 at drivers/base/power/runtime.c:1300
>>> pm_runtime_enable+0x94/0xd8
>>>
>>> Reverting commit 0408584d580d4a2c ("PM / runtime: Rework
>>> pm_runtime_force_suspend/resume()") fixes the crash.
>>>
>>> Note that applying Ulf's "[PATCH v2 0/3] phy: core: Re-work runtime PM
>>> deployment and fix an issue"
>>> (https://www.spinics.net/lists/linux-renesas-soc/msg21719.html) instead
>>> does not fix the crash.
>>
>> OK
>>
>>> With more debug code added, it seems the EHCI module clocks (701-703) are
>>> enabled earlier than before. I guess this triggers the workqueue to perform
>>> an operation while another related device (HSUSB 704?) is still disabled?
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
> Something fishy is going on. Status of the USB PHYs differ before/after
> system suspend, according to /sys/kernel/debug/pm_genpd/pm_genpd_summary:
>
> -    /devices/platform/soc/ee0a0200.usb-phy              active
> -    /devices/platform/soc/ee0c0200.usb-phy              active
> -    /devices/platform/soc/ee080200.usb-phy              active
> +    /devices/platform/soc/ee0a0200.usb-phy              suspended
> +    /devices/platform/soc/ee0c0200.usb-phy              suspended
> +    /devices/platform/soc/ee080200.usb-phy              suspended

Yeah.

That's because of the pm_runtime_force_suspend/resume() called by
genpd.  These functions generally may cause devices active before
system suspend to be left in suspend after it.  That generally is a
good idea if the device was not really in use before the system
suspend, but there is a problem that the driver of it may not be
prepared for that to happen (and also the way to determine the "not
really in use" case may not be as expected by the driver).

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
