From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 09/11] acpi: bus: Enable HWP CPPC objects
Date: Sat, 20 Aug 2016 02:49:56 +0200
Message-ID: <1871091.CP6iqTUKPK@vostro.rjw.lan>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1471559812-19967-10-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1471559812-19967-10-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thursday, August 18, 2016 03:36:50 PM Srinivas Pandruvada wrote:
> Need to set platform wide _OSC bits to enable CPPC and CPPC version 2.
> If platform supports CPPC, then BIOS exposess CPPC tables.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 85b7d07..61643a5 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -330,6 +330,13 @@ static void acpi_bus_osc_support(void)
>  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
>  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
>  
> +#ifdef CONFIG_X86
> +	if (boot_cpu_has(X86_FEATURE_HWP)) {
> +		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> +		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> +	}
> +#endif

Any chance to use IS_ENABLED() here too?

> +
>  	if (!ghes_disable)
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> 

Thanks,
Rafael

