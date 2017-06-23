From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] cpupower: Fix bug where return value was not used
Date: Fri, 23 Jun 2017 16:00:57 +0200
Message-ID: <6275735.KfbznezEp5@skinner>
References: <20170620065708.21434.80154.stgit@Diesel2540.amd.com> <20170620070241.21434.57148.stgit@Diesel2540.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751620AbdFWOA7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Jun 2017 10:00:59 -0400
In-Reply-To: <20170620070241.21434.57148.stgit@Diesel2540.amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tuesday, June 20, 2017 02:07:37 AM Sherry Hurwitz wrote:
> Save return value from amd_pci_get_num_boost_states
> and remove redundant setting of *support
> 
> Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>

Acked-by: Thomas Renninger <trenn@suse.com>
Reviewed-by: Thomas Renninger <trenn@suse.com>
whatever is more appropriate or both...

Thanks, good catch!

Rafael can you queue this an the next one, please?

Thanks,

     Thomas

> ---
>  tools/power/cpupower/utils/helpers/misc.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c 
b/tools/power/cpupower/utils/helpers/misc.c
> index 1609243..6952a6a 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -16,10 +16,9 @@ int cpufreq_has_boost_support(unsigned int cpu, int 
*support, int *active,
>  
>  	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CBP) {
>  		*support = 1;
> -		amd_pci_get_num_boost_states(active, states);
> -		if (ret <= 0)
> +		ret = amd_pci_get_num_boost_states(active, states);
> +		if (ret)
>  			return ret;
> -		*support = 1;
>  	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>  		*support = *active = 1;
>  	return 0;
> 
> 
