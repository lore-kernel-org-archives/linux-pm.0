From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] PM / core: Add WAKEUP_POWERED driver flag
Date: Thu, 9 Nov 2017 01:41:38 +0100
Message-ID: <CAJZ5v0jOLvCW58K-RiHU+j90AX1H+D6p6D+wnxat3jYzJcQDew@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org> <1510154134-1248-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510154134-1248-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 8, 2017 at 4:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> For some bus types and PM domains, it's not sufficient to only check the
> return value from device_may_wakeup(), to fully understand how to treat the
> device during system suspend.
>
> In particular, sometimes the device may need to stay in full power state,
> to have wakeup signals enabled for it. Therefore, define and document a
> WAKEUP_POWERED flag, to enable drivers to instruct bus types and PM domains
> exactly about that.
>
> During __device_suspend() in the PM core, let's make sure to also propagate
> the setting of the flag to the parent device, when wakeup signals are
> enabled and unless the parent has the "ignore_children" flag set. This
> makes it also consistent with how the existing "wakeup_path" flag is being
> assigned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/driver-api/pm/devices.rst | 12 ++++++++++++
>  drivers/base/power/main.c               |  6 +++++-
>  include/linux/pm.h                      |  5 +++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
> index 53c1b0b..1ca2d0f 100644
> --- a/Documentation/driver-api/pm/devices.rst
> +++ b/Documentation/driver-api/pm/devices.rst
> @@ -414,6 +414,18 @@ when the system is in the sleep state.  For example, :c:func:`enable_irq_wake()`
>  might identify GPIO signals hooked up to a switch or other external hardware,
>  and :c:func:`pci_enable_wake()` does something similar for the PCI PME signal.
>
> +Moreover, in case wakeup signals are enabled for a device, some bus types and
> +PM domains may manage the device slightly differently during system suspend. For
> +example, sometimes the device needs to stay in full power state, to have wakeup
> +signals enabled for it. In cases when the wakeup settings are mostly managed by
> +the driver, it may not be sufficient for bus types and PM domains to only check
> +the return value of :c:func:`device_may_wakeup(dev)`, to understand what actions
> +are needed. Therefore, drivers can set ``DPM_FLAG_WAKEUP_POWERED`` in
> +:c:member:`power.driver_flags`, by passing the flag to
> +:c:func:`dev_pm_set_driver_flags` helper. This instructs bus types and PM
> +domains to leave the device in full power state, when wakeup signals are enabled
> +for it.
> +
>  If any of these callbacks returns an error, the system won't enter the desired
>  low-power state.  Instead, the PM core will unwind its actions by resuming all
>  the devices that were suspended.
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 8089e72..f64f945 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1432,9 +1432,13 @@ static void dpm_propagate_to_parent(struct device *dev)
>         spin_lock_irq(&parent->power.lock);
>
>         parent->power.direct_complete = false;
> -       if (dev->power.wakeup_path && !parent->power.ignore_children)
> +       if (dev->power.wakeup_path && !parent->power.ignore_children) {
>                 parent->power.wakeup_path = true;
>
> +               if (dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_POWERED))
> +                       parent->power.driver_flags |= DPM_FLAG_WAKEUP_POWERED;

No, sorry.

The flag cannot be propagated this way, because that effectively
overrides the choices made by the parent driver and up.

Besides, wakeup_path already had a similar purpose.  What has happened to that?

Thanks,
Rafael
