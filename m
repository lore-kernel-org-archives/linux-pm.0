From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] PM / core: Add WAKEUP_POWERED driver flag
Date: Thu, 9 Nov 2017 01:24:52 +0100
Message-ID: <CAJZ5v0jFLL2pBNPo=J3MdwfcA9C+nSMe_S6iBYLoEA8SjbOJ+A@mail.gmail.com>
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

IMO this is a bit unclear.

First off, how does the driver know that the device has to be in full
power for wakeup to work?

Second, this requirement sort of implies that the device cannot go
into a low-power state during runtime suspend too, so it basically
remains stays at full power even when runtime-suspended.

Does it then mean that the middle layer is expected to simply avoid
changing the power state of the device when enabled to wake up the
system, or is there more to that?  In the former case, it may be
better to rename the flag to something along the lines of "don't
change power state if wakeup enabled".

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
> +       }
> +
>         spin_unlock_irq(&parent->power.lock);
>  }
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 65d3911..34c2404 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -559,6 +559,7 @@ struct pm_subsys_data {
>   * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
>   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
>   * SMART_SUSPEND: No need to resume the device from runtime suspend.
> + * WAKEUP_POWERED: Keep the device powered if it has wakeup enabled.
>   *
>   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>   * system suspend/resume callbacks to be skipped for the device to return 0 from
> @@ -572,10 +573,14 @@ struct pm_subsys_data {
>   * necessary from the driver's perspective.  It also may cause them to skip
>   * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
>   * the driver if they decide to leave the device in runtime suspend.
> + *
> + * Setting WAKEUP_POWERED instructs bus types and PM domains that the device
> + * needs to remain powered in system suspend, in case wakeup is enabled for it.
>   */
>  #define DPM_FLAG_NEVER_SKIP    BIT(0)
>  #define DPM_FLAG_SMART_PREPARE BIT(1)
>  #define DPM_FLAG_SMART_SUSPEND BIT(2)
> +#define DPM_FLAG_WAKEUP_POWERED        BIT(3)

I'd prefer this to be BIT(4).

>
>  struct dev_pm_info {
>         pm_message_t            power_state;
> --
> 2.7.4
>

Thanks,
Rafael
