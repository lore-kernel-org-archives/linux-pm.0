From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v5] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Tue, 30 Aug 2016 11:09:13 -0600
Message-ID: <4cc91494-fe77-0954-1b6c-c394130614f9@redhat.com>
References: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
 <20160801203156.GV4605@ubuntu>
 <872a4dd4-a752-507b-e720-ec2e6003bd8c@redhat.com>
 <406534f5-5e45-237e-cc68-2b57631e26d1@redhat.com>
 <CANYZqRv6pLCK+oaWxyzr3YPxs0VytupWD7oPfX4tA7STxWNGOg@mail.gmail.com>
 <6a0079da-2f81-a58b-0a71-3564d79ad61b@redhat.com>
 <1471926684.5747.13.camel@intel.com>
 <8012e614-885a-0445-44aa-63d92de5cd1f@redhat.com>
 <1472162436.13076.21.camel@intel.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472162436.13076.21.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "ashwinch@google.com" <ashwinch@google.com>
Cc: "pprakash@codeaurora.org" <pprakash@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 08/25/2016 04:00 PM, Pandruvada, Srinivas wrote:
> On Tue, 2016-08-23 at 10:14 -0600, Al Stone wrote:
>>>>
> 
> [...]
> 
>>> In x86 when CPPC is used, the unit is really unit-less in CPPC
>>> tables.
>>> This means that cpu->perf_caps.highest_perf can be just 0xff,
>>> instead
>>> of some scaled cppc max performance corresponding to max MHZ the
>>> processor can support. This allows the processor to cap at max
>>> which it
>>> can deliver.
>>> Is this case not possible for ARM SoCs?
>>>
> [...]
>> If I understand the question properly, I don't think it matters, and
>> I don't
>> think that will work for x86 either.
>>
>> This patch is meant to allow CPPC to continue operating solely based
>> on the
>> abstract scale provided by the ACPI tables; this should be true
>> regardless
>> of architecture.  Any actual processor performance changes are still
>> guided
>> solely by the CPPC scale provided in the tables, and not the values
>> in the
>> cpu->perf_caps struct.
>>
>> Assuming I understand the kernel code, the values in cpu->perf_caps
>> -- in this
>> case -- are really just for reporting to user space via sysfs, which
>> is the
>> root of the problem: user space expects frequencies, and we have none
>> when using
>> CPPC so we have to provide an approximation.  In those circumstances,
>> I think a
>> value of 0xff would be kind of confusing in sysfs, since it's
>> basically saying
>> the CPU is operating at a frequency equal to the largest integer
>> value.
>>
>> To be fair, this is how the ARM processor implements CPPC; I have not
>> examined
>> in detail the newly submitted x86 patches to use CPPC so I cannot
>> comment on
>> those.  This patch was written well before those showed up.
> Currently we are not using cppc-cpufreq driver, so not will not
> directly impact (you are  not changing acpi-cpufreq source, which we
> are using).
> x86 has other way to get max/min cpufreq policy frequencies using MSRs.
> So you may choose to ignore my comments here, as long as your changes
> are limited to drivers/cpufreq/cppc_cpufreq.c

Ah, okay.  Yes, the changes are intentionaly limited to cppc_cpufreq.c.

> When you are doing:
> policy->min = cpu->perf_caps.lowest_perf * cppc_dmi_max_khz / cpu-
>> perf_caps.highest_perf;
> 
> Aren't you assuming that scale from max to min performance is only
> related to frequency? It is possible that many points in between can be
> same frequency with multiple voltages.
> As per spec " The platform may choose to use a single metric such as
> processor frequency, or it may choose to blend multiple hardware
> metrics to create a synthetic measure of performance".

There are a couple of assumptions: (1) that the CPPC scale is a linear
scale, and that (2) there is a direct correlation to the frequency.  And
this is why longer term, we have to separate performance reporting from
the frequency -- any correlation between them is suspect on most modern
processors.  We know a priori that these assumptions are only approximations,
at best.

However, this is the only information we currently have, so we have to make
a best guess...um, I mean, "apply heuristics".  I'm treating this as two
problems, really: the first is the immediate term where we need to make sure
user space tools don't report complete garbage, which this patch tries to
address.  The second is the much larger problem of changing the way the kernel
reports performance in general, and fixing the user space tools that rely on
the info being reported; I'm still thinking through those patches (suggestions
are always welcome).

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
