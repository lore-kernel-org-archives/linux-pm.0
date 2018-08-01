From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
Date: Wed, 1 Aug 2018 17:03:29 +0100
Message-ID: <2a9bfa53-31b2-b44a-0bd5-07bcc344a466@arm.com>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 28/07/18 04:56, Saravana Kannan wrote:
> Many CPU architectures have caches that can scale independent of the CPUs.
> Frequency scaling of the caches is necessary to make sure the cache is not
> a performance bottleneck that leads to poor performance and power. The same
> idea applies for RAM/DDR.
> 
> To achieve this, this patch adds a generic devfreq governor that can listen
> to the frequency transitions of each CPU frequency domain and then adjusts
> the frequency of the cache (or any devfreq device) based on the frequency
> of the CPUs.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> 
> * Uses a CPU frequency to device frequency mapping table
>   - Either one mapping table used for all CPU freq policies (typically used
>     for system with homogeneous cores/clusters that have the same OPPs.
>   - One mapping table per CPU freq policy (typically used for ASMP systems
>     with heterogeneous CPUs with different OPPs)
> 
> OR
> 
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its max
>   frequency.  If the CPUs are running at their min frequency, the device
>   runs at its min frequency. And interpolated for frequencies in between.
> 

Is this solution for the old generation of SDM ?
I have seen newer ones have some kind of firmware interface/hardware to
deal with CPUFreq. Do you need this solution for them too ?

If yes, why ? IMO firmware can arbitrate various requests for frequency
scaling and do the *right thing* for the platform. Having OSPM sending
separate requests for such bus/interconnect might end up with conflicts.
No ?

-- 
Regards,
Sudeep
