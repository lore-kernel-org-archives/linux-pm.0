From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 6/7] arm, arm64: factorize common cpu capacity default code
Date: Thu, 19 Jan 2017 16:00:45 +0000
Message-ID: <e5b902a0-8c2b-a682-0f67-0b0d9ee4ef5c@arm.com>
References: <20170119143757.14537-1-juri.lelli@arm.com>
 <20170119143757.14537-7-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170119143757.14537-7-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 19/01/17 14:37, Juri Lelli wrote:
> arm and arm64 share lot of code relative to parsing CPU capacity
> information from DT, using that information for appropriate scaling and
> exposing a sysfs interface for chaging such values at runtime.
> 
> Factorize such code in a common place (driver/base/arch_topology.c) in
> preparation for further additions.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/Kconfig             |   1 +
>  arch/arm/kernel/topology.c   | 213 ++------------------------------------
>  arch/arm64/Kconfig           |   1 +
>  arch/arm64/kernel/topology.c | 213 +-------------------------------------
>  drivers/base/Kconfig         |   8 ++
>  drivers/base/Makefile        |   1 +
>  drivers/base/arch_topology.c | 240 +++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 260 insertions(+), 417 deletions(-)
>  create mode 100644 drivers/base/arch_topology.c

[...]

> +extern unsigned long
> +arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);

How about adding a driver specific prefix 'foo_' to all driver interfaces?

I'm asking because I would rather like to do a

#define arch_scale_cpu_capacity foo_scale_cpu_capacity

then a

#define arch_scale_cpu_capacity arch_scale_cpu_capacity

in arch/arm64/include/asm/topology.h

later to wire cpu-invariant load-tracking support up to the task
scheduler for ARM64.

That's probably true too for all the 'driver' interfaces which get used
in arch/arm{,64}/kernel/topology.c.

[...]
