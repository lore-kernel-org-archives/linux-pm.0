From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/7] OPP: Redefine bindings to overcome shortcomings
Date: Mon, 23 Feb 2015 14:36:18 -0800
Message-ID: <7ha904b6hp.fsf@deeprootsystems.com>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
	<cover.1423642246.git.viresh.kumar@linaro.org>
	<be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38746 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbBWWgX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 17:36:23 -0500
Received: by padbj1 with SMTP id bj1so30974655pad.5
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2015 14:36:22 -0800 (PST)
In-Reply-To: <be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>
	(Viresh Kumar's message of "Wed, 11 Feb 2015 16:16:24 +0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
>
> There had been multiple band-aid approaches to get them fixed (The latest one
> being: http://www.mail-archive.com/devicetree@vger.kernel.org/msg53398.html).
> For obvious reasons Rob rejected them and shown the right path forward.
>
> The shortcomings we are trying to solve here:
>
> - Getting clock sharing information between CPUs. Single shared clock vs
>   independent clock per core vs shared clock per cluster.
>
> - Support for turbo modes
>
> - Support for intermediate frequencies or OPPs we can switch to.
>
> - Other per OPP settings: transition latencies, disabled status, etc.?
>
> - Expandability of OPPs in future.
>
> This patch introduces new bindings "operating-points-v2" to get these problems
> solved. Refer to the bindings for more details.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

[...]

> +* OPP Descriptor Node
> +
> +This describes the OPPs belonging to a device. This node can have following
> +properties:
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2".
> +- OPP nodes: One or more OPP nodes describing frequency-voltage pairs. Their
> +  name isn't significant but their phandles can be used to reference an OPP.
> +
> +Optional properties:
> +- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
> +  switch their DVFS state together, i.e. they share clock lines. 

... or shared voltage rail?

> +  Missing property means devices have independent clock lines, but they share OPPs.

huh?  missing 'shared-opp' property means they share OPPs?  -ECONFUSED.

Maybe I missed some of the discussion of why this property is needed,
but I'm left wondering why it's needed explicitly.  With the OPPs as
part of the CPU nodes, shouldnt' the "shared" nature of the OPP be
easily derived from the clock and or regulator (opp-supply) property of
the CPU nodes?  IOW, if two CPU nodes share a clock and/or a regulator,
the framework should know it's "shared".

Or, were there other reasons besides clocks/regulators why this property
was needed (if so, the documentation doesn't describe them.)

Kevin
