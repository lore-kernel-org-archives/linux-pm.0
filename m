From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / QOS: Remove the global notifiers
Date: Mon, 13 Mar 2017 17:01:38 +0100
Message-ID: <CAPDyKFpdTFkrTp5T_YfeuiciR-UUWk4GP6Pmjcg56fVc+6T6mQ@mail.gmail.com>
References: <8361bf69d667d7092c2b3b0ecabf147c7324ec33.1487752071.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36154 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdCMQBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 12:01:40 -0400
Received: by mail-vk0-f54.google.com with SMTP id t8so37554164vke.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 09:01:39 -0700 (PDT)
In-Reply-To: <8361bf69d667d7092c2b3b0ecabf147c7324ec33.1487752071.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>

On 22 February 2017 at 09:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> They were never used in the kernel, not sure why they got merged into
> the kernel though. Get rid of them.

commit b66213cdb002b08b29603d488c451dfe25e2ca20
Author: Jean Pihet <j-pihet@ti.com>
Date:   Thu Aug 25 15:35:47 2011 +0200

    PM QoS: Add global notification mechanism for device constraints

    Add a global notification chain that gets called upon changes to the
    aggregated constraint value for any device.
    The notification callbacks are passing the full constraint request data
    in order for the callees to have access to it. The current use is for the
    platform low-level code to access the target device of the constraint.

    Signed-off-by: Jean Pihet <j-pihet@ti.com>
    Reviewed-by: Kevin Hilman <khilman@ti.com>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

It was a while ago since they were added, but it seems like

Ackec

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/power/pm_qos_interface.txt | 13 +--------
>  drivers/base/power/qos.c                 | 50 +++-----------------------------
>  include/linux/pm_qos.h                   |  8 -----
>  3 files changed, 5 insertions(+), 66 deletions(-)
>
> diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
> index 129f7c0e1483..21d2d48f87a2 100644
> --- a/Documentation/power/pm_qos_interface.txt
> +++ b/Documentation/power/pm_qos_interface.txt
> @@ -163,8 +163,7 @@ of flags and remove sysfs attributes pm_qos_no_power_off and pm_qos_remote_wakeu
>  under the device's power directory.
>
>  Notification mechanisms:
> -The per-device PM QoS framework has 2 different and distinct notification trees:
> -a per-device notification tree and a global notification tree.
> +The per-device PM QoS framework has a per-device notification tree.
>
>  int dev_pm_qos_add_notifier(device, notifier):
>  Adds a notification callback function for the device.
> @@ -174,16 +173,6 @@ is changed (for resume latency device PM QoS only).
>  int dev_pm_qos_remove_notifier(device, notifier):
>  Removes the notification callback function for the device.
>
> -int dev_pm_qos_add_global_notifier(notifier):
> -Adds a notification callback function in the global notification tree of the
> -framework.
> -The callback is called when the aggregated value for any device is changed
> -(for resume latency device PM QoS only).
> -
> -int dev_pm_qos_remove_global_notifier(notifier):
> -Removes the notification callback function from the global notification tree
> -of the framework.
> -
>
>  Active state latency tolerance
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index d888d9869b6a..271bec73185e 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -17,12 +17,9 @@
>   *
>   * This QoS design is best effort based. Dependents register their QoS needs.
>   * Watchers register to keep track of the current QoS needs of the system.
> - * Watchers can register different types of notification callbacks:
> - *  . a per-device notification callback using the dev_pm_qos_*_notifier API.
> - *    The notification chain data is stored in the per-device constraint
> - *    data struct.
> - *  . a system-wide notification callback using the dev_pm_qos_*_global_notifier
> - *    API. The notification chain data is stored in a static variable.
> + * Watchers can register a per-device notification callback using the
> + * dev_pm_qos_*_notifier API. The notification chain data is stored in the
> + * per-device constraint data struct.
>   *
>   * Note about the per-device constraint data struct allocation:
>   * . The per-device constraints data struct ptr is tored into the device
> @@ -49,8 +46,6 @@
>  static DEFINE_MUTEX(dev_pm_qos_mtx);
>  static DEFINE_MUTEX(dev_pm_qos_sysfs_mtx);
>
> -static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
> -
>  /**
>   * __dev_pm_qos_flags - Check PM QoS flags for a given device.
>   * @dev: Device to check the PM QoS flags for.
> @@ -135,8 +130,7 @@ s32 dev_pm_qos_read_value(struct device *dev)
>   * @value: Value to assign to the QoS request.
>   *
>   * Internal function to update the constraints list using the PM QoS core
> - * code and if needed call the per-device and the global notification
> - * callbacks
> + * code and if needed call the per-device callbacks.
>   */
>  static int apply_constraint(struct dev_pm_qos_request *req,
>                             enum pm_qos_req_action action, s32 value)
> @@ -148,12 +142,6 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>         case DEV_PM_QOS_RESUME_LATENCY:
>                 ret = pm_qos_update_target(&qos->resume_latency,
>                                            &req->data.pnode, action, value);
> -               if (ret) {
> -                       value = pm_qos_read_value(&qos->resume_latency);
> -                       blocking_notifier_call_chain(&dev_pm_notifiers,
> -                                                    (unsigned long)value,
> -                                                    req);
> -               }
>                 break;
>         case DEV_PM_QOS_LATENCY_TOLERANCE:
>                 ret = pm_qos_update_target(&qos->latency_tolerance,
> @@ -536,36 +524,6 @@ int dev_pm_qos_remove_notifier(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
>
>  /**
> - * dev_pm_qos_add_global_notifier - sets notification entry for changes to
> - * target value of the PM QoS constraints for any device
> - *
> - * @notifier: notifier block managed by caller.
> - *
> - * Will register the notifier into a notification chain that gets called
> - * upon changes to the target value for any device.
> - */
> -int dev_pm_qos_add_global_notifier(struct notifier_block *notifier)
> -{
> -       return blocking_notifier_chain_register(&dev_pm_notifiers, notifier);
> -}
> -EXPORT_SYMBOL_GPL(dev_pm_qos_add_global_notifier);
> -
> -/**
> - * dev_pm_qos_remove_global_notifier - deletes notification for changes to
> - * target value of PM QoS constraints for any device
> - *
> - * @notifier: notifier block to be removed.
> - *
> - * Will remove the notifier from the notification chain that gets called
> - * upon changes to the target value for any device.
> - */
> -int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier)
> -{
> -       return blocking_notifier_chain_unregister(&dev_pm_notifiers, notifier);
> -}
> -EXPORT_SYMBOL_GPL(dev_pm_qos_remove_global_notifier);
> -
> -/**
>   * dev_pm_qos_add_ancestor_request - Add PM QoS request for device's ancestor.
>   * @dev: Device whose ancestor to add the request for.
>   * @req: Pointer to the preallocated handle.
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index d4d34791e463..3e2547d6e207 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -146,8 +146,6 @@ int dev_pm_qos_add_notifier(struct device *dev,
>                             struct notifier_block *notifier);
>  int dev_pm_qos_remove_notifier(struct device *dev,
>                                struct notifier_block *notifier);
> -int dev_pm_qos_add_global_notifier(struct notifier_block *notifier);
> -int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier);
>  void dev_pm_qos_constraints_init(struct device *dev);
>  void dev_pm_qos_constraints_destroy(struct device *dev);
>  int dev_pm_qos_add_ancestor_request(struct device *dev,
> @@ -199,12 +197,6 @@ static inline int dev_pm_qos_add_notifier(struct device *dev,
>  static inline int dev_pm_qos_remove_notifier(struct device *dev,
>                                              struct notifier_block *notifier)
>                         { return 0; }
> -static inline int dev_pm_qos_add_global_notifier(
> -                                       struct notifier_block *notifier)
> -                       { return 0; }
> -static inline int dev_pm_qos_remove_global_notifier(
> -                                       struct notifier_block *notifier)
> -                       { return 0; }
>  static inline void dev_pm_qos_constraints_init(struct device *dev)
>  {
>         dev->power.power_state = PMSG_ON;
> --
> 2.7.1.410.g6faf27b
>
