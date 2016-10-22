From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 4/4] Documentation: kernel parameters: per core P-State control
Date: Sat, 22 Oct 2016 03:28:15 +0200
Message-ID: <1893073.Z6Px2pTx1l@vostro.rjw.lan>
References: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1477066466-22367-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48238 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755463AbcJVBVU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 21:21:20 -0400
In-Reply-To: <1477066466-22367-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Friday, October 21, 2016 09:14:26 AM Srinivas Pandruvada wrote:
> Additional command line control to enable per core performance
> control.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 37babf9..e216f6e 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1780,6 +1780,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			Description Table, specifies preferred power management
>  			profile as "Enterprise Server" or "Performance Server",
>  			then this feature is turned on by default.
> +		per_cpu_perf_limits
> +			Allow per core P-State performance control limits using
> +			cpufreq sysfs interface

I'd say "per-logical-CPU" rather than "per core" to avoid confusion of cores
vs HW threads.

>  
>  	intremap=	[X86-64, Intel-IOMMU]
>  			on	enable Interrupt Remapping (default)
> 

Thanks,
Rafael

