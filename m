From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 2/3] thermal: core: Reorder
 'thermal_zone_device_register()' error handling code
Date: Tue, 8 Aug 2017 14:31:56 +0200
Message-ID: <cee58c23-2fc4-4f60-2e51-731df97ff8fb@wanadoo.fr>
References: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
 <1b2b2a818d356097d5f6092745086b79d43aeafe.1500187753.git.christophe.jaillet@wanadoo.fr>
 <1502182158.4296.21.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:39545 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdHHMcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2017 08:32:07 -0400
In-Reply-To: <1502182158.4296.21.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Le 08/08/2017 à 10:49, Zhang Rui a écrit :
> On Sun, 2017-07-16 at 08:59 +0200, Christophe JAILLET wrote:
>> Reorder code in the error handling path in order to match the way
>> resources
>> have been allocated.
>>
>> With this new order, we can avoid a call to 'device_unregister()' if
>> 'thermal_zone_create_device_groups'()' fails. At this point,
>> 'device_register()' has not been called yet.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/thermal/thermal_core.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index 9743f3e65eb0..c58714800660 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1232,7 +1232,7 @@ thermal_zone_device_register(const char *type,
>> int trips, int mask,
>>   	/* Add nodes that are always present via .groups */
>>   	result = thermal_zone_create_device_groups(tz, mask);
>>   	if (result)
>> -		goto unregister;
>> +		goto remove_id;
>>
> I agree we should release ida and free tz, like you did in this patch.
>
> But the problem is in the code below, where device_register() fails,
> we should free the resources allocated in
> thermal_zone_create_device_groups() explicitly.
>
> thanks,
> rui
Hi,

Thanks for the review.


I will propose a v2 patch serie with some new helper functions:
    void destroy_trip_attrs(struct thermal_zone_device *tz)
    void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)

'thermal_zone_destroy_device_groups()' will then be called in the error 
handling path of 'thermal_zone_device_register()', when 
'device_register()' fails.


Would you like me to keep the same patch granularity:
    - (new patch in the serie) - Add some new helper functions to free 
resources
    - add kfree(tz) in the actual error handling path    (despite your 
comment on patch 1/3, I still think it is needed in thie error handling 
path)
    - reorder error handling code
    - avoid code duplication

Or the 3 last ones can be merged together under a generic "Fix resources 
release in error paths in thermal_zone_device_register()" ?

CJ

>>   	/* A new thermal zone needs to be updated anyway. */
>>   	atomic_set(&tz->need_update, 1);
>> @@ -1294,8 +1294,9 @@ thermal_zone_device_register(const char *type,
>> int trips, int mask,
>>   	return tz;
>>   
>>   unregister:
>> -	ida_simple_remove(&thermal_tz_ida, tz->id);
>>   	device_unregister(&tz->device);
>> +remove_id:
>> +	ida_simple_remove(&thermal_tz_ida, tz->id);
>>   	kfree(tz);
>>   	return ERR_PTR(result);
>>   }
