From: "Ilkka Koskinen" <ilkka.koskinen@linux.intel.com>
Subject: Re: [PATCH 2/2] Thermal/int340x: Handle properly the case when
     _trt or _art acpi entry is missing
Date: Tue, 9 Dec 2014 12:26:44 -0800 (PST)
Message-ID: <63380.10.24.4.249.1418156804.squirrel@linux.intel.com>
References: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
    <1418090492-87508-3-git-send-email-ilkka.koskinen@linux.intel.com>
    <1418096904.12435.4.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36868 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbaLIUmu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Dec 2014 15:42:50 -0500
In-Reply-To: <1418096904.12435.4.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>, linux-pm@vger.kernel.org, edubezval@gmail.com, jacob.jun.pan@linux.intel.com

On Mon, December 8, 2014 19:48, Zhang Rui wrote:
> On Mon, 2014-12-08 at 18:01 -0800, Ilkka Koskinen wrote:
>> If either of the entries was missing, the driver tried to free memory
>> using uninitialized pointer. In addition, it was dereferencing null
>> pointer.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
>> Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> ---
>>  drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
>> b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
>> index e4e61b3..ee4ed3b 100644
>> --- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
>> +++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
>> @@ -82,7 +82,7 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count,
>> struct trt **trtp,
>>  	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
>>
>>  	if (!acpi_has_method(handle, "_TRT"))
>> -		return 0;
>> +		return -EEXIST;
>>
> If the control method does not exist, shouldn't we return -ENODEV or
> -ENOENT instead?

Absolutely! I wonder why I had chosen that one. I change them
to -ENODEV and submit a new version of this patch.

Cheers, Ilkka

> thanks,
> rui

