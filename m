From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [Eas-dev] [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Thu, 27 Jul 2017 21:33:23 -0700
Message-ID: <CAEi0qNkHy7Ex418GgfOcK8-tc6nrLesT3EYo1GK8ybfmBqZvgA@mail.gmail.com>
References: <cover.1499927699.git.viresh.kumar@linaro.org> <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
 <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
 <597902DA.8060608@codeaurora.org> <20170727033059.GD352@vireshk-i7> <597A452C.7000303@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37011 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdG1EdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 00:33:25 -0400
In-Reply-To: <597A452C.7000303@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, eas-dev@lists.linaro.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <smuckle.linux@gmail.com>, Len Brown <lenb@kernel.org>, Joel Fernandes <joelaf@google.com>

On Thu, Jul 27, 2017 at 12:55 PM, Saravana Kannan
<skannan@codeaurora.org> wrote:
> On 07/26/2017 08:30 PM, Viresh Kumar wrote:
>>
>> On 26-07-17, 14:00, Saravana Kannan wrote:
>>>
>>> No, the alternative is to pass it on to the CPU freq driver and let it
>>> decide what it wants to do. That's the whole point if having a CPU freq
>>> driver -- so that the generic code doesn't need to care about HW specific
>>> details. Which is the point I was making in an earlier email to Viresh's
>>> patch -- we shouldn't be doing any CPU check for the call backs at the
>>> scheduler or ever governor level.
>>>
>>> That would simplify this whole thing by deleting a bunch of code. And
>>> having
>>> much simpler checks in those drivers that actually have to deal with
>>> their
>>> HW specific details.
>>
>>
>> So what you are saying is that we go and update (almost) every cpufreq
>> driver we have today and make their ->target() callbacks return early
>> if they don't support switching frequency remotely ? Is that really
>> simplifying anything?
>
>
> Yes. Simplifying isn't always about number of lines of code. It's also about
> abstraction. Having generic scheduler code care about HW details doesn't
> seem nice.
>
> It'll literally one simple check (cpu == smp_processor_id()) or (cpu "in"
> policy->cpus).
>

I think we can have both approaches? So we query the driver some time
around sugov_should_update_freq (with a new driver callback?) and ask
it if it has any say over the default behavior of "can't update remote
CPU if I'm not a part of its policy" and use that over the default if
it hasn't defined it in their struct cpufreq_driver.

I think this will also not have the concern of "updating every
driver", then we can just stick to the sane default of "no" for
drivers that haven't defined it. Probably Viresh has already thought
about this, but I just thought of bringing it up anyway. I also think
its fine to handle this case after this series gets in, but that's
just my opinion.

thanks!

-Joel
