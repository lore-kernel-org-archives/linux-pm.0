From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/2] PM / domains: Rework governor code to be more consistent
Date: Tue, 7 Nov 2017 11:22:48 +0100
Message-ID: <CAJZ5v0gfJY27TzsW6EWY4JE8z6XaK4=BjD5KBpXXPnbDknGUHQ@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
 <2941273.uOhv3ydaDP@aspire.rjw.lan> <3615978.1OBBRZE5lx@aspire.rjw.lan> <20171107050544.GB17606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171107050544.GB17606@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 7, 2017 at 6:05 AM, Ramesh Thomas <ramesh.thomas@intel.com> wrote:
> On 2017-11-07 at 02:23:18 +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The genpd governor currently uses negative PM QoS values to indicate
>> the "no suspend" condition and 0 as "no restriction", but it doesn't
>> use them consistently.  Moreover, it tries to refresh QoS values for
>> already suspended devices in a quite questionable way.
>>
>> For the above reasons, rework it to be a bit more consistent.
>>
>> First off, note that dev_pm_qos_read_value() in
>> dev_update_qos_constraint() and __default_power_down_ok() is
>> evaluated for devices in suspend.  Moreover, that only happens if the
>> effective_constraint_ns value for them is negative (meaning "no
>> suspend").  It is not evaluated in any other cases, so effectively
>> the QoS values are only updated for devices in suspend that should
>> not have been suspended in the first place.  In all of the other
>> cases, the QoS values taken into account are the effective ones from
>> the time before the device has been suspended, so generally devices
>> need to be resumed and suspended again for new QoS values to take
>> effect anyway.  Thus evaluating dev_update_qos_constraint() in
>> those two places doesn't make sense at all, so drop it.
>>
>> Second, initialize effective_constraint_ns to 0 ("no constraint")
>> rather than to (-1) ("no suspend"), which makes more sense in
>> general and in case effective_constraint_ns is never updated
>> (the device is in suspend all the time or it is never suspended)
>> it doesn't affect the device's parent and so on.
>>
>> Finally, rework default_suspend_ok() to explicitly handle the
>> "no restriction" and "no suspend" special cases.
>>
>> Also add WARN_ON() around checks that should never trigger.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>
>> v2 -> v3: Take children that don't belong to genpd power domains into
>>           account in dev_update_qos_constraint().
>>
>> ---
>>  drivers/base/power/domain.c          |    2
>>  drivers/base/power/domain_governor.c |   71 ++++++++++++++++++++++++-----------
>>  2 files changed, 50 insertions(+), 23 deletions(-)
>>
>> Index: linux-pm/drivers/base/power/domain.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/domain.c
>> +++ linux-pm/drivers/base/power/domain.c
>> @@ -1331,7 +1331,7 @@ static struct generic_pm_domain_data *ge
>>
>>       gpd_data->base.dev = dev;
>>       gpd_data->td.constraint_changed = true;
>> -     gpd_data->td.effective_constraint_ns = -1;
>> +     gpd_data->td.effective_constraint_ns = 0;
>>       gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
>>
>>       spin_lock_irq(&dev->power.lock);
>> Index: linux-pm/drivers/base/power/domain_governor.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/domain_governor.c
>> +++ linux-pm/drivers/base/power/domain_governor.c
>> @@ -14,22 +14,33 @@
>>  static int dev_update_qos_constraint(struct device *dev, void *data)
>>  {
>>       s64 *constraint_ns_p = data;
>> -     s32 constraint_ns = -1;
>> +     s64 constraint_ns;
>>
>> -     if (dev->power.subsys_data && dev->power.subsys_data->domain_data)
>> +     if (dev->power.subsys_data && dev->power.subsys_data->domain_data) {
>> +             /*
>> +              * Only take suspend-time QoS constraints of devices into
>> +              * account, because constraints updated after the device has
>> +              * been suspended are not guaranteed to be taken into account
>> +              * anyway.  In order for them to take effect, the device has to
>> +              * be resumed and suspended again.
>> +              */
>>               constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
>> -
>> -     if (constraint_ns < 0) {
>> +     } else {
>> +             /*
>> +              * The child is not in a domain and there's no info on its
>> +              * suspend/resume latencies, so assume them to be negligible and
>> +              * take its current PM QoS constraint (that's the only thing
>> +              * known at this point anyway).
>> +              */
>>               constraint_ns = dev_pm_qos_read_value(dev);
>> -             constraint_ns *= NSEC_PER_USEC;
>> +             if (constraint_ns > 0)
>> +                     constraint_ns *= NSEC_PER_USEC;
>>       }
>> +
>> +     /* 0 means "no constraint" */
>>       if (constraint_ns == 0)
>>               return 0;
>>
>> -     /*
>> -      * constraint_ns cannot be negative here, because the device has been
>> -      * suspended.
>> -      */
>>       if (constraint_ns < *constraint_ns_p || *constraint_ns_p == 0)
>>               *constraint_ns_p = constraint_ns;
>>
>> @@ -76,14 +87,32 @@ static bool default_suspend_ok(struct de
>>               device_for_each_child(dev, &constraint_ns,
>>                                     dev_update_qos_constraint);
>>
>> -     if (constraint_ns > 0) {
>> +     if (constraint_ns == 0) {
>> +             /* "No restriction", so the device is allowed to suspend. */
>> +             td->effective_constraint_ns = 0;
>> +             td->cached_suspend_ok = true;
>> +     } else if (constraint_ns < 0) {
>> +             /*
>> +              * This triggers if one of the children that don't belong to a
>> +              * domain has a negative PM QoS constraint and it's better not
>> +              * to suspend then.  effective_constraint_ns is negative already
>> +              * and cached_suspend_ok is false, so bail out.
>> +              */
>> +             return false;
>
> This change is ok. However, would like to bring to your attention a possible
> inconsistency in the treatment of negative value as "no suspend at all" that
> can affect this.
>
> user level entry does not allow negative values. Only way to enter a negative
> value is if the kernel API to add/update is used. In that interface, if -1
> (PM_QOS_DEFAULT_VALUE) is passed, pm_qos_update_target will actually assign
> the default value stored in the constraint. The default value is
> PM_QOS_RESUME_LATENCY_DEFAULT_VALUE which is 0. 0 means "no constraint".

OK, but that only means that default_suspend_ok() will never see -1 as
a value.  It may see other negative values, though, and treating them
as "no suspend" is not incorrect.  So I don't think the patch needs to
be updated.

In any case, good catch!

Thanks,
Rafael
