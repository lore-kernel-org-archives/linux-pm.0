From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Mon, 13 Nov 2017 14:26:28 +0100
Message-ID: <CAPDyKFp9Cqh3NOCMoT1d2R__yYynDBQ48OvfOLAfRQ_-Z9QfeQ@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1713438.irjm9MTSvo@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On 12 November 2017 at 01:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
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

The reason to why I changed this in commit a8636c89648a ("PM /
Runtime: Don't allow to suspend a device with an active child") was
because to get a consistent behavior.

Because, setting the device's status to active (RPM_ACTIVE) via
__pm_runtime_set_status(), requires its parent to also be active (in
case the parent has runtime PM enabled).

I would prefer to try maintain this consistency, but I also I realize
that commit a8636c89648a, should also have been checking if the parent
has runtime PM enabled (again for consistency), which it doesn't.

What about fixing that instead?

Kind regards
Uffe

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
> +
>         spin_unlock_irqrestore(&dev->power.lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
