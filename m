From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH 5/5] acpi: bus: Enable HWP CPPC objects
Date: Tue, 16 Aug 2016 15:32:57 +0100
Message-ID: <20160816143257.GA22533@arm.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470874646-70570-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470874646-70570-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Srinivas,

On Wed, Aug 10, 2016 at 05:17:26PM -0700, Srinivas Pandruvada wrote:
> Need to set platform wide _OSC bits CPC version 1 and version 2 bits
> so that BIOS presents CPPC objects.
> Even though the cppc_acpi supports only version 2, need to set both
> _OSC bits for version 1 and version 2, otherwise BIOS ignore _OSC
> settings.

Does such behaviour go against ACPI specs?
If yes, it's better to add comment in the code.
 
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

Just to check if I understand things correctly.
I thought that OSC method is kind of 'handshake'. OS describes features
that it supports and then platform indicates back what features it can
provide/support.
Here in this patch I see only first part and I don't see where you check
confirmation from platform that it supports/enabled CPPC.
You don't need that, do you?
It will be nice to see explanation.

Best regards,
Alexey.

>  	if (!ghes_disable)
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
