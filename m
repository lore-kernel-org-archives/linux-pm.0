From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] ACPI/thermal: support for thermal zone description
Date: Tue, 08 Aug 2017 16:23:23 +0800
Message-ID: <1502180603.4296.15.camel@intel.com>
References: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
         <1500054535-975-3-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:62481 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdHHIX2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 04:23:28 -0400
In-Reply-To: <1500054535-975-3-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: edubezval@gmail.com

On Fri, 2017-07-14 at 11:48 -0600, Prashanth Prakash wrote:
> Per ACPI 6.2 spec, platforms can optionally add a string(_STR)
> object within each thermal zone package which provides a user
> friendly name/description.
> 
> Add support to parse the string object, which will be exposed
> to userspace by thermal framework.
> 

is there any real request for this?

_STR is a generic control method for all the ACPI devices.
Thus I'm wondering, if really needed, should we expose this in acpi bus
instead?

thanks,
rui

> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/acpi/thermal.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 1d0417b..6ab6480 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -41,6 +41,7 @@
>  #include <linux/acpi.h>
>  #include <linux/workqueue.h>
>  #include <linux/uaccess.h>
> +#include <linux/nls.h>
>  
>  #define PREFIX "ACPI: "
>  
> @@ -188,6 +189,7 @@ struct acpi_thermal {
>  	int tz_enabled;
>  	int kelvin_offset;
>  	struct work_struct thermal_check_work;
> +	char desc[THERMAL_MAX_DESC_STR_LEN];
>  };
>  
>  /* ---------------------------------------------------------------
> -----------
> @@ -543,6 +545,15 @@ static int thermal_get_temp(struct
> thermal_zone_device *thermal, int *temp)
>  	return 0;
>  }
>  
> +static int thermal_get_desc(struct thermal_zone_device *thermal,
> char *desc,
> +			int size)
> +{
> +	struct acpi_thermal *tz = thermal->devdata;
> +
> +	strlcpy(desc, tz->desc, size);
> +	return 0;
> +}
> +
>  static int thermal_get_mode(struct thermal_zone_device *thermal,
>  				enum thermal_device_mode *mode)
>  {
> @@ -880,6 +891,7 @@ static int acpi_thermal_cooling_device_cb(struct
> thermal_zone_device *thermal,
>  	.get_crit_temp = thermal_get_crit_temp,
>  	.get_trend = thermal_get_trend,
>  	.notify = thermal_notify,
> +	.get_desc = thermal_get_desc,
>  };
>  
>  static int acpi_thermal_register_thermal_zone(struct acpi_thermal
> *tz)
> @@ -1014,6 +1026,29 @@ static void
> acpi_thermal_aml_dependency_fix(struct acpi_thermal *tz)
>  	acpi_evaluate_integer(handle, "_TMP", NULL, &value);
>  }
>  
> +static void acpi_thermal_get_desc(struct acpi_thermal *tz)
> +{
> +	acpi_handle handle = tz->device->handle;
> +	acpi_status status;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +
> +	status = acpi_evaluate_object(handle, "_STR", NULL,
> &buffer);
> +
> +	if (ACPI_FAILURE(status))
> +		strlcpy(tz->desc, "<not supported>",
> THERMAL_MAX_DESC_STR_LEN);
> +	else {
> +		union acpi_object *str;
> +		int result;
> +
> +		str = buffer.pointer;
> +		result = utf16s_to_utf8s((wchar_t *)str-
> >string.pointer,
> +					str->string.length,
> UTF16_LITTLE_ENDIAN,
> +					tz->desc,
> THERMAL_MAX_DESC_STR_LEN-1);
> +		tz->desc[result] = 0;
> +		kfree(buffer.pointer);
> +	}
> +}
> +
>  static int acpi_thermal_get_info(struct acpi_thermal *tz)
>  {
>  	int result = 0;
> @@ -1045,6 +1080,9 @@ static int acpi_thermal_get_info(struct
> acpi_thermal *tz)
>  	else
>  		acpi_thermal_get_polling_frequency(tz);
>  
> +	/* Get thermal zone description [_STR] (optional) */
> +	acpi_thermal_get_desc(tz);
> +
>  	return 0;
>  }
>  
