From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Tue, 28 Nov 2017 15:17:15 +0100
Message-ID: <CAJZ5v0iyjULu3Chxou61Xx3W1ULnfhheY5cHZASVVKw7JmO+Jg@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 28, 2017 at 11:58 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rafael, Shimoda-san,
>
> On Sun, Nov 12, 2017 at 1:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The check for "active" children in __pm_runtime_set_status(), when
>> trying to set the parent device status to "suspended", doesn't
>> really make sense, because in fact it is not invalid to set the
>> status of a device with runtime PM disabled to "suspended" in any
>> case.  It is invalid to enable runtime PM for a device with its
>> status set to "suspended" while its child_count reference counter
>> is nonzero, but the check in __pm_runtime_set_status() doesn't
>> really cover that situation.
>>
>> For this reason, drop the children check from __pm_runtime_set_status()
>> and add a check against child_count reference counters of "suspended"
>> devices to pm_runtime_enable().
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/base/power/runtime.c |   30 ++++++++++--------------------
>>  1 file changed, 10 insertions(+), 20 deletions(-)
>>
>> Index: linux-pm/drivers/base/power/runtime.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/runtime.c
>> +++ linux-pm/drivers/base/power/runtime.c
>> @@ -1101,29 +1101,13 @@ int __pm_runtime_set_status(struct devic
>>                 goto out;
>>         }
>>
>> -       if (dev->power.runtime_status == status)
>> +       if (dev->power.runtime_status == status || !parent)
>>                 goto out_set;
>>
>>         if (status == RPM_SUSPENDED) {
>> -               /*
>> -                * It is invalid to suspend a device with an active child,
>> -                * unless it has been set to ignore its children.
>> -                */
>> -               if (!dev->power.ignore_children &&
>> -                       atomic_read(&dev->power.child_count)) {
>> -                       dev_err(dev, "runtime PM trying to suspend device but active child\n");
>
> JFTR, this triggered before during system resume on e.g. Salvator-XS with
> R-Car H3:
>
>     ohci-platform ee080000.usb: runtime PM trying to suspend device
> but active child
>     phy_rcar_gen3_usb2 ee080200.usb-phy: runtime PM trying to suspend
> device but active child
>     ohci-platform ee0c0000.usb: runtime PM trying to suspend device
> but active child
>     ohci-platform ee0a0000.usb: runtime PM trying to suspend device
> but active child
>     phy_rcar_gen3_usb2 ee0c0200.usb-phy: runtime PM trying to suspend
> device but active child
>     phy_rcar_gen3_usb2 ee0a0200.usb-phy: runtime PM trying to suspend
> device but active child
>
> so this was an existing issue with USB before.
>
>> -                       error = -EBUSY;
>> -                       goto out;
>> -               }
>> -
>> -               if (parent) {
>> -                       atomic_add_unless(&parent->power.child_count, -1, 0);
>> -                       notify_parent = !parent->power.ignore_children;
>> -               }
>> -               goto out_set;
>> -       }
>> -
>> -       if (parent) {
>> +               atomic_add_unless(&parent->power.child_count, -1, 0);
>> +               notify_parent = !parent->power.ignore_children;
>> +       } else {
>>                 spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
>>
>>                 /*
>> @@ -1307,6 +1291,12 @@ void pm_runtime_enable(struct device *de
>>         else
>>                 dev_warn(dev, "Unbalanced %s!\n", __func__);
>>
>> +       WARN(dev->power.runtime_status == RPM_SUSPENDED &&
>> +            !dev->power.ignore_children &&
>> +            atomic_read(&dev->power.child_count) > 0,
>> +            "Enabling runtime PM for inactive device (%s) with active children\n",
>> +            dev_name(dev));
>
> And now it became a bit more noisy:

Well, it's all existing issues, although the WARN() doesn't provide
additional information in this particular case.

I'm considering changing it to print a message without a stack trace.

Thanks,
Rafael
