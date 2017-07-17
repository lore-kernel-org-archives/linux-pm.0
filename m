From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH 1/2] thermal: int340x: constify attribute_group
 structures.
Date: Mon, 17 Jul 2017 16:29:20 +0530
Message-ID: <b43c42d5-80ac-cb54-62a4-d5d1a04a3a79@gmail.com>
References: <3b42983a016cbb0d1fb3b6bab625b78abf843474.1500287619.git.arvind.yadav.cs@gmail.com>
 <1500288080.29303.38.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36233 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdGQK7u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 06:59:50 -0400
In-Reply-To: <1500288080.29303.38.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andy,


On Monday 17 July 2017 04:11 PM, Andy Shevchenko wrote:
> On Mon, 2017-07-17 at 16:04 +0530, Arvind Yadav wrote:
>> attribute_groups are not supposed to change at runtime. All functions
>> working with attribute_groups provided by <linux/sysfs.h> work
>> with const attribute_group. So mark the non-const structs as const.
>>
> I hope you did compile test it.
     I have compiled it. If we will see  <linux/sysfs.h>
     "int sysfs_create_group(struct kobject *kobj,  const struct 
attribute_group *grp)" and
     "void sysfs_remove_group(struct kobject *kobj, const struct 
attribute_group *grp);"
     Here, passing parameter attribute_group are constant. So I have 
changed non-const as const.

     ~arvind
>
>> File size before:
>>     text	   data	    bss	    dec	    hex	
>> filename
>>     1687	    592	      0	   2279	    8e7	
>> int3400_thermal.o
>>
>> File size After adding 'const':
>>     text	   data	    bss	    dec	    hex	
>> filename
>>     1751	    528	      0	   2279	    8e7	
>> int3400_thermal.o
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/thermal/int340x_thermal/int3400_thermal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c
>> b/drivers/thermal/int340x_thermal/int3400_thermal.c
>> index a9ec94e..b2ffbed 100644
>> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
>> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
>> @@ -104,7 +104,7 @@ static ssize_t current_uuid_store(struct device
>> *dev,
>>   	NULL
>>   };
>>   
>> -static struct attribute_group uuid_attribute_group = {
>> +static const struct attribute_group uuid_attribute_group = {
>>   	.attrs = uuid_attrs,
>>   	.name = "uuids"
>>   };
