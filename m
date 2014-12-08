From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/int3400: export uuids
Date: Mon, 08 Dec 2014 11:34:29 +0800
Message-ID: <1418009669.19126.13.camel@rzhang1-toshiba>
References: <1417540283-32609-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7215 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbaLHDec (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 7 Dec 2014 22:34:32 -0500
In-Reply-To: <1417540283-32609-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org

On Tue, 2014-12-02 at 09:11 -0800, Srinivas Pandruvada wrote:
> INT3400 currently supports only one policy, which can't be changed.
> This change exports all available policies (uuids) to user space and
> allow this to be changed.
> It introduces an attribute group uuids in INT3400 platform driver.
> There are two attributes exposed:
> - available_uuids
> - current_uuid
> 
> User space can set current_uuid via this interface to one of the
> available uuids. The uuid change is communicated to firmware, only
> when the current zone mode is changed to "enabled". So the ideal
> sequence should be
> - set INT3400 zone mode to "disabled"
> - change current_uuid
> - set INT3400 zone mode to "enabled"
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/int340x_thermal/int3400_thermal.c | 80 ++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index edc1cce..dcb306e 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -43,6 +43,74 @@ struct int3400_thermal_priv {
>  	struct trt *trts;
>  	u8 uuid_bitmap;
>  	int rel_misc_dev_res;
> +	int current_uuid_index;
> +};
> +
> +static ssize_t available_uuids_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	int i;
> +	int length = 0;
> +
> +	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
> +		if (priv->uuid_bitmap & (1 << i))
> +			if (PAGE_SIZE - length > 0)
> +				length += snprintf(&buf[length],
> +						   PAGE_SIZE - length,
> +						   "%s\n",
> +						   int3400_thermal_uuids[i]);
> +	}
> +
> +	return length;
> +}
> +
> +static ssize_t current_uuid_show(struct device *dev,
> +				 struct device_attribute *devattr, char *buf)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (priv->uuid_bitmap & (1 << priv->current_uuid_index))
> +		return sprintf(buf, "%s\n",
> +			       int3400_thermal_uuids[priv->current_uuid_index]);
> +	else
> +		return sprintf(buf, "INVALID\n");
> +}
> +
> +static ssize_t current_uuid_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
> +		if ((priv->uuid_bitmap & (1 << i)) &&
> +		    !(strncmp(buf, int3400_thermal_uuids[i],
> +			      sizeof(int3400_thermal_uuids[i]) - 1))) {
> +			priv->current_uuid_index = i;
> +			return count;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static DEVICE_ATTR(current_uuid, 0644, current_uuid_show, current_uuid_store);
> +static DEVICE_ATTR_RO(available_uuids);
> +static struct attribute *uuid_attrs[] = {
> +	&dev_attr_available_uuids.attr,
> +	&dev_attr_current_uuid.attr,
> +	NULL
> +};
> +
> +static struct attribute_group uuid_attribute_group = {
> +	.attrs = uuid_attrs,
> +	.name = "uuids"
>  };
>  
>  static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
> @@ -160,9 +228,9 @@ static int int3400_thermal_set_mode(struct thermal_zone_device *thermal,
>  
>  	if (enable != priv->mode) {
>  		priv->mode = enable;
> -		/* currently, only PASSIVE COOLING is supported */
>  		result = int3400_thermal_run_osc(priv->adev->handle,
> -					INT3400_THERMAL_PASSIVE_1, enable);
> +						 priv->current_uuid_index,
> +						 enable);
>  	}
>  	return result;
>  }
> @@ -223,7 +291,14 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>  	priv->rel_misc_dev_res = acpi_thermal_rel_misc_device_add(
>  							priv->adev->handle);
>  
> +	result = sysfs_create_group(&pdev->dev.kobj, &uuid_attribute_group);
> +	if (result)
> +		goto free_zone;
> +
>  	return 0;
> +
> +free_zone:
> +	thermal_zone_device_unregister(priv->thermal);
>  free_trt:
>  	kfree(priv->trts);
>  free_art:
> @@ -240,6 +315,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
>  	if (!priv->rel_misc_dev_res)
>  		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
>  
> +	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
>  	thermal_zone_device_unregister(priv->thermal);
>  	kfree(priv->trts);
>  	kfree(priv->arts);


