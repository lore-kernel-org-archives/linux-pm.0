From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] powercap/rapl: add support for denverton
Date: Thu, 16 Jun 2016 16:01:31 +0200
Message-ID: <1760055.hn59nWTpEW@vostro.rjw.lan>
References: <1465862548-10999-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62218 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754914AbcFPN5U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 09:57:20 -0400
In-Reply-To: <1465862548-10999-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Monday, June 13, 2016 05:02:28 PM Jacob Pan wrote:
> Denverton micro server is Atom based but RAPL interface
> is compatible with Core based CPUs.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 4aa8168..7977fbf 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1156,6 +1156,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>  	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD1,	rapl_defaults_tng),
>  	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD2,	rapl_defaults_ann),
>  	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
> +	RAPL_CPU(INTEL_FAM6_ATOM_DENVERTON,	rapl_defaults_core),
>  
>  	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
>  	{}
> 

Applied, thanks!

