From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [Resend][PATCH] cpufreq: conservative: Decrease frequency faster
 when the timer deferred
Date: Wed, 9 Nov 2016 20:27:28 +0200
Message-ID: <fcc84f05-408d-6020-5695-edb079728313@semaphore.gr>
References: <076fb177-9cb3-4534-aadb-ebc2190d0751@email.android.com>
 <CAKohpo=kbyXvjOYFdOyu6d6x1TP45UWT0kB9eAk3XUXTG5iUpQ@mail.gmail.com>
 <5ea3831e-7743-d39f-1f02-96c915cc757e@semaphore.gr>
 <20161109055537.GA5544@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161109055537.GA5544@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org



On 09/11/2016 07:55 πμ, Viresh Kumar wrote:
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

I have already tested a patch that tries to account the missed sampling
periods in load calculation and I will submit it, but I thought that
conservative should drop the frequency after the timer (or the update)
is deferred. This is the reason I first submitted this patch.


Regards,
Stratos
