From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/intel_rapl: Add support for Ivy Bridge server
Date: Thu, 23 Jun 2016 06:34:35 -0700
Message-ID: <20160623063435.2d1d963a@yairi>
References: <1466667204-26340-1-git-send-email-xiaolong.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24073 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbcFWNfM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jun 2016 09:35:12 -0400
In-Reply-To: <1466667204-26340-1-git-send-email-xiaolong.wang@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xiaolong Wang <xiaolong.wang@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, jacob.jun.pan@linux.intel.com

On Thu, 23 Jun 2016 15:33:24 +0800
Xiaolong Wang <xiaolong.wang@linux.intel.com> wrote:

> It's confirmed that RAPL works as expected on Ivy Bridge servers.
> Tested against processor: Intel(R) Xeon(R) CPU E5-2697 v2 @2.70GHz
> 
> Signed-off-by: Xiaolong Wang <xiaolong.wang@linux.intel.com>
looks good to me but please always send to lkml as well.
> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c
> b/drivers/powercap/intel_rapl.c index 06d21e6..fbab29d 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1134,6 +1134,7 @@ static const struct x86_cpu_id rapl_ids[]
> __initconst = { RAPL_CPU(INTEL_FAM6_SANDYBRIDGE_X,
> rapl_defaults_core), 
>  	RAPL_CPU(INTEL_FAM6_IVYBRIDGE,
> rapl_defaults_core),
> +	RAPL_CPU(INTEL_FAM6_IVYBRIDGE_X,	rapl_defaults_core),
>  
>  	RAPL_CPU(INTEL_FAM6_HASWELL_CORE,	rapl_defaults_core),
>  	RAPL_CPU(INTEL_FAM6_HASWELL_ULT,	rapl_defaults_core),

