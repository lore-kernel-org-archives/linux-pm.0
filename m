From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/6] arm64: wire frequency-invariant accounting support
 up to the task scheduler
Date: Mon, 12 Jun 2017 14:06:55 +0100
Message-ID: <20170612130655.GD24187@e104818-lin.cambridge.arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-6-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbdFLNHA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 09:07:00 -0400
Content-Disposition: inline
In-Reply-To: <20170608075513.12475-6-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, Juri Lelli <juri.lelli@arm.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Russell King <rmk+kernel@armlinux.org.uk>, Morten Rasmussen <morten.rasmussen@arm.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jun 08, 2017 at 08:55:12AM +0100, Dietmar Eggemann wrote:
> Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
> changed the wiring which now has to be done by associating
> arch_scale_freq_capacity with the actual implementation provided
> by the architecture.
> 
> Define arch_scale_freq_capacity to use the arch_topology "driver"
> function topology_get_freq_scale() for the task scheduler's
> frequency-invariant accounting instead of the default
> arch_scale_freq_capacity() in kernel/sched/sched.h.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm64/include/asm/topology.h | 5 +++++
>  arch/arm64/kernel/topology.c      | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
