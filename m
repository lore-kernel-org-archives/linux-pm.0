From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 6/6] arm64: wire cpu-invariant accounting support up to
 the task scheduler
Date: Mon, 12 Jun 2017 14:07:14 +0100
Message-ID: <20170612130714.GE24187@e104818-lin.cambridge.arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-7-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170608075513.12475-7-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, Juri Lelli <juri.lelli@arm.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Russell King <rmk+kernel@armlinux.org.uk>, Morten Rasmussen <morten.rasmussen@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 08, 2017 at 08:55:13AM +0100, Dietmar Eggemann wrote:
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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm64/include/asm/topology.h | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
