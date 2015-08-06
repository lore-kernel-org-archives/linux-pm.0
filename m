From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] intel_pstate: Fix possible overflow complained by Coverity
Date: Thu, 06 Aug 2015 02:11:04 +0200
Message-ID: <1536617.dpzoDvZL4g@vostro.rjw.lan>
References: <1438185190-12805-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45171 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751305AbbHEXn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 19:43:58 -0400
In-Reply-To: <1438185190-12805-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, kristen.c.accardi@intel.com, rui.zhang@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com

On Wednesday, July 29, 2015 11:53:10 PM Chen Yu wrote:
> Coverity scanning performed on intel_pstate.c shows possible
> overflow when doing left shifting:
> val = pstate << 8;
> since pstate is of type integer, while val is of u64, left shifting
> pstate might lead to potential loss of upper bits. Say, if pstate equals
> 0x4000 0000, after pstate << 8 we will get zero assigned to val.
> Although pstate will not likely be that big, this patch cast the left
> operand to u64 before performing the left shift, to avoid complaining
> from Coverity.
> 
> Reported-by: Coquard, Christophe <christophe.coquard@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Patch queued up for 4.3, thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 15ada47..6effe81 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -522,7 +522,7 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
>  	int32_t vid_fp;
>  	u32 vid;
>  
> -	val = pstate << 8;
> +	val = (u64)pstate << 8;
>  	if (limits.no_turbo && !limits.turbo_disabled)
>  		val |= (u64)1 << 32;
>  
> @@ -611,7 +611,7 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
>  {
>  	u64 val;
>  
> -	val = pstate << 8;
> +	val = (u64)pstate << 8;
>  	if (limits.no_turbo && !limits.turbo_disabled)
>  		val |= (u64)1 << 32;
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
