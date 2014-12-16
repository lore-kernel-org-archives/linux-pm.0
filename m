From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCHv3 2/7] devfreq: event: Add the list of supported
 devfreq-event type
Date: Tue, 16 Dec 2014 10:15:16 +0900
Message-ID: <548F87A4.5060000@samsung.com>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
 <1418372852-12454-3-git-send-email-cw00.choi@samsung.com>
 <1418655206.20866.6.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54487 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaLPBPU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 20:15:20 -0500
In-reply-to: <1418655206.20866.6.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, rafael.j.wysocki@intel.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

Hi Krzysztof,

On 12/15/2014 11:53 PM, Krzysztof Kozlowski wrote:
> On pi=C4=85, 2014-12-12 at 17:27 +0900, Chanwoo Choi wrote:
>> This patch adds the list of supported devfreq-event type as followin=
g.
>> Each devfreq-event device driver would support the various devfreq-e=
vent type
>> for devfreq governor at the same time.
>> - DEVFREQ_EVENT_TYPE_RAW_DATA
>> - DEVFREQ_EVENT_TYPE_UTILIZATION
>> - DEVFREQ_EVENT_TYPE_BANDWIDTH
>> - DEVFREQ_EVENT_TYPE_LATENCY
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq-event.c | 44 ++++++++++++++++++++++++++++++=
+++++++----
>>  include/linux/devfreq.h         | 29 ++++++++++++++++++++++-----
>>  2 files changed, 64 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfr=
eq-event.c
>> index eaf59c1..9444f93 100644
>> --- a/drivers/devfreq/devfreq-event.c
>> +++ b/drivers/devfreq/devfreq-event.c
>> @@ -29,6 +29,9 @@
>>  #include <linux/of.h>
>>  #include "governor.h"
>> =20
>> +#define EVENT_TYPE_RAW_DATA_MAX		U64_MAX
>> +#define EVENT_TYPE_UTILIZATION_MAX	100
>> +
>>  static struct class *devfreq_event_class;
>> =20
>>  /* The list of all devfreq event list */
>> @@ -144,7 +147,8 @@ EXPORT_SYMBOL_GPL(devfreq_event_is_enabled);
>>   * Note that this function set the event to the devfreq-event devic=
e to start
>>   * for getting the event data which could be various event type.
>>   */
>> -int devfreq_event_set_event(struct devfreq_event_dev *edev)
>> +int devfreq_event_set_event(struct devfreq_event_dev *edev,
>> +				enum devfreq_event_type type)
>>  {
>>  	int ret;
>> =20
>> @@ -158,7 +162,15 @@ int devfreq_event_set_event(struct devfreq_even=
t_dev *edev)
>>  		return -EPERM;
>> =20
>>  	mutex_lock(&edev->lock);
>> -	ret =3D edev->desc->ops->set_event(edev);
>> +
>> +	if ((edev->desc->type & type) =3D=3D 0) {
>> +		dev_err(&edev->dev, "unsupported of devfreq-event type\n");
>> +		mutex_unlock(&edev->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D edev->desc->ops->set_event(edev, type);
>> +
>>  	mutex_unlock(&edev->lock);
>> =20
>>  	return ret;
>> @@ -174,7 +186,9 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
>>   * current event data and total_event should be stored in second pa=
rameter
>>   * (total_event).
>>   */
>> -u64 devfreq_event_get_event(struct devfreq_event_dev *edev, u64 *to=
tal_event)
>> +u64 devfreq_event_get_event(struct devfreq_event_dev *edev,
>> +				enum devfreq_event_type type,
>> +				u64 *total_event)
>>  {
>>  	u64 event;
>> =20
>> @@ -190,7 +204,27 @@ u64 devfreq_event_get_event(struct devfreq_even=
t_dev *edev, u64 *total_event)
>>  		return 0;
>> =20
>>  	mutex_lock(&edev->lock);
>> -	event =3D edev->desc->ops->get_event(edev, total_event);
>> +
>> +	if ((edev->desc->type & type) =3D=3D 0) {
>> +		dev_err(&edev->dev, "unsupported of devfreq-event type\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	event =3D edev->desc->ops->get_event(edev, type, total_event);
>> +
>> +	switch (type) {
>> +	case DEVFREQ_EVENT_TYPE_RAW_DATA:
>> +	case DEVFREQ_EVENT_TYPE_BANDWIDTH:
>> +	case DEVFREQ_EVENT_TYPE_LATENCY:
>> +		if ((event > *total_event)
>> +			|| ((event > EVENT_TYPE_RAW_DATA_MAX) ||
>> +				*total_event > EVENT_TYPE_RAW_DATA_MAX))
>> +			event =3D 0;
>=20
> missing break here.

My mistake. I'll add it and 'default' case statement.

Best Regards,
Chanwoo Choi
