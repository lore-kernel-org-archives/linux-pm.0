From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/1] device property: Align return codes of acpi_fwnode_get_reference_with_args
Date: Tue, 19 Sep 2017 23:16:10 +0200
Message-ID: <1824834.2vbqGCFIt3@aspire.rjw.lan>
References: <20170912141512.21634-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170912141512.21634-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, mika.westerberg@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 12, 2017 4:15:12 PM CEST Sakari Ailus wrote:
> acpi_fwnode_get_reference_with_args(), the function implementing ACPI
> support for fwnode_property_get_reference_with_args(), returns directly
> error codes from __acpi_node_get_property_reference(). The latter uses
> different error codes than the OF implementation. In particular, the OF
> implementation uses -ENOENT to indicate there are no more entries whereas
> the former uses -ENODATA for the purpose.
> 
> To make matters more complicated, the ACPI implementation uses -ENOENT but
> for a different purpose --- when an entry exists but contains no
> reference. This isn't recognised by OF.
> 
> Document and align the error codes for property for
> fwnode_property_get_reference_with_args() so that they match with
> of_parse_phandle_with_args(), with the difference that -ENODATA is
> returned whenever an entry exists but contains no reference.
> 
> Also return -ENOENT if the property does not exist, which is what the DT
> equivalent does.
> 
> Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> since v1:
> 
> - Return -ENOENT if the property is not found.
> 
>  drivers/acpi/property.c | 7 +++++++
>  drivers/base/property.c | 5 +++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a65c09cc223f..8970dd288d9d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1205,8 +1205,15 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
>  	unsigned int i;
>  	int ret;
>  
> +	if (acpi_node_prop_get(fwnode, prop, NULL))
> +		return -ENOENT;
> +
>  	ret = __acpi_node_get_property_reference(fwnode, prop, index,
>  						 args_count, &acpi_args);
> +	if (ret == -ENODATA)
> +		return -ENOENT;
> +	if (ret == -ENOENT)
> +		return -ENODATA;

I agree with Mika that it would be good to have a comment describing what is
going on here.

Or maybe better, why don't you change __acpi_node_get_property_reference()
itself?

>  	if (ret < 0)
>  		return ret;
>  	if (!args)
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index d0b65bbe7e15..79b07ed83304 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -682,6 +682,11 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>   * Caller is responsible to call fwnode_handle_put() on the returned
>   * args->fwnode pointer.
>   *
> + * Returns: %0 on success
> + *	    %-ENOENT when the index is out of bounds, or the property was not
> + *		     found
> + *	    %-EINVAL on parse error
> + *	    %-ENODATA when an entry exists but contains no reference
>   */
>  int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  				       const char *prop, const char *nargs_prop,
> 

Thanks,
Rafael

