From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [Resend][PATCH] cpufreq: conservative: Decrease frequency faster
 when the timer deferred
Date: Tue, 8 Nov 2016 21:25:14 +0200
Message-ID: <5ea3831e-7743-d39f-1f02-96c915cc757e@semaphore.gr>
References: <076fb177-9cb3-4534-aadb-ebc2190d0751@email.android.com>
 <CAKohpo=kbyXvjOYFdOyu6d6x1TP45UWT0kB9eAk3XUXTG5iUpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.semaphore.gr ([138.201.185.188]:53294 "EHLO
        mail.semaphore.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbcKHTZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 14:25:22 -0500
In-Reply-To: <CAKohpo=kbyXvjOYFdOyu6d6x1TP45UWT0kB9eAk3XUXTG5iUpQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 08/11/2016 10:32 πμ, Viresh Kumar wrote:
> On 8 November 2016 at 12:49, Stratos Karafotis <stratosk@semaphore.gr> wrote:
>> I think we shouldn't. That's why the patch first decreases the frequency
>> by n freq steps (where n the number of deferred periods).
>> Then the normal processing takes place.
> 
> The problem that I see is that the new algorithm will reduce the
> frequency even if we are
> on a ramp up phase.
> 
> For example consider this case:
> 
> - We have a special load running, that runs in bursts. i.e. runs for
> some time, lets the CPU idle
> then and then again runs.
> 
> - To run the load properly, we need to ramp up the frequency
> 
> - But the new algorithm can make the frequency stagnant in this case.
> i.e. because of the idle
> period you may want to decrease the frequency by delta A and then the
> regular algorithm may
> want to increase it by same delta A.
> 
> That's why I was asking to adopt this only in the ramp down path.
> 

But this is the supposed behaviour of conservative governor. We want
the CPU to increase the frequency in steps. The patch just resets
the frequency to a lower frequency in case of idle.

For argument's sake, let's assume that the governor timer is never
deferred and runs every sampling period even on completely idle CPU.
And let's assume, for example, a burst load that runs every 100ms
for 20ms. The default sampling rate is also 20ms.
What would conservative do in case of that burst load? It would
increase the frequency by one freq step after 20ms and then it would
decrease the frequency 4 times by one frequency step. Most probably
on the next burst load, the CPU will run on min frequency.

I agree that maybe this is not ideal for performance but maybe this is
how we want conservative governor to work (lazily increase and decrease
frequency).


Regards,
Stratos
