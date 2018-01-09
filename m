From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 9 Jan 2018 15:13:50 +0100
Message-ID: <CAPDyKFoQA41R1jS4+sMpTf1YuVivJuhT5MP+nSsDzKeDCLNcew@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <303007688.lvsDLFNCpe@aspire.rjw.lan>
 <CAPDyKFqePzeiSjR=yvCAtHfOv6vJLm3wdPifsseK1p4cyyB8qQ@mail.gmail.com> <4116669.Kt826NCPrf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4116669.Kt826NCPrf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-pm@vger.kernel.org

[...]

>> > +++ linux-pm/drivers/base/power/runtime.c
>> > @@ -1613,17 +1613,28 @@ void pm_runtime_drop_link(struct device
>> >         spin_unlock_irq(&dev->power.lock);
>> >  }
>> >
>> > +static bool pm_runtime_need_not_resume(struct device *dev)
>> > +{
>> > +       return atomic_read(&dev->power.usage_count) <= 1 &&
>> > +               atomic_read(&dev->power.child_count) == 0;
>>
>> We should take into account the ignore_children flag here, I think.
>> Something like this:
>>
>> return atomic_read(&dev->power.usage_count) <= 1 &&
>> (atomic_read(&dev->power.child_count) == 0 ||
>> dev->power.ignore_children)
>
> The current code doesn't quite take ignore_children into account, however.
>
> Regardless of which way the change is made, there will be one corner case
> that is not going to be covered.  First, if ignore_children is taken into
> account, some cases in which the current code increments the parent's
> usage counter will be treated as "need not resume".  Second, if ignore_children
> is ignored, some cases in which the parent's usage counter is not incremented
> today will cause the parent to resume after the change.
>
> Frankly, I prefer to ignore ignore_children at least for the time being,
> because resuming the parent unnecessarily is not a tragedy (it will likely
> suspend shortly anyway), but if it is necessary to resume it and it is not
> be resumed, things will visibly break.
>
> So, I'd prefer to leave this patch as is and do a second one adding the
> ignore_children check.  Then, if things break due to the second patch, it
> can be reverted easily (unless that can be fixed differently).

Okay, that seems like a reasonable approach.

Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
