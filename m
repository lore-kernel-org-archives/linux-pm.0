From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Resend][PATCH] cpufreq: conservative: Decrease frequency faster
 when the timer deferred
Date: Thu, 10 Nov 2016 01:13:49 +0100
Message-ID: <CAJZ5v0hsEd_fVQEnW9ELhauwot8ZdqxWRJJCoF_j599DyrMJ-g@mail.gmail.com>
References: <076fb177-9cb3-4534-aadb-ebc2190d0751@email.android.com>
 <CAKohpo=kbyXvjOYFdOyu6d6x1TP45UWT0kB9eAk3XUXTG5iUpQ@mail.gmail.com>
 <5ea3831e-7743-d39f-1f02-96c915cc757e@semaphore.gr> <20161109055537.GA5544@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33814 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbcKJANu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 19:13:50 -0500
In-Reply-To: <20161109055537.GA5544@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wed, Nov 9, 2016 at 6:55 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-11-16, 21:25, Stratos Karafotis wrote:
>> But this is the supposed behaviour of conservative governor. We want
>> the CPU to increase the frequency in steps. The patch just resets
>> the frequency to a lower frequency in case of idle.
>>
>> For argument's sake, let's assume that the governor timer is never
>> deferred and runs every sampling period even on completely idle CPU.
>
> There are no timers now :)
>
>> And let's assume, for example, a burst load that runs every 100ms
>> for 20ms. The default sampling rate is also 20ms.
>> What would conservative do in case of that burst load? It would
>> increase the frequency by one freq step after 20ms and then it would
>> decrease the frequency 4 times by one frequency step. Most probably
>> on the next burst load, the CPU will run on min frequency.
>>
>> I agree that maybe this is not ideal for performance but maybe this is
>> how we want conservative governor to work (lazily increase and decrease
>> frequency).
>
> Idle periods are already accounted for while calculating system load by legacy
> governors.
>
> And the more and more I think about this, I am inclined towards your patch.
> Maybe in a bit different form and commit log.
>
> If we see how the governors were written initially, there were no deferred
> timers. And so even if CPUs were idle, we will wake up to adjust the step.
>
> Even if we want to make the behavior similar to that, then also we should
> account of missed sampling periods both while decreasing or increasing
> frequencies.
>
> @Rafael: What do you think ?

It looks like the issue with the conservative governor is real, but
I'm a bit concerned about adding things to use by one particular
governor only to cpufreq_governor.c.

Apart from the timer-related terminology that is not applicable any
more, of course.

Thanks,
Rafael
