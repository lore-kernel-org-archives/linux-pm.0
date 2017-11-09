From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] PM / core: Add WAKEUP_POWERED driver flag
Date: Thu, 9 Nov 2017 09:44:38 +0100
Message-ID: <CAPDyKFpn5m+t-hBcFT1RebqaTtyLna9JCNJtsFA6yZwurKTxvw@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
 <1510154134-1248-3-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0jFLL2pBNPo=J3MdwfcA9C+nSMe_S6iBYLoEA8SjbOJ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:48555 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbdKIIoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 03:44:39 -0500
Received: by mail-it0-f42.google.com with SMTP id c3so10307692itc.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Nov 2017 00:44:39 -0800 (PST)
In-Reply-To: <CAJZ5v0jFLL2pBNPo=J3MdwfcA9C+nSMe_S6iBYLoEA8SjbOJ+A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 9 November 2017 at 01:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Nov 8, 2017 at 4:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> For some bus types and PM domains, it's not sufficient to only check the
>> return value from device_may_wakeup(), to fully understand how to treat the
>> device during system suspend.
>>
>> In particular, sometimes the device may need to stay in full power state,
>> to have wakeup signals enabled for it. Therefore, define and document a
>> WAKEUP_POWERED flag, to enable drivers to instruct bus types and PM domains
>> exactly about that.
>>
>> During __device_suspend() in the PM core, let's make sure to also propagate
>> the setting of the flag to the parent device, when wakeup signals are
>> enabled and unless the parent has the "ignore_children" flag set. This
>> makes it also consistent with how the existing "wakeup_path" flag is being
>> assigned.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  Documentation/driver-api/pm/devices.rst | 12 ++++++++++++
>>  drivers/base/power/main.c               |  6 +++++-
>>  include/linux/pm.h                      |  5 +++++
>>  3 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
>> index 53c1b0b..1ca2d0f 100644
>> --- a/Documentation/driver-api/pm/devices.rst
>> +++ b/Documentation/driver-api/pm/devices.rst
>> @@ -414,6 +414,18 @@ when the system is in the sleep state.  For example, :c:func:`enable_irq_wake()`
>>  might identify GPIO signals hooked up to a switch or other external hardware,
>>  and :c:func:`pci_enable_wake()` does something similar for the PCI PME signal.
>>
>> +Moreover, in case wakeup signals are enabled for a device, some bus types and
>> +PM domains may manage the device slightly differently during system suspend. For
>> +example, sometimes the device needs to stay in full power state, to have wakeup
>> +signals enabled for it. In cases when the wakeup settings are mostly managed by
>> +the driver, it may not be sufficient for bus types and PM domains to only check
>> +the return value of :c:func:`device_may_wakeup(dev)`, to understand what actions
>> +are needed. Therefore, drivers can set ``DPM_FLAG_WAKEUP_POWERED`` in
>> +:c:member:`power.driver_flags`, by passing the flag to
>> +:c:func:`dev_pm_set_driver_flags` helper. This instructs bus types and PM
>> +domains to leave the device in full power state, when wakeup signals are enabled
>> +for it.
>
> IMO this is a bit unclear.
>
> First off, how does the driver know that the device has to be in full
> power for wakeup to work?

Because the device is accessed as part of dealing with the wakeup.

>
> Second, this requirement sort of implies that the device cannot go
> into a low-power state during runtime suspend too, so it basically
> remains stays at full power even when runtime-suspended.

No, not really, because that depends on the current situation.

An Ethernet device can surely go into a low power state, at runtime
suspend, when the interface is down, for example.

>
> Does it then mean that the middle layer is expected to simply avoid
> changing the power state of the device when enabled to wake up the
> system, or is there more to that?  In the former case, it may be
> better to rename the flag to something along the lines of "don't
> change power state if wakeup enabled".

Yes, correct.

I can try to clarify that in the description and unless you have a
suggestion for a better name of the flag, I try to come up with
something for that too.

>>  #define DPM_FLAG_NEVER_SKIP    BIT(0)
>>  #define DPM_FLAG_SMART_PREPARE BIT(1)
>>  #define DPM_FLAG_SMART_SUSPEND BIT(2)
>> +#define DPM_FLAG_WAKEUP_POWERED        BIT(3)
>
> I'd prefer this to be BIT(4).

OK.

I guess you can always also amend my patch, depending on in what order
you merge things. :-)

[...]

Kind regards
Uffe
