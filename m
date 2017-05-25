From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 8/8] arm,arm64,drivers: add a prefix to drivers
 arch_topology interfaces
Date: Thu, 25 May 2017 15:18:02 +0200
Message-ID: <20170525131802.GE16244@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-9-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbdEYNSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 09:18:14 -0400
Content-Disposition: inline
In-Reply-To: <20170420144316.15632-9-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org

On Thu, Apr 20, 2017 at 03:43:16PM +0100, Juri Lelli wrote:
> Now that some functions that deal with arch topology information live
> under drivers, there is a clash of naming that might create confusion.
> 
> Tidy things up by creating a drivers namespace for interfaces used by
> arch code; achieve this by prepending a 'atd_' (arch topology driver)
> prefix to driver interfaces.

No one knows, nor will they ever remember, what "atd_" means :(

Naming is hard, I know, here's my suggestion:

> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 4edae9fe8cdd..e25458d7ee9a 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -4,14 +4,14 @@
>  #ifndef _LINUX_ARCH_TOPOLOGY_H_
>  #define _LINUX_ARCH_TOPOLOGY_H_
>  
> -void normalize_cpu_capacity(void);
> +void atd_normalize_cpu_capacity(void);

arch_cpu_normalize_capacity();
or
cpu_normalize_capacity();

Why do you care if this is "arch" or not, of course it's arch-specific
in a way, right?

>  
>  struct device_node;
> -int parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> +int atd_parse_cpu_capacity(struct device_node *cpu_node, int cpu);

cpu_parse_capacity();

>  struct sched_domain;
> -unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> +unsigned long atd_scale_cpu_capacity(struct sched_domain *sd, int cpu);

cpu_scale_capacity();

> -void set_capacity_scale(unsigned int cpu, unsigned long capacity);
> +void atd_set_capacity_scale(unsigned int cpu, unsigned long capacity);

wait, where did the cpu go?  This doesn't make much sense, these are all
"capacity" issues, right?  If so, then these should be:
	capacity_normalize_cpu()
	capacity_parse_cpu()
	capacity_scale_cpu()
	capacity_set_scale()

But this is all really topology stuff, right?  Why use "capacity" at
all:
	topology_normalize_cpu()
	topology_parse_cpu()
	topology_scale_cpu()
	topology_set_scale()
?

It's always best to put the "subsystem" name first, we have a bad
history of getting this wrong in the past by putting the verb first, not
the noun.

thanks,

greg k-h
