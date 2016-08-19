From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle states
Date: Fri, 19 Aug 2016 13:10:32 -0500
Message-ID: <m2fuq0k4tj.fsf@baylibre.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
        <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
        <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
        <20160810164034.GA1401@linaro.org>
        <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35866 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755331AbcHSSKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 14:10:35 -0400
Received: by mail-io0-f172.google.com with SMTP id b62so55788753iod.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2016 11:10:34 -0700 (PDT)
In-Reply-To: <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com> (Sudeep Holla's
        message of "Wed, 10 Aug 2016 19:09:21 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, rjw@rjwysocki.net, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

Sudeep Holla <sudeep.holla@arm.com> writes:

[...]

> In general whatever binding we come up must not just address OS
> coordinated mode. Also I was thinking to have better coverage in the
> description by having a bit more complex system like:
>
> cluster0
> 	CLUSTER_RET(Retention)
> 	CLUSTER_PG(Power Gate)
> 	core0
> 		CORE_RET
> 		CORE_PG
> 	core1
> 		CORE_RET
> 		CORE_PG

Also, remember that a power domain may contain more than just CPUs, so
this will also need to handle things like:

	device0..N
        	DEV_CLK_GATE
                DEV_RET
                DEV_PG

So, as (I think) Lina was trying to say, including CPU idle states
inside domain idles states doesn't really scale well because it would
also imply domain states would also include device idle states.

IMO, the device-specific states belong in the device nodes, and that
includes CPUs.

It's up to the domain (genpd) governor to look at *all* devices in the
domain, check their state and make a domain-wide decision.

The tricky part remains, IMO, the mapping between device/CPU states and
allowable domain states.

As was suggested earlier, a good potential starting point would be that
all devices/CPUs would need to be in their deepest state before the
domain would make any decisions.  While that leaves soem power savings
on the table, it maps well to how genpd works today with only on/off
states and could be extended with more complicated governors down the
road.

Kevin




