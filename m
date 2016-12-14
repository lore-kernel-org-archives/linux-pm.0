From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Don't delete sysfs group twice
Date: Wed, 14 Dec 2016 11:48:42 +0900
Message-ID: <5850B30A.20701@samsung.com>
References: <CGME20161213171211epcas3p3ed8807883967daca28b7abe211446739@epcas3p3.samsung.com>
 <20161213170935.GA4661@e107465-lin.cambridge.arm.com>
 <5850A286.9080302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36169 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbcLNCsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2016 21:48:46 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OI5018G4MGVXXD0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 14 Dec 2016 11:48:42 +0900 (KST)
In-reply-to: <5850A286.9080302@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Diamand <chris.diamand@arm.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Nishanth Menon <nm@ti.com>, Cai Zhiyong <caizhiyong@huawei.com>, "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>

Hi Chris,

On 2016년 12월 14일 10:38, Chanwoo Choi wrote:
> Hi Chris,
>
> On 2016년 12월 14일 02:09, Chris Diamand wrote:
>> The 'userspace' governor adds a sysfs entry, which is removed when
>> the governor is changed, or the devfreq device is released. However,
>> when the latter occurs via device_unregister(), device_del() is
>> called first, which removes the sysfs entries recursively and deletes
>> the kobject.
>>
>> This means we get an Oops when the governor calls
>> sysfs_remove_group() on the deleted kobject. Fix this by explicitly
>> stopping the governor in devfreq_remove_device(), *before* the
>> devfreq entry is removed.
>>
>> Note that we can't just remove the call to sysfs_remove_group() in
>> the userspace governor, as it's needed for when the governor is
>> changed to one without a sysfs entry.
>>
>> Signed-off-by: Chris Diamand <chris.diamand@arm.com>
>> ---
>>  drivers/devfreq/devfreq.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 478006b..d8a817c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -622,6 +622,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
>>  	if (!devfreq)
>>  		return -EINVAL;
>>  
>> +	if (devfreq->governor) {
>> +		devfreq->governor->event_handler(devfreq,
>> +						 DEVFREQ_GOV_STOP, NULL);
>> +		devfreq->governor = NULL;
>> +	}
>> +
>>
> The devfreq_remove_device has following description:
> - "* The oppsite of devfreq_add_device()"
>
> I think that we should call the '_remove_devfreq()' function in the devfreq_remove_device()
> because '_remove_devfreq()' is in charge of releasing the devfreq instance.
>
> The '_remove_devfreq() ' function includes the code to stop the governor and following works:
> - remove the devfreq instance from devfreq list
> - call the profile->exit function
> - destroy the muxte of devfreq instance
> - Free the devfreq memory.

How about following patch?
I think that this patch covers the all of case when removing the devfreq device.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8a456dd55a8d..eea406df0037 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -496,6 +496,7 @@ static void _remove_devfreq(struct devfreq *devfreq)
                devfreq->profile->exit(devfreq->dev.parent);
 
        mutex_destroy(&devfreq->lock);
+       device_unregister(&devfreq->dev);
        kfree(devfreq);
 }
 
@@ -634,7 +635,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
        if (!devfreq)
                return -EINVAL;
 
-       device_unregister(&devfreq->dev);
+       _remove_devfreq(devfreq);
 
        return 0;
 }

Regards,
Chanwoo Choi

