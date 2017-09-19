From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 1/1] device property: Align return codes of
 acpi_fwnode_get_reference_with_args
Date: Wed, 20 Sep 2017 00:38:58 +0300
Message-ID: <86a432d7-48f2-231d-de61-e52b98f88ecf@linux.intel.com>
References: <20170912141512.21634-1-sakari.ailus@linux.intel.com>
 <1824834.2vbqGCFIt3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7283 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdISVjE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Sep 2017 17:39:04 -0400
In-Reply-To: <1824834.2vbqGCFIt3@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, mika.westerberg@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>

Hi Rafael,

Rafael J. Wysocki wrote:
> On Tuesday, September 12, 2017 4:15:12 PM CEST Sakari Ailus wrote:
>> acpi_fwnode_get_reference_with_args(), the function implementing ACPI
>> support for fwnode_property_get_reference_with_args(), returns directly
>> error codes from __acpi_node_get_property_reference(). The latter uses
>> different error codes than the OF implementation. In particular, the OF
>> implementation uses -ENOENT to indicate there are no more entries whereas
>> the former uses -ENODATA for the purpose.
>>
>> To make matters more complicated, the ACPI implementation uses -ENOENT but
>> for a different purpose --- when an entry exists but contains no
>> reference. This isn't recognised by OF.
>>
>> Document and align the error codes for property for
>> fwnode_property_get_reference_with_args() so that they match with
>> of_parse_phandle_with_args(), with the difference that -ENODATA is
>> returned whenever an entry exists but contains no reference.
>>
>> Also return -ENOENT if the property does not exist, which is what the DT
>> equivalent does.
>>
>> Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> ---
>> since v1:
>>
>> - Return -ENOENT if the property is not found.
>>
>>  drivers/acpi/property.c | 7 +++++++
>>  drivers/base/property.c | 5 +++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
>> index a65c09cc223f..8970dd288d9d 100644
>> --- a/drivers/acpi/property.c
>> +++ b/drivers/acpi/property.c
>> @@ -1205,8 +1205,15 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
>>  	unsigned int i;
>>  	int ret;
>>
>> +	if (acpi_node_prop_get(fwnode, prop, NULL))
>> +		return -ENOENT;
>> +
>>  	ret = __acpi_node_get_property_reference(fwnode, prop, index,
>>  						 args_count, &acpi_args);
>> +	if (ret == -ENODATA)
>> +		return -ENOENT;
>> +	if (ret == -ENOENT)
>> +		return -ENODATA;
>
> I agree with Mika that it would be good to have a comment describing what is
> going on here.
>
> Or maybe better, why don't you change __acpi_node_get_property_reference()
> itself?

I had a chat with Mika after sending the patch and ended up proposing 
changing the OF behaviour slightly.

The subject is "[RFC 0/5] Align and document return values of phandle 
and reference parsing for OF and ACPI". Rob commented on that already.

One option could be that the fwnode variant is simply made to mirror the 
OF behaviour. The fwnode API will need to be amended with function to 
tell the number of references available.

>
>>  	if (ret < 0)
>>  		return ret;
>>  	if (!args)
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index d0b65bbe7e15..79b07ed83304 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -682,6 +682,11 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>>   * Caller is responsible to call fwnode_handle_put() on the returned
>>   * args->fwnode pointer.
>>   *
>> + * Returns: %0 on success
>> + *	    %-ENOENT when the index is out of bounds, or the property was not
>> + *		     found
>> + *	    %-EINVAL on parse error
>> + *	    %-ENODATA when an entry exists but contains no reference
>>   */
>>  int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>>  				       const char *prop, const char *nargs_prop,
>>
>
> Thanks,
> Rafael
>


-- 
Sakari Ailus
sakari.ailus@linux.intel.com
