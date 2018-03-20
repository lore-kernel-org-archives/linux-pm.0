From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
Date: Tue, 20 Mar 2018 10:58:27 +0100
Message-ID: <CAJZ5v0iiALLPEO1CLQFNM6JyyVzS32napW4FQjt3PJCtP_Z2bA@mail.gmail.com>
References: <20180309121549.630-1-harry.pan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309121549.630-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Pan <harry.pan@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Joe Konno <joe.konno@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 9, 2018 at 1:15 PM, Harry Pan <harry.pan@intel.com> wrote:
> Cannon Lake microarchitecture is similar to Kaby Lake in terms of
> RAPL, this patch enables CNL RAPL support.
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>

I have applied an analogous patch from Joe Konno that was posted earlier.

Thanks!


> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 35636e1d8a3d..295d8dcba48c 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1162,6 +1162,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         RAPL_CPU(INTEL_FAM6_SKYLAKE_X,          rapl_defaults_hsw_server),
>         RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,    rapl_defaults_core),
>         RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,   rapl_defaults_core),
> +       RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,  rapl_defaults_core),
>
>         RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,   rapl_defaults_byt),
>         RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,       rapl_defaults_cht),
> --
> 2.13.5
>
