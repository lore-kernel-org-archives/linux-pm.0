From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] Introduce acpi_match_device_id().
Date: Fri, 28 Sep 2012 17:13:47 +0300
Message-ID: <20120928141347.GC15548@intel.com>
References: <1348817910.10877.321.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348817910.10877.321.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@secretlab.ca>, Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 28, 2012 at 03:38:30PM +0800, Zhang Rui wrote:
> >From 72df5d1f51fb27a4ba7f70a3b07df759d32b8288 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 27 Sep 2012 15:11:55 +0800
> Subject: [RFC PATCH 1/6] Introduce acpi_match_device_id().
> 
> This API is used to check if a device id string is compatible
> with an ACPI device,
> either PNP id exported via _HID or compatible ids exported
> via _CID control method.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/scan.c     |   22 ++++++++++++++++++++++
>  include/acpi/acpi_bus.h |    6 ++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d1ecca2..936a7c9 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -312,6 +312,28 @@ int acpi_match_device_ids(struct acpi_device *device,
>  }
>  EXPORT_SYMBOL(acpi_match_device_ids);
>  
> +int acpi_match_device_id(const struct device *dev, const char *id)

Would be good idea to implement this in terms of of_match_device() so that
it returns pointer to the matched id. This way drivers can get the
->driver_data pretty easily if needed.

> +{
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);

If the device is not bound to an ACPI handle this will return NULL. And I
don't see you doing that in this series meaning that..

> +	struct acpi_device *device;
> +	struct acpi_hardware_id *hwid;
> +	acpi_status status;
> +
> +	if (!handle || !id)
> +		return -ENODEV;

..you always return -ENODEV here, right?

> +
> +	status = acpi_bus_get_device(handle, &device);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	list_for_each_entry(hwid, &device->pnp.ids, list)
> +		if (!strcmp(id, hwid->id))
> +			return 0;
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL(acpi_match_device_id);
