From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 18/27] drivers: cpu-pd: Add PM Domain governor for CPUs
Date: Thu, 19 Nov 2015 15:52:13 -0800
Message-ID: <7hk2pdsg2a.fsf@deeprootsystems.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-19-git-send-email-lina.iyer@linaro.org>
	<20151118184245.GA28755@red-moon>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20151118184245.GA28755@red-moon> (Lorenzo Pieralisi's message of
	"Wed, 18 Nov 2015 18:42:45 +0000")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Tue, Nov 17, 2015 at 03:37:42PM -0700, Lina Iyer wrote:
>> A PM domain comprising of CPUs may be powered off when all the CPUs in
>> the domain are powered down. Powering down a CPU domain is generally a
>> expensive operation and therefore the power performance trade offs
>> should be considered. The time between the last CPU powering down and
>> the first CPU powering up in a domain, is the time available for the
>> domain to sleep. Ideally, the sleep time of the domain should fulfill
>> the residency requirement of the domains' idle state.
>> 
>> To do this effectively, read the time before the wakeup of the cluster's
>> CPUs and ensure that the domain's idle state sleep time guarantees the
>> QoS requirements of each of the CPU, the PM QoS CPU_DMA_LATENCY and the
>> state's residency.
>
> To me this information should be part of the CPUidle governor (it is
> already there), we should not split the decision into multiple layers.
>
> The problem you are facing is that the CPUidle governor(s) do not take
> cross cpus relationship into account, I do not think that adding another
> decision layer in the power domain subsystem helps, you are doing that
> just because adding it to the existing CPUidle governor(s) is invasive.
>
> Why can't we use the power domain work you put together to eg disable
> idle states that share multiple cpus and make them "visible" only
> when the power domain that encompass them is actually going down ?
>
> You could use the power domains information to detect states that
> are shared between cpus.
>
> It is just an idea, what I am saying is that having another governor in
> the power domain subsytem does not make much sense, you split the
> decision in two layers while there is actually one, the existing
> CPUidle governor and that's where the decision should be taken.

Hmm, considering "normal" devices in "normal" power domains, and
following the same logic, the equivalent would be to say that the
decision to gate the power domain belongs to the individual drivers
in the domain instead of in the power domain layer.  I disagree.

IMO, there are different decision layers because there are different
hardware layers.  Devices (including CPUs) are reponsible for handling
device-local idle states, based on device-local conditions (e.g. local
wakeups, timers, etc.)  and domains are responsible for handling
decisions based on conditions of the whole domain.

Kevin
