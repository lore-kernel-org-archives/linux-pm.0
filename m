From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 2/5] PM / Domains: core changes for multiple states
Date: Thu, 7 May 2015 09:53:59 -0600
Message-ID: <20150507155359.GA15980@linaro.org>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
 <1430391335-7588-3-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34478 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbEGPyA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 11:54:00 -0400
Received: by pdbqa5 with SMTP id qa5so44833981pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 08:54:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430391335-7588-3-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

On Thu, Apr 30 2015 at 04:57 -0600, ahaslam@baylibre.com wrote:
>From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
>Add the core changes to be able to declare multiple states.
>When trying to set a power domain to off, genpd will be able
>to choose from an array of states declared by the platform.
>
>The power on and off latencies are now tied to a state.
>
>States should be declared in ascending order from shallowest
>to deepest, deepest meaning the state which takes longer to
>enter and exit.
>
>the power_off and power_on function can use the 'state_idx'
>field of the generic_pm_domain structure, to distinguish between
>the different states and act accordingly.
>
> - if the genpd is initially off, the user should set the state_idx
>   field when registering the genpd.
>
> - if no states are passed to pm_genpd_init, a single OFF
>   state with no latency is assumed.
>
>Example:
>
>static int pd1_power_on(struct generic_pm_domain *domain)
>{
>	/* domain->state_idx = state the domain is coming from */
>}
>
>static int pd1_power_off(struct generic_pm_domain *domain)
>{
>	/* domain->state_idx = desired powered off state */
>}
>
>const struct genpd_power_state pd_states[] = {
>	{
>		.name = "RET",
>		.power_on_latency_ns = ON_LATENCY_FAST,
>		.power_off_latency_ns = OFF_LATENCY_FAST,
>	},
>	{
>		.name = "DEEP_RET",
>		.power_on_latency_ns = ON_LATENCY_MED,
>		.power_off_latency_ns = OFF_LATENCY_MED,
>	},
>	{
>		.name = "OFF",
>		.power_on_latency_ns = ON_LATENCY_SLOW,
>		.power_off_latency_ns = OFF_LATENCY_SLOW,
>	}
>};
>

I am trying to use your patches in fashioning a genpd for the cpu
domain.

The cpus are part of a power domain that can be powered off when the
cpus are powered off as part of the cpuidle. One of the biggest power
savings comes from powering off the domain completely. However, powering
off the domain involves flushing of caches (possibly) and turning off
some regulators and peripheral hardware. The power benefit is only
realized when the domain remains powered off for a certain period of
time, otherwise the overhead of powering on/off would add up to the
ineffeciency in the system.

So a governor that determines the idle state of the domain has two
things that needs to match, the time available to power off the domain
(which we can get from timer wheel) and the other residency as dictated
by the platform.

I was wondering if we could match the idle state definition of the
domain with that of the cpu, which has a precedence in the kernel. The
idle state of the cpu [1] is a superset of the idle state definition you
have above.  That way a shim layer could pick up domain idle states from
DT and pass the states to pm_genpd_init(). The use of these values could
depend on the genpd governor.

Thanks,
Lina

>struct generic_pm_domain pd1 = {
>	.name = "PD1",
>	.state_idx = 2, /* needed if domain is not on at init. */
>	.power_on = pd1_power_on,
>	.power_off = pd1_power_off,
>	...
>};
>
>int xxx_init_pm_domain(){
>
>	pm_genpd_init(struct generic_pm_domain,
>			pd1, pd_states, ARRAY_SIZE(pd_states), true);
>
>}
>
>Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>---

[1]. Documentation/devicetree/bindings/arm/idle-states.txt
