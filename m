From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v2 1/2] cpufreq: Make iowait boost a policy option
Date: Wed, 24 May 2017 13:17:01 -0700
Message-ID: <CAJWu+op_QRJWt=L=gGOk15pryD+1pm5xk9q90yt9wD1insdEzA@mail.gmail.com>
References: <20170519062344.27692-1-joelaf@google.com> <20170519062344.27692-2-joelaf@google.com>
 <20170519094245.ztm6tt2iwkaiwsya@hirez.programming.kicks-ass.net>
 <CAJWu+opefgyzER6jKTa1ktrT4pGL=bKdhAP2+i40k5tYAR38wA@mail.gmail.com> <20170522082154.f57cqovterd2qajv@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33450 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032504AbdEXURD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2017 16:17:03 -0400
Received: by mail-vk0-f47.google.com with SMTP id x71so81558583vkd.0
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2017 13:17:02 -0700 (PDT)
In-Reply-To: <20170522082154.f57cqovterd2qajv@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>

Hi Peter,

On Mon, May 22, 2017 at 1:21 AM, Peter Zijlstra <peterz@infradead.org> wrote:
[..]
>> On Fri, May 19, 2017 at 2:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Thu, May 18, 2017 at 11:23:43PM -0700, Joel Fernandes wrote:
>> >> Make iowait boost a cpufreq policy option and enable it for intel_pstate
>> >> cpufreq driver. Governors like schedutil can use it to determine if
>> >> boosting for tasks that wake up with p->in_iowait set is needed.
>> >
>> > Rather than just flat out disabling the option, is there something
>> > better we can do on ARM?
>> >
>> > The reason for the IO-wait boost is to ensure we feed our external
>> > devices data ASAP, this reduces wait times, increases throughput and
>> > decreases the duration the devices have to operate.
>>
>> Can you help understand how CPU frequency can affect I/O? The ASAP
>> makes me think of it as a latency thing than a throughput in which
>> case there should a scheduling priority increase? Also, to me it
>> sounds more like memory instead of CPU frequency should be boosted
>> instead so that DMA transfers happen quicker to feed devices data
>> faster.
>
> Suppose your (I/O) device has the task waiting for a completion for 1ms
> for each request. Further suppose that feeding it the next request takes
> .1ms at full speed (1 GHz).
>
> Then we get, without contending tasks, a cycle of:
>
>
>  R----------R----------                                 (1 GHz)
>
>
> Which comes at 1/11-th utilization, which would then select something
> like 100 MHz as being sufficient. But then the R part becomes 10x longer
> and we end up with:
>
>
>  RRRRRRRRRR----------RRRRRRRRRR----------               (100 MHz)
>
>
> And since there's still plenty idle time, and the effective utilization
> is still the same 1/11th, we'll not ramp up at all and continue in this
> cycle.
>
> Note however that the total time of the cycle increased from 1.1ms
> to 2ms, for an ~80% decrease in throughput.

Got it, thanks for the explanation.

>> Are you trying to boost the CPU frequency so that a process waiting on
>> I/O does its next set of processing quickly enough after iowaiting on
>> the previous I/O transaction, and is ready to feed I/O the next time
>> sooner?
>
> This. So we break the above pattern by boosting the task that wakes from
> IO-wait. Its utilization will never be enough to cause a significant
> bump in frequency on its own, as its constantly blocked on the IO
> device.

It sounds like this problem can happen with any other use-case where
one task blocks on the other, not just IO. Like a case where 2 tasks
running on different CPUs block on a mutex, then on either task can
wait on the other causing their utilization to be low right?

>> The case I'm seeing a lot is a background thread does I/O request and
>> blocks for short period, and wakes up. All this while the CPU
>> frequency is low, but that wake up causes a spike in frequency. So
>> over a period of time, you see these spikes that don't really help
>> anything.
>
> So the background thread is doing some spurious IO but nothing
> consistent?

Yes, its not a consistent pattern. Its actually a 'kworker' that woke
up to read/write something related to the video being played by the
YouTube app and is asynchronous to the app itself. It could be writing
to the logs or other information. But this definitely not a consistent
pattern as in the use case you described but intermittent spikes. The
frequency boosts don't help the actual activity of playing the video
except increasing power.

>> > I realize max freq/volt might not be the best option for you, but is
>> > there another spot that would make sense? I can imagine you want to
>> > return your MMC to low power state ASAP as well.
>> >
>> >
>> > So rather than a disable flag, I would really rather see an IO-wait OPP
>> > state selector or something.
>>
>> We never had this in older kernels and I don't think we ever had an
>> issue where I/O was slow because of CPU frequency. If a task is busy a
>> lot, then its load tracking signal should be high and take care of
>> keeping CPU frequency high right?
>
> As per the above, no. If the device completion takes long enough to
> inject enough idle time, the utilization signal will never be high
> enough to break out of that pattern.
>
>> If PELT is decaying the load
>> tracking of iowaiting tasks too much, then I think that it should be
>> fixed there (probably decay an iowaiting task lesser?).
>
> For the above to work, we'd have to completely discard IO-wait time on
> the utilization signal. But that would then give the task u=1, which
> would be incorrect for placement decisions and wreck EAS.

Not completely discard but cap the decay of the signal during IO wait.

>
>> Considering
>> that it makes power worse on newer kernels, it'd probably be best to
>> disable it in my opinion for those who don't need it.
>
> You have yet to convince me you don't need it. Sure Android might not
> have much IO heavy workloads, but that's not to say nothing on ARM ever
> does.
>
> Also note that if you set the boost OPP to the lowest OPP you
> effectively do disable it.
>
> Looking at the code, it appears we already have this in
> iowait_boost_max.

Currently it is set to:
 sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq

Are you proposing to make this a sysfs tunable so we can override what
the iowait_boost_max value is?

thanks,

-Joel
