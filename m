From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 0/8] CPUs capacity information for heterogeneous
 systems
Date: Mon, 7 Dec 2015 12:02:44 +0000
Message-ID: <20151207120244.GE14571@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36453 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772AbbLGMCR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Dec 2015 07:02:17 -0500
Content-Disposition: inline
In-Reply-To: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 23/11/15 14:28, Juri Lelli wrote:
> Hi all,
> 

Hi again everybody,

thanks a lot to Rob and Vincent for feedback, but, IMHO, we'd need more
discussion happening on this series to figure out how we move forward;
so, this is a ping :-).  It's a simple information that we need to figure
out how to provide, and in which form, but it has the potential to form
a standardized basis for achieving important performance benefits.

Thanks,

- Juri

> ARM systems may be configured to have CPUs with different power/performance
> characteristics within the same chip. In this case, additional information has
> to be made available to the kernel (the scheduler in particular) for it to be
> aware of such differences and take decisions accordingly. This posting stems
> from the ongoing discussion about introducing a simple platform energy cost
> model to guide scheduling decisions (a.k.a Energy Aware Scheduling [1]), but
> also aims to be an independent track aimed to standardise the way we make the
> scheduler aware of heterogenous CPU systems. With these patches and in addition
> patches from [1] (that make the scheduler wakeup paths aware of heterogenous
> CPU systems) we enable the scheduler to have good default performance on such
> systems. In addition, we get a clearly defined way of providing the scheduler
> with needed information about CPU capacity on such systems.
> 
> CPU capacity is defined in this context as a number that provides the scheduler
> information about CPUs heterogeneity. Such heterogeneity can come from
> micro-architectural differences (e.g., ARM big.LITTLE systems) or maximum
> frequency at which CPUs can run (e.g., SMP systems with multiple frequency
> domains and different max frequencies). Heterogeneity in this context is about
> differing performance characteristics; in practice, the binding that we propose
> in this RFC tries to capture a first-order approximation of the relative
> performance of CPUs.
> 
> This RFC proposes a solution to the problem of how do we init CPUs original
> capacity. The way it works today, and for arm A15/A7 systems only, is that we
> rely on cpu_efficiency magic numbers from arch/arm/kernel/topology.c and the
> existence of clock-frequency dtb properties; having those values available, we
> then do some math to come up with capacities we know from measurement (e.g.,
> EAS energy model), e.g. for TC2 they are 430 for A7 and 1024 for A15.
> Currently, arm64 doesn't have such a feature at all.
> 
> With this patchset we provide CPUs capacity information either from DT or from
> sysfs interface. Such information is standardized for both arm and arm64.
> 
> Patches high level description:
> 
>  o 01/08 cleans up how cpu_scale is initialized in arm
>  o 02/08 introduces documentation for the new optional DT binding
>  o [03-06]/08 add cpu-capacity attribute to TC2 and Juno DTs and provide
>    parsing of such information at boot time
>  o [07-08]/08 introduce sysfs attribute
> 
> The patchset is based on top of tip/sched/core as of today.
> 
> In case you would like to test this out, I pushed a branch here:
> 
>  git://linux-arm.org/linux-jl.git upstream/default_caps_dt
> 
> This branch contains additional patches, useful to better understand how CPU
> capacity information is actually used by the scheduler. Discussion regarding
> these additional patches will be started with a different posting in the
> future. We just didn't want to make discussion too broad, as we realize that
> this set can be controversial already on its own.
> 
> Comments, concerns and rants are more than welcome!
> 
> Best,
> 
> - Juri
> 
> Juri Lelli (8):
>   ARM: initialize cpu_scale to its default
>   Documentation: arm: define DT cpu capacity bindings
>   arm: parse cpu capacity from DT
>   arm, dts: add TC2 cpu capacity information
>   arm64: parse cpu capacity from DT
>   arm64, dts: add Juno cpu capacity information
>   arm: add sysfs cpu_capacity attribute
>   arm64: add sysfs cpu_capacity attribute
> 
>  .../devicetree/bindings/arm/cpu-capacity.txt       | 227 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  17 ++
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   6 +
>  arch/arm/kernel/topology.c                         | 122 ++++++++++-
>  arch/arm64/boot/dts/arm/juno.dts                   |   7 +
>  arch/arm64/kernel/topology.c                       | 114 +++++++++++
>  6 files changed, 489 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
> 
> -- 
> 2.2.2
> 
