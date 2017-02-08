From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Restore lock-less behaviour for the genpd syscore APIs
Date: Wed, 08 Feb 2017 13:06:02 +0100
Message-ID: <8013431.rZ86Yt4kzG@aspire.rjw.lan>
References: <1486482784-31734-1-git-send-email-ulf.hansson@linaro.org> <m27f51kg7l.fsf@baylibre.com> <CAPDyKFr1Pfx=jpRiti5KLXCOfBSBb5a5V69a9td=2fYVBEoHVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43100 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932092AbdBHMKv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2017 07:10:51 -0500
In-Reply-To: <CAPDyKFr1Pfx=jpRiti5KLXCOfBSBb5a5V69a9td=2fYVBEoHVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>

On Wednesday, February 08, 2017 01:06:21 PM Ulf Hansson wrote:
> On 7 February 2017 at 19:29, Kevin Hilman <khilman@baylibre.com> wrote:
> > Ulf Hansson <ulf.hansson@linaro.org> writes:
> >
> >> The commit ef4f7e2c8335 ("PM / Domains: Fix asynchronous execution of
> >> *noirq() callbacks") went too far, as it not only changed to use locks for
> >> the *noirq callbacks, but also for the genpd syscore APIs.
> >>
> >> This cause the following error, reported by Geert Uytterhoeven:
> >>
> >> "This causes the following BUG on all my Renesas arm32 boards, where the
> >> system timer is an IRQ safe device:
> >>
> >> BUG: sleeping function called from invalid context at
> >> kernel/locking/mutex.c:232
> >> in_atomic(): 0, irqs_disabled(): 128, pid: 1751, name: s2ram
> >> CPU: 0 PID: 1751 Comm: s2ram Not tainted
> >> 4.10.0-rc7-koelsch-05643-g27f4c73972a614fe #3354
> >> Hardware name: Generic R8A7791 (Flattened Device Tree)
> >> [<c020e9c4>] (unwind_backtrace) from [<c020a40c>] (show_stack+0x10/0x14)
> >> [<c020a40c>] (show_stack) from [<c03f9818>] (dump_stack+0x7c/0x9c)
> >> [<c03f9818>] (dump_stack) from [<c0240020>] (___might_sleep+0x124/0x160)
> >> [<c0240020>] (___might_sleep) from [<c06fedfc>] (mutex_lock+0x18/0x60)
> >> [<c06fedfc>] (mutex_lock) from [<c04de340>]
> >> (genpd_syscore_switch+0x2c/0x7c)
> >> [<c04de340>] (genpd_syscore_switch) from [<c05ec328>]
> >> (sh_cmt_clock_event_suspend+0x18/0x28)
> >> [<c05ec328>] (sh_cmt_clock_event_suspend) from [<c027f9a4>]
> >> (clockevents_suspend+0x40/0x54)
> >> [<c027f9a4>] (clockevents_suspend) from [<c0276d48>]
> >> (timekeeping_suspend+0x23c/0x278)
> >> [<c0276d48>] (timekeeping_suspend) from [<c04cbb88>]
> >> (syscore_suspend+0x88/0x138)
> >> [<c04cbb88>] (syscore_suspend) from [<c025f618>]
> >> (suspend_devices_and_enter+0x290/0x470)
> >> [<c025f618>] (suspend_devices_and_enter) from [<c025fa20>]
> >> (pm_suspend+0x228/0x280)
> >> [<c025fa20>] (pm_suspend) from [<c025e60c>] (state_store+0xac/0xcc)
> >> [<c025e60c>] (state_store) from [<c0340c4c>] (kernfs_fop_write+0x160/0x19c)
> >> [<c0340c4c>] (kernfs_fop_write) from [<c02e3054>] (__vfs_write+0x20/0x108)
> >> [<c02e3054>] (__vfs_write) from [<c02e4424>] (vfs_write+0xb8/0x144)
> >> [<c02e4424>] (vfs_write) from [<c02e5014>] (SyS_write+0x40/0x80)
> >> [<c02e5014>] (SyS_write) from [<c0206cc0>] (ret_fast_syscall+0x0/0x34)"
> >>
> >> To fix this problem, restore the lock-less behaviour. However only for the
> >> genpd syscore APIs.
> >>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Fixes: ef4f7e2c8335 ("PM / Domains: Fix asynchronous execution of *noirq() callbacks")
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > It's up to Rafael, but IMO, since this isn't yet in mainline, it would
> > be cleaner for the git history to revert the original, and rework the
> > patch to have just the relevant parts
> 
> Is a revert making it cleaner, as it will becomes three changes
> instead of two? :-)

Kevin probably meant dropping the original commit altogether with should
be easy enough to do. :-)

> 
> I guess the only way to make the git history really clean, is whether
> Rafael can re-base his branch, and then squash this change into the
> commit it states to fix.
> 
> Anyway, I fine with any way. Seems like Rafael, will have to tell me what to do.

Frankly, I'd rather drop the problematic commit entirely and then you can
submit a replacement.

Thanks,
Rafael

