From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/intel_rapl: Add support for Gemini Lake
Date: Mon, 24 Apr 2017 09:54:12 -0700
Message-ID: <20170424095412.5fda5fc6@jacob-builder>
References: <20170423141520.7517-1-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33615 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S974850AbdDXQxK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Apr 2017 12:53:10 -0400
In-Reply-To: <20170423141520.7517-1-david.e.box@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Sun, 23 Apr 2017 07:15:20 -0700
"David E. Box" <david.e.box@linux.intel.com> wrote:

> From: "Box, David E" <david.e.box@intel.com>
> 
> Gemini Lake RAPL support is similar to Goldmont.
> 
Acked-by: Pan, Jacob jun <jacob.jun.pan@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c
> b/drivers/powercap/intel_rapl.c index 9a25110..9ddad08 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1164,6 +1164,7 @@ static const struct x86_cpu_id rapl_ids[]
> __initconst = { RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD,
> rapl_defaults_tng), RAPL_CPU(INTEL_FAM6_ATOM_MOOREFIELD,
> rapl_defaults_ann), RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,
> rapl_defaults_core),
> +	RAPL_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE,
> rapl_defaults_core), RAPL_CPU(INTEL_FAM6_ATOM_DENVERTON,
> rapl_defaults_core), 
>  	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,
> rapl_defaults_hsw_server),

[Jacob Pan]
