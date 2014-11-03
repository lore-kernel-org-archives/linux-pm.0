From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 1/2] Thermal:Fix memory leak if occur goto unregister
Date: Mon, 3 Nov 2014 18:17:37 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB590902F30A@BGSMSX101.gar.corp.intel.com>
References: <5444C778.8050008@huawei.com> <20141020123338.GA3744@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32480 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644AbaKCSRm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 13:17:42 -0500
In-Reply-To: <20141020123338.GA3744@developer>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Yao Dongdong <yaodongdong@huawei.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

>-----Original Message-----
>From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>owner@vger.kernel.org] On Behalf Of Eduardo Valentin
>Sent: Monday, October 20, 2014 6:04 PM
>To: Yao Dongdong
>Cc: Zhang, Rui; linux-pm@vger.kernel.org; LKML
>Subject: Re: [PATCH 1/2] Thermal:Fix memory leak if occur goto unregister
>
>Hello,
>
>On Mon, Oct 20, 2014 at 04:27:36PM +0800, Yao Dongdong wrote:
>> Signed-off-by:yaodongdong@huawei.com
>
>Acked-by: Eduardo Valentin <edubezval@gmail.com>
>
>Rui, would you take care of this?
>

If I remember it right, this 'tz' is freed in the thermal_release()
function, during device_unregister().

It is similar in all other functions in thermal_core.c

So, Yao, Did you really test this patch ?
And did not see any crashes ?

Thanks,
Durga

>>
>> ---
>>  drivers/thermal/thermal_core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 71b0ec0..5b7d466 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1574,6 +1574,7 @@ struct thermal_zone_device
>*thermal_zone_device_register(const char *type,
>>  unregister:
>>     release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>>     device_unregister(&tz->device);
>> +   kfree(tz);
>>     return ERR_PTR(result);
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>> --
>> 1.8.0.1
>>
>>
