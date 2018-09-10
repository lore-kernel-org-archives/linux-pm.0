From: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
Date: Tue, 11 Sep 2018 00:15:28 +0530
Message-ID: <37035cf602bb0f5491240a021af46608@codeaurora.org>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
 <CGME20180802005756epcas4p465a12f42a0e36f0af6fd276a3a56957f@epcms1p3>
 <20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3>
 <45c77ee02536e237c054399cad4c7669@codeaurora.org>
 <35ff3e303f5de9980979b49c89f9a687@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35ff3e303f5de9980979b49c89f9a687@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: skannan@codeaurora.org
Cc: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org, vincent.guittot@linaro.org, daidavid1@codeaurora.org, bjorn.andersson@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Saravana,

On 2018-08-07 11:19, skannan@codeaurora.org wrote:
> On 2018-08-02 14:00, skannan@codeaurora.org wrote:
>> On 2018-08-02 02:56, MyungJoo Ham wrote:
>>>> Many CPU architectures have caches that can scale independent of the 
>>>> CPUs.
>>>> Frequency scaling of the caches is necessary to make sure the cache 
>>>> is not
>>>> a performance bottleneck that leads to poor performance and power. 
>>>> The same
>>>> idea applies for RAM/DDR.
>>>> 
>>>> To achieve this, this patch adds a generic devfreq governor that 
>>>> takes the
>>>> current frequency of each CPU frequency domain and then adjusts the
>>>> frequency of the cache (or any devfreq device) based on the 
>>>> frequency of
>>>> the CPUs. It listens to CPU frequency transition notifiers to keep 
>>>> itself
>>>> up to date on the current CPU frequency.
>>>> 

With the cpu-freq driver for SDM845 SoC supporting fast_switch and 
schedutil supporting
dynamic switching wouldn't this governor be incompatible due to its 
reliance on transition
notifiers? Is it planned to be used only with ondemand/performance 
governors?

>>>> To decide the frequency of the device, the governor does one of the
>>>> following:
>>> 
>>> This exactly has the same purpose with "passive" governor except for 
>>> the
>>> single part: passive governor depends on another devfreq driver, not
>>> cpufreq driver.
>>> 
>>> If both governors have many features in common, can you merge them 
>>> into one?
>>> Passive governor also has "get_target_freq", which allows driver 
>>> authors
>>> to define the mapping.
>> 
>> Thanks for the review and pointing me to the passive governor. I agree
>> that at a high level they are both doing the same. I can certainly
>> stuff this CPU freq to dev freq mapping into passive governor, but I
>> think it'll just make one huge set of code that's harder to understand
>> and maintain because it trying to do different things under the hood.
>> 
>> There are also a bunch of complexities and optimizations that come
>> with the cpufreq-map governor that don't fit with the passive
>> governor.
>> 
>> 1. It's not one CPU who's frequency we have to listen to. There are
>> multiple CPUs/policies we have to aggregate across.
>> 2. We have to deal with big vs little having different needs/mappings.
>> 3. Since it's always just CPUfreq, I can optimize the handling in the
>> transition notifiers. If I have 4 different devices that are scaled
>> based on CPU freq, I still use only 1 transition notifier. It becomes
>> a bit harder to do with the passive governor.
>> 4. It requires that the device explicitly support the passive governor
>> and pick a mapping function. With cpufreq-map governor, the device
>> drivers don't need to make any changes. Whoever is making a
>> device/board can choose what devices to scale up base on CPU freq
>> based on their board and their needs. Even an end user can say, scale
>> the GPU based on my CPU based on interpolation if they choose to.
>> 5. If a device has some other use for the private data, it can't work
>> with passive governor, but can work with cpufreq-map governor.
>> 6. I also want to improve cpufreq-map governor to handle hotplug
>> correctly in later patches (needs more discussion) and that'll add
>> more complexity.
>> 
>> I think for these reasons we shouldn't combine these two governors.
>> Let me know what you think.
> 
> Friendly reminder.
> 
> Thanks,
> Saravana

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
