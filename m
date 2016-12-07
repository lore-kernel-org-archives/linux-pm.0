From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v8 8/8] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Wed, 07 Dec 2016 15:12:53 -0800
Message-ID: <1481152373.3064.77.camel@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
         <0998b98943bcdec7d1ddd4ff27358da555ea8e92.1479844244.git.tim.c.chen@linux.intel.com>
         <20161207190608.boi7svavwrkx3epm@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161207190608.boi7svavwrkx3epm@breakpoint.cc>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-12-07 at 20:06 +0100, Sebastian Andrzej Siewior wrote:
> 
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/acpi/cppc_acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index d0d0504b7c89..93252e5374c5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -803,6 +803,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  		if (addr)
>  			iounmap(addr);
>  	}
> +	per_cpu(cpc_desc_ptr, pr->id) = NULL;
>  	kfree(cpc_ptr);
>  
>  out_buf_free:
> @@ -824,6 +825,8 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
>  	void __iomem *addr;
>  
>  	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
> +	if (!cpc_ptr)
> +		return;

I agree that not handling null pointer here is a bug that should be fixed.
The cpc_ptr is checked at other places like acpi_get_psd_map.  
We could potentially have a null cpc_ptr say when
the parsing of CPC table failed. We should handle such cases gracefully.

Tim

