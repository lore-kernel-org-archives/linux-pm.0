From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: append more Oracle OEM table id to vendor
 bypass list
Date: Wed, 5 Aug 2015 12:47:55 -0700
Message-ID: <20150805124755.3f92c662@kcaccard-desk.amr.corp.intel.com>
References: <1438734530-5855-1-git-send-email-ethan.zhao@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62605 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbbHETr4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 15:47:56 -0400
In-Reply-To: <1438734530-5855-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ethan Zhao <ethan.zhao@oracle.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  5 Aug 2015 09:28:50 +0900
Ethan Zhao <ethan.zhao@oracle.com> wrote:

> Append more Oracle X86 servers that have their own power management,
> 
> SUN FIRE X4275 M3
> SUN FIRE X4170 M3
> and
> SUN FIRE X6-2
> 
> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index c45d274..c57b011 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1156,6 +1156,10 @@ static struct hw_vendor_info vendor_info[] = {
>  	{1, "ORACLE", "X4270M3 ", PPC},
>  	{1, "ORACLE", "X4270M2 ", PPC},
>  	{1, "ORACLE", "X4170M2 ", PPC},
> +	{1, "ORACLE", "X4170 M3", PPC},
> +	{1, "ORACLE", "X4275 M3", PPC},
> +	{1, "ORACLE", "X6-2    ", PPC},
> +	{1, "ORACLE", "Sudbury ", PPC},
>  	{0, "", ""},
>  };
>  

Acked-by:  Kristen Carlson Accardi <kristen@linux.intel.com>
