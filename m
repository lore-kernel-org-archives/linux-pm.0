From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] powercap/intel_rapl: Add support for Kabylake
Date: Mon, 25 Apr 2016 16:20:17 +0200
Message-ID: <CAJZ5v0imwM3RCPM8QTWSWwEOfyCUZUTECMEa1hQOhyCLW06K_g@mail.gmail.com>
References: <1461345439-21215-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461345439-21215-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 22, 2016 at 7:17 PM, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
> Kabylake is similar to Skylake in terms of RAPL.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

How urgent is this?

Can we live without it in 4.6 in particular?

> ---
>  drivers/powercap/intel_rapl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 8fad0a7..470bb62 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1101,6 +1101,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
>         RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
>         RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
> +       RAPL_CPU(0x8E, rapl_defaults_core),/* Kabylake */
> +       RAPL_CPU(0x9E, rapl_defaults_core),/* Kabylake */
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
