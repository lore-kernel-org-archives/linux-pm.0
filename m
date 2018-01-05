From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/4] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Fri, 5 Jan 2018 13:44:11 +0100
Message-ID: <CAJZ5v0jsEX37AVA0FWyf8HD29gYAPh0GNRsUtfNd1J6q8TT_8w@mail.gmail.com>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org> <1514909333-4450-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34957 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeAEMoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 07:44:12 -0500
In-Reply-To: <1514909333-4450-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Jan 2, 2018 at 5:08 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The PM core in the device_prepare() phase, resets the wakeup_path status
> flag to the value of device_may_wakeup(). This means if a ->prepare() or a
> ->suspend() callback for the device would update the device's wakeup
> setting, this doesn't become reflected in the wakeup_path status flag.
>
> In general this isn't a problem, because wakeup settings are not supposed
> to be changed (via for example calling device_set_wakeup_enable()) during
> any system wide suspend/resume phase.  Nevertheless there are some users,
> which can be considered as legacy, that don't conform to this behaviour.
>
> These legacy cases should be corrected, however until that is done, let's
> address the issue from the PM core, by moving the assignment of the
> wakeup_path status flag to the __device_suspend() phase and after the
> ->suspend() callback has been invoked.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I'm queuing this one up with an extra empty line added.

> ---
>  drivers/base/power/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 70398e7..7aeb91d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1788,6 +1788,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>   End:
>         if (!error) {
>                 dev->power.is_suspended = true;
> +               if (device_may_wakeup(dev))
> +                       dev->power.wakeup_path = true;
>                 dpm_propagate_to_parent(dev);
>                 dpm_clear_suppliers_direct_complete(dev);
>         }
> @@ -1912,7 +1914,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>
>         device_lock(dev);
>
> -       dev->power.wakeup_path = device_may_wakeup(dev);
> +       dev->power.wakeup_path = false;
>
>         if (dev->power.no_pm_callbacks) {
>                 ret = 1;        /* Let device go direct_complete */
> --
> 2.7.4
>
