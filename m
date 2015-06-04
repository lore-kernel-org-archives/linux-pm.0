From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM / Domains: Infinite loop during reboot
Date: Thu, 4 Jun 2015 11:13:32 +0200
Message-ID: <CAPDyKFpD6XMOjveqJ79_ivj4++=b7z4ST2=wgQoix40HO6mvxQ@mail.gmail.com>
References: <CAMuHMdVAnZ5mH7EwJKVeKWSDqCxn+TSH1VOHoK3B2=b8oByoHg@mail.gmail.com>
	<CAMuHMdUTirgF7Qk2uMPYnejCOa14Khi=Sn8-y23TsRyJrFT-6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUTirgF7Qk2uMPYnejCOa14Khi=Sn8-y23TsRyJrFT-6A@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 5 May 2015 at 15:49, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 13, 2015 at 2:18 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Sometimes reboot doesn't work on r8a7791/koelsch with the CPG clock domain.
>> With additional debug messages, you can see it hangs in an infinite loop:
>>
>> rcar-dmac ec720000.dma-controller: removing from PM domain cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
>> [...]
>>
>> Presumably this is this loop in genpd_dev_pm_detach():
>>
>>         while (1) {
>>                 ret = pm_genpd_remove_device(pd, dev);
>>                 if (ret != -EAGAIN)
>>                         break;
>>                 cond_resched();
>>         }
>>
>> which is retried because genpd->prepared_count > 0 in pm_genpd_remove_device().
>> This looks a bit strange, as no suspend is in progress, so prepared_count
>> should be zero?
>>
>> I'm adding more debugging code to verify this, but it's not 100% reproducable.
>>
>> [...]
>>
>> Confirmed: prepared_count turns out to be 1 at reboot time if at least one
>> s2ram cycle happened before. Additional s2ram cycles don't seem to increase
>> prepared_count any further.
>
> This seems to be caused by the sh_cmt driver's sh_cmt_enable() calling
> dev_pm_syscore_device(..., true).
>
> If dev->power.syscore is set, device_prepare(), device_complete() et al.
> skip further operation.
>
> Hence during an s2ram+resume cycle, the following happens:
>
>     PM: Syncing filesystems ... done.
>     PM: Preparing system for mem sleep
>     Freezing user space processes ... (elapsed 0.001 seconds) done.
>     Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>     PM: Entering mem sleep
>     Suspending console(s) (use no_console_suspend to debug)
>
>     [ pm_genpd_prepare() is called for all devices (incl. sh_cmt), ]
>     [ increasing prepared_count ]
>
>     PM: suspend of devices complete after 36.472 msecs
>     PM: late suspend of devices complete after 7.569 msecs
>     PM: noirq suspend of devices complete after 8.035 msecs
>     Disabling non-boot CPUs ...
>     CPU1: shutdown
>
>     [ sh_cmt_enable() is called, and power.syscore becomes true ]
>
>     Enabling non-boot CPUs ...
>     CPU1 is up
>     PM: noirq resume of devices complete after 4.724 msecs
>     PM: early resume of devices complete after 5.100 msecs
>     PM: resume of devices complete after 84.156 msecs
>
>     [ pm_genpd_complete() is called for all devices (except for sh_cmt!, ]
>     [ as its power.syscore is now true!), decreasing prepared_count ]
>
>     [ prepared_count is now 1 instead of 0! ]
>
>     PM: Finishing wakeup.
>     Restarting tasks ...
>
> During subsequent s2ram+resume cycles, the prepared_count imbalance doesn't
> increase, as pm_genpd_prepare() is no longer called for sh_cmt due to
> power.syscore still being set.
>
> During reboot/halt, platform_drv_shutdown() is called for any platform device
> that has a driver with a .shutdown() method (on R-Car Gen2, that's just the
> rcar-dmac driver). platform_drv_shutdown() calls dev_pm_domain_detach(),
> which enters an infinite loop, due to the prepared_count imbalance.
>
> On R-Mobile, the imbalance also happens. But there it doesn't cause any issues
> as sh_cmt is part of a PM domain that doesn't contain any devices with drivers
> that have .shutdown() methods.
>
> I see two ways to fix this:
>   1. Fix the prepared_count imbalance.
>      Anyone with a clue?

Hi Geert,

Sorry for the delayed answer. I don't have an idea for 1), yet.

>   2. Fix the infinite loop.
>        a. Limit the loop to a fixed number of retries (e.g. 20),
>        b. Remove the call to dev_pm_domain_detach() from
>           platform_drv_shutdown(). Others buses (amba, i2c, spi) do not call
>           it from their .shutdown() method, only from .remove().

The reason why I added dev_pm_domain_detach() in that path was because
of the call to acpi_dev_pm_detach() that existed there already.

acpi_dev_pm_detach was added by Rafael in commit
94d76d5de38d7502c3e78fcd6bf50da95e3e0361 (platform / ACPI:
Attach/detach ACPI PM during probe/remove/shutdown).

>From genpd point of view, I think it safe to remove the call to
dev_pm_domain_detach() from platform_drv_shutdown(), but I can't tell
from ACPI point of view.

Moreover, we still need to looking into 1), as it's probably causing
other issues as well.

Kind regards
Uffe
