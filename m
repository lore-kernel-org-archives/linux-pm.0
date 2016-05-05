From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Ignore _PPC processing under HWP
Date: Thu, 05 May 2016 15:59:37 +0200
Message-ID: <4949775.UIqCg2qNjL@vostro.rjw.lan>
References: <1462399654-15005-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43779 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752622AbcEEN4Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 09:56:25 -0400
In-Reply-To: <1462399654-15005-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Wednesday, May 04, 2016 03:07:34 PM Srinivas Pandruvada wrote:
> When HWP (hardware P states) feature is active, the ACPI _PSS and _PPC
> is not used. So ignore processing for _PPC limits.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 97a8278..0620fa6 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -378,6 +378,9 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
>  	int ret;
>  	int i;
>  
> +	if (hwp_active)
> +		return;
> +
>  	if (!intel_pstate_get_ppc_enable_status())
>  		return;
>  
> 

Applied, thanks!

