From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/3] PM / core: Add IN_BAND_WAKEUP driver flag
Date: Sun, 10 Dec 2017 10:18:12 +0100
Message-ID: <CAPDyKFom2C3bhpPp_5znr35pgpt4fYwqEnnMHjd-yRmZ4UtyDg@mail.gmail.com>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
 <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org> <1926914.PsNMcYBlGW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33895 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdLJJSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Dec 2017 04:18:14 -0500
Received: by mail-io0-f179.google.com with SMTP id s19so6604253ioa.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2017 01:18:13 -0800 (PST)
In-Reply-To: <1926914.PsNMcYBlGW@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 10 December 2017 at 03:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, November 13, 2017 4:46:42 PM CET Ulf Hansson wrote:
>> For some bus types and PM domains, it's not sufficient to only check the
>> return value from device_may_wakeup(), to fully understand how to configure
>> wakeup settings for the device during system suspend.
>>
>> In particular, sometimes the device may need to remain in its power state,
>> in case the driver has configured it for in band IRQs, as to be able to
>> generate wakeup signals. Therefore, define and document an IN_BAND_WAKEUP
>> driver flag, to enable drivers to instruct bus types and PM domains about
>> this setting.
>>
>> Of course, in case the bus type and PM domain has additional information
>> about wakeup settings of the device, they may override the behaviour.
>>
>> Using the IN_BAND_WAKEUP driver flag for a device, may also affect how bus
>> types and PM domains should treat the device's parent during system
>> suspend. Therefore, in __device_suspend(), let the PM core propagate the
>> wakeup setting by using a status flag in the struct dev_pm_info for the
>> parent. This also makes it consistent with how the existing "wakeup_path"
>> status flag is being assigned.
>
> I've been thinking about this quite a bit recently and my conclusion is that
> the flag makes perfect sence (as it covers a valid use case), but I would
> define it and design the handling of it a bit differently.
>
> First off, the genpd changes in patch [3/3] effectively skip the "noirq"
> driver callbacks for the device, but question is why this is just "noirq".
> Arguably, the "late suspend" callback should be skipped too (the regular
> "suspend" one not necessarily, because the state of the device can still
> be changed via runtime PM at that point).  Moreover, if we go for the
> skipping at the suspend time, all of the resume should be skipped for the
> device too, because it has not been suspended in the first place.

No, sorry, but this is not the purpose of the flag. Actually there is
no reason at all to why genpd needs to skip invoking the driver's
noirq callbacks, no matter of whether the flag is set or not.

Moreover, skipping invoking callbacks would not work for those cases
where the driver needs to configure its wakeup setting in those
callbacks. Or if the driver has anything additional todo, like
disabling a request queue or whatever things, that it needs to manage
in those callbacks.

Instead this is about telling genpd that it must not power off the PM
domain (and in the special case of when genpd has the
->dev_ops.stop|start() assigned for the device, avoid to call them).

For that reason, I don't think the PM core needs to be involved,
besides what the patch already does.

Kind regards
Uffe

>
> But, if the device is in suspend at the suspend time already, the
> resume part should not be skipped for it at all (unless it has
> LEAVE_SUSPENDED set too), so it looks like the skipping should only
> happen if the device has not been suspended when the system transition
> starts.
>
> Second, it looks like the flag should be handled in the core in
> accordance with what genpd does with it or drivers will have to
> check the middle layer configuration.
>
> So below is my version of the core part (on top of the series I posted
> earlier today: https://marc.info/?l=linux-pm&m=151286423304445&w=2)
> and the genpd one should be analogous IMO.
>
> ---
>  Documentation/driver-api/pm/devices.rst |   21 ++++++++-
>  drivers/base/power/main.c               |   71 +++++++++++++++++++++++++-------
>  include/linux/pm.h                      |    8 +++
>  3 files changed, 82 insertions(+), 18 deletions(-)
>
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -560,6 +560,7 @@ struct pm_subsys_data {
>   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
>   * SMART_SUSPEND: No need to resume the device from runtime suspend.
>   * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
> + * IN_BAND_WAKEUP: Avoid suspending the device if configured for system wakeup.
>   *
>   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>   * system suspend/resume callbacks to be skipped for the device to return 0 from
> @@ -576,11 +577,16 @@ struct pm_subsys_data {
>   *
>   * Setting LEAVE_SUSPENDED informs the PM core and middle-layer code that the
>   * driver prefers the device to be left in suspend after system resume.
> + *
> + * Setting IN_BAND_WAKEUP informs the PM core and middle-layer code that, as far
> + * as the driver knows, the device cannot be suspended to be able to wake up the
> + * system from sleep.
>   */
>  #define DPM_FLAG_NEVER_SKIP            BIT(0)
>  #define DPM_FLAG_SMART_PREPARE         BIT(1)
>  #define DPM_FLAG_SMART_SUSPEND         BIT(2)
>  #define DPM_FLAG_LEAVE_SUSPENDED       BIT(3)
> +#define DPM_FLAG_IN_BAND_WAKEUP                BIT(4)
>
>  struct dev_pm_info {
>         pm_message_t            power_state;
> @@ -604,6 +610,7 @@ struct dev_pm_info {
>         bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>         unsigned int            must_resume:1;  /* Owned by the PM core */
>         unsigned int            may_skip_resume:1;      /* Set by subsystems */
> +       unsigned int            skip_suspend:1; /* Owned by the PM core */
>  #else
>         unsigned int            should_wakeup:1;
>  #endif
> @@ -774,6 +781,7 @@ extern void pm_generic_complete(struct d
>
>  extern void dev_pm_skip_next_resume_phases(struct device *dev);
>  extern bool dev_pm_may_skip_resume(struct device *dev);
> +extern bool dev_pm_skip_suspend_and_not_suspended(struct device *dev);
>  extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
>
>  #else /* !CONFIG_PM_SLEEP */
> Index: linux-pm/Documentation/driver-api/pm/devices.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/pm/devices.rst
> +++ linux-pm/Documentation/driver-api/pm/devices.rst
> @@ -401,6 +401,10 @@ the phases are: ``prepare``, ``suspend``
>         generated by some other device after its own device had been set to low
>         power.
>
> +If any of these callbacks returns an error, the system won't enter the desired
> +low-power state.  Instead, the PM core will unwind its actions by resuming all
> +the devices that were suspended.
> +
>  At the end of these phases, drivers should have stopped all I/O transactions
>  (DMA, IRQs), saved enough state that they can re-initialize or restore previous
>  state (as needed by the hardware), and placed the device into a low-power state.
> @@ -414,9 +418,20 @@ when the system is in the sleep state.
>  might identify GPIO signals hooked up to a switch or other external hardware,
>  and :c:func:`pci_enable_wake()` does something similar for the PCI PME signal.
>
> -If any of these callbacks returns an error, the system won't enter the desired
> -low-power state.  Instead, the PM core will unwind its actions by resuming all
> -the devices that were suspended.
> +Some devices can only generate any signals if they are not suspended at all.  If
> +:c:func:`device_may_wakeup(dev)` returns ``true`` for such a device, it should
> +not be suspended during system-wide transitions to sleep states.  Device drivers
> +can indicate that condition to the PM core and middle-layer code (bus types or
> +PM domains) by setting the ``DPM_FLAG_IN_BAND_WAKEUP`` driver flag (at the probe
> +time).  The PM core and middle-layer code respond to that by avoiding to suspend
> +the device unless they have additional information on the device's wakeup
> +capabilities (for example, they may know that the device is in fact capable of
> +generating wakeup signals from a low-power state which the driver may not be
> +aware of).  In particular, the PM core will not invoke driver callbacks in the
> +``suspend_late`` and ``suspend_noirq`` phases for devices with
> +``DPM_FLAG_IN_BAND_WAKEUP`` set and for their ancestors and suppliers, but it
> +still will invoke middle-layer callbacks for them (if present) and those
> +callbacks are then responsible for handling the devices as appropriate.
>
>
>  Leaving System Suspend
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -609,6 +609,14 @@ static pm_callback_t dpm_subsys_suspend_
>                                                 pm_message_t state,
>                                                 const char **info_p);
>
> +static bool device_no_subsys_suspend(struct device *dev, pm_message_t state)
> +{
> +       pm_message_t suspend_msg = suspend_event(state);
> +
> +       return !dpm_subsys_suspend_late_cb(dev, suspend_msg, NULL) &&
> +               !dpm_subsys_suspend_noirq_cb(dev, suspend_msg, NULL);
> +}
> +
>  /**
>   * device_resume_noirq - Execute a "noirq resume" callback for given device.
>   * @dev: Device to handle.
> @@ -645,25 +653,26 @@ static int device_resume_noirq(struct de
>         if (skip_resume)
>                 goto Skip;
>
> -       if (dev_pm_smart_suspend_and_suspended(dev)) {
> -               pm_message_t suspend_msg = suspend_event(state);
> -
> -               /*
> -                * If "freeze" callbacks have been skipped during a transition
> -                * related to hibernation, the subsequent "thaw" callbacks must
> -                * be skipped too or bad things may happen.  Otherwise, resume
> -                * callbacks are going to be run for the device, so its runtime
> -                * PM status must be changed to reflect the new state after the
> -                * transition under way.
> -                */
> -               if (!dpm_subsys_suspend_late_cb(dev, suspend_msg, NULL) &&
> -                   !dpm_subsys_suspend_noirq_cb(dev, suspend_msg, NULL)) {
> +       if (device_no_subsys_suspend(dev, state)) {
> +               if (dev_pm_smart_suspend_and_suspended(dev)) {
> +                       /*
> +                        * If "freeze" callbacks have been skipped during a
> +                        * transition related to hibernation, the subsequent
> +                        * "thaw" callbacks must be skipped too or bad things
> +                        * may happen.  Otherwise, resume callbacks are going to
> +                        * be run for the device, so its runtime PM status must
> +                        * be changed to reflect the new state after the
> +                        * transition under way.
> +                        */
>                         if (state.event == PM_EVENT_THAW) {
>                                 skip_resume = true;
>                                 goto Skip;
>                         } else {
>                                 pm_runtime_set_active(dev);
>                         }
> +               } else if (dev_pm_skip_suspend_and_not_suspended(dev)) {
> +                       skip_resume = true;
> +                       goto Skip;
>                 }
>         }
>
> @@ -1317,7 +1326,8 @@ static int __device_suspend_noirq(struct
>
>         no_subsys_cb = !dpm_subsys_suspend_late_cb(dev, state, NULL);
>
> -       if (dev_pm_smart_suspend_and_suspended(dev) && no_subsys_cb)
> +       if ((dev_pm_smart_suspend_and_suspended(dev) ||
> +            dev_pm_skip_suspend_and_not_suspended(dev)) && no_subsys_cb)
>                 goto Skip;
>
>         if (dev->driver && dev->driver->pm) {
> @@ -1450,6 +1460,22 @@ int dpm_suspend_noirq(pm_message_t state
>         return ret;
>  }
>
> +static void dpm_superior_set_skip_suspend(struct device *dev)
> +{
> +       struct device_link *link;
> +       int idx;
> +
> +       if (dev->parent)
> +               dev->parent->power.skip_suspend = true;
> +
> +       idx = device_links_read_lock();
> +
> +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +               link->supplier->power.skip_suspend = true;
> +
> +       device_links_read_unlock(idx);
> +}
> +
>  static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
>                                                 pm_message_t state,
>                                                 const char **info_p)
> @@ -1511,11 +1537,17 @@ static int __device_suspend_late(struct
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
> +       if ((state.event == PM_EVENT_SUSPEND || state.event == PM_EVENT_HIBERNATE) &&
> +           dev_pm_test_driver_flags(dev, DPM_FLAG_IN_BAND_WAKEUP) &&
> +           device_may_wakeup(dev))
> +               dev->power.skip_suspend = true;
> +
>         callback = dpm_subsys_suspend_late_cb(dev, state, &info);
>         if (callback)
>                 goto Run;
>
> -       if (dev_pm_smart_suspend_and_suspended(dev) &&
> +       if ((dev_pm_smart_suspend_and_suspended(dev) ||
> +            dev_pm_skip_suspend_and_not_suspended(dev)) &&
>             !dpm_subsys_suspend_noirq_cb(dev, state, NULL))
>                 goto Skip;
>
> @@ -1534,6 +1566,9 @@ Run:
>  Skip:
>         dev->power.is_late_suspended = true;
>
> +       if (dev->power.skip_suspend)
> +               dpm_superior_set_skip_suspend(dev);
> +
>  Complete:
>         TRACE_SUSPEND(error);
>         complete_all(&dev->power.completion);
> @@ -1746,6 +1781,7 @@ static int __device_suspend(struct devic
>
>         dev->power.may_skip_resume = false;
>         dev->power.must_resume = false;
> +       dev->power.skip_suspend = false;
>
>         dpm_watchdog_set(&wd, dev);
>         device_lock(dev);
> @@ -2112,6 +2148,11 @@ void device_pm_check_callbacks(struct de
>         spin_unlock_irq(&dev->power.lock);
>  }
>
> +bool dev_pm_skip_suspend_and_not_suspended(struct device *dev)
> +{
> +       return dev->power.skip_suspend && !pm_runtime_status_suspended(dev);
> +}
> +
>  bool dev_pm_smart_suspend_and_suspended(struct device *dev)
>  {
>         return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
>
