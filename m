From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v2 1/2] PM / domains: Rework governor code to be more consistent
Date: Mon, 6 Nov 2017 13:34:28 +0100
Message-ID: <CAJZ5v0jmeqxZyws_hS8T8pZdHK2p3kzzAA4-jaJw9+v9gv1DRQ@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
 <1780873.Ca3tjQj9XB@aspire.rjw.lan> <CAPDyKFox_5XN1bV1rG_DJvADnpQLqBQcJFDamkEvpRXRMP7mag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45600 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdKFMe3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 07:34:29 -0500
In-Reply-To: <CAPDyKFox_5XN1bV1rG_DJvADnpQLqBQcJFDamkEvpRXRMP7mag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

On Mon, Nov 6, 2017 at 1:10 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 November 2017 at 12:47, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
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
>> "no restriction" special case.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/base/power/domain.c          |    2 -
>>  drivers/base/power/domain_governor.c |   61 +++++++++++++++++++++--------------
>>  2 files changed, 38 insertions(+), 25 deletions(-)
>>
>> Index: linux-pm/drivers/base/power/domain.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/domain.c
>> +++ linux-pm/drivers/base/power/domain.c
>> @@ -1331,7 +1331,7 @@ static struct generic_pm_domain_data *ge
>>
>>         gpd_data->base.dev = dev;
>>         gpd_data->td.constraint_changed = true;
>> -       gpd_data->td.effective_constraint_ns = -1;
>> +       gpd_data->td.effective_constraint_ns = 0;
>>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
>>
>>         spin_lock_irq(&dev->power.lock);
>> Index: linux-pm/drivers/base/power/domain_governor.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/domain_governor.c
>> +++ linux-pm/drivers/base/power/domain_governor.c
>> @@ -14,22 +14,22 @@
>>  static int dev_update_qos_constraint(struct device *dev, void *data)
>>  {
>>         s64 *constraint_ns_p = data;
>> -       s32 constraint_ns = -1;
>> -
>> -       if (dev->power.subsys_data && dev->power.subsys_data->domain_data)
>> -               constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
>> +       s64 constraint_ns;
>>
>> -       if (constraint_ns < 0) {
>> -               constraint_ns = dev_pm_qos_read_value(dev);
>> -               constraint_ns *= NSEC_PER_USEC;
>> -       }
>> -       if (constraint_ns == 0)
>> +       if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data)
>>                 return 0;
>>
>>         /*
>> -        * constraint_ns cannot be negative here, because the device has been
>> -        * suspended.
>> +        * Only take suspend-time QoS constraints of devices into account,
>> +        * because constraints updated after the device has been suspended are
>> +        * not guaranteed to be taken into account anyway.  In order for them
>> +        * to take effect, the device has to be resumed and suspended again.
>>          */
>
> This means a change in behavior, because earlier we took into account
> QoS values for child devices that were not attached to a genpd.

OK

I have overlooked it or rather have forgotten about that.

> Is there any reason you think we should change this, or is it just
> something you overlooked here?
>
> I understand, that if the QoS constraint has been updated after such
> child device has been suspended, it's tricky to take a correct
> decision.

Right, but if they are not in a domain, the best we can do is to look
at the current value.

> To really solve this, we would either have to register a QoS notifier
> for all children devices that has its parent attached to a genpd, or
> always runtime resume devices before updating QoS constraints.
>
> Non of these options is perfect, so perhaps we should consider a "best
> effort" approach instead? Whatever that may be.

I think best effort makes most sense.

So I guess I'll simply evaluate dev_pm_qos_read_value(dev) if
subsys_data or subsys_data->domain_data is not there.

Of course, that doesn't apply to the code in __default_power_down_ok()
as that only takes device in the domain into account anyway.

Thanks,
Rafael
