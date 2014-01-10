From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/SCAN: _STA status read
Date: Sat, 11 Jan 2014 00:07:30 +0100
Message-ID: <9214170.89Zbxqe2sA@vostro.rjw.lan>
References: <1389380231-826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62352 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751263AbaAJWxi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 17:53:38 -0500
In-Reply-To: <1389380231-826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Friday, January 10, 2014 10:57:11 AM Srinivas Pandruvada wrote:
> This patch adds a "status" attribute for an acpi device. This status
> attribute shows the value of _STA object. The _STA object returns
> current status of an ACPI device to show enabled, disabled or removed.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks a lot for sending this, but can you please resend it with CCs to
linux-acpi@vger.kernel.org and linux-kernel@vger.kernel.org so that more
people know what's going on?

Rafael


> ---
>  drivers/acpi/scan.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fd39459..a5f4a60 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -567,6 +567,20 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
>  
> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> +				char *buf) {
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	acpi_status status;
> +	unsigned long long sta;
> +
> +	status = acpi_evaluate_integer(acpi_dev->handle, "_STA", NULL, &sta);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	return sprintf(buf, "%llu\n", sta);
> +}
> +static DEVICE_ATTR_RO(status);
> +
>  static int acpi_device_setup_files(struct acpi_device *dev)
>  {
>  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -622,6 +636,12 @@ static int acpi_device_setup_files(struct acpi_device *dev)
>  		dev->pnp.sun = (unsigned long)-1;
>  	}
>  
> +	if (acpi_has_method(dev->handle, "_STA")) {
> +		result = device_create_file(&dev->dev, &dev_attr_status);
> +		if (result)
> +			goto end;
> +	}
> +
>          /*
>           * If device has _EJ0, 'eject' file is created that is used to trigger
>           * hot-removal function from userland.
> @@ -677,6 +697,8 @@ static void acpi_device_remove_files(struct acpi_device *dev)
>  		device_remove_file(&dev->dev, &dev_attr_adr);
>  	device_remove_file(&dev->dev, &dev_attr_modalias);
>  	device_remove_file(&dev->dev, &dev_attr_hid);
> +	if (acpi_has_method(dev->handle, "_STA"))
> +		device_remove_file(&dev->dev, &dev_attr_status);
>  	if (dev->handle)
>  		device_remove_file(&dev->dev, &dev_attr_path);
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
