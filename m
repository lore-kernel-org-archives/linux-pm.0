From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 2/2] PM / devfreq: Generic cpufreq governor
Date: Tue, 5 Jun 2018 16:26:31 -0700
Message-ID: <7a7f2e59-1109-eb49-e26f-ed052fccd5c7@codeaurora.org>
References: <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
 <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
 <CGME20180518082505epcas2p265038f51fc070a4aada4c692a71ebc3c@epcms1p8>
 <20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d@epcms1p8>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d@epcms1p8>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Rajendra Nayak <rjendra@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 05/27/2018 11:00 PM, MyungJoo Ham wrote:
>> Many CPU architectures have caches that can scale independent of the CPUs.
>> Frequency scaling of the caches is necessary to make sure the cache is not
>> a performance bottleneck that leads to poor performance and power. The same
>> idea applies for RAM/DDR.
>>
>> To achieve this, this patch series adds a generic devfreq governor that can
>> listen to the frequency transitions of each CPU frequency domain and then
>> adjusts the frequency of the cache (or any devfreq device) based on the
>> frequency of the CPUs.
> I agree that we have some hardware pieces that want to configure
> frequencies based on the CPUfreq.
>
> Creating a devfreq governor that configures devfreq-freq
> based on incoming events (CPUFreq-transition-event in this case)
> is indeed a good idea.
>
> However, I would like to ask the followings:
> The overall code appears to be overly complex compared what you need.
> - Do you really need to revive "CPUFREQ POLICY" events for this?
> especially when you are going to look at "first CPU" only?
>
>
> Cheers,
> MyungJoo
>
Sorry, didn't notice this email earlier. My message filters seem to be 
messed up.

The POLICY notifiers are necessary for cases when all CPUs in a policy 
are hotplugged off -- we need to ignore their frequencies to avoid 
getting the devfreq device stuck at a high frequency. Looking at "first 
CPU" is just an optimization to ignore multiple transition notifiers for 
the each CPU in a policy -- we'd want to do that even if we don't have 
policy notifiers. Not having policy notifier won't really simplify the 
code by much. We'd be forced to check for policy->related_cpus for every 
transition notifier call if the CPU state hasn't been already initialized.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
