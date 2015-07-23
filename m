From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Add get_scaling cpu_defaults param to Knights Landing
Date: Thu, 23 Jul 2015 23:01:11 +0200
Message-ID: <1511570.FZY0g9ByP0@vostro.rjw.lan>
References: <1437468073-9668-1-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64864 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753963AbbGWUeX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 16:34:23 -0400
In-Reply-To: <1437468073-9668-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: viresh.kumar@linaro.org, kristen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yishimat@redhat.com, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

On Tuesday, July 21, 2015 10:41:13 AM Lukasz Anaczkowski wrote:
> Scaling for Knights Landing is same as the default scaling (100000).
> When Knigts Landing support was added to the pstate driver, this
> parameter was omitted resulting in a kernel panic during boot.
> 
> Reported-by: Yasuaki Ishimatsu <yishimat@redhat.com>
> Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>

Queued up for 4.3, thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 15ada47..fcb929e 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -681,6 +681,7 @@ static struct cpu_defaults knl_params = {
>  		.get_max = core_get_max_pstate,
>  		.get_min = core_get_min_pstate,
>  		.get_turbo = knl_get_turbo_pstate,
> +		.get_scaling = core_get_scaling,
>  		.set = core_set_pstate,
>  	},
>  };
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
