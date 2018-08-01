From: skannan@codeaurora.org
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
Date: Wed, 01 Aug 2018 13:16:11 -0700
Message-ID: <07f57aced47960cf48f273d6446b4221@codeaurora.org>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
 <2a9bfa53-31b2-b44a-0bd5-07bcc344a466@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a9bfa53-31b2-b44a-0bd5-07bcc344a466@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2018-08-01 09:03, Sudeep Holla wrote:
> On 28/07/18 04:56, Saravana Kannan wrote:
>> Many CPU architectures have caches that can scale independent of the 
>> CPUs.
>> Frequency scaling of the caches is necessary to make sure the cache is 
>> not
>> a performance bottleneck that leads to poor performance and power. The 
>> same
>> idea applies for RAM/DDR.
>> 
>> To achieve this, this patch adds a generic devfreq governor that can 
>> listen
>> to the frequency transitions of each CPU frequency domain and then 
>> adjusts
>> the frequency of the cache (or any devfreq device) based on the 
>> frequency
>> of the CPUs.
>> 
>> To decide the frequency of the device, the governor does one of the
>> following:
>> 
>> * Uses a CPU frequency to device frequency mapping table
>>   - Either one mapping table used for all CPU freq policies (typically 
>> used
>>     for system with homogeneous cores/clusters that have the same 
>> OPPs.
>>   - One mapping table per CPU freq policy (typically used for ASMP 
>> systems
>>     with heterogeneous CPUs with different OPPs)
>> 
>> OR
>> 
>> * Scales the device frequency in proportion to the CPU frequency. So, 
>> if
>>   the CPUs are running at their max frequency, the device runs at its 
>> max
>>   frequency.  If the CPUs are running at their min frequency, the 
>> device
>>   runs at its min frequency. And interpolated for frequencies in 
>> between.
>> 
> 
> Is this solution for the old generation of SDM ?

This code isn't even specific to Qualcomm chips. Let alone a specific 
generation of SDM.

> I have seen newer ones have some kind of firmware interface/hardware to
> deal with CPUFreq. Do you need this solution for them too ?

You are confusing two completely unrelated drivers. This is generic 
*devfreq* *governor* code. I'll be renaming the commit text like Rafael 
suggested.

Something like: CPU frequency to devfreq mapping governor.

> If yes, why ?

Read the commit text.

> IMO firmware can arbitrate various requests for frequency
> scaling and do the *right thing* for the platform.

Firmware (if any) can arbitrate HW that it controls. DDR and 
interconnect is not something a firmware might control (or should 
control).

> Having OSPM sending
> separate requests for such bus/interconnect might end up with 
> conflicts.
> No ?

If some chips have firmware that takes care of everything, then you 
obviously won't be enabling any power management code.

Thanks,
Saravana
