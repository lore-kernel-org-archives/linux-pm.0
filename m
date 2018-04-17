From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v2 0/6] Energy Aware Scheduling
Date: Tue, 17 Apr 2018 19:22:03 +0200
Message-ID: <20ed355c-21f7-79c2-e3b3-05d8cfb0c176@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180417125059.GA18509@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417125059.GA18509@leoy-ThinkPad-X240s>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Leo,

On 04/17/2018 02:50 PM, Leo Yan wrote:
> Hi Dietmar,
> 
> On Fri, Apr 06, 2018 at 04:36:01PM +0100, Dietmar Eggemann wrote:

[...]

>> 1.1 Energy Model
>>
>> A CPU with asymmetric core capacities features cores with significantly
>> different energy and performance characteristics. As the configurations
>> can vary greatly from one SoC to another, designing an energy-efficient
>> scheduling heuristic that performs well on a broad spectrum of platforms
>> appears to be particularly hard.
>> This proposal attempts to solve this issue by providing the scheduler
>> with an energy model of the platform which enables energy impact
>> estimation of scheduling decisions in a generic way. The energy model is
>> kept very simple as it represents only the active power of CPUs at all
>> available P-states and relies on existing data in the kernel (only used
>> by the thermal subsystem so far).
>> This proposal does not include the power consumption of C-states and
>> cluster-level resources which were originally introduced in [1] since
>> firstly, their impact on task placement decisions appears to be
>> neglectable on modern asymmetric platforms and secondly, they require
>> additional infrastructure and data (e.g new DT entries).
> 
> Seems to me, if we move forward a bit for the energy model, we can use
> more simple method by generate power consumption:
> 
>    Power(@Freq) = Power(cpu_util=100%@Freq) - Power(cpu_util=%0@Freq)
> 
>  From upper formula, the power data includes CPU and cluster level
> power (and includes dynamic power and static leakage) but this is
> quite straightforward for measurement.
> 
> I read a bit for Quentin's slides for simplized power modeling
> experiments [1], IIUC the simplized power modeling still bases on the
> distinguished CPU and cluster c-state and p-state power data, and just
> select CPU p-state power data for scheduler.  I wander if we can
 > simplize the power measurement, so the power data can be generated in
 > single one testing and the power data without any post processing.
 >
 > This might need more detailed experiment to support this idea, just
 > want to know how about you guys think for this?
 >
 > This is a side topic for this patch series, so whatever the conclusion
 > for it, I think this will not impact anything of this patch series
 > implementation and upstreaming.
 >
 > [1] http://connect.linaro.org/resource/hkg18/hkg18-501/

The simplified Energy Model in this patch-set only contains the per-cpu 
p-state power data. This allows us to only rely on the knowledge of 
which OPP's (opp frequency/max frequency) we have for the individual 
frequency domains and the CPU dt property 'dynamic-power-coefficient'. 
This is even encapsulated in the new PM_OPP library function 
dev_pm_opp_get_power().

Please note that this has to be redesigned since neither Rafael nor 
Peter like the idea of using PM_OPP library here. But we will continue 
to only use per-cpu p-state power data.

[...]

>> 30 iterations of perf bench sched messaging --pipe --thread --group G
>> --loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).
> 
> What's the reason to select different loop number for Hikey960 and
> Juno? Based on the testing time?

The Juno r0 board has only ~0.3 of the performance of the Hikey960. We 
wanted to have roughly comparable test execution time numbers. We're 
only interested in the difference between running w/ and w/o this code 
per platform.
