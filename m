From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/4] PM / core: Propagate wakeup_path status flag in __device_suspend_late()
Date: Sat, 6 Jan 2018 00:25:21 +0100
Message-ID: <CAJZ5v0i5XELAXHCsWAsAnMJp_bR3_2cnb2yfnOspWSk9cHL43w@mail.gmail.com>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
 <1514909333-4450-3-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0iVbj7g6QkCJT2hG4=y=MRzXaB4yBbLQnjV3Pn5R0QLqg@mail.gmail.com>
 <CAPDyKFpp73v9LbR0A65m9rmVPx6jZdipzxJ6+ZRSgvF86J2m7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41280 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeAEXZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 18:25:22 -0500
In-Reply-To: <CAPDyKFpp73v9LbR0A65m9rmVPx6jZdipzxJ6+ZRSgvF86J2m7w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Fri, Jan 5, 2018 at 6:12 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 5 January 2018 at 13:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Tue, Jan 2, 2018 at 5:08 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Currently the wakeup_path status flag becomes propagated from a child
>>> device to its parent device at __device_suspend(). This allows a driver
>>> dealing with a parent device to act on the flag from its ->suspend()
>>> callback.
>>>
>>> However, in situations when the wakeup_path status flag needs to be set
>>> from a ->suspend_late() callback, its value doesn't get propagated to the
>>> parent by the PM core. Let's address this limitation, by also propagating
>>> the flag at __device_suspend_late().
>>
>> This doesn't need to be done twice, so doing it once in
>> __device_suspend_late() should be sufficient.
>
> Unfortunately no.
>
> For example that would break drivers/ssb/pcihost_wrapper.c, as it uses
> the flag from its ->suspend() callback.

But what drivers/ssb/pcihost_wrapper.c does is just wrong!

I guess we'd need a special variant of pci_prepare_to_sleep() with an
extra "wakeup" arg for it to do the right thing and I don't see why it
cannot do all that in ->suspend_late.

> Also, I expect there may be more cases when the flag may be useful to
> check from a ->suspend() callback, rather than from a ->suspend_late()
> (or in later phase).

I'm not inclined to believe it until I see a convincing example. :-)

And it obviously won't take the later updates of power.wakeup_path into account.

Anyway, for the time being please at least add a comment next to the
first invocation of this routine to explain why it is needed in there.

>
>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/main.c | 33 +++++++++++++++++----------------
>>>  1 file changed, 17 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index 7aeb91d..612bf1b 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -1476,6 +1476,22 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
>>>         return callback;
>>>  }
>>>
>>> +static void dpm_propagate_to_parent(struct device *dev)
>>> +{
>>> +       struct device *parent = dev->parent;
>>> +
>>> +       if (!parent)
>>> +               return;
>>> +
>>> +       spin_lock_irq(&parent->power.lock);
>>> +
>>> +       parent->power.direct_complete = false;
>>> +       if (dev->power.wakeup_path && !parent->power.ignore_children)
>>> +               parent->power.wakeup_path = true;
>>> +
>>> +       spin_unlock_irq(&parent->power.lock);
>>> +}
>>
>> Clearing the parent's direct_complete in __device_suspend_late() is
>> incorrect, because it potentially overwrites the value previously used
>> by __device_suspend() for the parent.
>
> That is already taken care of in __device_suspend_late(), with the below check:
>
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
>  In other words, the dpm_propagate_to_parent() isn't called when
> dev->power.direct_complete is set.

Which means that the parent's direct_complete is only cleared when it
is unset already, so this isn't incorrect, but just pointless.

Well, "pointless" doesn't really sound good to me too ...

>>
>> IMO it also need not be done under parent->power.lock, however,
>> because the other parent's power. flags should not be updated in
>> parallel with this update anyway, so maybe just move the parent's
>> direct_complete update to __device_suspend(), rename
>> dpm_propagate_to_parent() to something like
>> dpm_propagate_wakeup_to_parent() and call it from
>> __device_suspend_late() only?
>
> I can do this, if you think this is more clear, but according to the
> above, it's shouldn't be needed.

Yes, please.

Apart from avoiding a pointless update of the parent's direct_complete
I think that it's better to keep it close to the update of
direct_complete for suppliers.

Thanks,
Rafael
