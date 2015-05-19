From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] PM / sleep: Add power.direct_complete_default flag
Date: Tue, 19 May 2015 22:47:14 +0200
Message-ID: <CAPDyKFo-B_fopkCGAKweeEyR_tyMTxi0sNqRd_hz0EYiYsp5qg@mail.gmail.com>
References: <1432044679-10256-1-git-send-email-tomeu.vizoso@collabora.com>
	<1432044679-10256-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36449 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbESUrP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 16:47:15 -0400
Received: by qkgw4 with SMTP id w4so18687594qkg.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2015 13:47:14 -0700 (PDT)
In-Reply-To: <1432044679-10256-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 19 May 2015 at 16:11, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> Introduce a new per-device flag power.direct_complete_default that will
> instruct the PM core to let that device remain in runtime suspend when
> the system goes into a sleep power state, without it having to implement
> the prepare() callback.

The above wording make it sounds like the normal behavior is that the
PM core will runtime resume the device during the system PM suspend
phase. That's not the case.

As I understand it for the mentioned cases above, it will skip
invoking the system PM callbacks, if the device is already runtime
suspended.

>
>
> This is useful because otherwise it would be needed to get dozens of
> drivers to implement the prepare() callback even if they don't have a
> 1-to-1 relationship with a piece of HW.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> ---
>
> v3:     * Have the flag be a more direct substitute for prepare() as
> suggested by Rafael
>         * Inherit this flag from the parent device
>
> v2:     * Fix wording as suggested by Kevin Hilman
> ---
>  Documentation/power/runtime_pm.txt | 8 +++++++-
>  drivers/base/power/main.c          | 5 +++++
>  include/linux/pm.h                 | 1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index e76dc0a..caf7b53 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -228,6 +228,12 @@ defined in include/linux/pm.h:
>    unsigned int ignore_children;
>      - if set, the value of child_count is ignored (but still updated)
>
> +  bool direct_complete_default;
> +    - if set, the device will be left runtime-suspended when the system
> +      transitions to a sleep state, unless there's a .prepare() callback that
> +      returns a non-positive value. This flag is inherited from the parent
> +      device when a device is added to the PM core's list of active devices.

Similar comment as to the change log.

> +
>    unsigned int disable_depth;
>      - used for disabling the helper functions (they work normally if this is
>        equal to zero); the initial value of it is 1 (i.e. runtime PM is
> @@ -669,7 +675,7 @@ system suspend and resume callbacks for all of those devices, except for the
>  complete callback, which is then entirely responsible for handling the device
>  as appropriate.  This only applies to system suspend transitions that are not
>  related to hibernation (see Documentation/power/devices.txt for more
> -information).
> +information).  See also power.direct_complete_default.
>
>  The PM core does its best to reduce the probability of race conditions between
>  the runtime PM and system suspend/resume (and hibernation) callbacks by carrying
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3d874ec..175ddec 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -128,6 +128,9 @@ void device_pm_add(struct device *dev)
>         if (dev->parent && dev->parent->power.is_prepared)
>                 dev_warn(dev, "parent %s should not be sleeping\n",
>                         dev_name(dev->parent));
> +       if (dev->parent)
> +               dev->power.direct_complete_default =
> +                       dev->parent->power.direct_complete_default;
>         list_add_tail(&dev->power.entry, &dpm_list);
>         mutex_unlock(&dpm_list_mtx);
>  }
> @@ -1589,6 +1592,8 @@ static int device_prepare(struct device *dev, pm_message_t state)
>                 trace_device_pm_callback_start(dev, info, state.event);
>                 ret = callback(dev);
>                 trace_device_pm_callback_end(dev, ret);
> +       } else if (dev->power.direct_complete_default) {
> +               ret = 1;
>         }
>
>         device_unlock(dev);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 4890743..fcb3451 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -565,6 +565,7 @@ struct dev_pm_info {
>         bool                    ignore_children:1;
>         bool                    early_init:1;   /* Owned by the PM core */
>         bool                    direct_complete:1;      /* Owned by the PM core */
> +       bool                    direct_complete_default:1;      /* Ditto */
>         spinlock_t              lock;
>  #ifdef CONFIG_PM_SLEEP
>         struct list_head        entry;
> --

Besides the above minor things, this looks good to me.

Kind regards
Uffe
