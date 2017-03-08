From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] cpufreq: schedutil: remove redundant code from sugov_next_freq_shared()
Date: Wed, 8 Mar 2017 11:50:01 +0100
Message-ID: <CAJZ5v0jyX8DashfzBPmLxwRDqQsA_QK4OR=g7-R=jERyfOqAcw@mail.gmail.com>
References: <cover.1488437503.git.viresh.kumar@linaro.org> <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org>
 <1772276.4tCnP8C0XV@aspire.rjw.lan> <1668614.4zDQWLsnmH@aspire.rjw.lan>
 <20170306044553.GE8206@vireshk-i7> <CAJZ5v0hov8Lz_MK9dxP9MyqSmPNRfWV9Wia4DtAZtOPmoTOqAw@mail.gmail.com>
 <20170307103108.GA4526@vireshk-i7> <CAJZ5v0itZo-tybgz2p49VxkGzFL9EZBB-4aZg6R5sthVrBiAYQ@mail.gmail.com>
 <20170308041823.GB4526@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36182 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdCHKuI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2017 05:50:08 -0500
In-Reply-To: <20170308041823.GB4526@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Wed, Mar 8, 2017 at 5:18 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 07-03-17, 14:19, Rafael J. Wysocki wrote:
>> On Tue, Mar 7, 2017 at 11:31 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > Why do you think so? I thought all CPU in the policy can have the RT/DL flag set
>> > and the probability of all of them is just the same.
>>
>> Well, yes, but if the current CPU has that flag set already, we surely
>> don't need to check the other ones in the policy?
>
> That's true for every other CPU in policy too..

Not exactly.

The flags value for the current CPU is in a hot cache line already (if
not in a register) and it is not necessary to chase a pointer (and
possibly fetch a new cache line) to get to it.

That also applies to util and max for the current CPU, but the benefit
here is debatable.

>> >> So to the point, the code was written this way on purpose and not just
>> >> by accident as your changelog suggests and
>> >
>> > I didn't wanted to convey that really and I knew that it was written on purpose.
>> >
>> >> if you want to change it, you need numbers.
>> >
>> > What kind of numbers can we get for such a change ? I tried to take the running
>> > average of the time it takes to execute this routine over 10000 samples, but it
>> > varies a lot even with the same build. Any tests like hackbench, etc wouldn't be
>> > of any help as well.
>>
>> So why do you think it needs to be changed, but really?
>>
>> Is that because it is particularly hard to follow or similar?
>
> Just that I didn't like keeping the same code at two places (outside
> and inside the loop) and the benefit it has.

So there are two things here, the flags check and the invocation of
sugov_iowait_boost() for the current CPU.

I claim that the flags check is a clear benefit due to what I said above.

The other thing is a way to initialize util and max to sensible
values.  It also can be done the way you did it and that change should
not affect the execution time.

So overall, maybe you can move the flags check to
sugov_update_shared(), so that you don't need to pass flags to
sugov_next_freq_shared(), and then do what you did to util and max.

But that would be a 4.12 change anyway.

> Anyway, its not straight forward to get any numbers supporting my
> argument. I can claim improvement only theoretically by comparing the
> number of comparisons that we may end up doing for quad or octa core
> policies. Lets abandon this patch as I failed to convince you :)
>
> Thanks for applying the other two patches though.

No problem.

Thanks,
Rafael
