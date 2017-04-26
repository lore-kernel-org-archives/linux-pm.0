From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/intel_idle: add GLK support
Date: Thu, 27 Apr 2017 00:36:42 +0200
Message-ID: <5173906.Kty4Ih4RO9@aspire.rjw.lan>
References: <20170423060625.4593-1-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53187 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031941AbdDZWm4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 18:42:56 -0400
In-Reply-To: <20170423060625.4593-1-david.e.box@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>, jacob.jun.pan@linux.intel.com
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Saturday, April 22, 2017 11:06:25 PM David E. Box wrote:
> From: "Box, David E" <david.e.box@intel.com>
> 
> Gemini Lake uses the same C-states as Broxton and also uses the
> IRTL MSR's to determine maximum C-state latency.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

You could use the code names consistently in your subjects (but I can fix this up).

Jacob, any concerns?

> ---
>  drivers/idle/intel_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index e045a5c..778af71 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1097,6 +1097,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>  	ICPU(INTEL_FAM6_XEON_PHI_KNL,		idle_cpu_knl),
>  	ICPU(INTEL_FAM6_XEON_PHI_KNM,		idle_cpu_knl),
>  	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		idle_cpu_bxt),
> +	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	idle_cpu_bxt),
>  	ICPU(INTEL_FAM6_ATOM_DENVERTON,		idle_cpu_dnv),
>  	{}
>  };
> @@ -1309,6 +1310,7 @@ static void intel_idle_state_table_update(void)
>  		ivt_idle_state_table_update();
>  		break;
>  	case INTEL_FAM6_ATOM_GOLDMONT:
> +	case INTEL_FAM6_ATOM_GEMINI_LAKE:
>  		bxt_idle_state_table_update();
>  		break;
>  	case INTEL_FAM6_SKYLAKE_DESKTOP:
> 
