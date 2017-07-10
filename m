From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Mon, 10 Jul 2017 14:11:11 -0700
Message-ID: <CAGAzgspCPrmoSZ7MFKER7MF0Jo4Le=rqbf5+B0r662cb651o6A@mail.gmail.com>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <20170708000303.21863-2-dbasehore@chromium.org> <CAHp75Vcw7uG+d42Td9d7vzmzWu2b_LMKzeO=aHc5kWSDbS54KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33878 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754332AbdGJVLO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 17:11:14 -0400
Received: by mail-wr0-f173.google.com with SMTP id 77so155651802wrb.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2017 14:11:13 -0700 (PDT)
In-Reply-To: <CAHp75Vcw7uG+d42Td9d7vzmzWu2b_LMKzeO=aHc5kWSDbS54KA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, "x86@kernel.org" <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat, Jul 8, 2017 at 9:05 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jul 8, 2017 at 3:03 AM, Derek Basehore <dbasehore@chromium.org> wrote:
>> Adds a new feature to tick to schedule wakeups on a CPU during freeze.
>> This won't fully wake up the system (devices are not resumed), but
>> allow simple platform functionality to be run during freeze with
>> little power impact.
>>
>> This implementation allows an idle driver to setup a timer event with
>> the clock event device when entering freeze by calling
>> tick_set_freeze_event. Only one caller should exist for the function.
>>
>> tick_freeze_event_expired is used to check if the timer went off when
>> the CPU wakes.
>>
>> The event is cleared by tick_clear_freeze_event.
>
>> +int tick_set_freeze_event(int cpu, ktime_t delta)
>> +{
>
>> +               printk_deferred(KERN_WARNING
>> +                               "[%s] unsupported by clock event device\n",
>
> Can it be one line?

Sure. It seems that some of these lines were at 80 characters on one
line anyways. Putting some of these on one line breaks the 80
character limit and doesn't help with grepping through code, though.

>
>> +               printk_deferred(KERN_WARNING
>> +                               "[%s] clock event device in use\n",
>
> Ditto.
>
>> +               printk_deferred(KERN_WARNING
>> +                               "[%s] %lluns outside range: [%lluns, %lluns]\n",
>
> Ditto.
>
>> +               printk_deferred(KERN_WARNING
>> +                               "Failed to program freeze event\n");
>
> Ditto.
>
>> +int tick_freeze_event_expired(int cpu)
>> +{
>> +       struct clock_event_device *dev = per_cpu(tick_cpu_device, cpu).evtdev;
>> +
>> +       if (!(dev && dev->event_expired))
>
> Usually we use a pattern (!x || !x->y). At least for me it looks
> slightly better to read.

Will do.

>
>> +               return 0;
>> +
>> +       return dev->event_expired(dev);
>> +}
>
> --
> With Best Regards,
> Andy Shevchenko
