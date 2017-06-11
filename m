From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: Fix selection algorithm while
 reducing frequency
Date: Sat, 10 Jun 2017 23:21:30 -0700
Message-ID: <CAJWu+oomeeyCaz_zXQRGgz+yB59AANnrMLtXV8Lu+n=UvMhkcA@mail.gmail.com>
References: <cover.1497002895.git.viresh.kumar@linaro.org> <8d5e793df4f06d54794a889543817cf5be131650.1497002895.git.viresh.kumar@linaro.org>
 <CAJWu+or0GhiVS2rTAGMzS+y5xMrVUakYKO8G7u5Cn1dHX_P=SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:34964 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdFKGVb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jun 2017 02:21:31 -0400
Received: by mail-ot0-f182.google.com with SMTP id a2so54352064oth.2
        for <linux-pm@vger.kernel.org>; Sat, 10 Jun 2017 23:21:31 -0700 (PDT)
In-Reply-To: <CAJWu+or0GhiVS2rTAGMzS+y5xMrVUakYKO8G7u5Cn1dHX_P=SQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, John Ettedgui <john.ettedgui@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On Sat, Jun 10, 2017 at 2:11 AM, Joel Fernandes <joelaf@google.com> wrote:
> On Fri, Jun 9, 2017 at 3:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> While reducing frequency if there are no frequencies available between
>> "current" and "next" calculated frequency, then the core will never
>> select the "next" frequency.
>>
>> For example, consider the possible range of frequencies as 900 MHz, 1
>> GHz, 1.1 GHz, and 1.2 GHz. If the current frequency is 1.1 GHz and the
>> next frequency (based on current utilization) is 1 GHz, then the
>> schedutil governor will try to set the average of these as the next
>> frequency (i.e. 1.05 GHz).
>>
>> Because we always try to find the lowest frequency greater than equal to
>> the target frequency, cpufreq_driver_resolve_freq() will end up
>> returning 1.1 GHz only. And we will not be able to reduce the frequency
>> eventually. The worst hit is the policy->min frequency as that will
>> never get selected after the frequency is increased once.
>
> But once utilization goes to 0, it will select the min frequency
> (because it selects lowest frequency >= target)?

Never mind my comment about util 0, I see the problem you mention.
However I feel that this entire series adds complexity all to handle
the case of a false cache-miss which I think might not be that bad,
and the tradeoff with complexity/readability of the code kind of
negates the benefit. That's just my opinion about it fwiw.

Thanks,
Joel
