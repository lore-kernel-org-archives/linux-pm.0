From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC v2 2/6] PM / Domains: prepare for devices that might register a power state
Date: Tue, 13 Oct 2015 14:03:07 -0700
Message-ID: <7hy4f6cwhg.fsf@deeprootsystems.com>
References: <20151006022702.GA78570@linaro.org>
	<1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
	<1444141665-18534-3-git-send-email-mtitinger+renesas@baylibre.com>
	<20151008161156.GA921@linaro.org> <56178B44.6040604@baylibre.com>
	<20151009182217.GE921@linaro.org> <561CDD1B.5090900@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34469 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbbJMVDK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 17:03:10 -0400
Received: by pabws5 with SMTP id ws5so663692pab.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 14:03:10 -0700 (PDT)
In-Reply-To: <561CDD1B.5090900@baylibre.com> (Marc Titinger's message of "Tue,
	13 Oct 2015 12:29:47 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, rjw@rjwysocki.net, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>

Marc Titinger <mtitinger@baylibre.com> writes:

> On 09/10/2015 20:22, Lina Iyer wrote:
>> On Fri, Oct 09 2015 at 03:39 -0600, Marc Titinger wrote:
>>> On 08/10/2015 18:11, Lina Iyer wrote:
>>>> Hi Marc,
>>>>
>>>> Thanks for rebasing on top of my latest series.
>>>>
>>>> On Tue, Oct 06 2015 at 08:27 -0600, Marc Titinger wrote:
>>>>> Devices may register an intermediate retention state into the domain
>>>>> upon
>>>>>
>>>> I may agree with the usability of dynamic adding a state to the domain,
>>>> but I dont see why a device attaching to a domain should bring about a
>>>> new domain state.
>>>
>>> Hi Lina,
>>>
>>> thanks a lot for taking the time to look into this. The initial
>>> discussion behind it was about to see how a device like a PMU, FPU,
>>> cache, or a Healthcheck IP in the same power domain than CPUs, with
>>> special retention states can be handled in a way 'unified' with CPUs.
>>> Also I admit it is partly an attempt from us to create something
>>> useful out of the "collision" of Axel's multiple states and your
>>> CPUs-as-generic-power-domain-devices, hence the RFC!
>>>
>>> Looking at Juno for instance, she currently has a platform-initiated
>>> mode implemented in the arm-trusted-firmware through psci as a
>>> cpuidle-driver. the menu governor will select a possibly deep c-state,
>>> but the last-man CPU and actual power state is known to ATF. Similarly
>>> my idea was to have a genpd-initiated mode so to say, where the actual
>>> power state results from the cpu-domain's governor choice based on
>>> possible retention states, and their latency.
>>>
>> Okay, I must admit that my ideas are quite partial to OS-initiated PSCI
>> (v1.0 onwards). So you have C-States that allow domains to enter idle as
>> well. Fair.
>>
>>> A Health-check IP or Cache will not (to my current knowledge) have a
>>> driver calling runtime_put, but may have a retention state "D1_RET"
>>> with a off/on latency between CPU_SLEEP and CLUSTER_SLEEP, so that
>>> CLUSTER_SLEEP may be ruled out by the governor, but D1_RET is ok given
>>> the time slot available.
>> A couple of questions here.
>>
>> You say there is no driver for HIP, is there a device for it atleast?
>> How is the CPU/Domain going to know if the HIP is running or not?
>>
>> To me this seems like you want to set a QoS on the PM domain here.
>>
>>> Some platform code can be called so that the cluster goes to D1_RET in
>>> that case, upon the last-man CPU waiting-for-interrupt. Note that in
>>> the case of a Health-Check HIP, the state my actually be a working
>>> state (all CPUs power down, and time slot OK for sampling stuff).
>>>
>> Building on my previous statement, if you have a QoS for a domain and a
>> domain governor, it could consider the QoS requirement and choose to do
>> retention. However that needs a driver or some entity that know the HIP
>> is requesting a D1_RET mode only.
>
> lets' consider a device like an L2-cache with a RAM retention state,
> (for instance looking at
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0500f/DDI0500F_cortex_a53_r0p4_trm.pdf
> page 41). the platform code and suspend sequence that will allow for
> setup of this  L2 RAM Retention state will be partly common to
> handling deep c-states like 'CLUSTER_SLEEP'. Typically for a53, the
> manual describes a parent power domain PDCORTEXA53, child CPU domains
> PDCPUn and a child domain PDL2 that allows for L2 RAM retention. We
> can have all CPUs 'off' and PDL2 in retention.
>
> In terms of 'multiple states', each CPU as a genpd device can
> independently set a constraint for the domain 'simple governor', ok
> it's not done through pm_qos_add_request, but through runtime_put, but
> since the c-states are soaked into the power domain as possible
> power-domain states, the domain will chose for the deepest possible
> c-state based on :
>
> - cpus runtime_put (for c-states deeper than state0 "WFI")
> - qos_requests from regular devices in the domain, or subdomains
> - .. what about L2 or devices with their own power domain, that will
> not hook to pm_runtime ?
>
> Beyond L2 controllers, you could have hard IPs for debug, monitoring,
> that will have a child power domain like above, but not necessarily
> hook to pm_runtime. Since the platform code for handling the CPU
> constraints on the domain QoS is the one for handling c-states, and
> the same for the L2-retention state, why not expose those constraints
> as all-c-states ?
>
> I reckon that alternatively, it could be interesting to model L2-cc as
> a regular peripheral on its own, and hook to pm_runtime instead, but
> then eventually will call the same monitor code code that handles the
> cpu-suspend. But it's maybe less architecture dependent and more in
> the initial spirit of "statement-of-work" motivating this series ?

Correct.

I think has a first pass, rather than add the additional complexity
required for a dynamic set of genpd states, I think it's much better to
start by assuming that all devices in the domain that affect the domain
state should have an associated device and a driver using runtime PM.
For example, performance montitoring units (PMUs) like CoreSight have
this same issue, and the upstream support for those is already using
runtime PM.

For really simple/dump devices like L2$ or similar, it might be that we
don't need a real driver, but instead the CPU "devices" could do
gets/puts on any dependent devices directly.

Kevin
