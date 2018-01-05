From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/4] PM / core: Propagate wakeup_path status flag in __device_suspend_late()
Date: Fri, 5 Jan 2018 18:12:25 +0100
Message-ID: <CAPDyKFpp73v9LbR0A65m9rmVPx6jZdipzxJ6+ZRSgvF86J2m7w@mail.gmail.com>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
 <1514909333-4450-3-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0iVbj7g6QkCJT2hG4=y=MRzXaB4yBbLQnjV3Pn5R0QLqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iVbj7g6QkCJT2hG4=y=MRzXaB4yBbLQnjV3Pn5R0QLqg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 5 January 2018 at 13:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jan 2, 2018 at 5:08 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Currently the wakeup_path status flag becomes propagated from a child
>> device to its parent device at __device_suspend(). This allows a driver
>> dealing with a parent device to act on the flag from its ->suspend()
>> callback.
>>
>> However, in situations when the wakeup_path status flag needs to be set
>> from a ->suspend_late() callback, its value doesn't get propagated to the
>> parent by the PM core. Let's address this limitation, by also propagating
>> the flag at __device_suspend_late().
>
> This doesn't need to be done twice, so doing it once in
> __device_suspend_late() should be sufficient.

Unfortunately no.

For example that would break drivers/ssb/pcihost_wrapper.c, as it uses
the flag from its ->suspend() callback.

Also, I expect there may be more cases when the flag may be useful to
check from a ->suspend() callback, rather than from a ->suspend_late()
(or in later phase).

>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/main.c | 33 +++++++++++++++++----------------
>>  1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 7aeb91d..612bf1b 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1476,6 +1476,22 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
>>         return callback;
>>  }
>>
>> +static void dpm_propagate_to_parent(struct device *dev)
>> +{
>> +       struct device *parent = dev->parent;
>> +
>> +       if (!parent)
>> +               return;
>> +
>> +       spin_lock_irq(&parent->power.lock);
>> +
>> +       parent->power.direct_complete = false;
>> +       if (dev->power.wakeup_path && !parent->power.ignore_children)
>> +               parent->power.wakeup_path = true;
>> +
>> +       spin_unlock_irq(&parent->power.lock);
>> +}
>
> Clearing the parent's direct_complete in __device_suspend_late() is
> incorrect, because it potentially overwrites the value previously used
> by __device_suspend() for the parent.

That is already taken care of in __device_suspend_late(), with the below check:

        if (dev->power.syscore || dev->power.direct_complete)
                goto Complete;

 In other words, the dpm_propagate_to_parent() isn't called when
dev->power.direct_complete is set.

>
> IMO it also need not be done under parent->power.lock, however,
> because the other parent's power. flags should not be updated in
> parallel with this update anyway, so maybe just move the parent's
> direct_complete update to __device_suspend(), rename
> dpm_propagate_to_parent() to something like
> dpm_propagate_wakeup_to_parent() and call it from
> __device_suspend_late() only?

I can do this, if you think this is more clear, but according to the
above, it's shouldn't be needed.

Kind regards
Uffe
