From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH V4] PM / Domains: Remove intermediate states from the
 power off sequence
Date: Tue, 22 Dec 2015 20:49:15 +0800
Message-ID: <CAGS+omDa6miWTSCL2ETx2vx-XRt1Aq2EEu+WwTgmtdkJBKrp9A@mail.gmail.com>
References: <1434633473-12908-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34810 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbbLVMtg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 07:49:36 -0500
Received: by mail-vk0-f42.google.com with SMTP id j66so117107400vkg.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 04:49:36 -0800 (PST)
In-Reply-To: <1434633473-12908-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Lina Iyer <lina.iyer@linaro.org>, Nicolas Boichat <drinkcat@chromium.org>

Hi All,

On Thu, Jun 18, 2015 at 9:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Genpd's ->runtime_suspend() (assigned to pm_genpd_runtime_suspend())
> doesn't immediately walk the hierarchy of ->runtime_suspend() callbacks.
> Instead, pm_genpd_runtime_suspend() calls pm_genpd_poweroff() which
> postpones that until *all* the devices in the genpd are runtime suspended.
[snip...]
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v4:
>         - According to comments from Lina, restore to existing behavior to
>         invoke the ->start|stop() callbacks for IRQ safe devices.
>         - Improve fine-grained PM support for IRQ safe devices, by allowing to
>         walk the hierarchy of the ->runtime_suspend|resume() callbacks.
>         - Updated the changelog to describe the forth positive side effect case
>         conserning IRQ safe devices.
>         - Rebased on top Geert's recently queued genpd patch.
>
> Changes in v3:
>         Moved from RFC to PATCH.
>         According to comment from Lina, changed __pm_genpd_poweron() to keep
>         current behavior which means to *not* power off potentially unused
>         masters in the error path. Instead, let's deal with that from a separate
>         patch.
>         Updated a comment in pm_genpd_poweroff().
>
> Changes in v2:
>         Updated the changelog and the commit message header.
>         Header for v1 was "PM / Domains: Minimize latencies by not delaying
>         save/restore".
>
> ---
>  drivers/base/power/domain.c | 363 ++++++++------------------------------------
>  include/linux/pm_domain.h   |   7 -
>  2 files changed, 62 insertions(+), 308 deletions(-)
>

I was testing a kernel with this patch on one of my systems today I
saw a splat like this on boot:

[    1.893134]
[    1.893137] =============================================
[    1.893139] [ INFO: possible recursive locking detected ]
[    1.893143] 3.18.0 #531 Not tainted
[    1.893145] ---------------------------------------------
[    1.893148] kworker/u8:4/113 is trying to acquire lock:
[    1.893167]  (&genpd->lock){+.+...}, at: [<ffffffc000573818>]
genpd_poweron+0x30/0x70
[    1.893169]
[    1.893169] but task is already holding lock:
[    1.893179]  (&genpd->lock){+.+...}, at: [<ffffffc000573818>]
genpd_poweron+0x30/0x70
[    1.893182]
[    1.893182] other info that might help us debug this:
[    1.893184]  Possible unsafe locking scenario:
[    1.893184]
[    1.893185]        CPU0
[    1.893187]        ----
[    1.893191]   lock(&genpd->lock);
[    1.893195]   lock(&genpd->lock);
[    1.893196]
[    1.893196]  *** DEADLOCK ***
[    1.893196]
[    1.893198]  May be due to missing lock nesting notation
[    1.893198]
[    1.893201] 4 locks held by kworker/u8:4/113:
[    1.893217]  #0:  ("%s""deferwq"){++++.+}, at: [<ffffffc00023b4e0>]
process_one_work+0x1f8/0x50c
[    1.893229]  #1:  (deferred_probe_work){+.+.+.}, at:
[<ffffffc00023b4e0>] process_one_work+0x1f8/0x50c
[    1.893241]  #2:  (&dev->mutex){......}, at: [<ffffffc000560920>]
__device_attach+0x40/0x12c
[    1.893251]  #3:  (&genpd->lock){+.+...}, at: [<ffffffc000573818>]
genpd_poweron+0x30/0x70
[    1.893253]
[    1.893253] stack backtrace:
[    1.893259] CPU: 2 PID: 113 Comm: kworker/u8:4 Not tainted 3.18.0 #531
[    1.893261] Hardware name: Mediatek Oak rev4 board (DT)
[    1.893269] Workqueue: deferwq deferred_probe_work_func
[    1.893271] Call trace:
[    1.893278] [<ffffffc000208cf0>] dump_backtrace+0x0/0x140
[    1.893283] [<ffffffc000208e4c>] show_stack+0x1c/0x28
[    1.893289] [<ffffffc00084ab48>] dump_stack+0x80/0xb4
[    1.893295] [<ffffffc000269dcc>] __lock_acquire+0x68c/0x19a8
[    1.893299] [<ffffffc00026b954>] lock_acquire+0x128/0x164
[    1.893304] [<ffffffc00084e090>] mutex_lock_nested+0x90/0x3b4
[    1.893308] [<ffffffc000573814>] genpd_poweron+0x2c/0x70
[    1.893312] [<ffffffc0005738ac>] __genpd_poweron.part.14+0x54/0xcc
[    1.893316] [<ffffffc000573834>] genpd_poweron+0x4c/0x70
[    1.893321] [<ffffffc00057447c>] genpd_dev_pm_attach+0x160/0x19c
[    1.893326] [<ffffffc00056931c>] dev_pm_domain_attach+0x1c/0x2c
[    1.893331] [<ffffffc000562754>] platform_drv_probe+0x3c/0xa4
[    1.893336] [<ffffffc000560604>] driver_probe_device+0x124/0x2c8
[    1.893340] [<ffffffc000560824>] __device_attach_driver+0x7c/0x90
[    1.893344] [<ffffffc00055e6fc>] bus_for_each_drv+0x90/0xc4
[    1.893348] [<ffffffc000560988>] __device_attach+0xa8/0x12c
[    1.893352] [<ffffffc000560a5c>] device_initial_probe+0x20/0x30
[    1.893356] [<ffffffc00055f994>] bus_probe_device+0x34/0x9c
[    1.893360] [<ffffffc00055fe38>] deferred_probe_work_func+0x7c/0xb0
[    1.893365] [<ffffffc00023b5d4>] process_one_work+0x2ec/0x50c
[    1.893370] [<ffffffc00023c340>] worker_thread+0x350/0x470
[    1.893374] [<ffffffc00024165c>] kthread+0xf0/0xfc

I have not been able to reproduce, but by looking at how
genpd_poweron() was modified by this patch, it looks like it might
have been introduced by this hunk:

> @@ -291,20 +239,8 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>          */
>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
>                 genpd_sd_counter_inc(link->master);
> -               genpd->status = GPD_STATE_WAIT_MASTER;
> -
> -               mutex_unlock(&genpd->lock);
>
>                 ret = pm_genpd_poweron(link->master);
> -
> -               mutex_lock(&genpd->lock);
> -
> -               /*
> -                * The "wait for parent" status is guaranteed not to change
> -                * while the master is powering on.
> -                */
> -               genpd->status = GPD_STATE_POWER_OFF;
> -               wake_up_all(&genpd->status_wait_queue);

AFAICT, the mutex_*() calls here that were removed unlock
(&genpd->lock) and allowed pm_genpd_poweron() to be recursively called
without the above splat in the case where a pm_genpd_poweron() on the
master would take a lock of the same lock class as the current (slave)
genpd.

Other places in domain.c use something like this to lock a second
genpd while already holding one genpd's lock:
   mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);

However, it seems like in this case we might actually need to walk up
several layers of a hierarchy.

So, AFAICT the best thing to do would be to restore the
mutex_unlock()/_lock() around the call to pm_genpd_poweron().

It isn't clear to me whether this was removed by this patch on purpose
or as an accident.

Thanks for your help!
-Dan
