From: Yao Dongdong <yaodongdong@huawei.com>
Subject: Re: [PATCH 2/2] Thermal:Remove usless if(!result) before return tz
Date: Tue, 21 Oct 2014 11:34:37 +0800
Message-ID: <5445D44D.60808@huawei.com>
References: <5444C78F.10404@huawei.com> <20141020121039.GA3688@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:25470 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaJUDer (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 23:34:47 -0400
In-Reply-To: <20141020121039.GA3688@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


On 2014/10/20 20:10, Eduardo Valentin wrote:
> Hello Yao
>
> On Mon, Oct 20, 2014 at 04:27:59PM +0800, Yao Dongdong wrote:
>> result is always zero when comes here.
>>
>> Signed-off-by:yaodongdong@huawei.com
>>
>> ---
>>  drivers/thermal/thermal_core.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 5b7d466..19cac8e 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1568,8 +1568,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>>
>>     thermal_zone_device_update(tz);
>>
>> -   if (!result)
>> -       return tz;
>> +   return tz;
>>
> Adding a return here will make the resource release below not reachable
> in the fail path.

But all fails above followed a "goto unregister", so i think it must be successful when come here.

Thanks.

>>  unregister:
>>     release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>> --
>> 1.8.0.1
>>
>>


