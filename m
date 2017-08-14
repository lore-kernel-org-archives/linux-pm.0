From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 08/10] arm: wire cpu-invariant accounting support up
 to the task scheduler
Date: Mon, 14 Aug 2017 14:16:49 +0100
Message-ID: <20170814131649.GI20805@n2100.armlinux.org.uk>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
 <20170727193312.9849-9-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49106 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbdHNNRO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2017 09:17:14 -0400
Content-Disposition: inline
In-Reply-To: <20170727193312.9849-9-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

On Thu, Jul 27, 2017 at 08:33:10PM +0100, Dietmar Eggemann wrote:
> Commit 8cd5601c5060 ("sched/fair: Convert arch_scale_cpu_capacity() from
> weak function to #define") changed the wiring which now has to be done
> by associating arch_scale_cpu_capacity with the actual implementation
> provided by the architecture.
> 
> Define arch_scale_cpu_capacity to use the arch_topology "driver"
> function topology_get_cpu_scale() for the task scheduler's cpu-invariant
> accounting instead of the default arch_scale_cpu_capacity() in
> kernel/sched/sched.h.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> Reviewed-by: Juri Lelli <juri.lelli@arm.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
