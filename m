From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 4/4] PM / core: Print warn if device gets enabled as
 wakeup source during sleep
Date: Tue, 2 Jan 2018 13:30:27 +0100
Message-ID: <CAPDyKFoQUYHaqr7Tf5g9+8B2KF9pHXx7q+SEne7Mr1Z2r-ozBg@mail.gmail.com>
References: <1514547423-18965-1-git-send-email-ulf.hansson@linaro.org>
 <1514547423-18965-5-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0jWjvfQAttj6uhOhc_Hs1oT=sz3yEGnWGJaCMvJ7HJf8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jWjvfQAttj6uhOhc_Hs1oT=sz3yEGnWGJaCMvJ7HJf8Q@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 December 2017 at 01:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 29, 2017 at 12:37 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> In general, wakeup settings are not supposed to be changed during any of
>> the system wide PM phases. The reason is simply that it would break
>> guarantees provided by the PM core, to properly act on active wakeup
>> sources.
>>
>> However, there are exceptions to when, in particular, disabling a device as
>> wakeup source makes sense. For example, in cases when a driver realizes
>> that its device is dead during system suspend. For these scenarios, we
>> don't need to care about acting on the wakeup source correctly, because a
>> dead device shouldn't deliver wakeup signals.
>>
>> To this reasoning and to help users to properly manage wakeup settings,
>> let's print a warning in cases someone calls device_wakeup_enable() during
>> system sleep.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/main.c   | 4 ++++
>>  drivers/base/power/wakeup.c | 4 ++++
>>  include/linux/pm.h          | 1 +
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 1327726..6b0d312 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1030,6 +1030,8 @@ static void device_complete(struct device *dev, pm_message_t state)
>>                 callback(dev);
>>         }
>>
>> +       dev->power.may_set_wakeup = dev->power.can_wakeup;
>> +
>>         device_unlock(dev);
>>
>>         pm_runtime_put(dev);
>> @@ -1747,6 +1749,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>>
>>         device_lock(dev);
>>
>> +       dev->power.may_set_wakeup = false;
>>         dev->power.wakeup_path = false;
>>
>>         if (dev->power.no_pm_callbacks) {
>> @@ -1775,6 +1778,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>>         if (ret < 0) {
>>                 suspend_report_result(callback, ret);
>>                 pm_runtime_put(dev);
>> +               dev->power.may_set_wakeup = dev->power.can_wakeup;
>>                 return ret;
>>         }
>>         /*
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index cb72965..5445bea 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -268,6 +268,9 @@ int device_wakeup_enable(struct device *dev)
>>         if (!dev || !dev->power.can_wakeup)
>>                 return -EINVAL;
>>
>> +       if (!dev->power.may_set_wakeup)
>> +               dev_warn(dev, "don't enable as wakup source during sleep!\n");
>> +
>>         ws = wakeup_source_register(dev_name(dev));
>>         if (!ws)
>>                 return -ENOMEM;
>> @@ -413,6 +416,7 @@ void device_set_wakeup_capable(struct device *dev, bool capable)
>>                 return;
>>
>>         dev->power.can_wakeup = capable;
>> +       dev->power.may_set_wakeup = capable;
>>         if (device_is_registered(dev) && !list_empty(&dev->power.entry)) {
>>                 if (capable) {
>>                         int ret = wakeup_sysfs_add(dev);
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index ebc6ef8..106fb15 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -606,6 +606,7 @@ struct dev_pm_info {
>>         struct list_head        entry;
>>         struct completion       completion;
>>         struct wakeup_source    *wakeup;
>> +       bool                    may_set_wakeup:1;
>>         bool                    wakeup_path:1;
>>         bool                    syscore:1;
>>         bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>> --
>
> I didn't mean anything so complicated. :-)

Okay. :-)

>
> Just a warning message if (pm_suspend_target_state != PM_SUSPEND_ON)
> in device_wakeup_enable() (or equivalent) should be sufficient.

Alright, let me re-spin this and thanks for the suggestion.

Kind regards
Uffe
