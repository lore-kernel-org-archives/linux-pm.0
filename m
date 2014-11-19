From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal/int340x: avoid unnecessary pointer casting
Date: Wed, 19 Nov 2014 16:31:32 +0800
Message-ID: <1416385892.2352.20.camel@rzhang1-toshiba>
References: <1415145214-2986-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29392 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbaKSIbV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Nov 2014 03:31:21 -0500
In-Reply-To: <1415145214-2986-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>

On Tue, 2014-11-04 at 15:53 -0800, Jacob Pan wrote:
> Avoid pointer casting which may also lead to problems on big endian
> 64 bit systems.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Patch queued for 3.19.

thanks,
rui
> ---
>  drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> index 0d8db80..ac5c405 100644
> --- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> +++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> @@ -317,21 +317,21 @@ static long acpi_thermal_rel_ioctl(struct file *f, unsigned int cmd,
>  {
>  	int ret = 0;
>  	unsigned long length = 0;
> -	unsigned long count = 0;
> +	int count = 0;
>  	char __user *arg = (void __user *)__arg;
>  	struct trt *trts;
>  	struct art *arts;
>  
>  	switch (cmd) {
>  	case ACPI_THERMAL_GET_TRT_COUNT:
> -		ret = acpi_parse_trt(acpi_thermal_rel_handle, (int *)&count,
> +		ret = acpi_parse_trt(acpi_thermal_rel_handle, &count,
>  				&trts, false);
>  		kfree(trts);
>  		if (!ret)
>  			return put_user(count, (unsigned long __user *)__arg);
>  		return ret;
>  	case ACPI_THERMAL_GET_TRT_LEN:
> -		ret = acpi_parse_trt(acpi_thermal_rel_handle, (int *)&count,
> +		ret = acpi_parse_trt(acpi_thermal_rel_handle, &count,
>  				&trts, false);
>  		kfree(trts);
>  		length = count * sizeof(union trt_object);
> @@ -341,14 +341,14 @@ static long acpi_thermal_rel_ioctl(struct file *f, unsigned int cmd,
>  	case ACPI_THERMAL_GET_TRT:
>  		return fill_trt(arg);
>  	case ACPI_THERMAL_GET_ART_COUNT:
> -		ret = acpi_parse_art(acpi_thermal_rel_handle, (int *)&count,
> +		ret = acpi_parse_art(acpi_thermal_rel_handle, &count,
>  				&arts, false);
>  		kfree(arts);
>  		if (!ret)
>  			return put_user(count, (unsigned long __user *)__arg);
>  		return ret;
>  	case ACPI_THERMAL_GET_ART_LEN:
> -		ret = acpi_parse_art(acpi_thermal_rel_handle, (int *)&count,
> +		ret = acpi_parse_art(acpi_thermal_rel_handle, &count,
>  				&arts, false);
>  		kfree(arts);
>  		length = count * sizeof(union art_object);


