From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 9 Jan 2018 20:02:19 +0100
Message-ID: <CAJZ5v0hgNUszYFxJXB30WquFDo9CPqn7J0h1bwSPEZZHzkHiWQ@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <303007688.lvsDLFNCpe@aspire.rjw.lan>
 <CAMuHMdX=rc4M9oO0dFQ9b2TtRgUXRG_37sw+MVJ3REeAa-0ogw@mail.gmail.com> <CAJZ5v0jVon9PjiDti106kT4s87GW6tuLKY=ZNfkE=eMqOwdDVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jVon9PjiDti106kT4s87GW6tuLKY=ZNfkE=eMqOwdDVA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 9, 2018 at 7:46 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jan 9, 2018 at 2:37 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Hi Rafael,
>>
>> On Wed, Jan 3, 2018 at 12:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>

[cut]

>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> This patch causes a regression during system resume on Renesas Salvator-XS
>> with R-Car H3 ES2.0:
>>
>>     SError Interrupt on CPU3, code 0xbf000002 -- SError
>>     SError Interrupt on CPU2, code 0xbf000002 -- SError
>>     CPU: 3 PID: 1769 Comm: kworker/u16:13 Not tainted
>> 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>>     CPU: 2 PID: 1774 Comm: kworker/u16:18 Not tainted
>> 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>>     Hardware name: Renesas Salvator-X 2nd version board based on
>> r8a7795 ES2.0+ (DT)
>>     Hardware name: Renesas Salvator-X 2nd version board based on
>> r8a7795 ES2.0+ (DT)
>>     Workqueue: events_unbound async_run_entry_fn
>>     Workqueue: events_unbound async_run_entry_fn
>>     pstate: 60000005 (nZCv daif -PAN -UAO)
>>     pstate: 60000005 (nZCv daif -PAN -UAO)
>>     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>>     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>>     lr : phy_init+0x64/0xcc
>>     lr : phy_init+0x64/0xcc
>>     ...
>>     Kernel panic - not syncing: Asynchronous SError Interrupt
>>
>> Note that before, it printed a warning instead:
>>
>>     Enabling runtime PM for inactive device (ee0a0200.usb-phy) with
>> active children
>>     WARNING: CPU: 0 PID: 1741 at drivers/base/power/runtime.c:1300
>> pm_runtime_enable+0x94/0xd8
>>
>> Reverting commit 0408584d580d4a2c ("PM / runtime: Rework
>> pm_runtime_force_suspend/resume()") fixes the crash.
>
> It looks like what happens without the Ulf's patch is as follows.
>
> usb-phy has children with runtime PM enabled that are not in the
> domain, so without the $subject patch the pm_runtime_force_suspend()
> in genpd_finish_suspend() checks the usage counter of usb-phy and
> since it is 1, the parent's usage counter is not incremented and
> genpd_runtime_suspend() is run for usb-phy.  On resume, the
> pm_runtime_force_resume() in genpd_resume_noirq() finds that the usage
> counter of usb-phy is 1, so the parent's usage counter is not
> decremented (correctly) and the function returns (arguably incorrectly
> if the runtime PM status of the children is "active", because it is
> necessary to resume the children in that case, but the children have
> no PM callbacks and even if they had had them, they would have been
> run later anyway).  The parent of usb-phy is skipped by the
> pm_runtime_force_resume() too, because its usage counter is 1 when it
> is checked by this function.

And note that it shouldn't be skipped by pm_runtime_force_resume() in
principle, because there are active children under usb-phy.

> With the $subject patch pm_runtime_force_suspend() in
> genpd_finish_suspend() calls pm_runtime_need_not_resume() and that
> returns "false" for usb-phy if the runtime PM status or at least one
> of its children is "active" (which it is for the "phy" devices).  That
> is correct, but for this reason the parent's children counter is not
> decremented and both usb-phy and its parent will be resumed by the
> subsequent pm_runtime_force_resume().
>
> The pm_runtime_force_resume() in genpd_resume(_noirq) now finds that
> pm_runtime_need_not_resume() returns "false" for both usb-phy and its
> parent and attempts to resume them both via genpd_runtime_resume()
> which is too early, because stuff they depend on hasn't been resumed
> yet.  That triggers the crash (so
> https://patchwork.kernel.org/patch/10152767/ will cause the crash to
> happen too).
>
> In conclusion, without the $subject patch it all works pretty much by
> accident, basically because the pm_runtime_force_resume()
> inadvertently decides to skip the resume of some devices which avoids
> the premature execution of genpd_runtime_resume() for them.
>
>> Note that applying Ulf's "[PATCH v2 0/3] phy: core: Re-work runtime PM
>> deployment and fix an issue"
>> (https://www.spinics.net/lists/linux-renesas-soc/msg21719.html) instead
>> does not fix the crash.
>
> I'm not sure why the crash is still there in this case,

It is there, because usb-phy itself is now reference-counted by the
phy layer, so its usage counter is greater than 1 in
genpd_finish_suspend() and its parent's children counter is not
decremented then.

Next, on resume, the pm_runtime_force_resume() in genpd_resume_noirq()
will attempt to resume both usb-phy and its parent via
genpd_runtime_suspend() and that (again) is too early.

I'm not sure, however, why the crash isn't there with
https://www.spinics.net/lists/linux-renesas-soc/msg21719.html alone,
because in theory it should be there too in that case.

Thanks,
Rafael
