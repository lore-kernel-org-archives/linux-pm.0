From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower tools: Fix error when running cpupower monitor
Date: Mon, 10 Aug 2015 14:28:59 +0200
Message-ID: <9534146.fFc3TD2C5D@skinner>
References: <1438582560-13352-1-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46529 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbbHJM3B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 10 Aug 2015 08:29:01 -0400
In-Reply-To: <1438582560-13352-1-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, pavsubra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, August 03, 2015 11:46:00 AM Shreyas B. Prabhu wrote:
> get_cpu_topology() tries to get topology info from all cpus by reading
> files in the topology sysfs dir. If a cpu is offlined, since it doesn't
> have topology dir, this function fails and returns -1. This causes
> functions relying on get_cpu_topology() to fail. For example-
> 
> $ cpupower monitor
> Cannot read number of available processors
> 
> Fix this by skipping fetching topology info for offline cpus.

Looks fine.

Thanks!

Acked-by: Thomas Renninger <trenn@suse.de>


> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Reported-by: Pavaman Subramaniyam <pavsubra@linux.vnet.ibm.com>
> ---
>  tools/power/cpupower/utils/helpers/topology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/topology.c
> b/tools/power/cpupower/utils/helpers/topology.c index
> c13120af519b..cea398c176e7 100644
> --- a/tools/power/cpupower/utils/helpers/topology.c
> +++ b/tools/power/cpupower/utils/helpers/topology.c
> @@ -73,6 +73,8 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
>  	for (cpu = 0; cpu < cpus; cpu++) {
>  		cpu_top->core_info[cpu].cpu = cpu;
>  		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
> +		if (!cpu_top->core_info[cpu].is_online)
> +			continue;
>  		if(sysfs_topology_read_file(
>  			cpu,
>  			"physical_package_id",

