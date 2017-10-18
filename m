From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 3/8] PM / devfreq: Use the available min/max
 frequency
Date: Wed, 18 Oct 2017 10:31:02 +0900
Message-ID: <59E6AED6.70703@samsung.com>
References: <CGME20171013074833epcas1p433f03287f42a5b6dc16e796efa2a3bf3@epcas1p4.samsung.com>
        <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <1507880904-31956-4-git-send-email-cw00.choi@samsung.com>
        <CAJ0PZbRarw8hSmkUZydn79czJj7HK1nc2G8egQdabDRVHE7W_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41231 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762121AbdJRBbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 21:31:04 -0400
In-reply-to: <CAJ0PZbRarw8hSmkUZydn79czJj7HK1nc2G8egQdabDRVHE7W_w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, chanwoo@kernel.org, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi,

On 2017년 10월 17일 23:43, MyungJoo Ham wrote:
> On Fri, Oct 13, 2017 at 4:48 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> The commit a76caf55e5b35 ("thermal: Add devfreq cooling") is able
>> to disable OPP as a cooling device. In result, both update_devfreq()
>> and {min|max}_freq_show() have to consider the 'opp->available'
>> status of each OPP.
>>
>> So, this patch adds the 'scaling_{min|max}_freq' to struct devfreq
>> in order to indicate the available mininum and maximum frequency
>> by adjusting OPP interface such as dev_pm_opp_{disable|enable}().
>> The 'scaling_{min|max}_freq' are used for on both update_devfreq()
>> and {min|max}_freq_show().
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++++++--------
>>  include/linux/devfreq.h   |  4 ++++
>>  2 files changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index b6ba24e5db0d..9de013ffeb67 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
> []
>> @@ -494,6 +499,19 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>>         int ret;
>>
>>         mutex_lock(&devfreq->lock);
>> +
>> +       devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>> +       if (!devfreq->scaling_min_freq) {
>> +               mutex_unlock(&devfreq->lock);
>> +               return -EINVAL;
>> +       }
>> +
>> +       devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>> +       if (!devfreq->max_freq) {
> 
> 1. s/max_freq/scaling/max_freq/ ??

My mistake. The scaling_max_freq is right. I'll fix it.

> 
> 2. what if thermal is not active or has never triggered any event and
> the user has never stated max/min? (making scaling_*_freq zero)


The devfreq-cooling.c of tmu uses the OPP interface
and then OPP interface affect the scaling_min/max_freq of devfreq
through dev_pm_opp_disable/enable(). So, even if 'thermal is not active
or has never triggered any event', devfreq will use the OPP interface
as a mandatory.

In result, I think that devfreq should maintain the correct frequency
of scaling_min/max_freq indicating the 'limit minimum/maximum frequency
requested by OPP interface' instead of zero.

So, I'll change the description of scaling_min/max_freq as following:
(by devfreq-cooling -> by OPP interface)
On v4:
+ * @scaling_min_freq:  Limit minimum frequency requested by devfreq-cooling
+ * @scaling_max_freq:  Limit maximum frequency requested by devfreq-cooling

On v5:
+ * @scaling_min_freq:  Limit minimum frequency requested by OPP interface
+ * @scaling_max_freq:  Limit maximum frequency requested by OPP interface


And, this patch showed the wrong value of min/max_freq_show() by my mistake.
I showed the 'min/max_freq' directly through min/max_freq_show()
without comparing with scaling_min/max_freq. So, I'll fix this issue as following:
---------------
On v5:
static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
                             char *buf)
 {
-       return sprintf(buf, "%lu\n", to_devfreq(dev)->min_freq);
+       struct devfreq *df = to_devfreq(dev);
+
+       return sprintf(buf, "%lu\n", MAX(df->scaling_min_freq, df->min_freq));
 }

 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
@@ -1161,7 +1183,9 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
                             char *buf)
 {
-       return sprintf(buf, "%lu\n", to_devfreq(dev)->max_freq);
+       struct devfreq *df = to_devfreq(dev);
+
+       return sprintf(buf, "%lu\n", MIN(df->scaling_max_freq, df->max_freq));
---------------


> 
>> +               mutex_unlock(&devfreq->lock);
>> +               return -EINVAL;
>> +       }
>> +
>>         ret = update_devfreq(devfreq);
>>         mutex_unlock(&devfreq->lock);
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
