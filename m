From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Wed, 24 Jun 2015 10:33:54 +0200
Message-ID: <CAPDyKFqeYN2bWaQr=a8p7gPuFJtXEVr9k7+vuN_psyPgp90-rg@mail.gmail.com>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
	<1434958282-27376-1-git-send-email-geert+renesas@glider.be>
	<CAPDyKFpRMrJZxZPv8w+jLEGAHu8U+AGSeG3LaJMXGW9zn__o+g@mail.gmail.com>
	<CAMuHMdX4cWmkx_W4P8vh6soZD_LzHJWgL=QpVUrKdubo2LaePg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX4cWmkx_W4P8vh6soZD_LzHJWgL=QpVUrKdubo2LaePg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>>
>>> @@ -2183,6 +2191,7 @@ int genpd_dev_pm_attach(struct device *dev)
>>>  {
>>>         struct of_phandle_args pd_args;
>>>         struct generic_pm_domain *pd;
>>> +       unsigned int i;
>>>         int ret;
>>>
>>>         if (!dev->of_node)
>>> @@ -2218,10 +2227,13 @@ int genpd_dev_pm_attach(struct device *dev)
>>>
>>>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>>>
>>> -       while (1) {
>>> +       for (i = 0; i < GENPD_RETRIES; i++) {
>>>                 ret = pm_genpd_add_device(pd, dev);
>>>                 if (ret != -EAGAIN)
>>>                         break;
>>> +
>>> +               if (i > GENPD_RETRIES / 2)
>>> +                       udelay(GENPD_DELAY_US);
>>
>> In this execution path, we retry when getting -EAGAIN while believing
>> the reason to the error are only *temporary* as we are soon waiting
>> for all devices in the genpd to be system PM resumed. At least that's
>> my understanding to why we want to deal with -EAGAIN here, but I might
>> be wrong.
>>
>> In this regards, I wonder whether it could be better to re-try only a
>> few times but with a far longer interval time than a couple us. What
>> do you think?
>
> That's indeed viable. I have no idea for how long this temporary state can
> extend.

That will depend on the system PM resume time for the devices residing
in the genpd. So, I guess we need a guestimate then. How about a total
sleep time of a few seconds?

>
>> However, what if the reason to why we get -EAGAIN isn't *temporary*,
>> because we are about to enter system PM suspend state. Then the caller
>> of this function which comes via some bus' ->probe(), will hang until
>> the a system PM resume is completed. Is that really going to work? So,
>> for this case your limited re-try approach will affect this scenario
>> as well, have you considered that?
>
> There's a limit on the number of retries, so it won't hang indefinitely.

What happens with the timer functions (like msleep()) during the
system PM suspend transition?

Kind regards
Uffe
