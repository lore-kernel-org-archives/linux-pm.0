From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Tue, 28 Nov 2017 11:58:22 +0100
Message-ID: <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1713438.irjm9MTSvo@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael, Shimoda-san,

On Sun, Nov 12, 2017 at 1:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The check for "active" children in __pm_runtime_set_status(), when
> trying to set the parent device status to "suspended", doesn't
> really make sense, because in fact it is not invalid to set the
> status of a device with runtime PM disabled to "suspended" in any
> case.  It is invalid to enable runtime PM for a device with its
> status set to "suspended" while its child_count reference counter
> is nonzero, but the check in __pm_runtime_set_status() doesn't
> really cover that situation.
>
> For this reason, drop the children check from __pm_runtime_set_status()
> and add a check against child_count reference counters of "suspended"
> devices to pm_runtime_enable().
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1101,29 +1101,13 @@ int __pm_runtime_set_status(struct devic
>                 goto out;
>         }
>
> -       if (dev->power.runtime_status == status)
> +       if (dev->power.runtime_status == status || !parent)
>                 goto out_set;
>
>         if (status == RPM_SUSPENDED) {
> -               /*
> -                * It is invalid to suspend a device with an active child,
> -                * unless it has been set to ignore its children.
> -                */
> -               if (!dev->power.ignore_children &&
> -                       atomic_read(&dev->power.child_count)) {
> -                       dev_err(dev, "runtime PM trying to suspend device but active child\n");

JFTR, this triggered before during system resume on e.g. Salvator-XS with
R-Car H3:

    ohci-platform ee080000.usb: runtime PM trying to suspend device
but active child
    phy_rcar_gen3_usb2 ee080200.usb-phy: runtime PM trying to suspend
device but active child
    ohci-platform ee0c0000.usb: runtime PM trying to suspend device
but active child
    ohci-platform ee0a0000.usb: runtime PM trying to suspend device
but active child
    phy_rcar_gen3_usb2 ee0c0200.usb-phy: runtime PM trying to suspend
device but active child
    phy_rcar_gen3_usb2 ee0a0200.usb-phy: runtime PM trying to suspend
device but active child

so this was an existing issue with USB before.

> -                       error = -EBUSY;
> -                       goto out;
> -               }
> -
> -               if (parent) {
> -                       atomic_add_unless(&parent->power.child_count, -1, 0);
> -                       notify_parent = !parent->power.ignore_children;
> -               }
> -               goto out_set;
> -       }
> -
> -       if (parent) {
> +               atomic_add_unless(&parent->power.child_count, -1, 0);
> +               notify_parent = !parent->power.ignore_children;
> +       } else {
>                 spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
>
>                 /*
> @@ -1307,6 +1291,12 @@ void pm_runtime_enable(struct device *de
>         else
>                 dev_warn(dev, "Unbalanced %s!\n", __func__);
>
> +       WARN(dev->power.runtime_status == RPM_SUSPENDED &&
> +            !dev->power.ignore_children &&
> +            atomic_read(&dev->power.child_count) > 0,
> +            "Enabling runtime PM for inactive device (%s) with active children\n",
> +            dev_name(dev));

And now it became a bit more noisy:

Enabling runtime PM for inactive device (ee0a0200.usb-phy) with active children
WARNING: CPU: 0 PID: 1697 at drivers/base/power/runtime.c:1299
pm_runtime_enable+0x94/0xd8
CPU: 0 PID: 1697 Comm: s2idle Not tainted
4.15.0-rc1-arm64-renesas-00381-g40d152b966c941dd #41
Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
task: ffff8006f81bb100 task.stack: ffff00000aa80000
pstate: 60000085 (nZCv daIf -PAN -UAO)
pc : pm_runtime_enable+0x94/0xd8
lr : pm_runtime_enable+0x94/0xd8
sp : ffff00000aa83b50
x29: ffff00000aa83b50 x28: ffff8006f81bb100
x27: ffff000008841000 x26: ffff000008b4b640
x25: ffff000008b7f6e0 x24: ffff0000097a2f90
x23: ffff000008b7f000 x22: 0000000000000010
x21: 0000000000000000 x20: ffff8006fa9ad158
x19: ffff8006fa9ad010 x18: 00000000013c6577
x17: ffff00000947ea80 x16: 0000000000006370
x15: 000000000000636e x14: 646c696863206576
x13: 0000000000000001 x12: ffff8006f81bbaa8
x11: ffff8006f9479230 x10: ffff8006f97a63e0
x9 : 0000000000000000 x8 : ffff8006f97a6408
x7 : ffff8006f97a63c0 x6 : ffff00000975de80
x5 : 0000000000000000 x4 : 0000000000000000
x3 : ffffffffffffffff x2 : ffff000008b4bbf0
x1 : ffff8006f81bb100 x0 : 000000000000004f
Call trace:
 pm_runtime_enable+0x94/0xd8
 device_resume_early+0x50/0xec
 dpm_resume_early+0x118/0x204
 suspend_devices_and_enter+0x2a8/0x4b0
 pm_suspend+0x22c/0x27c
 state_store+0x84/0x108
 kobj_attr_store+0x14/0x24
 sysfs_kf_write+0x54/0x64
 kernfs_fop_write+0xd8/0x1ec
 __vfs_write+0x28/0x124
 vfs_write+0xa0/0x198
 SyS_write+0x44/0xa0
 el0_svc_naked+0x20/0x24
---[ end trace 965c08c229b62a65 ]---
------------[ cut here ]------------
Enabling runtime PM for inactive device (ee0c0200.usb-phy) with active children
WARNING: CPU: 0 PID: 1697 at drivers/base/power/runtime.c:1299
pm_runtime_enable+0x94/0xd8
CPU: 0 PID: 1697 Comm: s2idle Tainted: G        W
4.15.0-rc1-arm64-renesas-00381-g40d152b966c941dd #41
Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
task: ffff8006f81bb100 task.stack: ffff00000aa80000
pstate: 60000085 (nZCv daIf -PAN -UAO)
pc : pm_runtime_enable+0x94/0xd8
lr : pm_runtime_enable+0x94/0xd8
sp : ffff00000aa83b50
x29: ffff00000aa83b50 x28: ffff8006f81bb100
x27: ffff000008841000 x26: ffff000008b4b640
x25: ffff000008b7f6e0 x24: ffff0000097a2f90
x23: ffff000008b7f000 x22: 0000000000000010
x21: 0000000000000000 x20: ffff8006fa9ad958
x19: ffff8006fa9ad810 x18: 00000000013c6577
x17: ffff00000947ea80 x16: 0000000000006370
x15: 000000000000636e x14: 0720072007200720
x13: 0000000000000001 x12: ffff8006f81bbaa8
x11: ffff8006f9478940 x10: ffff8006f97a7ad8
x9 : 0000000000000000 x8 : ffff8006f97a7b00
x7 : ffff8006f97a7ab8 x6 : ffff00000975de80
x5 : 0000000000000000 x4 : 0000000000000000
x3 : ffffffffffffffff x2 : ffff000008b4bbf0
x1 : ffff8006f81bb100 x0 : 000000000000004f
Call trace:
 pm_runtime_enable+0x94/0xd8
 device_resume_early+0x50/0xec
 dpm_resume_early+0x118/0x204
 suspend_devices_and_enter+0x2a8/0x4b0
 pm_suspend+0x22c/0x27c
 state_store+0x84/0x108
 kobj_attr_store+0x14/0x24
 sysfs_kf_write+0x54/0x64
 kernfs_fop_write+0xd8/0x1ec
 __vfs_write+0x28/0x124
 vfs_write+0xa0/0x198
 SyS_write+0x44/0xa0
 el0_svc_naked+0x20/0x24
---[ end trace 965c08c229b62a66 ]---
------------[ cut here ]------------
...

> +
>         spin_unlock_irqrestore(&dev->power.lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
