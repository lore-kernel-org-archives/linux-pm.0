From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
Date: Wed, 6 Sep 2017 15:54:06 +0200
Message-ID: <CAPDyKFr8jEBf9YRUQGOwFi0q7V70f-fTGbOW6q2L1yB85JQn1w@mail.gmail.com>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
 <1668277.7DWLdgHGid@aspire.rjw.lan> <CAPDyKFpX3Owk4H=0SqgfspXZd9TmdL_ANOZftXRq6HPjrT2ctQ@mail.gmail.com>
 <1883292.VFru06qUYG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1883292.VFru06qUYG@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

>
>> >
>> > Now, if that's just one device, it probably doesn't matter, but if there are
>> > more devices like that, they will be resumed after system suspend when they
>> > are accessed and quite likely they will be accessed one-by-one rather than in
>> > parallel with each other, so the latencies related to that will add up.  In
>> > that case it is better to resume them upfront during system resume as they will
>> > be resumed in parallel with each other then.  And that also is *way* simpler.
>> >
>> > This means that the benefit from avoiding to resume devices during system
>> > resume is not quite so obvious and the whole point above is highly
>> > questionable.
>>
>> I hope my reasoning above explains why I think it shouldn't be
>> considered as questionable.
>>
>> If you like, I can also provide some real data/logs - showing you
>> what's happening.
>>
>
> That's not necessary, this behavior can be useful and there are arguments for
> doing it in *some* cases, but all of this argumentation applies to devices
> that aren't going to be used right after system resume.  If they *are* going
> to be used then, it very well may be better to resume them as part of
> system resume instead of deferring that.
>
> The tricky part is that at the point the resume callbacks run it is not known
> whether or not the device is going to be accessed shortly and the decision made
> either way may be suboptimal.

You have a point and it seems like this is what everything boils done
to, except for the reasons about that you dislike how
pm_runtime_force_suspend|resume() is being used by drivers.

To clarify, let me bring up yet another typical scenario, observed
often in cases when pm_runtime_force_suspend|resume is not used.

During system resume the device gets resumed, then shortly after the
system resume sequence has completed, it become runtime suspened,
because pm_runtime_put() is called in device_complete(). Then, soon
after the system has resumed, the device becomes runtime resumed
again, which is because there is a request for it to really be used.

This means we end up resuming the device, suspending it then and
resuming it again, all within a very short time frame. I guess this is
also one of those tricky cases you refer to above, because one just
can know how long after the system has resumed it takes for the device
to be requested to be used again, thus we end up runtime suspending
the device in-between.

To me, spending lot of time in the world of embedded battery driven
devices, this behavior isn't good enough, because it increases system
resume time and may waste some power. Apologize if you find me
repeating myself.

Anyway, this leads to my final question, do you want this behavior to
be better addressed by the ACPI PM domain, if it can be solved nicely,
or are you fine with how works today?

>
> [Note: I know that people mostly care about seeing the screen on, but in fact
> they should *also* care about the touch panel being ready to respond to
> touches, for example.  If it isn't ready and the system suspends again
> after a while because of that, the experience is somehwat less than fantastic.]
>

Yep!

[...]

>> Comparing a call to pm_runtime_resume(); this may trigger rpm_resume()
>> to invoke the callbacks. To me, the difference is that the conditions
>> looked at in rpm_resume(), when runtime PM is enabled, becomes
>> different for system sleep when runtime PM is disabled - and that is
>> taken care of in pm_runtime_force_suspend|resume().
>
> So actually invoking runtime PM from a *driver* ->suspend callback for the
> same device it was called for is fishy at best and may be a bug.  I'm not
> sure why I had been thinking that it might have been fine at all.  It isn't.

Huh, now you lost me. :-)

>
> The reason why is because runtime PM *potentially* involves invoking middle
> layer callbacks an they generally may look like
>
> ->runtime_resume:
>         (1) do A
>         (2) call driver ->runtime_resume
>         (3) do B
>
> Now, a middle layer ->suspend callback generally may look like this:
>
> ->suspend:
>         (1) do C
>         (2) call driver ->suspend
>         (3) do D
>
> and if you stick the middle layer ->runtime_suspend invocation into the
> driver ->suspend (which effectively is what running runtime PM in there means),
> you get something like
>
> do C
> ...
> do A
> call driver ->runtime_resume
> do B
> ...
> do D
>
> and there's no guarantee whatever that "do C" can go before "do A" and
> "do B" can go before "do D".  That depends on how the middle layer is designed
> and there may be good reasons for how it works.

For ARM SoCs, not using the ACPI PM domain, many drivers needs to be
able to use runtime PM during system suspend, simply because the PM
domain/middle layer, has no knowledge of what the driver needs to put
its device into low power state during system suspend.

For many of the simple cases, the PM domain/middle layer act
transparent to this, which means leaving what needs to be done to the
driver (platform, spi, i2c, amba, genpd etc).

I understand there may be some cases where the situation becomes more
complex and interaction between the driver and the PM domain/middle
layer is required, like what it seems for in ACPI PM domain and PCI,
but is that a reason turn the world upside down for everybody else?

Or perhaps I don't understand what your are suggesting here.

[...]

>
>> I think the relevant use case here is when a parent and a child, both
>> have subsystems/drivers using pm_runtime_force_suspend|resume(). If
>> that isn't the case, we expect that the parent is always resumed
>> during system resume.
>
> Why?

Because the child may rely on that for it to be resumed.

Moreover, the expectation is that the parent likely doesn't support
runtime PM, or that it not yet supports the optimized method of using
pm_runtime_force_suspend|resume() during system sleep, and will thus
resume its device always during system resume.

>
>> It's a bit fragile approach, so we perhaps we
>> should deal with it, even if the hole thing is used as opt-in.
>>
>> Anyway, let's focus on the case which I think is most relevant to your question:
>>
>> A couple of conditions to start with.
>> *) The PM core system suspends a child prior a parent, which leads to
>> pm_runtime_force_suspend() being called for the child first.
>> **) The PM core system resumes a parents before a child, thus
>> pm_runtime_force_resume() is called for the parent first.
>>
>> In case a child don't need to be resumed when
>> pm_runtime_force_resume() is called for it, likely doesn't its parent.
>> However, to control that, in system suspend the
>> pm_runtime_force_suspend() increases the usage counter for the parent,
>> as to indicate if it needs to be resumed when
>> pm_runtime_force_resume() is called for it.
>
> OK, I see.
>
> Why is usage_count > 1 used as the condition to trigger this behavior?

It takes into account that the PM core increases the usage count in
device_prepare(), but which isn't because it needs the device to be
operational.

Kind regards
Uffe
