From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH 2/2] PM / QoS: Fix device resume latency framework
Date: Fri, 3 Nov 2017 11:38:54 +0100
Message-ID: <CAJZ5v0h3aDOE=j6=O-avxNQpXyTuddZhkOV6seaC3SW+VaMBUg@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2054600.p9BxnU7SDF@aspire.rjw.lan>
 <20171103074351.GB22692@intel.com> <CAJZ5v0gBgPBYRA2f3qbbNmJA+39v3avtge8kxFu0h_GGbrHz5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:49431 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbdKCKiz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2017 06:38:55 -0400
In-Reply-To: <CAJZ5v0gBgPBYRA2f3qbbNmJA+39v3avtge8kxFu0h_GGbrHz5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ramesh.thomas@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>

On Fri, Nov 3, 2017 at 8:58 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>  On Fri, Nov 3, 2017 at 8:43 AM, Ramesh Thomas <ramesh.thomas@intel.com> wrote:
>> On 2017-11-02 at 00:03:54 +0100, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The special value of 0 for device resume latency PM QoS means
>>> "no restriction", but there are two problems with that.
>>>
>>> First, device resume latency PM QoS requests with 0 as the
>>> value are always put in front of requests with positive
>>> values in the priority lists used internally by the PM QoS
>>> framework, causing 0 to be chosen as an effective constraint
>>> value.  However, that 0 is then interpreted as "no restriction"
>>> effectively overriding the other requests with specific
>>> restrictions which is incorrect.
>>>
>>> Second, the users of device resume latency PM QoS have no
>>> way to specify that *any* resume latency at all should be
>>> avoided, which is an artificial limitation in general.
>>>
>>> To address these issues, modify device resume latency PM QoS to
>>> use S32_MAX as the "no constraint" value and 0 as the "no
>>> latency at all" one and rework its users (the cpuidle menu
>>> governor, the genpd QoS governor and the runtime PM framework)
>>> to follow these changes.
>>>
>>> Also add a special "n/a" value to the corresponding user space I/F
>>> to allow user space to indicate that it cannot accept any resume
>>> latencies at all for the given device.
>>>
>>> Fixes: 85dc0b8a4019 (PM / QoS: Make it possible to expose PM QoS latency constraints)
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197323
>>> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-devices-power |    4 ++-
>>>  drivers/base/cpu.c                            |    3 +-
>>>  drivers/base/power/domain.c                   |    2 -
>>>  drivers/base/power/domain_governor.c          |   27 ++++++++++++--------------
>>>  drivers/base/power/qos.c                      |    5 +++-
>>>  drivers/base/power/runtime.c                  |    2 -
>>>  drivers/base/power/sysfs.c                    |   25 ++++++++++++++++++++----
>>>  drivers/cpuidle/governors/menu.c              |    4 +--
>>>  include/linux/pm_qos.h                        |   24 +++++++++++++++--------
>>>  9 files changed, 63 insertions(+), 33 deletions(-)
>>>
>>> Index: linux-pm/drivers/base/power/sysfs.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/power/sysfs.c
>>> +++ linux-pm/drivers/base/power/sysfs.c
>>> @@ -218,7 +218,14 @@ static ssize_t pm_qos_resume_latency_sho
>>>                                         struct device_attribute *attr,
>>>                                         char *buf)
>>>  {
>>> -     return sprintf(buf, "%d\n", dev_pm_qos_requested_resume_latency(dev));
>>> +     s32 value = dev_pm_qos_requested_resume_latency(dev);
>>> +
>>> +     if (value == 0)
>>> +             return sprintf(buf, "n/a\n");
>>> +     else if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>>> +             value = 0;
>>> +
>>> +     return sprintf(buf, "%d\n", value);
>>>  }
>>>
>>>  static ssize_t pm_qos_resume_latency_store(struct device *dev,
>>> @@ -228,11 +235,21 @@ static ssize_t pm_qos_resume_latency_sto
>>>       s32 value;
>>>       int ret;
>>>
>>> -     if (kstrtos32(buf, 0, &value))
>>> -             return -EINVAL;
>>> +     if (!kstrtos32(buf, 0, &value)) {
>>> +             /*
>>> +              * Prevent users from writing negative or "no constraint" values
>>> +              * directly.
>>> +              */
>>> +             if (value < 0 || value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>>> +                     return -EINVAL;
>>>
>>> -     if (value < 0)
>>> +             if (value == 0)
>>> +                     value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>> +     } else if (!strcmp(buf, "n/a") || !strcmp(buf, "n/a\n")) {
>>> +             value = 0;
>>> +     } else {
>>>               return -EINVAL;
>>> +     }
>>>
>>>       ret = dev_pm_qos_update_request(dev->power.qos->resume_latency_req,
>>>                                       value);
>>> Index: linux-pm/include/linux/pm_qos.h
>>> ===================================================================
>>> --- linux-pm.orig/include/linux/pm_qos.h
>>> +++ linux-pm/include/linux/pm_qos.h
>>> @@ -27,16 +27,17 @@ enum pm_qos_flags_status {
>>>       PM_QOS_FLAGS_ALL,
>>>  };
>>>
>>> -#define PM_QOS_DEFAULT_VALUE -1
>>> +#define PM_QOS_DEFAULT_VALUE (-1)
>>> +#define PM_QOS_LATENCY_ANY   S32_MAX
>>>
>>>  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE     (2000 * USEC_PER_SEC)
>>>  #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE     (2000 * USEC_PER_SEC)
>>>  #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE      0
>>>  #define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE        0
>>> -#define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE  0
>>> +#define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE  PM_QOS_LATENCY_ANY
>>> +#define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT  PM_QOS_LATENCY_ANY
>>>  #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE       0
>>>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT       (-1)
>>> -#define PM_QOS_LATENCY_ANY                   ((s32)(~(__u32)0 >> 1))
>>>
>>>  #define PM_QOS_FLAG_NO_POWER_OFF     (1 << 0)
>>>
>>> @@ -173,7 +174,8 @@ static inline s32 dev_pm_qos_requested_f
>>>  static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
>>>  {
>>>       return IS_ERR_OR_NULL(dev->power.qos) ?
>>> -             0 : pm_qos_read_value(&dev->power.qos->resume_latency);
>>> +             PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
>>> +             pm_qos_read_value(&dev->power.qos->resume_latency);
>>>  }
>>>  #else
>>>  static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
>>> @@ -183,9 +185,9 @@ static inline enum pm_qos_flags_status d
>>>                                                       s32 mask)
>>>                       { return PM_QOS_FLAGS_UNDEFINED; }
>>>  static inline s32 __dev_pm_qos_read_value(struct device *dev)
>>> -                     { return 0; }
>>> +                     { return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
>>>  static inline s32 dev_pm_qos_read_value(struct device *dev)
>>> -                     { return 0; }
>>> +                     { return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
>>>  static inline int dev_pm_qos_add_request(struct device *dev,
>>>                                        struct dev_pm_qos_request *req,
>>>                                        enum dev_pm_qos_req_type type,
>>> @@ -231,9 +233,15 @@ static inline int dev_pm_qos_expose_late
>>>                       { return 0; }
>>>  static inline void dev_pm_qos_hide_latency_tolerance(struct device *dev) {}
>>>
>>> -static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev) { return 0; }
>>> +static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
>>> +{
>>> +     return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>> +}
>>>  static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
>>> -static inline s32 dev_pm_qos_raw_read_value(struct device *dev) { return 0; }
>>> +static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
>>> +{
>>> +     return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>> +}
>>>  #endif
>>>
>>>  #endif
>>> Index: linux-pm/drivers/cpuidle/governors/menu.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
>>> +++ linux-pm/drivers/cpuidle/governors/menu.c
>>> @@ -298,8 +298,8 @@ static int menu_select(struct cpuidle_dr
>>>               data->needs_update = 0;
>>>       }
>>>
>>> -     /* resume_latency is 0 means no restriction */
>>> -     if (resume_latency && resume_latency < latency_req)
>>> +     if (resume_latency < latency_req &&
>>> +         resume_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>>>               latency_req = resume_latency;
>>>
>>>       /* Special case when user has set very strict latency requirement */
>>> Index: linux-pm/drivers/base/power/runtime.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/power/runtime.c
>>> +++ linux-pm/drivers/base/power/runtime.c
>>> @@ -253,7 +253,7 @@ static int rpm_check_suspend_allowed(str
>>>           || (dev->power.request_pending
>>>                       && dev->power.request == RPM_REQ_RESUME))
>>>               retval = -EAGAIN;
>>> -     else if (__dev_pm_qos_read_value(dev) < 0)
>>> +     else if (__dev_pm_qos_read_value(dev) == 0)
>>>               retval = -EPERM;
>>>       else if (dev->power.runtime_status == RPM_SUSPENDED)
>>>               retval = 1;
>>> Index: linux-pm/drivers/base/cpu.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/cpu.c
>>> +++ linux-pm/drivers/base/cpu.c
>>> @@ -377,7 +377,8 @@ int register_cpu(struct cpu *cpu, int nu
>>>
>>>       per_cpu(cpu_sys_devices, num) = &cpu->dev;
>>>       register_cpu_under_node(num, cpu_to_node(num));
>>> -     dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
>>> +     dev_pm_qos_expose_latency_limit(&cpu->dev,
>>> +                                     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
>>>
>>>       return 0;
>>>  }
>>> Index: linux-pm/drivers/base/power/qos.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/power/qos.c
>>> +++ linux-pm/drivers/base/power/qos.c
>>> @@ -139,6 +139,9 @@ static int apply_constraint(struct dev_p
>>>
>>>       switch(req->type) {
>>>       case DEV_PM_QOS_RESUME_LATENCY:
>>> +             if (WARN_ON(value < 0))
>>> +                     value = 0;
>>> +
>>>               ret = pm_qos_update_target(&qos->resume_latency,
>>>                                          &req->data.pnode, action, value);
>>>               break;
>>> @@ -189,7 +192,7 @@ static int dev_pm_qos_constraints_alloca
>>>       plist_head_init(&c->list);
>>>       c->target_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
>>>       c->default_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
>>> -     c->no_constraint_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
>>> +     c->no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>>       c->type = PM_QOS_MIN;
>>>       c->notifiers = n;
>>>
>>> Index: linux-pm/Documentation/ABI/testing/sysfs-devices-power
>>> ===================================================================
>>> --- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-power
>>> +++ linux-pm/Documentation/ABI/testing/sysfs-devices-power
>>> @@ -211,7 +211,9 @@ Description:
>>>               device, after it has been suspended at run time, from a resume
>>>               request to the moment the device will be ready to process I/O,
>>>               in microseconds.  If it is equal to 0, however, this means that
>>> -             the PM QoS resume latency may be arbitrary.
>>> +             the PM QoS resume latency may be arbitrary and the special value
>>> +             "n/a" means that user space cannot accept any resume latency at
>>> +             all for the given device.
>>>
>>>               Not all drivers support this attribute.  If it isn't supported,
>>>               it is not present.
>>> Index: linux-pm/drivers/base/power/domain.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/power/domain.c
>>> +++ linux-pm/drivers/base/power/domain.c
>>> @@ -1331,7 +1331,7 @@ static struct generic_pm_domain_data *ge
>>>
>>>       gpd_data->base.dev = dev;
>>>       gpd_data->td.constraint_changed = true;
>>> -     gpd_data->td.effective_constraint_ns = 0;
>>> +     gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>>       gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
>>>
>>>       spin_lock_irq(&dev->power.lock);
>>> Index: linux-pm/drivers/base/power/domain_governor.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/power/domain_governor.c
>>> +++ linux-pm/drivers/base/power/domain_governor.c
>>> @@ -26,11 +26,11 @@ static int dev_update_qos_constraint(str
>>>        * to take effect, the device has to be resumed and suspended again.
>>>        */
>>>       constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
>>> -     /* 0 means "no constraint" */
>>> -     if (constraint_ns == 0)
>>> +     if (constraint_ns == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>>>               return 0;
>>>
>>> -     if (constraint_ns < *constraint_ns_p || *constraint_ns_p == 0)
>>> +     if (constraint_ns < *constraint_ns_p ||
>>> +         *constraint_ns_p == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>>
>> Check for constraint_ns < *constraint_ns_p should be enough because
>> PM_QOS_RESUME_LATENCY_NO_CONSTRAINT = S32_MAX which is the largest possible
>> value, if that can be assumed here.
>
> Well, not quite.  effective_constraint_ns is s64 and it is the QoS
> value multiplied by NSEC_PER_USEC.
>
> Surely can be greater than PM_QOS_RESUME_LATENCY_NO_CONSTRAINT.
>
> Which reminds me about the possible collision in default_suspend_ok()
> which needs to be addressed. :-)
>
>>>               *constraint_ns_p = constraint_ns;
>>>
>>>       return 0;
>>> @@ -58,12 +58,12 @@ static bool default_suspend_ok(struct de
>>>       }
>>>       td->constraint_changed = false;
>>>       td->cached_suspend_ok = false;
>>> -     td->effective_constraint_ns = -1;
>>> +     td->effective_constraint_ns = 0;
>>>       constraint_ns = __dev_pm_qos_read_value(dev);
>>
>> Why not initialize td->effective_constraint_ns with what is read by
>> __dev_pm_qos_read_value()?

Because if that is 0, we can return without scribbling on it again in
the following code and if it wasn't 0, it would need to be multiplied
by NSEC_PER_USEC.

Thanks,
Rafael
