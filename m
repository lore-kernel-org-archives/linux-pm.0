From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 0/3] per cpu resume latency
Date: Tue, 10 Jan 2017 16:02:25 +0800
Message-ID: <972e504c-0a84-7b8e-a111-7da93f91714a@linaro.org>
References: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
 <8b471c83-8e62-bf93-b502-0bb7e9c271d6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8b471c83-8e62-bf93-b502-0bb7e9c271d6@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi All,

Is there any comments for the testing or the patch?

Thanks!
Alex

On 01/05/2017 11:48 PM, Alex Shi wrote:
> On 01/05/2017 11:29 PM, Alex Shi wrote:
>> > cpu_dma_latency is designed to keep all cpu awake from deep c-state.
>> > That is good keep system with short response latency. But sometime we
>> > don't need all cpu power especially in a more and more multi-core day.
>> > So set all cpu restless that lead to a big power waste.
>> > 
>> > A better way is to keep the short cpu response latency on needed cpu, 
>> > while let other unnecesscary cpus go to deep idle. That is this 
>> > patchset. We just use the pm_qos_resume_latency on cpu. Giving the 
>> > short cpu latency on appointed cpu via setting value on
>> > /sys/devices/system/cpu/cpuX/power/pm_qos_resume_latency_us
>> > We can set we wanted latency value according to the value of
>> > /sys/devices/system/cpu/cpuX/cpuidle/stateX/latency. to just a bit
>> > less related state's latency value. Then cpu can get to this state or
>> > higher.
>> > 
>> > Here is some testing data on my dragonboard 410c, the latency of state1
>> > is 280us. It has 4 cores.
>> > 
>> > Benchmark: cyclictest -t 1  -n -i 10000 -l 1000 -q --latency=10000
>> > 
>> > without the patch:
>> > Latency (us) Min:     87 Act:  209 Avg:  205 Max:     239
>> > With the patch and cpu0/power/pm_qos_resume_latency_us is lower than
>> > 280us, like set to 279
>> > benchmark result on cpu0:
>> > Latency (us) Min:     82 Act:   91 Avg:   95 Max:     110
>> > In repeat testing, the Avg latency always drop to half of vanilla kernel
>> > value, as well as Max latency value, although sometime the Max latency
>> > is similar with vanilla kernel. 
