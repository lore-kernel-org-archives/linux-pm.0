From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 17 Oct 2018 12:24:14 -0400
Message-ID: <5BC7622E.6000201@linaro.org>
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
 <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
 <5BBE3751.7000908@linaro.org>
 <20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b@eucas1p2.samsung.com>
 <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, l.luba@partner.samsung.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Quentin Perret <quentin.perret@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

On 10/16/2018 01:11 PM, Vincent Guittot wrote:
> Hi Lukasz,
> 
> On Thu, 11 Oct 2018 at 13:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>
>>
>> On 10/10/2018 07:30 PM, Thara Gopinath wrote:
>>> Hello Lukasz,
>>>
>>> On 10/10/2018 11:35 AM, Lukasz Luba wrote:
>>>> Hi Thara,
>>>>
>>>> I have run it on Exynos5433 mainline.
>>>> When it is enabled with step_wise thermal governor,
>>>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>>>> dhrystone ~10%.
>>>
>>> That is interesting. If I understand correctly, dhrystone spawns 16
>>> threads or so and floods the system. In "theory", such a test should not
>>> see any performance improvement and degradation. What is the thermal
>>> activity like in your system? I will try running one of these tests on
>>> hikey960.
>> I use this dhrystone implementation:
>> https://github.com/Keith-S-Thompson/dhrystone/blob/master/v2.2/dry.c
>> It does not span new threads/processes and I pinned it to a single cpu.
>>
>> My thermal setup is probably different than yours.
>> You have (on hikey960) probably 1 sensor for whole SoC and one thermal
>> zone (if it is this mainline file:
>> arch/arm64/boot/dts/hisilicon/hi3660.dtsi).
>> This thermal zone has two cooling devices - two clusters with dvfs.
>> Your temperature signal read out from that sensor is probably much
>> smoother. When you have sensor inside cluster, the rising factor
>> can be even 20deg/s (for big cores).
>> In my case, there are 4 thermal zones, each cluster has it's private
>> sensor and thermal zone. There is no 'SoC sensor' or 'PCB sensor',
>> which is recommended for IPA.
>>>>
>>>> Could you tell me which thermal governor was used in your case?
>>>> Please also share the name of that benchmark, i will give it a try.
>>>> Is it single threaded compute-intensive?
>>>
>>> Step-wise governor.
>>> I use aobench which is part of phoronix-test-suite.
>>>
>>> Regards
>>> Thara
>>>
>> I have built this aobench and run it pinned to single big cpu:
>> time taskset -c 4 ./aobench
> 
> Why have you pinned the test only on CPU4 ?
> Goal of thermal pressure is to inform the scheduler of reduced compute
> capacity and help the scheduler to take better decision in tasks
> placement.

Hi Lukasz,

I agree with Vincent's observation. I had not seen this earlier. Pinning
a task to a cpu will obviously prevent migration. The performance
regression could be due to as Vincent mentioned below other tasks in the
system. On another note, which cpufreq governor are you using? Is the
core being bumped up to highest possible OPP during the test?

Regards
Thara
> So I would not expect perf impact on your test as the bench will stay
> pinned on the cpu4
> That being said you obviously have perf impact as shown below in your results
> And other tasks on the system are not pinned and might come and
> disturb your bench
> 
>> The results:
>> 3min-5:30min [mainline]
>> 5:15min-5:50min [+patchset]
>>
>> The idea is definitely worth to investigate further.
> 
> Yes I agree
> 
> Vincent
>>
>> Regards,
>> Lukasz
>>
>>
>>


-- 
Regards
Thara
