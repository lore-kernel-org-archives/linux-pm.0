From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] Thermal/int340x: Clear the error value of the last
 acpi_bus_get_device() call
Date: Tue, 09 Dec 2014 11:48:50 +0800
Message-ID: <1418096930.12435.5.camel@rzhang1-toshiba>
References: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
	 <1418090492-87508-2-git-send-email-ilkka.koskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756451AbaLIDsx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Dec 2014 22:48:53 -0500
In-Reply-To: <1418090492-87508-2-git-send-email-ilkka.koskinen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, edubezval@gmail.com, jacob.jun.pan@linux.intel.com

On Mon, 2014-12-08 at 18:01 -0800, Ilkka Koskinen wrote:
> Previously the return value of the last acpi_bus_get_device() was
> returned. However, since we only report those issues, it should be
> cleared to continue as expected.
> 
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
> Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> index ac5c405..e4e61b3 100644
> --- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> +++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> @@ -131,6 +131,8 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
>  			pr_warn("Failed to get target ACPI device\n");
>  	}
>  
> +	result = 0;
> +
>  	*trtp = trts;
>  	/* don't count bad entries */
>  	*trt_count -= nr_bad_entries;


