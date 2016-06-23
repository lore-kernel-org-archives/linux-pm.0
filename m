From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 23 Jun 2016 12:04:51 -0600
Message-ID: <20160623180451.GD1115@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-3-git-send-email-lina.iyer@linaro.org>
 <20160623173312.GA22204@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160623173312.GA22204@leverpostej>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Thu, Jun 23 2016 at 11:35 -0600, Mark Rutland wrote:
>Hi,
>
>On Wed, Jun 22, 2016 at 01:36:37PM -0600, Lina Iyer wrote:
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> Update DT bindings to describe idle states of PM domains.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> [Lina: Added state properties, removed state names, wakeup-latency,
>> added of_pm_genpd_init() API, pruned commit text]
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
>> ---
>>  .../devicetree/bindings/power/power_domain.txt     | 70 ++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>> index 025b5e7..41e8dda 100644
>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -29,6 +29,43 @@ Optional properties:
>>     specified by this binding. More details about power domain specifier are
>>     available in the next section.
>>
>> +- power-states : A phandle of an idle-state that shall be soaked into a
>> +                generic domain power state.
>
>It's somewhat unfortunate that this gives us two possible locations for
>idle state lists (under the /cpus node and in a pm-domains node),
>especially as it's not clear what would happen were a DT to have both.
>
>I would prefer that we extend the existing bindings such that states can
>refer to the power domains which they affect.
>
I agree. The CPU idle states have become defined to be specific to CPUs.
PM Domain idle states are generic for any type of domain. I am hoping at
some point, we could converge and use the same idle state, but that
would mean changing the CPU idle states to make it generic. At some
point, during my development, I did use the arm,idle-state for domains
as well, but the binding definitions were too restrictive for a generic
PM domain.

I would be willing to make the change to CPU idle states to make it
generic and then we could just reference domain and CPU idle states
using the same bindings. Are we okay with that, specifically,
arm,psci-suspend-param? This binding is very restrictive in its
description. What we pass to the platform driver upon choosing a domain
state is very platform specific and therefore has to be generic in its
description.

Thanks,
Lina

>> +==Power state==
>> +
>> +A PM domain power state describes an idle state of a domain and must be
>> +have the following properties -
>> +
>> +	- entry-latency-us
>> +		Usage: Not required if wakeup-latency-us is provided.
>> +		Value type: <prop-encoded-array>
>> +		Definition: u32 value representing worst case latency in
>> +		microseconds required to enter the idle state.
>> +		The exit-latency-us duration may be guaranteed
>> +		only after entry-latency-us has passed.
>> +
>> +	- exit-latency-us
>> +		Usage: Not required if wakeup-latency-us is provided.
>> +		Value type: <prop-encoded-array>
>> +		Definition: u32 value representing worst case latency
>> +		in microseconds required to exit the idle state.
>
>These are part of the existing idle state binding
>(Documentation/devicetree/bindings/arm/idle-states.txt), and I would
>prefer that we did not duplicate this nor come up with an independent
>set of idle state bindings.
>
>> +
>> +	- residency-us:
>> +		Usage: Optional
>> +		Value type: <prop-encoded-array>
>> +		Definition: A u32 value representing the time for which a
>> +		domain must be idle in the state to reap power saving benefits
>> +		of entering the state.
>
>This is "min-residency-us" per the existing bindings.
>
>> +
>> +	- state-param:
>> +		Usage: Optional
>> +		Value type: <prop-encoded-array>
>> +		Definition: A u32 value as defined by the state. May be used
>> +		by the driver to hold state related u32 data. In the case of
>> +		PSCI, an extended state-id for the domain may be encoded in
>> +		this value.
>
>This is "arm,psci-suspend-param", per the existing bindings.
>
>Thanks,
>Mark.
