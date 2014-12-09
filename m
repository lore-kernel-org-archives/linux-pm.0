From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] Thermal/int340x: Handle properly the case when _trt
 or _art acpi entry is missing
Date: Tue, 09 Dec 2014 11:48:24 +0800
Message-ID: <1418096904.12435.4.camel@rzhang1-toshiba>
References: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
	 <1418090492-87508-3-git-send-email-ilkka.koskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45208 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372AbaLIDsb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Dec 2014 22:48:31 -0500
In-Reply-To: <1418090492-87508-3-git-send-email-ilkka.koskinen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, edubezval@gmail.com, jacob.jun.pan@linux.intel.com

On Mon, 2014-12-08 at 18:01 -0800, Ilkka Koskinen wrote:
> If either of the entries was missing, the driver tried to free memory
> using uninitialized pointer. In addition, it was dereferencing null
> pointer.
> 
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
> Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> index e4e61b3..ee4ed3b 100644
> --- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> +++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> @@ -82,7 +82,7 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
>  	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
>  
>  	if (!acpi_has_method(handle, "_TRT"))
> -		return 0;
> +		return -EEXIST;
>  
If the control method does not exist, shouldn't we return -ENODEV or
-ENOENT instead?

thanks,
rui
>  	status = acpi_evaluate_object(handle, "_TRT", NULL, &buffer);
>  	if (ACPI_FAILURE(status))
> @@ -167,7 +167,7 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
>  		sizeof("RRNNNNNNNNNNN"), "RRNNNNNNNNNNN" };
>  
>  	if (!acpi_has_method(handle, "_ART"))
> -		return 0;
> +		return -EEXIST;
>  
>  	status = acpi_evaluate_object(handle, "_ART", NULL, &buffer);
>  	if (ACPI_FAILURE(status))
> @@ -321,8 +321,8 @@ static long acpi_thermal_rel_ioctl(struct file *f, unsigned int cmd,
>  	unsigned long length = 0;
>  	int count = 0;
>  	char __user *arg = (void __user *)__arg;
> -	struct trt *trts;
> -	struct art *arts;
> +	struct trt *trts = NULL;
> +	struct art *arts = NULL;
>  
>  	switch (cmd) {
>  	case ACPI_THERMAL_GET_TRT_COUNT:


