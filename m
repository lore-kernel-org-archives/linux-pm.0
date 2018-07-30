From: skannan@codeaurora.org
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
Date: Mon, 30 Jul 2018 11:58:36 -0700
Message-ID: <534629d03437bc8e72a62d89e726dbe5@codeaurora.org>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
 <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rjwysocki@gmail.com
List-Id: linux-pm@vger.kernel.org

On 2018-07-29 03:52, Rafael J. Wysocki wrote:
> On Sat, Jul 28, 2018 at 5:56 AM, Saravana Kannan 
> <skannan@codeaurora.org> wrote:
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
> 
> While not having looked at the details of the patch yet, I would
> change the name of the feature to "Generic cpufreq transition
> governor" to make it somewhat less ambiguous.

In my opinion it makes it look MORE like this is a cpufreq governor. How 
about the following?
PM / devfreq: Generic cpufreq to devfreq mapping governor
Seem a lot more clear to me.

I'm open to suggestions for the devfreq governor name too. "cpufreq" has 
been very confusing so far.
cpufreq-map maybe?

Thanks,
Saravana
