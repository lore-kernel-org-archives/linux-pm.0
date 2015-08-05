From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] intel_pstate: append more Oracle OEM table id to vendor
 bypass list
Date: Wed, 5 Aug 2015 10:40:05 +0530
Message-ID: <20150805051005.GC15655@linux>
References: <1438734530-5855-1-git-send-email-ethan.zhao@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34433 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbHEFKN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 01:10:13 -0400
Received: by pawu10 with SMTP id u10so25979196paw.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 22:10:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438734530-5855-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ethan Zhao <ethan.zhao@oracle.com>
Cc: kristen@linux.intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 05-08-15, 09:28, Ethan Zhao wrote:
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
