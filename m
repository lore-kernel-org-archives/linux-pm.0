From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86/intel_idle: add GLK support
Date: Fri, 28 Apr 2017 23:56:14 -0400
Message-ID: <CAJvTdKnt5vJP5=OnzOsm1k+w07E+f-PPWK0fwx=jr4KOQM+aRg@mail.gmail.com>
References: <20170423060625.4593-1-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35373 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933136AbdD2D4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 23:56:16 -0400
In-Reply-To: <20170423060625.4593-1-david.e.box@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Acked-by: Len Brown <len.brown@intel.com>

On Sun, Apr 23, 2017 at 2:06 AM, David E. Box
<david.e.box@linux.intel.com> wrote:
> From: "Box, David E" <david.e.box@intel.com>
>
> Gemini Lake uses the same C-states as Broxton and also uses the
> IRTL MSR's to determine maximum C-state latency.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index e045a5c..778af71 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1097,6 +1097,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         ICPU(INTEL_FAM6_XEON_PHI_KNL,           idle_cpu_knl),
>         ICPU(INTEL_FAM6_XEON_PHI_KNM,           idle_cpu_knl),
>         ICPU(INTEL_FAM6_ATOM_GOLDMONT,          idle_cpu_bxt),
> +       ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       idle_cpu_bxt),
>         ICPU(INTEL_FAM6_ATOM_DENVERTON,         idle_cpu_dnv),
>         {}
>  };
> @@ -1309,6 +1310,7 @@ static void intel_idle_state_table_update(void)
>                 ivt_idle_state_table_update();
>                 break;
>         case INTEL_FAM6_ATOM_GOLDMONT:
> +       case INTEL_FAM6_ATOM_GEMINI_LAKE:
>                 bxt_idle_state_table_update();
>                 break;
>         case INTEL_FAM6_SKYLAKE_DESKTOP:
> --
> 2.9.3
>



-- 
Len Brown, Intel Open Source Technology Center
