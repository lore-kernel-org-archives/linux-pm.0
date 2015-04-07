From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] [RFC] PM / Domains: multiple states
Date: Mon, 06 Apr 2015 17:06:57 -0700
Message-ID: <7hvbh8sswu.fsf@deeprootsystems.com>
References: <1427963699-2638-1-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35130 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbDGAHA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 20:07:00 -0400
Received: by pddn5 with SMTP id n5so59937465pdd.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2015 17:07:00 -0700 (PDT)
In-Reply-To: <1427963699-2638-1-git-send-email-ahaslam@baylibre.com>
	(ahaslam@baylibre.com's message of "Thu, 2 Apr 2015 10:34:59 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org

ahaslam@baylibre.com writes:

> From: Axel Haslam <ahaslam@baylibre.com>
>
> Some architectures may have intermediate
> power levels between on and off. each state in
> between may have its own set of registers to
> save and restore, and procedures to put the power
> domain into that state.

Maybe a bit more description is needed here, something like:

...the most common of these being a "retention" state, where clocks are
gated, and voltage is lowered to a retention voltage so the domain is
not technically "off" (as in zero volts) but is in a low-power state,
with all or part of the logic/memory retained.

For those more familiar with ACPI, you might also mention the simliarity
to ACPI D states:
http://en.wikipedia.org/wiki/Advanced_Configuration_and_Power_Interface#Device_states

> This patch adds the ability to declare multiple
> states for a given generic power domain, the
> idea is that the deepest state will be entered which
> does not violate any of the device or sub-domain
> latency constraints.
>
> for this purpose, the device save and restore callbacks
> take in a new parameter "state" which is the state
> the domain is trying to go to. The implementation
> of these callbacks can use this to save and restore
> the appropriate registers. Also the power on and off
> callbacks and latencies are now tied to a particular
> state.

The unfortunate problem here is that the underlying framework (runtime
PM) doesn't yet know about multiple power states, so I'm not sure (yet)
how to make this work at the genpd level without also changing runtime
PM understand the concept of multiple power states.  

So, maybe I'm missing something, but I'm not yet sure how this would be
useful without the underlying support in runtime PM also.

> States should be declared in ascending order from shallowest
> to deepest, deepest meaning the state which takes longer
> to enter and exit. The declaration would look something like:
>
> 	struct genpd_power_state states[3] = {
> 		{
> 			.name= "LOW_POWER_1",
> 			.power_off = arch_callback_lp1,
> 			.power_on = arch_callback_lp1,
> 			.power_off_latency_ns = 1000000,
> 			.power_on_latency_ns = 1000000,
>
> 		},
> 		{
> 			.name= "LOW_POWER_2",
> 			.power_off = arch_callback_lp2,
> 			.power_on = arch_callback_lp2,
> 			.power_off_latency_ns = 2000000,
> 			.power_on_latency_ns = 2000000,
>
> 		},
> 		{
> 			.name= "OFF",
> 			.power_off = arch_callback_off,
> 			.power_on = arch_callback_off,
> 			.power_off_latency_ns = 4000000,
> 			.power_on_latency_ns = 4000000,
>
> 		},
> 	};

We might also need a per-state flag stating whether context is lost, so
we know whether the save/restore state stuff actually needs to be
called.

[...]

> @@ -118,14 +120,33 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>  			link->master->max_off_time_changed = true;
>  
>  		genpd->max_off_time_changed = false;
> -		genpd->cached_power_down_ok = false;
> -		genpd->max_off_time_ns = -1;
> +		/*
> +		 * invalidate the cached values for every state
> +		 */
> +		for (i = 0; i < genpd->state_count; i++) {
> +			genpd->states[i].cached_power_down_ok =
> +				GPD_CACHED_UNKNOWN;
> +			genpd->max_off_time_ns = -1;
> +		}
> +

I'm not quite understanding the need for these new GPD_CACHED_* flags,
and this change isn't described in the changelog.

Kevin
