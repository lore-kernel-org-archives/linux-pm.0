From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Tue, 2 Jan 2018 12:36:55 +0100
Message-ID: <CAPDyKFq_sOvGBkSgVKgzooKke_huNFxOQabk+QiLGFCiP6vvWA@mail.gmail.com>
References: <1514547423-18965-1-git-send-email-ulf.hansson@linaro.org>
 <1514547423-18965-2-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0gCnQgRS7aBkQ6LUoNab0_=mMqdqje+YLmJpcusANkfMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:44019 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeABLg5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 06:36:57 -0500
Received: by mail-io0-f180.google.com with SMTP id w188so4245819iod.10
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 03:36:56 -0800 (PST)
In-Reply-To: <CAJZ5v0gCnQgRS7aBkQ6LUoNab0_=mMqdqje+YLmJpcusANkfMg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 30 December 2017 at 01:44, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 29, 2017 at 12:37 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The PM core in the device_prepare() phase, resets the wakeup_path status
>> flag to the value of device_may_wakeup(). This means if a ->prepare() or a
>> ->suspend() callback for the device would update the device's wakeup
>> setting, this doesn't become reflected in the wakeup_path status flag.
>>
>> In general this isn't a problem, because wakeup settings are not supposed
>> to be changed (via for example calling device_set_wakeup_enable()) during
>> any system wide suspend/resume phase.  Nevertheless there are some users,
>> which can be considered as legacy, that don't conform to this behaviour.
>>
>> These legacy cases should be corrected, however until that is done, let's
>> address the issue from the PM core, by moving the assignment of the
>> wakeup_path status flag to the __device_suspend() phase and after the
>> ->suspend() callback has been invoked.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/main.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 6e8cc5d..810e5fb 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1620,6 +1620,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>>   End:
>>         if (!error) {
>>                 dev->power.is_suspended = true;
>> +               if (device_may_wakeup(dev))
>> +                       dev->power.wakeup_path = true;
>>                 dpm_propagate_to_parent(dev);
>>                 dpm_clear_suppliers_direct_complete(dev);
>>         }
>> @@ -1744,7 +1746,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>>
>>         device_lock(dev);
>>
>> -       dev->power.wakeup_path = device_may_wakeup(dev);
>> +       dev->power.wakeup_path = false;
>
> If you did "dev->power.wakeup_path = device_may_wakeup(dev)" in
> __device_suspend(), it wouldn't need to be cleared here I guess?
>

No that doesn't work, because it may override the value of the flag
wrongly, in case a child's wakeup_path flag that is set and has been
propagated to the parent.

>>
>>         if (dev->power.no_pm_callbacks) {
>>                 ret = 1;        /* Let device go direct_complete */
>> --
>> 2.7.4
>>

Kind regards
Uffe
