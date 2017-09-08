From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH 1/1] device property: Align return codes of
 acpi_fwnode_get_reference_with_args
Date: Fri, 8 Sep 2017 17:54:50 +0300
Message-ID: <20170908145450.GE2477@lahna.fi.intel.com>
References: <20170908122156.2493-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdIHO7P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Sep 2017 10:59:15 -0400
Content-Disposition: inline
In-Reply-To: <20170908122156.2493-1-sakari.ailus@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Fri, Sep 08, 2017 at 03:21:56PM +0300, Sakari Ailus wrote:
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
> Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

You should CC Rafael and linux-acpi.

Also why not follow ACPI error codes and convert the corresponding DT
function to return those instead?

> ---
>  drivers/acpi/property.c | 4 ++++
>  drivers/base/property.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a65c09cc223f..17d760b89908 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1207,6 +1207,10 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
>  
>  	ret = __acpi_node_get_property_reference(fwnode, prop, index,
>  						 args_count, &acpi_args);
> +	if (ret == -ENODATA)
> +		return -ENOENT;
> +	if (ret == -ENOENT)
> +		return -ENODATA;

This kind of construct without any comments explaining why this is
needed, looks suspicious.
