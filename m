From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / PM: Do not apply ACPI_SUCCESS() to
 acpi_bus_get_device() result
Date: Sun, 16 Dec 2012 17:59:53 +0200
Message-ID: <20121216155953.GN2261@intel.com>
References: <1432424.eSUdEQ1VBT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432424.eSUdEQ1VBT@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 16, 2012 at 02:32:06PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since the return value of acpi_bus_get_device() is not of type
> acpi_status, ACPI_SUCCESS() should not be used for checking its
> return value.  Fix that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/acpi/device_pm.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux/drivers/acpi/device_pm.c
> ===================================================================
> --- linux.orig/drivers/acpi/device_pm.c
> +++ linux/drivers/acpi/device_pm.c
> @@ -358,8 +358,7 @@ static struct acpi_device *acpi_dev_pm_g
>  	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
>  	struct acpi_device *adev;
>  
> -	return handle && ACPI_SUCCESS(acpi_bus_get_device(handle, &adev)) ?
> -		adev : NULL;
> +	return handle && !acpi_bus_get_device(handle, &adev) ? adev : NULL;
>  }
>  
>  /**
