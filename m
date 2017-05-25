From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 7/8] arm,arm64,drivers: move externs in a new header
 file
Date: Thu, 25 May 2017 15:13:44 +0200
Message-ID: <20170525131344.GD16244@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-8-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969138AbdEYNN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 09:13:56 -0400
Content-Disposition: inline
In-Reply-To: <20170420144316.15632-8-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org

On Thu, Apr 20, 2017 at 03:43:15PM +0100, Juri Lelli wrote:
> Create a new header file (include/linux/arch_topology.h) and put there
> declarations of interfaces used by arm, arm64 and drivers code.
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/kernel/topology.c    |  7 +------
>  arch/arm64/kernel/topology.c  |  4 +---
>  drivers/base/arch_topology.c  |  1 +
>  include/linux/arch_topology.h | 17 +++++++++++++++++
>  4 files changed, 20 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/arch_topology.h
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 1e35a3265ddf..557be4f1d2d7 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -11,6 +11,7 @@
>   * for more details.
>   */
>  
> +#include <linux/arch_topology.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> @@ -45,10 +46,6 @@
>   * updated during this sequence.
>   */
>  
> -extern unsigned long
> -arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> -extern void set_capacity_scale(unsigned int cpu, unsigned long capacity);
> -
>  #ifdef CONFIG_OF
>  struct cpu_efficiency {
>  	const char *compatible;
> @@ -76,8 +73,6 @@ static unsigned long *__cpu_capacity;
>  
>  static unsigned long middle_capacity = 1;
>  static bool cap_from_dt = true;
> -extern void normalize_cpu_capacity(void);
> -extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
>  
>  /*
>   * Iterate all CPUs' descriptor in DT and compute the efficiency
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 7e1f6f75185b..255230c3e835 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -11,6 +11,7 @@
>   * for more details.
>   */
>  
> +#include <linux/arch_topology.h>
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
> @@ -27,9 +28,6 @@
>  #include <asm/cputype.h>
>  #include <asm/topology.h>
>  
> -extern void normalize_cpu_capacity(void);
> -extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> -
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
>  	struct device_node *cpu_node;
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index acf99372c5cf..76c19aa0d82f 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/arch_topology.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/device.h>
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> new file mode 100644
> index 000000000000..4edae9fe8cdd
> --- /dev/null
> +++ b/include/linux/arch_topology.h
> @@ -0,0 +1,17 @@
> +/*
> + * include/linux/arch_topology.h - arch specific cpu topology information
> + */
> +#ifndef _LINUX_ARCH_TOPOLOGY_H_
> +#define _LINUX_ARCH_TOPOLOGY_H_
> +
> +void normalize_cpu_capacity(void);
> +
> +struct device_node;
> +int parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> +
> +struct sched_domain;
> +unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> +
> +void set_capacity_scale(unsigned int cpu, unsigned long capacity);

Ugh, horrid names, but I'll get to that on your next patch, when you
rename these things...

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
