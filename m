From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V6 0/4] Reduce the intel_pstate timer overhead
Date: Fri, 11 Mar 2016 00:19:39 +0100
Message-ID: <1617213.bt918jm17G@vostro.rjw.lan>
References: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54148 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751370AbcCJXRq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 18:17:46 -0500
In-Reply-To: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com

On Tuesday, March 08, 2016 10:31:12 AM Philippe Longepe wrote:
> V6: Minor fixes on commit message (Patch 1) + add intel_pstate:
> 
> This serie includes the following code optimizations:
> 
> Patch 1: Remove extra conversions in pid calculation
> Patch 2: Optimize calculation for max/min_perf_adj
> Patch 3: Move the intel_pstate_calc_busy into get_target_pstate_use_performance
> Patch 4: Remove the freq calculation from the intel_pstate_calc_busy function
> 
> Philippe Longepe (4):
>   Remove extra conversions in pid calculation
>   Optimize calculation for max/min_perf_adj
>   Move the intel_pstate_calc_busy into get_target_pstate_use_performance
>   intel_pstate: Remove the freq calculation from the
>     intel_pstate_calc_busy function
> 
>  drivers/cpufreq/intel_pstate.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)

All applied, [2-4/4] with Srinivas' ACKs.

Thanks,
Rafael

