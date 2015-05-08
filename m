From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 2/5] PM / Domains: core changes for multiple states
Date: Fri, 8 May 2015 16:31:35 -0600
Message-ID: <20150508223135.GA16124@linaro.org>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
 <1430391335-7588-3-git-send-email-ahaslam@baylibre.com>
 <20150507155359.GA15980@linaro.org>
 <7ha8xehjug.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34470 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbbEHWbi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 18:31:38 -0400
Received: by iedfl3 with SMTP id fl3so82913081ied.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2015 15:31:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7ha8xehjug.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: ahaslam@baylibre.com, ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

On Fri, May 08 2015 at 14:53 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> On Thu, Apr 30 2015 at 04:57 -0600, ahaslam@baylibre.com wrote:
>>>From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>>
>>>Add the core changes to be able to declare multiple states.
>>>When trying to set a power domain to off, genpd will be able
>>>to choose from an array of states declared by the platform.
>>>
>>>The power on and off latencies are now tied to a state.
>>>
>>>States should be declared in ascending order from shallowest
>>>to deepest, deepest meaning the state which takes longer to
>>>enter and exit.
>>>
>>>the power_off and power_on function can use the 'state_idx'
>>>field of the generic_pm_domain structure, to distinguish between
>>>the different states and act accordingly.
>>>
>>> - if the genpd is initially off, the user should set the state_idx
>>>   field when registering the genpd.
>>>
>>> - if no states are passed to pm_genpd_init, a single OFF
>>>   state with no latency is assumed.
>>>
>>>Example:
>>>
>>>static int pd1_power_on(struct generic_pm_domain *domain)
>>>{
>>>	/* domain->state_idx = state the domain is coming from */
>>>}
>>>
>>>static int pd1_power_off(struct generic_pm_domain *domain)
>>>{
>>>	/* domain->state_idx = desired powered off state */
>>>}
>>>
>>>const struct genpd_power_state pd_states[] = {
>>>	{
>>>		.name = "RET",
>>>		.power_on_latency_ns = ON_LATENCY_FAST,
>>>		.power_off_latency_ns = OFF_LATENCY_FAST,
>>>	},
>>>	{
>>>		.name = "DEEP_RET",
>>>		.power_on_latency_ns = ON_LATENCY_MED,
>>>		.power_off_latency_ns = OFF_LATENCY_MED,
>>>	},
>>>	{
>>>		.name = "OFF",
>>>		.power_on_latency_ns = ON_LATENCY_SLOW,
>>>		.power_off_latency_ns = OFF_LATENCY_SLOW,
>>>	}
>>>};
>>>
>>
>> I am trying to use your patches in fashioning a genpd for the cpu
>> domain.
>>
>> The cpus are part of a power domain that can be powered off when the
>> cpus are powered off as part of the cpuidle. One of the biggest power
>> savings comes from powering off the domain completely. However, powering
>> off the domain involves flushing of caches (possibly) and turning off
>> some regulators and peripheral hardware. The power benefit is only
>> realized when the domain remains powered off for a certain period of
>> time, otherwise the overhead of powering on/off would add up to the
>> ineffeciency in the system.
>>
>> So a governor that determines the idle state of the domain has two
>> things that needs to match, the time available to power off the domain
>> (which we can get from timer wheel) and the other residency as dictated
>> by the platform.
>>
>> I was wondering if we could match the idle state definition of the
>> domain with that of the cpu, which has a precedence in the kernel. The
>> idle state of the cpu [1] is a superset of the idle state definition you
>> have above.  That way a shim layer could pick up domain idle states from
>> DT and pass the states to pm_genpd_init(). The use of these values could
>> depend on the genpd governor.
>
>IMO, we need to keep the domain latency descriptions separate from the
>the devices within those domains, which could be CPUs or any other form
>of device.

Sure, the devices could be any. All I am saying is the format of idle
state definitions could be the same (same as cpu). There is a good
value in specifying the residency of an idle state in addition to the
the enter and exit latency.

>It should be the job of the governor then to look at the domain latency
>along with latencies of the other devices in the domain to make its
>decision.

Agreed and thats how it should be. In all probablility, a cpu-domain
governor would need a residency value of the domain idle state to best
determine the idle state of the domain.

If we have not stored the residency in struct genpd_power_state, then
the governor would not have a good way to make that decision.

I am not ready yet with my patches, but feel free to browse through my
working tree at [1] to see how I plan to use this patchset.

Thanks,
Lina

[1].
https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-8916-3
