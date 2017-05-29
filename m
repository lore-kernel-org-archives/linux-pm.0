From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v4 8/8] arm,arm64,drivers: add a prefix to drivers
 arch_topology interfaces
Date: Mon, 29 May 2017 11:20:24 +0200
Message-ID: <bcc2f8f1-e953-9f32-2aa2-e660b0351e0a@arm.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-9-juri.lelli@arm.com>
 <20170525131802.GE16244@kroah.com>
 <20170526101032.2t2xn5wrfenimu5w@e106622-lin>
 <20170526183610.GB16490@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526183610.GB16490@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Greg,

On 05/26/2017 08:36 PM, Greg KH wrote:
> On Fri, May 26, 2017 at 11:10:32AM +0100, Juri Lelli wrote:
>> Hi,
>>
>> On 25/05/17 15:18, Greg KH wrote:
>>> On Thu, Apr 20, 2017 at 03:43:16PM +0100, Juri Lelli wrote:

[...]

>>> But this is all really topology stuff, right?  Why use "capacity" at
>>> all:
>>> 	topology_normalize_cpu()
>>> 	topology_parse_cpu()
>>> 	topology_scale_cpu()
>>> 	topology_set_scale()
>>> ?
>>>
>>> It's always best to put the "subsystem" name first, we have a bad
>>> history of getting this wrong in the past by putting the verb first, not
>>> the noun.
>>>
>>
>> topology_ works for me. However, I'd keep "capacity" in the names, as we
>> might need to topology_normalize_cpu_somethingelse() (etc.) in the
>> future?
> 
> Worry about the future, in the future.  Change the names then, _IF_ it
> becomes an issue.  Try to be short and simple please.
> 
>> Updated patch follows. I kept Catalin and Russell's acks as I only
>> renamed the functions, please shout if that's not OK.
>>
>> Greg, if you are fine with this approach, do you still want a complete
>> v5 of the set or can you pick this up?
> 
> Am I the one who is supposed to take all of these arm-specific patches?
> If so, that's fine, but I need to have acks from the arm maintainers...
> 
> Oh, and drop "capacity" please :)

Once we have driver/base/arch_topology.c in, we want to enable (cpu 
micro-architectural + max frequency (OPPmax)) invariant and frequency 
(OPPmin..OPPmax) invariant load-tracking/accounting in the task 
scheduler for arm and arm64.

The way to do this is to define the task scheduler interfaces 
arch_scale_cpu_capacity() and arch_scale_freq_capacity() in arch 
specific code:

#define arch_scale_cpu_capacity topology_scale_cpu_capacity
#define arch_scale_freq_capacity topology_scale_freq_capacity

In case an arch is not defining them, the default definitions in 
kernel/sched/sched.h are used.

So topology_scale_cpu() wouldn't be correct since we scale the 
_capacity_ by the micro-architectural differences (hence cpu) and not 
the cpu.

Likewise we will have a function topology_scale_freq_capacity indicating 
that we scale the capacity by the frequency.

Or would you prefer something like topology_scale_capacity_by_cpu() and 
topology_scale_capacity_by_freq()?

-- Dietmar

[...]
