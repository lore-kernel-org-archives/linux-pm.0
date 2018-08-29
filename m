From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Add new name attribute for sysfs
Date: Thu, 30 Aug 2018 07:50:58 +0900
Message-ID: <5B872352.6030304@samsung.com>
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
        <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
        <20180829105738.GA26948@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20180829105738.GA26948@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear Greg,

On 2018년 08월 29일 19:57, Greg KH wrote:
> On Wed, Aug 29, 2018 at 04:34:06PM +0900, Chanwoo Choi wrote:
>> commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
>> sysfs") changed the node name to devfreq(x). After this commit, it is not
>> possible to get the device name through /sys/class/devfreq/devfreq(X)/*.
>>
>> Add new name attribute in order to get device name.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 11 +++++++++++
>>  include/linux/devfreq.h   |  3 +++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 4c49bb1330b5..2145563d5ee5 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	}
>>  	devfreq->max_freq = devfreq->scaling_max_freq;
>>
>> +	devfreq->name = dev_name(devfreq->dev.parent);
>> +	if (IS_ERR_OR_NULL(devfreq->name))
>> +		return -EINVAL;
>>  	dev_set_name(&devfreq->dev, "devfreq%d",
>>  				atomic_inc_return(&devfreq_no));
>>  	err = device_register(&devfreq->dev);
>> @@ -1261,6 +1264,13 @@ static ssize_t trans_stat_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(trans_stat);
>>
>> +static ssize_t name_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%s\n", to_devfreq(dev)->name);
>> +}
>> +static DEVICE_ATTR_RO(name);
> 
> You need a new Documentation/ABI/ entry for this.

Thanks for comment. I'll.

Best Regards,
Chanwoo Choi
Samsung Electronics
