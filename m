From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Add CPUID for BDW-H CPU
Date: Sat, 15 Nov 2014 00:54:36 +0100
Message-ID: <1543234.jn62GexWHC@vostro.rjw.lan>
References: <1415296245-4368-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64542 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422746AbaKNXdh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 18:33:37 -0500
In-Reply-To: <1415296245-4368-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

On Thursday, November 06, 2014 09:50:45 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Add BDW-H to the list of supported processors.
> 
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

Queued up for 3.19, thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 27bb6d3..6dafd4f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -730,6 +730,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>  	ICPU(0x3f, core_params),
>  	ICPU(0x45, core_params),
>  	ICPU(0x46, core_params),
> +	ICPU(0x47, core_params),
>  	ICPU(0x4c, byt_params),
>  	ICPU(0x4f, core_params),
>  	ICPU(0x56, core_params),
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
