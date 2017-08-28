From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 01/12] PM / devfreq: Fix memory leak when fail to
 register device
Date: Mon, 28 Aug 2017 09:23:00 +0900
Message-ID: <59A36264.4030605@samsung.com>
References: <1503538979-22693-2-git-send-email-cw00.choi@samsung.com>
        <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p398a53a9a76d9aff7e35cf8515ec4e46a@epcms1p6>
        <20170828001753epcms1p658026b4f636aa4c0aee6f22bc128ebe3@epcms1p6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20170828001753epcms1p658026b4f636aa4c0aee6f22bc128ebe3@epcms1p6>
Sender: stable-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2017년 08월 28일 09:17, MyungJoo Ham wrote:
>> When the devfreq_add_device fails to register deivce, the memory
>> leak of devfreq instance happen. So, this patch fix the memory
>> leak issue. Before freeing the devfreq instance checks whether
>> devfreq instance is NULL or not because the device_unregister()
>> frees the devfreq instance when jumping to the 'err_init'.
>> It is to prevent the duplicate the kfee(devfreq).
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ac4b281176a5 ("PM / devfreq: fix duplicated kfree on devfreq pointer")
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> This looks like to be duplicated. Please check your repo basis.

These patches is based on the v4.13-rc6.

After merged ("PM / devfreq: fix duplicated kfree on devfreq pointer"),
this patch doesn't consider the free of memory when error case.

After applying this patch, this patch consider the error case
when jumping the err_dev statement with goto.
		device_unregister(&devfreq->dev);
	err_dev:
		if (devfreq)		
			kfree(devfreq);


> 
> 
> Cheers,
> MyungJoo
> 
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index dea04871b50d..a1c4ee818614 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -564,7 +564,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	err = device_register(&devfreq->dev);
>>  	if (err) {
>>  		mutex_unlock(&devfreq->lock);
>> -		goto err_out;
>> +		goto err_dev;
>>  	}
>>  
>>  	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
>> @@ -610,6 +610,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	mutex_unlock(&devfreq_list_lock);
>>  
>>  	device_unregister(&devfreq->dev);
>> +err_dev:
>> +	if (devfreq)
>> +		kfree(devfreq);
>>  err_out:
>>  	return ERR_PTR(err);
>>  }
>> -- 
>> 1.9.1
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
