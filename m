From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpufreq/intel_pstate: Load only on Intel hardware
Date: Mon, 01 Apr 2019 17:18:49 +0200
Message-ID: <9389251.Bs5y7Thn0n@house>
References: <20190330100225.14744-1-bp@alien8.de> <20190401083902.GC28264@zn.tnic> <20190401150345.GJ28264@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401150345.GJ28264@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Erwan Velu <e.velu@criteo.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, April 1, 2019 5:03:45 PM CEST Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> This driver is Intel-only so loading on anything which is not Intel is
> pointless. Prevent it from doing so.

Nice.
I wondered whether there are more of these to find by review, instead
of waiting for the next message to show up.

I ended up in the "not so straight forward" IOMMU init macros... and
continued with daily work again.

Anyway there are a lot files showing up when grepping the kernel for
intel files/drivers, maybe someone who is involved in the one or other comes
up with something similar...

       Thomas

FWIW:
Reviewed-by: Thomas Renninger <trenn@suse.de>

 
> While at it, correct the "not supported" print statement to say CPU
> "model" which is what that test does.
> 
> Suggested-by: Erwan Velu <e.velu@criteo.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index b599c7318aab..2986119dd31f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2596,6 +2596,9 @@ static int __init intel_pstate_init(void)
>  	const struct x86_cpu_id *id;
>  	int rc;
> 
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +		return -ENODEV;
> +
...
