From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 4/4] PM / devfreq: Modify the device name as devfreq[X]
 for sysfs
Date: Mon, 23 Jan 2017 12:25:03 +0900
Message-ID: <5885778F.7010004@samsung.com>
References: <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170116122609epcas5p3e9f106e6d097613cd866107bc0e065c7@epcas5p3.samsung.com>
 <20170123021924epcms1p86578a78189221928e48ede3e26ecce38@epcms1p8>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170123021924epcms1p86578a78189221928e48ede3e26ecce38@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2017년 01월 23일 11:19, MyungJoo Ham wrote:
>>  	if (!dev || !profile || !governor_name) {
>> @@ -568,7 +569,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		mutex_lock(&devfreq->lock);
>>  	}
>>  
>> -	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
>> +	dev_set_name(&devfreq->dev, "devfreq%lu",
>> +			(unsigned long)atomic_inc_return(&devfreq_no));
> 
> Do you have any specific reason to use "unsigned long" here?
> (atomic_t has 32bit int).

There is no any reason. I'll change to use the integer value as following:

	dev_set_name(&devfreq->dev, "devfreq%d", atomic_inc_return(&devfreq_no));


> 
>>  	err = device_register(&devfreq->dev);
>>  	if (err) {
>>  		mutex_unlock(&devfreq->lock);
>> -- 
>> 1.9.1


-- 
Best Regards,
Chanwoo Choi
S/W R&D Center
Samsung Electronics
