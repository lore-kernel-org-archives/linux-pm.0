From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] acpi: utils: Add new acpi_dev_present helper
Date: Tue, 28 Mar 2017 23:42:29 +0200
Message-ID: <4029834.c3GWUpRlkb@aspire.rjw.lan>
References: <20170316161736.339-1-hdegoede@redhat.com> <20170316161736.339-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59222 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754152AbdC1VsW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 17:48:22 -0400
In-Reply-To: <20170316161736.339-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday, March 16, 2017 05:17:35 PM Hans de Goede wrote:
> acpi_dev_found just iterates over all acpi-ids and sees if one matches.
> This means that it will return true for devices which are in the dsdt
> but disabled (their _STA method returns 0).
> 
> For some drivers it is useful to be able to check if a certain hid
> is not only present in the namespace, but also actually present as in
> acpi_device_is_present() will return true for the device. For example
> because if a certain device is present then the driver will want to use
> an extcon or IIO adc channel provided by that device.
> 
> This commit adds a new acpi_dev_present helper which drivers can use
> to this end.
> 
> Arguably acpi_dev_present is what acpi_dev_found should have been, but
> there are too many users to just change acpi_dev_found without the risk
> of breaking something.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Andy, Mika, any concerns about this patch, please?

> ---
>  drivers/acpi/utils.c    | 34 ++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  1 +
>  include/linux/acpi.h    |  5 +++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 22c0995..40f8953 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -736,6 +736,40 @@ bool acpi_dev_found(const char *hid)
>  }
>  EXPORT_SYMBOL(acpi_dev_found);
>  
> +static acpi_status acpi_dev_present_cb(acpi_handle ah, u32 level, void *ctx,
> +				     void **retval)
> +{
> +	/*
> +	 * acpi_get_devices() does all the work for us, if we get called
> +	 * a device with a matching hid has been found and its _STA indicates
> +	 * it is present.
> +	 */
> +	*(bool *)ctx = true;
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +/**
> + * acpi_dev_present - Detect that a given ACPI device is present
> + * @hid: Hardware ID of the device.
> + *
> + * Return %true if the device was present at the moment of invocation.
> + * Note that if the device is pluggable, it may since have disappeared.
> + *
> + * Note that unlike acpi_dev_found() this function checks the status
> + * of the device so for devices which are present in the dsdt, but
> + * which are disabled (their _STA callback returns 0) this function
> + * will return false.
> + */
> +bool acpi_dev_present(const char *hid)
> +{
> +	bool present = false;
> +
> +	acpi_get_devices(hid, acpi_dev_present_cb, &present, NULL);
> +
> +	return present;
> +}
> +EXPORT_SYMBOL(acpi_dev_present);
> +
>  /*
>   * acpi_backlight= handling, this is done here rather then in video_detect.c
>   * because __setup cannot be used in modules.
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ef0ae8a..29f6b5f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -88,6 +88,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, u64 rev, u64 func,
>  	}
>  
>  bool acpi_dev_found(const char *hid);
> +bool acpi_dev_present(const char *hid);
>  
>  #ifdef CONFIG_ACPI
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 673acda..059ffdc 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -614,6 +614,11 @@ static inline bool acpi_dev_found(const char *hid)
>  	return false;
>  }
>  
> +static inline bool acpi_dev_present(const char *hid)
> +{
> +	return false;
> +}
> +
>  static inline bool is_acpi_node(struct fwnode_handle *fwnode)
>  {
>  	return false;
> 
