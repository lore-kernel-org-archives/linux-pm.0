From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 4/4] PM / wakeup: Print warn if device gets enabled as
 wakeup source during sleep
Date: Mon, 8 Jan 2018 12:13:05 +0100
Message-ID: <CAPDyKFor=wOr8RZ0g1rw=gJb4D4mRyrOL-3yYYZaCsR9vE=ZMw@mail.gmail.com>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
 <1514909333-4450-5-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0ix1HH_az91ga5ETpi-qCS4MFtfyC6oB+Umdqw+9MzOrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ix1HH_az91ga5ETpi-qCS4MFtfyC6oB+Umdqw+9MzOrQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 6 January 2018 at 00:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jan 2, 2018 at 5:08 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
>> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/wakeup.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index b7b8b2f..272c44b 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -268,6 +268,9 @@ int device_wakeup_enable(struct device *dev)
>>         if (!dev || !dev->power.can_wakeup)
>>                 return -EINVAL;
>>
>> +       if (pm_suspend_target_state != PM_SUSPEND_ON)
>> +               dev_warn(dev, "don't enable as wakup source during sleep!\n");
>> +
>>         ws = wakeup_source_register(dev_name(dev));
>>         if (!ws)
>>                 return -ENOMEM;
>> --
>
> It looks like we need to defer this until we fix a couple of issues ...

Yes.

Or, perhaps changing from dev_warn() to dev_dbg(), as it could provide
us with some more detailed information, compared to a "git grep"
research?

Kind regards
Uffe
