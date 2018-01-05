From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/4] PM / core: Propagate wakeup_path status flag in __device_suspend_late()
Date: Fri, 5 Jan 2018 13:57:06 +0100
Message-ID: <CAJZ5v0iVbj7g6QkCJT2hG4=y=MRzXaB4yBbLQnjV3Pn5R0QLqg@mail.gmail.com>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org> <1514909333-4450-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46856 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeAEM5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 07:57:07 -0500
In-Reply-To: <1514909333-4450-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Jan 2, 2018 at 5:08 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Currently the wakeup_path status flag becomes propagated from a child
> device to its parent device at __device_suspend(). This allows a driver
> dealing with a parent device to act on the flag from its ->suspend()
> callback.
>
> However, in situations when the wakeup_path status flag needs to be set
> from a ->suspend_late() callback, its value doesn't get propagated to the
> parent by the PM core. Let's address this limitation, by also propagating
> the flag at __device_suspend_late().

This doesn't need to be done twice, so doing it once in
__device_suspend_late() should be sufficient.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/main.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 7aeb91d..612bf1b 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1476,6 +1476,22 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
>         return callback;
>  }
>
> +static void dpm_propagate_to_parent(struct device *dev)
> +{
> +       struct device *parent = dev->parent;
> +
> +       if (!parent)
> +               return;
> +
> +       spin_lock_irq(&parent->power.lock);
> +
> +       parent->power.direct_complete = false;
> +       if (dev->power.wakeup_path && !parent->power.ignore_children)
> +               parent->power.wakeup_path = true;
> +
> +       spin_unlock_irq(&parent->power.lock);
> +}

Clearing the parent's direct_complete in __device_suspend_late() is
incorrect, because it potentially overwrites the value previously used
by __device_suspend() for the parent.

IMO it also need not be done under parent->power.lock, however,
because the other parent's power. flags should not be updated in
parallel with this update anyway, so maybe just move the parent's
direct_complete update to __device_suspend(), rename
dpm_propagate_to_parent() to something like
dpm_propagate_wakeup_to_parent() and call it from
__device_suspend_late() only?

Thanks,
Rafael
